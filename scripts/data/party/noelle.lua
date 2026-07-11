local character, super = Class("noelle", true)

function character:init()
    super.init(self)
	
    self.level = 3
    self.title = "Mistletoe\nThings got\nserious today."
end

function character:getTitle()
    local prefix = "LV"..self:getLevel().." "
    if self:checkWeapon("thornring") then
        return prefix.."Ice Trancer\nReceives pain to\nbecome stronger."
    elseif self:getFlag("iceshocks_used", 0) > 0 then
        return prefix.."Frostmancer\nFreezes the enemy."
    elseif self:checkArmor("doctrine_veil") then
        return prefix.."   \nA veil that\nhides the truth."    
    else
        return super.getTitle(self)
    end
end

function character:hasXAct()
    if self:checkArmor("doctrine_veil") then
        return false
    end 
    return true   
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        local icon = Assets.getTexture("ui/menu/icon/snow")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Coldness", x, y)
        local coldness = MathUtils.clamp(47 + (self:getFlag("iceshocks_used", 0) * 7), 47, 100)
        love.graphics.print(coldness, x+130, y)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/exclamation")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Boldness", x, y, 0, 0.8, 1)
        love.graphics.print(self:getFlag("boldness", -12), x+130, y)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)
        return true
    end
end

return character