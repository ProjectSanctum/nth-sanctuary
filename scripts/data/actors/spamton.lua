local actor, super = Class(Actor, "spamton")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Spamton"

    -- Width and height for this actor, used to determine its center
    self.width = 26
    self.height = 38

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {5, 13, 15, 20}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/spamton"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = "spam"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        ["idle"] = {"idle", 0.25, true},
        ["arms"] = {"arms", 0.25, true},
        ["arms_lookdown"] = {"arms_lookdown", 0.25, true},
        ["arms_lookdown_dark"] = {"arms_lookdown_dark", 0.25, true},
        ["armsup"] = {"armsup", 0.25, true},
        ["armsup_laugh"] = {"armsup_laugh", 0.25, true},
        ["dark"] = {"dark", 0.25, true},
        ["grab"] = {"grab", 0.25, true},
        ["grab_dark"] = {"grab_dark", 0.25, true},
        ["glitch_laugh"] = {"glitch_laugh/glitch_laugh", 0.1, true},
        ["laugh_left"] = {"laugh_left", 1/15, true}
        
        
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["idle"] = {0, 0},
        ["arms"] = {0,0},
        ["arms_lookdown"] = {0, -4},
        ["arms_lookdown_dark"] = {0, -4},
        ["armsup"] = {0, 0},
        ["armsup_laugh"] = {0,1},
        ["grab_dark"] = {0,-2},
        ["dark"] = {0,-2},
        ["glitch_laugh/glitch_laugh"] = {-7,-24},
        ["laugh_left"] = {0,-2}
    }
end

return actor