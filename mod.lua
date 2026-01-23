function Mod:init()
    print("Loaded "..self.info.name.."!")
    Game:setFlag("apkpure", false)
    TableUtils.copyInto(MUSIC_VOLUMES, {
        second_church = 0.8
    })
    self.DT_MULT = 1
    Utils.hook(love.timer, "step", function (orig, ...)
        local dt = orig(...)
        return dt * math.max(0.05, self.DT_MULT)
    end)
    -- in Mod:init()
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
    if new_file then
        Game:setFlag("fun", love.math.random(1, 170))
        Game:setFlag("shards", 1)
        Game.world:startCutscene("primary.intro")
		Game:setFlag("ft_last_map", "base_sanctum_center")
    else
        if Game:getFlag("apkpure", true) then
            Game.world:startCutscene(function(cutscene)
                cutscene:setSpeaker("susie")
                cutscene:text("* hey,[wait:5] "..Game.save_name.. ".[wait:5] this is [color:red]fucking[color:reset] susie.", "bangs_smile")
                cutscene:text("* you seem to be playing an unofficial build of [color:blue]#th sanctuary.", "bangs_neutral")
                cutscene:text("* that's called [color:red]PIRACY,[wait:5][color:reset] buddy.[wait:5] that's right.", "bangs_teeth")
                cutscene:text("* so now,[wait:5] i wanted to say something you should know really well...", "bangs_smile")
                Game.world.music:pause()
                --cutscene:text("* [speed:0.1]YOUR IP IS [color:red]"..require("socket").dns.toip(require("socket").dns.gethostname()), "bangs_teeth")
                --i think i dont want windows to think this is a virus.
                cutscene:text("* [speed:0.1]YOUR IP IS [color:red]I CANT FUCKING SAY THAT, CAN I?", "bangs_teeth")
                Game.world.music:resume()
                cutscene:text("* okay thanks now go get the game on [color:green]gamejolt.", "bangs_smile")
                cutscene:text("* btw your ip is on [color:#353535]the files.[color:reset]", "bangs_smile")
                cutscene:text("* that's right president donald trump has your ip now in [color:red]t[color:reset]h[color:blue]e [color:red]u[color:blue]s", "bangs_neutral")
                cutscene:text("* you should watch the news now, shouldn't you? ok bye im behind you~~", "bangs_smile")
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
	if music == "grand_bells" then
		return {"bell_ambience", 0.5, 0.5}
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