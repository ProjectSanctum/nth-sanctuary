local CreatureActorGuei, super = Class(ActorSprite)

function CreatureActorGuei:init(actor)
    super.init(self, actor)
    self.body = Sprite(self:getTexturePath("body"), 0, 0)
    self.body.debug_select = true
    self:addChild(self.body)

    self.eye = Part(17, 15, 10)
    self:addChild(self.eye)

    self.hand = Sprite(self:getTexturePath("hand"), -15, 30)
    self.hand.debug_select = false
    self:addChild(self.hand)

    self.siner = 0
end

function CreatureActorGuei:getTexturePath(sprite_name)
    return self.actor:getSpritePath() .. '/' .. self.actor.parts[sprite_name][1]
end

function CreatureActorGuei:update()
    super.update(self)

    self.siner = self.siner + DT
    self.hand.x = self.hand.x + math.sin(self.siner * 2) * 1.5
    self.hand.y = self.hand.y - math.cos(self.siner * 2) * 0.5
    if self.hand.x < -14 then
        self.hand:setLayer(self.body.layer - 1)
    elseif self.hand.x > 28 then
        self.hand:setLayer(self.body.layer + 1)
    end
    --self.eye.rotation = self.eye.rotation + (DTMULT/40)

end
return CreatureActorGuei