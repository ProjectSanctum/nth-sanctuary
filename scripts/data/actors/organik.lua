local actor, super = Class(Actor)

function actor:init()
    super.init(self)

    self.name = "Organikk"

    self.width = 38
    self.height = 61
    self.hitbox = {2, 22, 29, 38}

    self.color = {0, 0, 1}

    self.flip = nil

    self.path = "npcs/organik"
    self.default = "a"

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {
        ["a"] = 0.1,
        ["b"] = 0.1,
        ["c"] = 0.1,
        ["d"] = 0.1,
        ["ar"] = 0.1,
        ["br"] = 0.1,
        ["cr"] = 0.1,
        ["dr"] = 0.1,
    }
end

return actor