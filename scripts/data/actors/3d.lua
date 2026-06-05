local actor, super = Class(Actor, "3d")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "3D Spinning Prism"

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
    self.path = "enemies/3d"
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
	self.interlace_shader = Assets.getShader("wave_interlace")
	self.rage_aura_timer = 0
end

function actor:createSprite()
	if not Kristal.Config["simplifyVFX"] then
		return ThreeDActorPrism(self)
	end
	return ActorSprite(self)
end

function actor:preSpriteDraw(sprite)
	super.preSpriteDraw(sprite)
	local sprite_texture = Kristal.Config["simplifyVFX"] and sprite.texture or sprite.canvas
    if sprite_texture and Game.battle and Game.battle.encounter.rage_anim_speed > 1 then
        -- Use additive blending if the enemy is not being drawn to a canvas
		self.rage_aura_timer = self.rage_aura_timer + DTMULT
        if love.graphics.getCanvas() == SCREEN_CANVAS then
            love.graphics.setBlendMode("add")
        end

        local sprite_width = sprite.texture:getWidth()
        local sprite_height = sprite.texture:getHeight()
		
        local last_shader = love.graphics.getShader()
		love.graphics.setShader(self.interlace_shader)
        self.interlace_shader:send("wave_sine", Kristal.getTime() * 100)
        self.interlace_shader:send("wave_mag", (Game.battle.encounter.rage_anim_speed - 1) * 4)
        self.interlace_shader:send("wave_height", 2)
        self.interlace_shader:send("texsize", { sprite_width, sprite_height })
		
        for i = 1, 5 do
            local aura = (i * 9) + ((self.rage_aura_timer * 3) % 9)
            local aurax = (aura * 0.75) + (math.sin(aura / 4) * 4)
            --var auray = (45 * scr_ease_in((aura / 45), 1))
            local auray = 45 * Ease.inSine(aura / 45, 0, 1, 1)
            local aurayscale = math.min(1, 80 / sprite_height)

            Draw.setColor(1, 0, 0, ((1 - (auray / 45)) * 0.5) * (Game.battle.encounter.rage_anim_speed - 1))
            Draw.draw(sprite_texture, -((aurax / 180) * sprite_width), -((auray / 82) * sprite_height * aurayscale), 0, 1 + ((aurax/36) * 0.5), 1 + (((auray / 36) * aurayscale) * 0.5))
        end

        love.graphics.setBlendMode("alpha")

        local xmult = math.min((70 / sprite_width) * ((Game.battle.encounter.rage_anim_speed - 1) * 4), (Game.battle.encounter.rage_anim_speed - 1) * 4)
        local ymult = math.min((80 / sprite_height) * ((Game.battle.encounter.rage_anim_speed - 1) * 5), (Game.battle.encounter.rage_anim_speed - 1) * 5)
        local ysmult = math.min((80 / sprite_height) * ((Game.battle.encounter.rage_anim_speed - 1) * 0.2), (Game.battle.encounter.rage_anim_speed - 1) * 0.2)

        Draw.setColor(1, 0, 0, 0.2 * (Game.battle.encounter.rage_anim_speed - 1))
        Draw.draw(sprite_texture, (sprite_width / 2) + (math.sin(self.rage_aura_timer / 5) * xmult) / 2, (sprite_height / 2) + (math.cos(self.rage_aura_timer / 5) * ymult) / 2, 0, 1, 1 + (math.sin(self.rage_aura_timer / 5) * ysmult) / 2, sprite_width / 2, sprite_height / 2)
        Draw.draw(sprite_texture, (sprite_width / 2) - (math.sin(self.rage_aura_timer / 5) * xmult) / 2, (sprite_height / 2) - (math.cos(self.rage_aura_timer / 5) * ymult) / 2, 0, 1, 1 - (math.sin(self.rage_aura_timer / 5) * ysmult) / 2, sprite_width / 2, sprite_height / 2)
		
        love.graphics.setShader(Kristal.Shaders["AddColor"])

        Kristal.Shaders["AddColor"]:send("inputcolor", {1, 0, 0})
        Kristal.Shaders["AddColor"]:send("amount", 1)

        Draw.setColor(1, 1, 1, 0.3 * (Game.battle.encounter.rage_anim_speed - 1))
        Draw.draw(sprite_texture,  (Game.battle.encounter.rage_anim_speed - 1)*1,  0)
        Draw.draw(sprite_texture,  (Game.battle.encounter.rage_anim_speed - 1)*-1,  0)
        Draw.draw(sprite_texture,  0,  (Game.battle.encounter.rage_anim_speed - 1)*1)
        Draw.draw(sprite_texture,  0,  (Game.battle.encounter.rage_anim_speed - 1)*-1)

        love.graphics.setShader(last_shader)

        Draw.setColor(sprite:getDrawColor())
    end
end

function actor:onSpriteDraw(sprite)
	super.onSpriteDraw(sprite)
	if not Kristal.Config["simplifyVFX"] then
		Draw.setColor(sprite:getDrawColor())
		Draw.drawCanvas(sprite.canvas)
	end
end

return actor