local BaseSanctumBGEvent, super = Class(Event)

function BaseSanctumBGEvent:init(data)
    super.init(self, data)
	self.debug_select = false
end

function BaseSanctumBGEvent:onAdd(parent)
    super.onAdd(self, parent)
	Game.world:spawnObject(IntroGigaProphecies(), "objects_bg")
	self:remove()
end

return BaseSanctumBGEvent