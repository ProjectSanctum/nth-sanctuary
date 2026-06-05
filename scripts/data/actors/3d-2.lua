local actor, super = Class(Actor, "3d-2")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "3D Spinning Cube"

    -- Width and height for this actor, used to determine its center
    self.width = 100
    self.height = 100

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 25, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "enemies/3d-2"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = "3d"
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
        ["idle"] = {"idle", 1/30, true},
        ["hurt"] = {"hurt", 0.25, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["idle"] = {0, 0},
    }
end

function actor:createSprite()
	if not Kristal.Config["simplifyVFX"] then
		return ThreeDActorCube(self)
	end
	return ActorSprite(self)
end

function actor:preSpriteDraw(sprite)
	super.preSpriteDraw(sprite)
end

function actor:onSpriteDraw(sprite)
	super.onSpriteDraw(sprite)
	if not Kristal.Config["simplifyVFX"] then
		Draw.setColor(sprite:getDrawColor())
		Draw.drawCanvas(sprite.canvas)
	end
end

return actor