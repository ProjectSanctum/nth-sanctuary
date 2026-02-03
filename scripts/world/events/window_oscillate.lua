local WindowOscillate, super = Class(Event, "window_oscillate")

function WindowOscillate:init(data)
    super.init(self, data)
    local properties = data and data.properties or {}
	self.osc_speed = properties["speed"] or 1
	self.osc_texture = properties["texture"] or "window_oscillate"
	self:setSprite("world/events/window_oscillate/" .. self.osc_texture .. "_1")
	self:setScale(0.5)
	self.osc_sprite = Sprite("world/events/window_oscillate/" .. self.osc_texture .. "_2")
	self.osc_sprite:setScale(2)
	self:addChild(self.osc_sprite)
	self:setOrigin(0.5, 1)
end

function WindowOscillate:update()
    super.update(self)
	self.osc_sprite.alpha = Ch4Lib.scr_wave(0, 1, self.osc_speed, 0)
end

return WindowOscillate