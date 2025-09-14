local GueiActorSprite, super = Class(ActorSprite)

function GueiActorSprite:init(actor)
    super.init(self, actor)

    self.arm_back = Sprite(self:getTexturePath("arm_back"), 0, 0)
    self.arm_back.debug_select = false
    self:addChild(self.arm_back)

    self.body = Sprite(self:getTexturePath("body"), 0, 0)
    self.body.debug_select = false
    self:addChild(self.body)

    self.head = Sprite(self:getTexturePath("head"), 0, 0)
    self.head.debug_select = false
    self:addChild(self.head)

    self.arm_front = Sprite(self:getTexturePath("arm_front"), 0, 0)
    self.arm_front.debug_select = false
    self:addChild(self.arm_front)

    self.wisp1 = Sprite(self:getTexturePath("wisp1"), 0, 0)
    self.wisp1.debug_select = false
    self:addChild(self.wisp1)

    self.wisp2 = Sprite(self:getTexturePath("wisp2"), 0, 0)
    self.wisp2.debug_select = false
    self:addChild(self.wisp2)

	self.animsiner = -14
end

function GueiActorSprite:getTexturePath(sprite_name)
    return self.actor:getSpritePath() .. '/' .. self.actor.parts[sprite_name][1]
end

function GueiActorSprite:set(anim, ...)
    self.actor:onSetAnimation(self, anim, ...)
end

function GueiActorSprite:setPartVisible(boolean)
    for _, child in ipairs(self.children) do
        child.visible = boolean
    end
end

function GueiActorSprite:update()
    super.update(self)

    if self.anim == "idle" or self.anim == "spared" then
        self.animsiner = self.animsiner + (1 * DTMULT)

        self.arm_back:setFrame(math.floor((self.animsiner + 2) / 6))
        self.body:setFrame(math.floor(self.animsiner / 6))
        self.head:setFrame(math.floor(self.animsiner / 6))
        self.arm_front:setFrame(math.floor((self.animsiner + 4) / 6))
		
        self.wisp1:setFrame(math.floor(self.animsiner / 6))
        self.wisp1.alpha = math.sin(self.animsiner / 14) * 0.5
        self.wisp1.x = 0 + (math.sin(self.animsiner / 6) * 2)
        self.wisp1.y = 0 + (math.cos(self.animsiner / 6) * 2)

        self.wisp2:setFrame(math.floor(self.animsiner / 6))
        self.wisp2.alpha = math.sin((self.animsiner + 7) / 14) * 0.5
        self.wisp2.x = 0 - (math.sin(self.animsiner / 6) * 2)
        self.wisp2.y = 0 - (math.cos(self.animsiner / 6) * 2)
    end
end

return GueiActorSprite