local MainMenuOptions, super = HookSystem.hookScript(MainMenuOptions)


function MainMenuOptions:init(menu)
    super.init(self, menu)
end

function MainMenuOptions:initializeOptions()
    super.initializeOptions(self)
    self:registerConfigOption({"graphics" }, "Remove Hue Shift", "nthSanctuary/removeHSV")
    self:registerConfigOption({"graphics" }, "potat mode :)", "nthSanctuary/removeHSV", function (toggled)
        self.menu.mod_list:buildModList()
    end)
    
end



return MainMenuOptions