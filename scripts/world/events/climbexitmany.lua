local ClimbExitMany, super = Class(ClimbExit)

function ClimbExitMany:init(data)
    settings = data and data.properties or {}
    super.init(data.x, data.y, data.shape, settings)

    self.target_down = settings.target_down
    self.target_up = settings.target_up
    self.target_left = settings.target_left
    self.target_right = settings.target_right

    self.target_x = {}
    self.target_y = {}

    self.exit["down"] = settings.can_exit_down ~= false
    self.exit["up"] = settings.can_exit_up ~= false
    self.exit["left"] = settings.can_exit_left ~= false
    self.exit["right"] = settings.can_exit_right ~= false
    self.auto_exit["down"] = false
    self.auto_exit["up"] = false
	self.auto_exit["left"] = false
    self.auto_exit["right"] = false

    if self.can_exit and self.target == nil then
        error(string.format("ClimbExit at (%d, %d) requires a target, found none", self.x, self.y))
    end
end

function ClimbExitMany:calculateAutoExit()
	local exits = {"down", "up", "left", "right"}
	for _, exitdir in ipairs(exits) do
		local x_diff = self.target_x[exitdir] - self.x
		local y_diff = self.target_y[exitdir] - self.y

		local climb_x = MathUtils.sign(x_diff)
		local climb_y = MathUtils.sign(y_diff)

		if climb_x ~= 0 and climb_y ~= 0 then
			-- Figure out which one went further
			if math.abs(x_diff) > math.abs(y_diff) then
				climb_y = 0
			else
				climb_x = 0
			end
		end

		if climb_x == 0 and climb_y == 0 then
			climb_y = -1
		end

		-- Now we use the directions (and invert them)
		if climb_x == 1 and not TableUtils.contains(self.auto_exit, "right") then
			self.auto_exit["right"] = true
		elseif climb_x == -1 and not TableUtils.contains(self.auto_exit, "left") then
			self.auto_exit["left"] = true
		elseif climb_y == 1 and not TableUtils.contains(self.auto_exit, "down") then
			self.auto_exit["down"] = true
		elseif climb_y == -1 and not TableUtils.contains(self.auto_exit, "up") then
			self.auto_exit["up"] = true
		end
	end
end

---@return "up"|"down"|"left"|"right"|nil
function ClimbExitMany:getExitDirection()
    if not self.can_exit then
        return nil
    end
	local player = Game.world.player
    return (self.exit[player:getFacing()] or self.auto_exit[player:getFacing()]) and player:getFacing()
end

function ClimbExitMany:getExitPosition()
	local player = Game.world.player
    return self.target_x[player:getFacing()], self.target_y[player:getFacing()]
end

function ClimbExitMany:onLoad()
    if self.can_exit == false then
        return
    end

	local tx, ty, _ = TiledUtils.parseMarkerProperty(self, self.target_down, "target_down")
	self.target_x["down"] = tx or nil
	self.target_y["down"] = ty or nil
	tx, ty, _ = TiledUtils.parseMarkerProperty(self, self.target_up, "target_up")
	self.target_x["up"] = tx or nil
	self.target_y["up"] = ty or nil
	tx, ty, _ = TiledUtils.parseMarkerProperty(self, self.target_down, "target_left")
	self.target_x["left"] = tx or nil
	self.target_y["left"] = ty or nil
	tx, ty, _ = TiledUtils.parseMarkerProperty(self, self.target_right, "target_right")
	self.target_x["right"] = tx or nil
	self.target_y["right"] = ty or nil
    self:calculateAutoExit()
end

return ClimbExitMany
