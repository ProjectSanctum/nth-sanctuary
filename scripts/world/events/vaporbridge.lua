local VaporBridge, super = Class(Event)

function VaporBridge:init(data)
    super.init(self, data)
	
	self:setOrigin(0, 0)
    local properties = data.properties or {}
	self.always_enabled = properties["always"] or false
	self.log_dir = properties["dir"] or "horz"
	self.log_amount = 0
	self.log_amount_half = 0
	self.log_length = 0
	self.logs = {}
	self.horz_log_tex = Assets.getFrames("world/events/vaporbridge/horz")
	self.vert_log_tex = Assets.getFrames("world/events/vaporbridge/vert")
	self.max_bend_log_no = 0
	self.max_bend_value = 0
	self.bend_angle = 0
	self.enabled = false
	self.disabling = false
	self:setupLogs()
end

function VaporBridge:setupLogs()
	if self.log_dir == "horz" then
		self.log_length = math.floor(self.width / 40)
		self.log_amount = math.floor(self.height / 20)
	else
		self.log_length = math.floor(self.height / 40)
		self.log_amount = math.floor(self.width / 20)
	end
	for i = 0, self.log_amount do
		table.insert(self.logs, {index = i, x = 0 + 20 * i, y = 0, bend_off = 0, bend_val = (i < math.floor(self.log_amount * 0.5) and (i + 1) * 2 or (self.log_amount - i) * 2)})
	end
end

function VaporBridge:onPostLoad()
	super.onPostLoad(self)
	if Kristal.Config["simplifyVFX"] and not self.always_enabled then
		if Game.world.map.simple_bridge_layer and not Game.world.map.simple_bridge_layer.visible then
			Game.world.map.simple_bridge_layer.visible = true
		end
		self.enabled = false
	else
		if Game.world.map.simple_bridge_layer and Game.world.map.simple_bridge_layer.visible then
			Game.world.map.simple_bridge_layer.visible = false
		end
		self.enabled = true
	end
end

function VaporBridge:update()
	super.update(self)
	if not self.always_enabled then
		if Kristal.Config["simplifyVFX"] then
			if self.enabled then
				if self.disabling then
					self.enabled = false
					self.disabling = false
				else
					if Game.world.map.simple_bridge_layer and not Game.world.map.simple_bridge_layer.visible then
						Game.world.map.simple_bridge_layer.visible = true
					end
					for _, chara in ipairs(Game.stage:getObjects(Character)) do
						if chara.log_index then
							chara.floored_log_index = nil
							chara.ceiled_log_index = nil
							chara.log_index = nil
							chara.sprite.y = chara.last_sprite_y or 0
						end
					end
					self.max_bend_log_no = 0
					self.max_bend_value = 0
					self.bend_angle = 0
					self.disabling = true
				end
				return
			end
		else
			if Game.world.map.simple_bridge_layer and Game.world.map.simple_bridge_layer.visible then
				Game.world.map.simple_bridge_layer.visible = false
			end
			self.enabled = true
		end
	end
	if not self.enabled then
		return
	end
	Object.startCache()
	local characters_on_bridge = {}
	local max_bend_val_temp = 0
	local apply_bend = false
	for _, chara in ipairs(Game.stage:getObjects(Character)) do
		chara.sprite.y = chara.last_sprite_y or 0
		chara.floored_log_index = nil
		chara.ceiled_log_index = nil
		chara.log_index = nil
		if chara:collidesWith(self.collider) then
			table.insert(characters_on_bridge, chara)
			apply_bend = true
			local log_index, chara_log_index = 1, 0
			if self.log_dir == "horz" then
				chara_log_index = MathUtils.clamp(((chara.y - self.y) / 20) + 1, 0, self.log_amount + 1)
				log_index = MathUtils.clamp(((chara.y - self.y) / 20) + 1, 1, self.log_amount)
			else
				chara_log_index = MathUtils.clamp(((chara.x - self.x) / 20) + 1, 0, self.log_amount + 1)
				log_index = MathUtils.clamp(((chara.x - self.x) / 20) + 1, 1, self.log_amount)
			end
			local bend_value = self.logs[MathUtils.round(log_index)].bend_val
			if bend_value > max_bend_val_temp then
				self.max_bend_log_no = MathUtils.round(log_index)
				self.max_bend_value = bend_value
				max_bend_val_temp = bend_value
			end
			chara.floored_log_index = math.floor(chara_log_index)
			chara.ceiled_log_index = math.ceil(chara_log_index)
			chara.log_index = chara_log_index
		end
	end
	if apply_bend then
		if self.bend_angle < 90 then
			self.bend_angle = self.bend_angle + 5.625 * DTMULT
		end
	else
		if self.bend_angle > 0 then
			self.bend_angle = self.bend_angle - 5.625 * DTMULT
		end	
	end
	for i = 1, self.log_amount do
		local distance = math.abs(i - self.max_bend_log_no)
		local strength = 1
		if i - 1 < self.max_bend_log_no then
			strength = strength - distance / self.max_bend_log_no
		else
			strength = strength - distance / (self.log_amount - self.max_bend_log_no + 1)
		end
		local bend_offset = self.max_bend_value * math.sin(-math.rad(90 * strength))
		self.logs[i].bend_off = MathUtils.lerp(self.logs[i].bend_off, bend_offset, 1 - (1 - 0.25) ^ DTMULT)
		self.logs[i].y = self.logs[i].bend_off * math.sin(-math.rad(self.bend_angle))
	end
	for _, chara in ipairs(Game.stage:getObjects(Character)) do
		chara.last_sprite_y = chara.sprite.y
		if chara.log_index then
			local floor_log_y, ceil_log_y = 0, 0
			if chara.floored_log_index > 0 then
				floor_log_y = self.logs[chara.floored_log_index].y
			end
			if chara.ceiled_log_index <= self.log_amount then
				ceil_log_y = self.logs[chara.ceiled_log_index].y
			end
			chara.sprite.y = chara.last_sprite_y + MathUtils.lerp(floor_log_y, ceil_log_y, chara.log_index % 1) / 2
		end
	end
	Object.endCache()
end

function VaporBridge:draw()
	if not self.enabled then
		return
	end
	Draw.setColor(Game.world.map.fx.color or COLORS.white, 1)
	if self.log_dir == "horz" then
		for i = 1, self.log_amount do
			local _log = self.logs[i]
			local loglen = math.max(self.log_length - 2, 0) 
			Draw.drawPart(self.horz_log_tex[(_log.index % 2) + 1], 0, _log.x + _log.y, 0, 0, 10, 16, 0, 2, 2)
			if loglen > 0 then
				for i = 0, loglen + 1 do
					Draw.drawPart(self.horz_log_tex[(_log.index % 2) + 1], 20 + (i * 40), _log.x + _log.y, 10, 0, 20, 16, 0, 2, 2)
				end
			end
			Draw.drawPart(self.horz_log_tex[(_log.index % 2) + 1], 20 + (loglen * 40), _log.x + _log.y, 30, 0, 10, 16, 0, 2, 2)
		end
	else
		for i = 1, self.log_amount do
			local _log = self.logs[i]
			local loglen = math.max(self.log_length - 2, 0)
			Draw.drawPart(self.vert_log_tex[(_log.index % 2) + 1], _log.x - 2, _log.y, 0, 0, 11, 10, 0, 2, 2)
			if loglen > 0 then
				for i = 0, loglen + 1 do
					Draw.drawPart(self.vert_log_tex[(_log.index % 2) + 1], _log.x - 2, 20 + (i * 40) + _log.y, 0, 10, 11, 20, 0, 2, 2)
				end
			end
			Draw.drawPart(self.vert_log_tex[(_log.index % 2) + 1], _log.x - 2, 20 + (loglen * 40) + _log.y, 0, 30, 11, 16, 0, 2, 2)
		end
	end
	super.draw(self)
end

return VaporBridge