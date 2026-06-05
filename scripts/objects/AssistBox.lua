---@class AssistBox : Object
---@overload fun(...) : AssistBox
local AssistBox, super = Class(Object)

function AssistBox:init(x, y, index, battler)
    super.init(self, x, y)

    self.selection_siner = 0

    self.index = index
    self.battler = battler

    self.data_offset = 0

    -- self.box = ActionBoxDisplay(self)
    -- self.box.layer = 1
    -- self:addChild(self.box)

    self.head_offset_x, self.head_offset_y = battler.chara:getHeadIconOffset()	-- temporary probably
	
	self.assist_path = battler.chara.assist_path
	self.icon_path = self.assist_path .. "/icons"

    self.head_sprite = Sprite(self.icon_path .. "/head", 13 + self.head_offset_x, 11 + self.head_offset_y)
    self.force_head_sprite = false

    if battler.chara:getNameSprite() then
        self.name_sprite = Sprite(self.assist_path .. "/name", 51, 14)
        self:addChild(self.name_sprite)
    end

    self.hp_sprite = Sprite("ui/hp", 119, 22)

    self:addChild(self.head_sprite)
    self:addChild(self.hp_sprite)
	
	self.font = Assets.getFont("smallnumbers")
end

function AssistBox:setHeadIcon(icon)
    self.force_head_sprite = true

    local full_icon = self.icon_path .. "/" .. icon
    if self.head_sprite:hasSprite(full_icon) then
        self.head_sprite:setSprite(full_icon)
    else
        self.head_sprite:setSprite(self.icon_path .. "/head")
    end
end

function AssistBox:resetHeadIcon()
    self.force_head_sprite = false

    local full_icon = self.icon_path .. "/head"
    self.head_sprite:setSprite(full_icon)
end

function AssistBox:update()
    self.selection_siner = self.selection_siner + 2 * DTMULT

    self:animateBox()

    self.head_sprite.y = 11 - self.data_offset + self.head_offset_y
    if self.name_sprite then
        self.name_sprite.y = 14 - self.data_offset
    end
    self.hp_sprite.y = 22 - self.data_offset

    if not self.force_head_sprite then
        local current_head = self.icon_path .. "/head"

        if not self.head_sprite:isSprite(current_head) then
            self.head_sprite:setSprite(current_head)
        end
    end

    super.update(self)
end

function AssistBox:animateBox()
    -- if Game.battle.current_selecting == self.index then
        -- if self.box.y > -32 then self.box.y = self.box.y - 2 * DTMULT end
        -- if self.box.y > -24 then self.box.y = self.box.y - 4 * DTMULT end
        -- if self.box.y > -16 then self.box.y = self.box.y - 6 * DTMULT end
        -- if self.box.y > -8  then self.box.y = self.box.y - 8 * DTMULT end
        -- -- originally '= -64' but that was an oversight by toby
        -- if self.box.y < -32 then self.box.y = -32 end
    -- elseif self.box.y < -14 then
        -- self.box.y = self.box.y + 15 * DTMULT
    -- else
        -- self.box.y = 0
    -- end
end

function AssistBox:draw()
    Draw.setColor({0, 0, 0, 1})
	love.graphics.rectangle("fill", 4, 6, 204, 29)
    Draw.setColor(self.battler.chara.assist_color)
    love.graphics.setLineWidth(2)
    love.graphics.line(5  , 6, 5,   35)
    love.graphics.line(Game:getConfig("oldUIPositions") and 207 or 208, 6, Game:getConfig("oldUIPositions") and 207 or 208, 35)
    love.graphics.line(4  , 6, 209, 6 )
    Draw.setColor(1, 1, 1, 1)

    Draw.setColor(PALETTE["action_health_bg"])
    love.graphics.rectangle("fill", 138, 22 - self.data_offset, 66, 9)

    local health = (self.battler.chara:getAssistHealth() / self.battler.chara:getStat("assist_health")) * 66

    if health > 0 then
        Draw.setColor(self.battler.chara.assist_color)
        love.graphics.rectangle("fill", 138, 22 - self.data_offset, math.ceil(health), 9)
    end


    local color = PALETTE["action_health_text"]
    if health <= 0 then
        color = PALETTE["action_health_text_down"]
    elseif (self.battler.chara:getAssistHealth() <= (self.battler.chara:getStat("assist_health") / 4)) then
        color = PALETTE["action_health_text_low"]
    else
        color = PALETTE["action_health_text"]
    end


    local health_offset = 0
    health_offset = (#tostring(self.battler.chara:getAssistHealth()) - 1) * 8

    Draw.setColor(color)
    love.graphics.setFont(self.font)
    love.graphics.print(self.battler.chara:getAssistHealth(), 152 - health_offset, 9 - self.data_offset)
    Draw.setColor(PALETTE["action_health_text"])
    love.graphics.print("/", 161, 9 - self.data_offset)
    local string_width = self.font:getWidth(tostring(self.battler.chara:getStat("assist_health")))
    Draw.setColor(color)
    love.graphics.print(self.battler.chara:getStat("assist_health"), 205 - string_width, 9 - self.data_offset)

    super.draw(self)
end

return AssistBox
