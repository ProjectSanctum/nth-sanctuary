local actor, super = Class(Actor)

function actor:init()
    super.init(self)

    self.name = "Mangle"

    self.width = 62
    self.height = 62
    self.hitbox = {0, 31, 62, 25}

    self.color = {0, 0, 1}

    self.flip = nil

    self.path = "npcs/mangle"
    self.default = ""
end

return actor