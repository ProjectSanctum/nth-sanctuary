local actor, super = Class(Actor)

function actor:init()
    super.init(self)

    self.name = "Waferr"

    self.width = 30
    self.height = 62
    self.hitbox = {2, 22, 25, 38}

    self.color = {0, 0, 1}

    self.flip = nil

    self.path = "npcs/wafer"
    self.default = ""

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {
        [""] = 0.2
    }
end

return actor