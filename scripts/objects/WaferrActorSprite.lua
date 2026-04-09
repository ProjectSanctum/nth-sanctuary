---@diagnostic disable: undefined-field
local OrganikkActorSprite, super = Class(ActorSprite)

function OrganikkActorSprite:init(actor)
    super.init(self, actor)

    self.body = Sprite(self:getTexturePath("body"), 0, 0)
    self.body.debug_select = false
    self:addChild(self.body)

    self.head = Sprite(self:getTexturePath("head"), 0, 0)
    self.head.debug_select = false
    self:addChild(self.head)
	
    self.head_chip = Sprite(self:getTexturePath("head_chip"), 0, 0)
    self.head_chip.debug_select = false
    self:addChild(self.head_chip)

    self.siner_2 = 0
    self.siner = 0
end

function OrganikkActorSprite:update()
    super.update(self)

    self.siner_2 = self.siner_2 + 1/6 * DTMULT
    self.siner = self.siner + 0.1 * DTMULT

    local anim = self.anim or "idle"
    if anim == "idle" or anim == "right" then
        local scale = (anim == "right") and -1 or 1
        local bx = (anim == "right") and 30 or 0
        self.head.scale_x = scale
        self.head_chip.scale_x = scale
        self.body.scale_x = scale
        self.head.x = bx
        self.head_chip.x = bx
        self.body.x = bx
        self.head.y = math.sin(self.siner)
        self.head_chip.y = math.sin(self.siner_2) * 0.9
    end
end

function OrganikkActorSprite:getTexturePath(sprite_name)
    return self.actor:getSpritePath() .. '/' .. self.actor.parts[sprite_name][1]
end

function OrganikkActorSprite:set(anim, ...)
    self.actor:onSetAnimation(self, anim, ...)
end

function OrganikkActorSprite:setPartVisible(boolean)
    for _, child in ipairs(self.children) do
        child.visible = boolean
    end
end

return OrganikkActorSprite