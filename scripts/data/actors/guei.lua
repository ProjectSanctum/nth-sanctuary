local Guei, super = Class(Actor)

function Guei:init()
    super.init(self)

    self.name = "Guei"

    self.width = 71
    self.height = 64
    self.hitbox = {17, 44, 40, 20}
    self.flip = nil

    self.path = "enemies/guei"

    self.default = "idle"

    self.voice = nil

    self.portrait_path = nil

    self.portrait_offset = nil

    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        ["hurt"] = {"hurt"},
        ["idle"] = {"idle", 1/7, true},
    }

    self.offsets = {
        ["hurt"] = {0, 0},
    }
end

return Guei