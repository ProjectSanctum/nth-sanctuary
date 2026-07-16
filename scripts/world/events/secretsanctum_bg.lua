local SecretSanctumBGEvent, super = Class(Event)

function SecretSanctumBGEvent:init(data)
    super.init(self, data)
	self.debug_select = false
end

function SecretSanctumBGEvent:onAdd(parent)
    super.onAdd(self, parent)
	Game.world:spawnObject(SecretSanctumBG(), "objects_bg")
	self:remove()
end

return SecretSanctumBGEvent