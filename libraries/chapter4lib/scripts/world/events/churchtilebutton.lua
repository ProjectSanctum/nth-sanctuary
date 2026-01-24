---@class Event.bell_button : Event
local ChurchTileButton, super = Class(TileButton, "churchtilebutton")

function ChurchTileButton:init(data)
    super.init(self, data.x, data.y, { data.width, data.height, data.polygon }, data.properties)
    local properties = data and data.properties or {}
    self.idle_sprite = properties["sprite"] or idle_sprite or "world/events/churchglowtile/idle"
    self.pressed_sprite = properties["pressedsprite"] or properties["sprite"] or pressed_sprite or idle_sprite or "world/events/churchglowtile/pressed"

    self:setSprite(self.idle_sprite, 5/30)
    self:setHitbox(10, 6, 20, 12)
	
    self.glow = properties["glow"] or true
    self.do_ripple = properties["ripple"] or false
    self.glow_color = TiledUtils.parseColorProperty(properties["glow_color"]) or ColorUtils.hexToRGB("#4EADFF")
	self.siner = MathUtils.random(360) * math.pi
	self.glow_timer = 0
    self.npc_activated = properties["npcpress"]
end

function ChurchTileButton:update()
    super.update(self)
	
	self.siner = self.siner + DTMULT
	
	local onscreen = true
    local size = self.width + self.height
    local x, y = self:getScreenPos()
    if x < -size - 80 or y < -size - 80 or x > SCREEN_WIDTH + size + 80 or y > SCREEN_HEIGHT + size + 80 then
		onscreen = false
    end
	if self.glow and onscreen then
		self.glow_timer = self.glow_timer + DTMULT
		if self.glow_timer >= 1 then
			local glowspr = Sprite(self.sprite.texture_path, self.x + self.width/2, self.y + self.height/2)
			glowspr:setOrigin(0.5)
			glowspr:stop()
			local scale = 2 + math.abs(math.sin(self.siner / 30) * 0.2)
			glowspr:setScale(2)
			local pressed = (self.pressed and 1 or 0)
			local lifetime = 12 - pressed
			Game.world.timer:lerpVar(glowspr, "scale_x", scale, (scale / 2) + (math.sin(self.siner / 6) * 0.1), lifetime, 2, "in")
			Game.world.timer:lerpVar(glowspr, "scale_y", scale, (scale / 2) + (math.sin(self.siner / 8) * 0.1), lifetime, 2, "in")
			Game.world.timer:lerpVar(glowspr, "alpha", MathUtils.clamp((0.35 + (math.sin(self.siner / 20) * 0.125)) - pressed, 0.05, 0.5), 0, lifetime)
			glowspr.color = self.glow_color
			glowspr.physics.direction = math.rad(self.siner * 12)
			glowspr.layer = self.layer + 0.01
			glowspr.physics.gravity = -0.7
			glowspr.physics.speed_y = 1.5
			Game.world.timer:after(lifetime/30, function()
				glowspr:remove()
			end)
			glowspr.darkness_unlit = true
			Game.world:addChild(glowspr)
			self.glow_timer = 0
		end
	end
    self.sprite.alpha = self.do_ripple and 0 or 1
end

function ChurchTileButton:onPressed()
    self:setSprite(self.pressed_sprite)
    if self.on_sound and self.on_sound ~= "" then
		if self.on_sound == 0 then
			Assets.playSound("spearappear", 0.6, 1.2)
			Assets.playSound("spearappear", 0.8, 1.4)
			Assets.playSound("noise", 0.6)
		elseif self.on_sound == 3 then
			Assets.playSound("churchbell_short", 1, 1.1)
		else
			Assets.stopAndPlaySound(self.on_sound)
		end
    end
	if self.do_ripple then
		self.world:addChild(RippleEffect(self.x + self.width/2, self.y + self.height/2, 50, 460, 10, {1, 1, 0}, 0, 0, 1));
		self.world:addChild(RippleEffect(self.x + self.width/2, self.y + self.height/2, 50, 380, 10, {1, 1, 0}, 0, 0, 1));
		self.world:addChild(RippleEffect(self.x + self.width/2, self.y + self.height/2, 50, 320, 10, {1, 1, 0}, 0, 0, 1));
		self.world:addChild(RippleEffect(self.x + self.width/2, self.y + self.height/2, 50, 240, 10, {1, 1, 0}, 0, 0, 1));
	end
end

function ChurchTileButton:onReleased()
    self:setSprite(self.idle_sprite, 5/30)
    if self.off_sound and self.off_sound ~= "" then
		if self.off_sound == 0 then
			Assets.playSound("noise", 1, 0.8)
		else
			Assets.stopAndPlaySound(self.off_sound)
		end
    end
end

return ChurchTileButton