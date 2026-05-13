local Basic, super = Class(Wave)

function Basic:init()
    super.init(self)
    self.time = 30
    self.input = [[#thSanctuary:setState("TRAGEDY") ]]
	self.flipped = TableUtils.pick({true, false})
end

function Basic:onStart()
    -- Every 0.33 seconds...
    local h = Text("", Game.battle.arena:getLeft()-140, Game.battle.arena:getTop() - 50)
    self:spawnObject(h)
    self.timer:script(function(wait)
        wait(1)
        for i = 1, #self.input do
            h:setText(self.input:sub(1, i))
            wait(1/30)
            Assets.playSound("voice/default")
        end
		local fliprot = math.rad(90)
		if self.flipped then
			fliprot = math.rad(-90)
			self.stay = Sprite("stayhere_flip")
			self:spawnObject(self.stay, Game.battle.arena:getRight()-134, Game.battle.arena:getTop()-20)
		else
			self.stay = Sprite("stayhere")
			self:spawnObject(self.stay, Game.battle.arena:getLeft()-20, Game.battle.arena:getTop()-20)
		end
        self.stay:setLayer(9999)
        self.stx, self.sty = self.stay.x, self.stay.y
        for k = 0, 5, 0.1 do
            h:setText("[shake:"..k.."]"..self.input)
            wait(1/29)
        end
        wait(1)
		if self.flipped then
			h.x = Game.battle.arena:getLeft()-140-Game.battle.arena.width-71
		end
        h:explode()
        self.stay:remove()
        Game.battle.arena:shake(10, 0, 0.5, 1/15)
        Assets.playSound("snd_closet_fall")
        self.timer:tween(3, Game.battle.arena, {y = Game.battle.arena.y + 700, rotation = fliprot}, "in-cubic", function()
            if Game.battle.soul.y > SCREEN_HEIGHT + 19 then
				Game.battle.soul.active = false
                Assets.playSound("error", 1.2)
                self.timer:after(1, function()
					local sndpitch = 1
                    for _, battler in ipairs(Game.battle.party) do
						battler:hurt(40)
						Assets.playSound("statuseffect", 1-(#Game.battle.party)*0.08, sndpitch)
						sndpitch = sndpitch - 0.1
						if not battler:hasStatus("poison") then
							battler:inflictStatus("poison")
							battler.hit_count = battler.hit_count + 1
							battler:statusMessage("msg", "poisoned")
						end
                    end
					Assets.playSound("mercy_down")
					Game.battle.enemies[1]:addMercy(-5)
                end)
            else
                Assets.playSound("dumbvictory")
                self.timer:after(1, function()
                    for _, battler in ipairs(Game.battle.party) do
                        battler:heal(1)
                    end
                    Game.battle.enemies[1]:addMercy(5)
                end)
            end
            self.timer:after(1, function()
				Game.battle.soul.active = true
                self:setFinished()
			end)
        end)
    end)
end

function Basic:update()
    -- Code here gets called every frame
    super.update(self)
    if self.stay then
        self.stay.x = self.stx + math.sin(Kristal.getTime()*100)
        self.stay.y = self.sty - math.cos(Kristal.getTime()*100)
    end
end

return Basic