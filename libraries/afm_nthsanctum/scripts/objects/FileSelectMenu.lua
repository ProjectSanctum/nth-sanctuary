---@class FileSelectMenu: Object
---@field background FileSelectBackground?
---@overload fun(): FileSelectMenu
local FileSelectMenu, super= Class("FileSelectMenu")

function FileSelectMenu:initStateclasses()
	super.initStateclasses(self)
    self.credits = ModlandCredits(self)
end

function FileSelectMenu:initStates()
	super.initStates(self)
    self.state_manager:addState("CREDITS", self.credits)
    Kristal.hideBorder(0)
	Game:setBorder("church_grand")
end

return FileSelectMenu