---@class Map.dark_place : Map
local map, super = Class(Map)

function map:init(world, data)
	super.init(self, world, data)
    self.ripindex = 0
    self.con = 0
    self.finished = false
    self.fakefader = Rectangle(0,0,999,999)
    self.fakefader.alpha = 0
end

function map:onEnter()
	local r = self.world:getCharacter("ralsei")
	local s = self.world:getCharacter("susie")
	local j = self.world:getCharacter("jamm")
	local party = {r, s, j}
	r.x, r.y = 400, 200
	s.x, s.y = 320, 200
	j.x, j.y = 480, 200
	Game.world.timer:script(function (wait)
		for _, p in ipairs(party) do
			p.following = false
			p:walkTo(p.x, p.y+40, 0.55)
		end
		wait(1)
		Assets.playSound("jump")
		for _, p in ipairs(party) do
			p:setSprite("ball")
			p.sprite:play(1/7, true)
			p.physics.speed_y = -12
			p.physics.gravity = 1
		end
		wait(1)
		for _, p in ipairs(party) do
			p.state = "SLIDE"
		end

	end)
end

function map:update()
	super.update(self)
end

function map:spawnRippleBurst()
    local seqtime = 0.17647
    for i = 0, 8 do
        Game.world.timer:after(seqtime * i, function()
            self:makeRippleLogic()
        end)
    end
end

function map:makeRippleLogic()
    local cx,cy = Game.world.camera.x-SCREEN_WIDTH/2, Game.world.camera.y-SCREEN_HEIGHT/2
    local loc = {}
    local border = 80
    table.insert(loc, {x = cx + 0 + border, y = cy + 0 + border})
    table.insert(loc, {x = cx + SCREEN_WIDTH - border, y = cy + 0 + border})
    table.insert(loc, {x = cx + 0 + border, y = cy + SCREEN_HEIGHT - border})
    table.insert(loc, {x = cx + SCREEN_WIDTH - border, y = cy + SCREEN_HEIGHT - border})
    border = 120
    table.insert(loc, {x = cx + SCREEN_WIDTH/2, y = cy + SCREEN_HEIGHT/2 + border})
    table.insert(loc, {x = cx + SCREEN_WIDTH/2, y = cy + SCREEN_HEIGHT/2 - border})
    border = 160
    table.insert(loc, {x = cx + SCREEN_WIDTH/2 + border, y = cy + SCREEN_HEIGHT/2})
    table.insert(loc, {x = cx + SCREEN_WIDTH/2 - border, y = cy + SCREEN_HEIGHT/2})
    
    local masterdir = 0
    if Game.world.player then
        masterdir = MathUtils.angle(Game.world.player.x, Game.world.player.y, Game.world.player.x + Game.world.player.moving_x, Game.world.player.y + Game.world.player.moving_y)
    end
    local hhsp = -math.cos(masterdir) * 2
    local vvsp = -math.sin(masterdir) * 2
    
    self.ripple_fx_alt:makeRipple(loc[self.ripindex+1].x, loc[self.ripindex+1].y, 60, COLORS.white, 200, 1, 14, -5, hhsp, vvsp, 0.25)
    self.ripindex = (self.ripindex + 1) % #loc
end

function map:onExit()
	Game:setFlag("ripple2nd", false)
    self.world.color = COLORS.white
end


function map:doIntro()    
    self.ripple_fx = RippleEffect()
    self.ripple_fx.layer = WORLD_LAYERS["bottom"]
    Game.stage:addChild(self.ripple_fx)
    self.ripple_fx_alt = RippleEffect()
    self.ripple_fx_alt.layer = 0.8
    Game.stage:addChild(self.ripple_fx_alt)
    

    Game.world.map.timer:script(function(wait)
        wait(10/30)
        self.con = 1
        Game.world.music:play("second_church", 0.7, 1)

        local beat_times = {0, 95.25, 190.5, 285.75, 381, 476.25, 571.5, 666.75}
        local current_beat = 1

        for i = 1, #beat_times do
            self:spawnRippleBurst()
            
            if i == 5 then 
                for _, window in ipairs(Game.world.map:getEvents("window_glow")) do
                    Game.world.timer:tween(300/30, window, {alpha = 1}, "linear")
                end
            end

            if beat_times[i+1] then
                wait((beat_times[i+1] - beat_times[i]) / 30)
            end
        end

        wait((720 - 666.75) / 30)
        Game.stage:addChild(self.fakefader)
		self.fakefader:setParallax(0)	
        Game.world.timer:tween(1, self.fakefader, {alpha = 1}, nil, function() 
            self.finished = true
            Game.world.color = COLORS.white
            self.world:loadMap("2_2nd_sanctuary/second_sanctum_0_ripple_post", "spawn")
            self.fakefader:fadeOutAndRemove(0.5)
            self.con = 2
        end)

        -- wait(60/30)
        -- self:transitionMap()
    end)
end

return map