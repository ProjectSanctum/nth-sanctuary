local CreatureActorGuei, super = Class(ActorSprite)

function CreatureActorGuei:init(actor)
    local static_fx = ShaderFX(Mod.staticBulletShader, {
        ["time"] = function() return Kristal.getTime() end,
        ["brightness"] = 2
    })


    super.init(self, actor)
    self.body = Sprite(self:getTexturePath("body"), 0, 24)
    self.body.debug_select = true
    self:addChild(self.body)
    self.body:addFX(static_fx, "static_fx")

    self.eye = Part(17, 15, 10)
    self:addChild(self.eye)

    self.hand = Sprite(self:getTexturePath("hand"), -15, 30)
    self.hand.debug_select = false
    self.hand:setColor(COLORS.red)
    self:addChild(self.hand)
    self.hand:addFX(static_fx, "static_fx")

    self.hand2 = Sprite(self:getTexturePath("wisp1"), 11, 15)
    self.hand2.debug_select = true
    self.hand2:setColor(COLORS.yellow)
    self:addChild(self.hand2)
    self.hand2:addFX(static_fx, "static_fx")
    

    self.hand3 = Sprite(self:getTexturePath("hand"), 30, 33)
    self.hand3.debug_select = false
    self.hand3:setColor(COLORS.green)
    self:addChild(self.hand3)
    self.hand3:addFX(static_fx, "static_fx")

    self.hand4 = Sprite(self:getTexturePath("wisp2"), 11, 45)
    self.hand4.debug_select = true
    self.hand4:setColor(COLORS.blue)
    self:addChild(self.hand4)
    self.hand4:play(1/7, true)
    self.hand4:addFX(static_fx, "static_fx")

    self.animsiner = -14
    self.siner = 0
end

function CreatureActorGuei:getTexturePath(sprite_name)
    return self.actor:getSpritePath() .. '/' .. self.actor.parts[sprite_name][1]
end

function CreatureActorGuei:update()
    super.update(self)

    self.siner = self.siner + DT
    self.animsiner = self.animsiner + (1 * DTMULT)

    self.body:setFrame(math.floor(self.animsiner / 6))

    self.hand.x = math.sin(self.siner * 1.5) * 24 + 8
    self.hand.y = -math.cos(self.siner * 1.5) * 12 + 30
    if self.hand.x < -14 then
        self.hand:setLayer(self.body.layer - 1)
    elseif self.hand.x > 28 then
        self.hand:setLayer(self.body.layer + 1)
    end

    self.hand2.x = math.sin(math.pi/2 + self.siner * 1.5) * 24 + 11
    self.hand2.y = -math.cos(math.pi/2 + self.siner * 1.5) * 12 + 26
    self.hand2:setFrame(math.floor(self.animsiner / 6))
    self.hand2.alpha = 0.5 + math.sin(self.animsiner / 14) * 0.5
    if self.hand2.x < -12 then
        self.hand2:setLayer(self.body.layer - 1)
    elseif self.hand2.x > 26 then
        self.hand2:setLayer(self.body.layer + 1)
    end
    
    self.hand3.x = math.sin(math.pi + self.siner * 1.5) * 24 + 8
    self.hand3.y = -math.cos(math.pi + self.siner * 1.5) * 12 + 30
    print(self.hand3.x, self.hand3.layer)
    if self.hand3.x < -14 then
        self.hand3:setLayer(self.body.layer - 1)
    elseif self.hand3.x > 28 then
        self.hand3:setLayer(self.body.layer + 1)
    end

    self.hand4.x = math.sin((math.pi * 1.5) + self.siner * 1.5) * 24 + 11
    self.hand4.y = -math.cos((math.pi * 1.5) + self.siner * 1.5) * 12 + 26
    self.hand4:setFrame(math.floor(self.animsiner / 6))
    self.hand4.alpha = 0.5 + math.sin(self.animsiner / 14) * 0.5
    if self.hand4.x < -12 then
        self.hand4:setLayer(self.body.layer - 1)
    elseif self.hand4.x > 26 then
        self.hand4:setLayer(self.body.layer + 1)
    end
    --self.eye.rotation = self.eye.rotation + (DTMULT/40)

end

return CreatureActorGuei