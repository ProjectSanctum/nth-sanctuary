local CreatureActorMizzle, super = Class(ActorSprite)

function CreatureActorMizzle:init(actor)
    local static_fx = ShaderFX("static_bullet", {
        ["time"] = function() return Kristal.getTime() end,
        ["brightness"] = 2
    })

    super.init(self, actor)

    self.body = Sprite(self:getTexturePath("body"), 0, 24)
    self.body.debug_select = true
    self:addChild(self.body)
    self.body:addFX(static_fx, "static_fx")

    self.head = Sprite(self:getTexturePath("head"), 25, 0)
    self.head.debug_select = false
    self:addChild(self.head)
    self.head:addFX(static_fx, "static_fx")

    self.eye = Part(40, 13, 8)
    self:addChild(self.eye)

    self.animsiner = -14
    self.siner = 0
end

function CreatureActorMizzle:getTexturePath(sprite_name)
    return self.actor:getSpritePath() .. '/' .. self.actor.parts[sprite_name][1]
end

function CreatureActorMizzle:update()
    super.update(self)

    self.siner = self.siner + DT
    self.animsiner = self.animsiner + (1 * DTMULT)

    self.body:setFrame(math.floor(self.animsiner / 6))
    self.head.x = 25 + (math.cos(self.siner*2.5) * 10)/2
    self.head.y = 0 - (math.sin(self.siner*5)*5)/2
    self.eye.x = 40 + (math.cos(self.siner*2.5) * 10)/2
    self.eye.y = 13 - (math.sin(self.siner*5)*5)/2

    self.x = self.x + (math.cos(self.siner) * 5)/10
    self.y = self.y - ((math.sin(self.siner) * 5)/5)/2
    
    
    --self.eye.rotation = self.eye.rotation + (DTMULT/40)

end

return CreatureActorMizzle