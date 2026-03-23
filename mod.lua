---@enum DarkShardID
Mod.DarkShardID = {
    TEST_SHARD_1 = 0,
    TEST_SHARD_2 = 1,
    BookShard = 2,
    LeafRoomShard = 3,
}

---@param plugin TypeGenPlugin.MainScript
function Mod:onTiledTypegen(plugin)
    plugin:addEnumType({
        values = TableUtils.getKeys(self.DarkShardID),
        type = "enum",
        id = 0,
        valuesAsFlags = false,
        name = "DarkShardID",
        storageType = "int",
    })
end

function Mod:registerDebugOptions(debug)
    debug:registerMenu("nth_sanctumdebug", "#th Sanctuary Debug","menu")
    
    debug:registerOption("main", "#th Sanctuary Options", "Enter the  Funky  Menu.", function () debug:enterMenu("nth_sanctumdebug", 1) end)
    
    debug:registerOption(
        "nth_sanctumdebug", 
        "Set Dark Shards to somthign big", 
        "Ease of Access.",
        function()
        for i=1,100 do
            Mod.dark_shards[i]=-1
        end
    end)
    
    debug:registerOption(
    "nth_sanctumdebug", 
    "Set Dark Shards to 1", 
    "Set them to 1.",
    function()
        for g, shard in ipairs(Mod.dark_shards) do
            Mod.dark_shards[g] = 0
        end
    end)

    debug:registerOption(
    "nth_sanctumdebug", 
    "Force mod finish", 
    function()
        local b = (Game:getFlag("finished")==false and "OFF") or "ON"
        return "Probably of good use? ("..b      ..")"
    end,
    function()
        Game:setFlag("finished", not Game:getFlag("finished"))
    end)

    debug:registerOption(
    "nth_sanctumdebug", 
    "The Cooler 'Give Money'", 
    "fre mony genrtr",
    function()
        Game.money = Game.money + 1000
    end)    
    
    debug:registerOption(
    "nth_sanctumdebug", 
    "Toggle 3D Mode", 
    "Enables first person view & 3D graphics. (Not actually dont do this please)",
    function()
        love.graphics.setCanvas(4)
    end)

end

function Mod:init()
    print("Loaded "..self.info.name.."!")
    Game:registerEvent("squeak", function(data)
        return Squeak(data.x, data.y, {data.width, data.height, data.polygon})
    end)
    TableUtils.copyInto(MUSIC_VOLUMES, {
        second_church = 0.8
    })
    self.DT_MULT = 1
    Utils.hook(love.timer, "step", function (orig, ...)
        local dt = orig(...)
        return dt * math.max(0.05, self.DT_MULT)
    end)
    self.legacy_base_music = Kristal.Config["nthSanctuary/legacyBaseMusic"] or false
end

function Mod:afmGetMusic()
    local data = Kristal.getSaveFile(1)
	local flags = {}
	for i=1,3 do
		local path = "saves/nth_sanctum/file_"..i..".json"
		if love.filesystem.getInfo(path) then
			local data = JSON.decode(love.filesystem.read(path))
			table.insert(flags, data.flags["prog"])
		end
	end
	table.sort(flags)
	local flag = flags[#flags]
    if flag == 0 or not flag then
		return "afm/preview"
	else
		return "afm/prev2"
	end
end

function Mod:afmGetStyle()
    return "normal"
end

function Mod:unload()
    if DISCORD_RPC_AVAILABLE and Kristal.Config["discordRPC"] then
        DiscordRPC.shutdown()
        DiscordRPC.initialize(DISCORD_RPC_ID, true)
    end
end

function Mod:registerTextCommands(text)
    text:registerCommand("friend", function(self, node, dry)
        self.state.friendly = (node.arguments[1] ~= "unfriend")
    end, {dry = true})
    text:registerCommand("dualcol", function(self, node, dry)
        self.state.dualcol = (node.arguments[1] ~= "stop")
        if node.arguments[1] == "stop" then return end
        self.state.col1 = ColorUtils.hexToRGB(node.arguments[1])
        self.state.col2 = ColorUtils.hexToRGB(node.arguments[2])
    end, {dry = true})
    text:registerCommand("gold", function(self, node, dry)
        self.state.golden = (node.arguments[1] ~= "ungold")
    end, {dry = true})
    text:registerCommand("rainbow", function(self, node, dry)
        self.state.rainbow = (node.arguments[1] ~= "unrainbow")
    end, {dry = true})
end

function Mod:onDrawText(text, node, state, x, y, scale, font, use_color)
    
    if state.friendly then
        local shader = Kristal.Shaders["GradientV"]
        local last_shader = love.graphics.getShader()
        local w, h = text:getNodeSize(node, state)
        local canvas = Draw.pushCanvas(w, h, { stencil = false })
        love.graphics.print(node.character, 0, 0, 0, scale, scale)
        Draw.popCanvas()
        love.graphics.setShader(shader)
        shader:sendColor("from", {1, 0.4, 1, 1})
        shader:sendColor("to", {1,1,0,1})
        Draw.draw(canvas, x, y)
        love.graphics.setShader(last_shader)
        return true
    elseif state.golden then
        local shader = Kristal.Shaders["GradientV"]
        local last_shader = love.graphics.getShader()
        local w, h = text:getNodeSize(node, state)
        local canvas = Draw.pushCanvas(w, h, { stencil = false })
        love.graphics.print(node.character, 0, 0, 0, scale, scale)
        Draw.popCanvas()
        love.graphics.setShader(shader)
        shader:sendColor("from", {1, 217/255, 89/255, 1})
        shader:sendColor("to", {1,178/255,77/255,1})
        Draw.draw(canvas, x, y)
        love.graphics.setShader(last_shader)
        return true
    elseif state.rainbow then
        local function pastelRainbow(t)
            local r = 0.6 + 0.4 * math.sin(t)
            local g = 0.6 + 0.4 * math.sin(t + 2)
            local b = 0.6 + 0.4 * math.sin(t + 4)
            return r, g, b
        end
        local shader = Kristal.Shaders["AddColor"]
        local last_shader = love.graphics.getShader()
        local w, h = text:getNodeSize(node, state)
        local canvas = Draw.pushCanvas(w, h, { stencil = false })
        love.graphics.print(node.character, 0, 0, 0, scale, scale)
        Draw.popCanvas()
        love.graphics.setShader(shader)
        local r,g,b = pastelRainbow(love.timer.getTime() * 1.5) -- slow rainbow
        shader:sendColor("inputcolor", {r, g, b, 1})
        shader:send("amount", 1)
        Draw.draw(canvas, x, y)
        love.graphics.setShader(last_shader)
        return true
    elseif state.dualcol then
        local shader = Kristal.Shaders["GradientV"]
        local last_shader = love.graphics.getShader()
        local w, h = text:getNodeSize(node, state)
        local canvas = Draw.pushCanvas(w, h, { stencil = false })
        love.graphics.print(node.character, 0, 0, 0, scale, scale)
        Draw.popCanvas()
        love.graphics.setShader(shader)
        shader:sendColor("from", state.col1)
        shader:sendColor("to", state.col2)
        Draw.draw(canvas, x, y)
        love.graphics.setShader(last_shader)
        return true
    end
end

function Mod:c4lCreateFilterFX(type, properties)
    local fxtype = (type or "hsv"):lower()
    if fxtype == "hsv" then
        return HSVShiftFX()
    elseif fxtype == "hsv2" then
		local hsv = HSVShiftFX()
		hsv.hue_start = 60;
		hsv.sat_start = 0.4;
		hsv.val_start = 1;
		hsv.hue_target = 80;
		hsv.sat_target = 0.4;
		hsv.val_target = 1;
		hsv.hue = hsv.hue_start;
		hsv.sat = hsv.sat_start;
		hsv.val = hsv.val_start;
		hsv.wave_time = 1;
        return hsv
    elseif fxtype == "hsv3" then
		local hsv = HSVShiftFX()
		hsv.hue_start = -100;
		hsv.sat_start = 0.6;
		hsv.val_start = 1;
		hsv.hue_target = -140;
		hsv.sat_target = 0.6;
		hsv.val_target = 1.5;
		hsv.hue = hsv.hue_start;
		hsv.sat = hsv.sat_start;
		hsv.val = hsv.val_start;
		hsv.wave_time = 2;
        return hsv
    elseif fxtype == "fractured" then
        return FracturedHSVFX()
    elseif fxtype == "custom" then --FINALLY
		local hsv = HSVShiftFX()
		hsv.hue_start = properties["hue_start"] or 0; --NO
		hsv.sat_start = properties["sat_start"] or 0.6; --MORE
		hsv.val_start = properties["val_start"] or 1; --DUPLICATE
		hsv.hue_target = properties["hue_target"] or -140; --HUE
		hsv.sat_target = properties["sat_target"] or 1; --SHIFT
		hsv.val_target = properties["val_target"] or 1.5; --TYPES
		hsv.hue = hsv.hue_start;
		hsv.sat = hsv.sat_start;
		hsv.val = hsv.val_start;
		hsv.wave_time = properties["speed"] or 2;
        return hsv
    elseif fxtype == "prophecyscroll" then
        return ProphecyScrollFX()
    end
end

function Mod:afmPostInit(new_file)
    Game:setFlag("apkpure", false)
    if new_file then
        Game:setFlag("fun", love.math.random(1, 170))
        Game.world:startCutscene("primary.intro")
		Game:setFlag("ft_last_map", "base_center")
    else
        Game:setFlag("shards", nil) -- Clean up old save files
        if Game:getFlag("apkpure", true) then
            Game.world:startCutscene(function(cutscene)
                cutscene:setSpeaker("susie")
                cutscene:text("* hey,[wait:5] "..Game.save_name.. ".[wait:5] this is [color:red]fucking[color:reset] susie.", "bangs_smile")
                cutscene:text("* you seem to be playing an unofficial build of [color:blue]#th sanctuary.", "bangs_neutral")
                cutscene:text("* that's called [color:red]PIRACY,[wait:5][color:reset] buddy.[wait:5] that's right.", "bangs_teeth")
                cutscene:text("* so now,[wait:5] i wanted to say something you should know really well...", "bangs_smile")
                Game.world.music:pause()
                cutscene:text("* [speed:0.1]HYPERBOID.", "bangs_teeth")
                Game.world.music:resume()
                cutscene:text("* okay thanks now go get the game on [color:green]gamejolt.", "bangs_smile")
                cutscene:text("* btw your [color:#ff00ff]FRI[color:#eaff00]END is on [color:#353535]the funnyfeline youtube channel.[color:reset]", "bangs_smile")
                cutscene:text("* AND president donald trump has your ip now in [color:red]t[color:reset]h[color:blue]e [color:red]u[color:blue]s", "bangs_neutral")
                cutscene:text("* ok bye im behind you because im your [color:#ff00ff]FRI[color:#eaff00]END~~", "bangs_smile")
            end)
        end
    end
	Mod.titan_dissolve_shader = love.graphics.newShader[[
    extern float amount;
    vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
        if (Texel(tex, texture_coords).a < amount) {
            // a discarded pixel wont be applied as the stencil.
            discard;
        }
        return vec4(1.0);
    }
 ]]
end

function Mod:onTextSound(sound, node)
    if sound == "3d" then
        local ranNum = love.math.random(1, 7)
        if ranNum == 1 then
            Assets.playSound("voice/chops/t1")
        elseif ranNum == 2 then
            Assets.playSound("voice/chops/t2")
        elseif ranNum == 3 then
            Assets.playSound("voice/chops/t3")
        elseif ranNum == 4 then
            Assets.playSound("voice/chops/t4")
        elseif ranNum == 5 then
            Assets.playSound("voice/chops/t5")
        elseif ranNum == 6 then
            Assets.playSound("voice/chops/t6")
        elseif ranNum == 7 then
            Assets.playSound("voice/chops/t7")
        end
        return true
    end
end

function Mod:onMapMusic(map, music)
	if music == "homebase" and self.legacy_base_music then
		return "homebase_old"
	elseif music == "grand_bells" then
		return {"bell_ambience", 0.5, 0.5}
	elseif music == "church_study_slower" then
		return {"church_dark_study", 1, 0.75}
	end
end

function Mod:onShadowCrystal(item, light)
    if light then return end
	if Game.world:getEvent("prophecy") then
		Game.world:startCutscene(function(cutscene)
			cutscene:text("* You held the crystal up to your eye.")
			cutscene:text("* For some strange reason,[wait:5] no matter how you look...")
			cutscene:text("* The prophecy's text does not warp in the crystal's lens.")
		end)
		return true
	elseif not item:getFlag("used_none", false) then
        item:setFlag("used_none", true)
		local extra_sanctum_maps = {
			"base_east",
			"base_east2",
		}
        Game.world:startCutscene(function(cutscene)
			if Game.world.map.id and StringUtils.contains(Game.world.map.id, "hell") then
				cutscene:text("* You held the crystal up to your eye.")
				cutscene:text("* For some strange reason,[wait:5] for just a brief moment...")
				cutscene:text("* You thought you saw the church burning down.")
			elseif Game.world.map.id and StringUtils.contains(Game.world.map.id, "sanctum")
			or StringUtils.contains(Game.world.map.id, "sanctuary")
			or TableUtils.contains(extra_sanctum_maps, Game.world.map.id) then
				cutscene:text("* You held the crystal up to your eye.")
				cutscene:text("* For some strange reason,[wait:5] for just a brief moment...")
				cutscene:text("* You thought you saw the lobby of the church.")
			else
				cutscene:text("* You looked through the glass.")
				cutscene:text("* ...[wait:5] but nothing happened.")
			end
        end)
        return true
    end
end

function Mod:load(data)
    ---@type [int, int, int, int, int, int, int]
    self.dark_shards = {
        0, 0, 0, 0,
        0, 0, 0, 0,
    } -- 8 words * 32 bits per word = 256 bits
    if data.dark_shards then
        for i = 1, #data.dark_shards do
            Mod.dark_shards[i] = data.dark_shards[i]
        end
    end
end

function Mod:save(data)
    data.dark_shards = TableUtils.copy(self.dark_shards)
end

---@return int
function Mod:getDarkShardCount(dark_shard_bits)
    dark_shard_bits = dark_shard_bits or self.dark_shards
    local count = 1 -- (Because of the starting dark shard)
    for id = 0, #dark_shard_bits * 32 do
        local word = bit.rshift(id, 5) + 1
        local subid = bit.band(id, 0b00011111)
        if bit.band(dark_shard_bits[word] or 0, bit.lshift(1, subid)) ~= 0 then
            count = count + 1
        end
    end
    return count
end

---@param id DarkShardID
---@param collected boolean
function Mod:setDarkShard(id, collected)
    local word = bit.rshift(id, 5) + 1
    local subid = bit.band(id, 0b00011111)
    assert(self.dark_shards[word], "ID out of range")
    if collected then
        self.dark_shards[word] = bit.bor(self.dark_shards[word], bit.lshift(1, subid))
    else
        self.dark_shards[word] = bit.band(self.dark_shards[word], bit.bnot(bit.lshift(1, subid)))
    end
end


---@param id DarkShardID
---@return boolean
function Mod:getDarkShard(id)
    local word = bit.rshift(id, 5) + 1
    local subid = bit.band(id, 0b00011111)
    return bit.band(self.dark_shards[word] or 0, bit.lshift(1, subid)) ~= 0
end
--[==[
function Mod:preInit()
    ---@return string|number[][]
    local function parseCSV(str)
        local lines = StringUtils.splitFast(str, "\n")
        local dat = {}
        for index, line in ipairs(lines) do
            dat[index] = StringUtils.split(line, ";")
            for l_index, value in ipairs(dat[index]) do
                dat[index][l_index] = tonumber(value) or value
            end
        end
        return dat
    end
    local dat = parseCSV(love.filesystem.read(Mod.info.path .. "/glyphs_fnt_legend.csv"))
    local img = love.graphics.newImage(Mod.info.path .. "/fnt_legend.png")
    ---@type (string|number)[]
    local header = table.remove(dat, 1)
    local glyphs = {}
    local total_width = 0
    local max_height = 0
    for index, line in ipairs(dat) do
        local quad = Assets.getQuad(line[2], line[3], line[4], line[5], img:getDimensions())

        local this_width = line[6] + 0
        this_width = math.floor(this_width)
        glyphs[line[1]] = love.graphics.newCanvas(this_width, line[5] )
        Draw.pushCanvas(glyphs[line[1]])
        love.graphics.draw(img, quad)
        Draw.popCanvas()

        total_width = total_width + 1 + this_width
        max_height = math.max(max_height, line[5])
    end

    local font_config = {
        ["glyphs"] = ""
    }

    local canvas = love.graphics.newCanvas(total_width, max_height)
    Draw.pushCanvas(canvas)
    for key, value in Utils.orderedPairs(glyphs) do
        local ok, char = pcall(string.char, key)
        if not ok then goto continue end
        font_config["glyphs"] = font_config["glyphs"] .. char
        Draw.setColor(0,0,1)
        love.graphics.rectangle("fill", 0,0,1,max_height)
        love.graphics.translate(1, 0)
        Draw.setColor(COLORS.white)
        Draw.draw(value)
        love.graphics.translate(value:getWidth(), 0)
        ::continue::
    end
    Draw.popCanvas()
    canvas:newImageData():encode("png", Mod.info.path .. "/libraries/chapter4lib/assets/fonts/legend.png")
    print(JSON.encode(font_config))
end
--]==]


function Mod:postInit()
    if DISCORD_RPC_AVAILABLE and Kristal.Config["discordRPC"] then
        DiscordRPC.shutdown()
        DiscordRPC.initialize("1235713537322651648", true)
    end

end

--[[
function Mod:postDraw()
    local points = {}
    for index, value in ipairs(self.thingy or {}) do
        table.insert(points, index*6)
        table.insert(points, (SCREEN_HEIGHT) - (value * (SCREEN_HEIGHT/2)))
    end
    love.graphics.line(points)
    love.graphics.setColor(1,0,0,1)
    points = {}
    for index, value in ipairs(self.thingy2 or {}) do
        table.insert(points, index*4)
        table.insert(points, (SCREEN_HEIGHT) - (value * (SCREEN_HEIGHT/2)))
    end
    love.graphics.line(points)
end
]]
