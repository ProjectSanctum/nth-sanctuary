local item, super = Class("cd_bagel", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I remember that..."
    })
	
	self.sounds = TableUtils.merge(self.sounds, {
		["jamm"] = "cd_bagel/jamm"
    })
end

return item