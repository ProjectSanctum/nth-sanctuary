---@class Event.climbentry : Event
local event, super = Class(Event, "climbentry")

function event:init(data)
    super.init(self, data)
    local properties = data and data.properties or {}
    self.up = properties.up or false
    self.yoffset = properties.yoff or (self.up and -5 or (self.height + 40))
	self.marker = properties["marker"] or nil
	self.center_if_tower = properties["towercenter"] ~= false
    self.timer = self:addChild(Timer())
	self.true_x = self.x
end

function event:update()
    super.update(self)
	if self.center_if_tower and self.world.player and not (self.world.player.onrotatingtower) then
		self.x = self.world.map.cyltower.tower_x - 20
	else
		self.x = self.true_x
	end
    if
        not Game.lock_movement
        and self.world:hasCutscene()
        and Input.pressed("confirm")
        and self.world.player.interact_collider[self.world.player.facing]:collidesWith(self)
    then
        self:onInteract(self.world.player, self.world.player.facing)
    end
end

---@param chara Character
local function jumpTo(chara, ...)
    chara:jumpTo(...)
    return function() return not chara.jumping end
end

local function co_wrap(func)
    local thread = coroutine.create(func)
    return function (...)
        local ok, msg = coroutine.resume(thread, ...)
        if not ok then
            COROUTINE_TRACEBACK = debug.traceback(thread)
            error(msg)
        end
    end
end

function event:startScript(func)
    local co co = co_wrap(function ()
        Game.lock_movement = true
        func({wait = function (t)
            if type(t) == "number" then
                self.timer:after(t, co)
            else
                self.timer:afterCond(t, co)
            end
            coroutine.yield()
        end})
        Game.lock_movement = false
    end)
    co()
end

---@param player Player
function event:onInteract(player, dir)
    if player.state_manager.state ~= "WALK" then return end
    if dir ~= "up" and dir ~= "down" then
        Kristal.Console:warn("climbentry interacted at a weird angle ("..dir..")! Assuming \"down\"...")
        dir = "down"
    end

    local id = "climb_fade"
    for _,follower in ipairs(self.world.followers) do
        local mask = follower:addFX(AlphaFX(1), id)
        self.world.timer:tween(10/30, mask, {alpha = 0})
    end

    self:startScript(function (scr)
        -- TODO: Accurate camera movement
        self.world:setCameraAttached(false)
        self.world.camera:panTo(self.x + (self:getScaledWidth()/2), self.y+(self.up and 38 or -32), .5)
        local tx = MathUtils.round(player.x-(self.x+20), 40)+(self.x+20)
        tx = MathUtils.clamp(tx, self.x+20, self.x+self.width-20)
        local ty = MathUtils.round(self.y, 40)
        if dir == "down" then
            ty = ty + 80
        else
            ty = ty
        end
        
        Assets.playSound("wing")
        player.sprite:set("jump_ball")
        scr.wait(jumpTo(player,tx,ty,10,.5))
        player:resetSprite()
        self.world:detachFollowers()
		if self.marker then
			player:setPosition(self.world.map:getMarker(self.marker))
		end
        Assets.playSound("noise")
        player:setState("CLIMB")
		if self.world.map.cyltower then
			if self.center_if_tower then
				player.x = self.true_x + 20
			end
			player.onrotatingtower = true
			player.falseloop = true
			player.falseloopx = {}
			player.falseloopx[1] = 0
			player.falseloopx[2] = self.world.map.cyltower.tower_circumference
		end
    end)
end

---@param player Player
function event:preClimbEnter(player)
    if player.state_manager.state == "CLIMB" then
        player:setState("WALK")
        local tx, ty = player.x, self.y
        ty = ty + self.yoffset
        -- TODO: Accurate camera movement
		if self.world.map.cyltower then
			tx = self.world.map.cyltower.tower_x
			self.world.player.onrotatingtower = false
			self.world.player.x = tx
			self.world.camera:panTo(self.world.camera.x, self.y+(self.up and -42 or 43), .5, nil, function()
				Kristal.Console:log(self.world.camera.y)
				self.world.camera:setAttached(true)
			end)
		else
			self.world.camera:panTo(self.x + (self:getScaledWidth()/2), self.y+(self.up and -42 or 43), .5, nil, function()
				Kristal.Console:log(self.world.camera.y)
				self.world.camera:setAttached(true)
			end)
		end
        self:startScript(function (scr)
            Assets.stopAndPlaySound("wing")
            player.sprite:set("jump_ball")
            scr.wait(jumpTo(player,tx,ty,10,.5))
            player:resetSprite()
            Assets.playSound("noise")
            local id = "climb_fade"
            for i,follower in ipairs(self.world.followers) do
                local mask = follower:getFX(id)
                if mask then
                    self.world.timer:tween(10/30, mask, {alpha = 1}, nil, function ()
                        follower:removeFX(mask)
                    end)
                end
                -- TODO: Support parties > 3
                follower:setPosition(tx + (i == 1 and -30 or 30), ty + (self.up and 10 or -10))
                follower:setFacing(player.facing)
            end
            self.world.player:interpolateFollowers()
            self.world:attachFollowers()
        end)
    end
end

return event
