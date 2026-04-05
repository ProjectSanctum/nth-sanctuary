local actor, super = Class(Actor)

function actor:init()
    super.init(self)

    self.name = "Bibliox"

    self.width = 57
    self.height = 55
    self.hitbox = {4, 3, 50, 47}

    self.color = {0, 0, 1}

    self.flip = nil

    self.path = "npcs/bibliox"
    self.default = ""

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {
        [""] = 0.2
    }
end

return actor