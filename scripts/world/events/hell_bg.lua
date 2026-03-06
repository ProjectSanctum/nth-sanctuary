local HellBGEvent, super = Class(Event)

function HellBGEvent:init(data)
    super.init(self, data)
	self.debug_select = false
end

function HellBGEvent:onAdd(parent)
    super.onAdd(self, parent)
	Game.world:spawnObject(HellBG(), "objects_bg")
	self:remove()
end

return HellBGEvent