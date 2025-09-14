function Mod:init()
    print("Loaded "..self.info.name.."!")
    Utils.copyInto(MUSIC_VOLUMES, {
        second_church = 0.8
    })
end

function Mod:postInit(new_file)
    if new_file then
        Game:setFlag("fun", love.math.random(1, 170))
        Game:setFlag("shards", 1)
        Game.world:startCutscene("primary.intro")
    end
    Utils.hook(Battle, "spawnEnemyTextbox", function(orig, self, enemy, ...)
        if enemy and enemy.id == "guei" then
            local x, y = enemy.sprite:getRelativePos(0, enemy.sprite.height/2, self)
            if enemy.dialogue_offset then
                x, y = x + enemy.dialogue_offset[1], y + enemy.dialogue_offset[2]
            end
            local textbox = GueiTextbox(x, y, enemy.balloon_type)
            self:addChild(textbox)
            return textbox
        else
            return orig(self, enemy, ...)
        end
    end)
end
--[==[
function Mod:preInit()
    ---@return string|number[][]
    local function parseCSV(str)
        local lines = Utils.splitFast(str, "\n")
        local dat = {}
        for index, line in ipairs(lines) do
            dat[index] = Utils.split(line, ";")
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

--[[
function Mod:postInit()
    self.thingy = {0,0,0,0,0,0,0}
    self.thingy2 = {0,0,0,0,0,0,0}
    Game.stage.timer:every(2/30, function ()
        table.insert(self.thingy, Ch4Lib.scr_wave(0, 1, 1/30, 0))
        table.insert(self.thingy, Ch4Lib.scr_wave(1, 0, 1/30, 0))
        if #self.thingy > (SCREEN_WIDTH/6) then
            table.remove(self.thingy, 1)
        end
    end)
end

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