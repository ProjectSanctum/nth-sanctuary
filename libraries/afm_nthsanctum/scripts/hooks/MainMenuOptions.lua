local MainMenuOptions, super = HookSystem.hookScript(MainMenuOptions)


function MainMenuOptions:init(menu)
    super.init(self, menu)
end

function MainMenuOptions:initializeOptions()
    super.initializeOptions(self)
    self:registerConfigOption({"graphics" }, "Remove Hue Shift", "nthSanctuary/removeHSV")
    self:registerConfigOption({"graphics" }, "potat mode :)", "nthSanctuary/potat", function (toggled)
        if toggled then
            SCREEN_CANVAS = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT, {dpiscale = 0.125})
        else
            SCREEN_CANVAS = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT, {dpiscale = 1})
        end
    end)
    self:registerConfigOption({"general" }, "Legacy Music", "nthSanctuary/legacyBaseMusic", function (toggled)
        Mod.legacy_base_music = toggled
        if Game.world and Game.world.music and Game.world.map then
            -- Try to force music change by directly setting current music
            local current_music = Game.world.map.music
            if current_music == "homebase" then
                -- Force the music system to re-evaluate
                Game.world.music:stop()
                Game.world.music:play("homebase")
            end
        end
    end)
    
end



return MainMenuOptions