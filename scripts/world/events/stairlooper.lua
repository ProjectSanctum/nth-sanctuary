local CutsceneStairLooper, super = Class(Event)

function CutsceneStairLooper:init(data)
    super.init(self, data)
    local properties = data and data.properties or {}
	
    self.solid = false

    self.loop = true
	self.entered_loop = false
	self.dialogue_finish = true
	self.legend_finish = true
	self.xgobackamount = properties["xback"] or -120
	self.ygobackamount = properties["yback"] or 120
	self.type = properties["type"] or 0
	self.xpoint = properties["xpoint"] or 560
	self.ypoint = properties["ypoint"] or 0
    self.cutscene = properties["cutscene"]
	self.con = 0
	self.preventmenu = false
    self.set_flag = properties["setflag"]
    self.set_value = properties["setvalue"]
    self.once = properties["once"] ~= false
end

function CutsceneStairLooper:onLoad()
    super.onLoad(self)
    if self.once and self:getFlag("used_once", false) then
		self:remove()
    end
end

function CutsceneStairLooper:update()
    super.update(self)
	local rightloop = false
	local leftloop = false
	local px, py = 0, 0
	if self.world.player then
		px, py = self.world.player:getRelativePos(0, 0)
	end
	if not self.dialogue_finish and not self.world:hasCutscene() then
		self.dialogue_finish = true
	end
	if self.loop then
		if self.type == 0 then
			if px >= self.xpoint and px <= self.xpoint + math.abs(self.xgobackamount) and not self.entered_loop then
				self.entered_loop = true
				self.legend_finish = false
				if self.cutscene then
					self.dialogue_finish = false
					self.world:startCutscene(self.cutscene, self, chara)
				end
			end
			if self.entered_loop then
				if px >= self.xpoint + math.abs(self.xgobackamount) then
					rightloop = true
				end
				if px <= self.xpoint then
					leftloop = true
				end
			end
		end
		if self.type == 1 then
			if py >= self.ypoint and py <= self.ypoint + math.abs(self.ygobackamount) and not self.entered_loop then
				self.entered_loop = true
				self.legend_finish = false
				if self.cutscene then
					self.dialogue_finish = false
					self.world:startCutscene(self.cutscene, self, chara)
				end
			end
			if self.entered_loop then
				if py >= self.ypoint + math.abs(self.ygobackamount) then
					rightloop = true
				end
				if py <= self.ypoint then
					leftloop = true
				end
			end
		end
		if self.entered_loop and (rightloop or leftloop) then
			local xback = self.xgobackamount
			local yback = self.ygobackamount
			if leftloop then
				xback = -xback
				yback = -yback
			end
			self.world.player.x = self.world.player.x + xback
			self.world.player.y = self.world.player.y + yback
			for _, follower in ipairs(self.world.followers) do
				follower.x = follower.x + xback
				follower.y = follower.y + yback
				for _,point in ipairs(follower.history) do
					point.x = point.x + xback
					point.y = point.y + yback
				end
			end
			for _, legender in ipairs(self.world:getEvents("legender")) do
				legender.xx = legender.xx + xback
				legender.yy = legender.yy + yback
			end
			for _, fog in ipairs(self.world:getEvents("churchfog")) do
				fog.xx = fog.xx - xback/2
				fog.yy = fog.yy - yback/2
			end
		end
		if self.entered_loop then
			if self.dialogue_finish and self.legend_finish then
				self.loop = false
				self.preventmenu = false
				if self.set_flag then
					Game:setFlag(self.set_flag, (self.set_value == nil and true) or self.set_value)
				end
				if self.once then
					self:setFlag("used_once", true)
				end
			end
		end
	end
	if self.preventmenu then
		if self.world.can_open_menu then
			self.world.can_open_menu = false
		end
		self.world:closeMenu()
	else
		if not self.world.can_open_menu then
			self.world.can_open_menu = true
		end	
	end
end

return CutsceneStairLooper