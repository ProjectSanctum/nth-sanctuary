local character, super = Class("susie", true)

function character:init()
    super.init(self)

    self:removeSpell("ok_heal")
    self:addSpell("better_heal")
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        local icon = Assets.getTexture("ui/menu/icon/demon")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Rudeness", x, y)
        if Game.chapter == 1 then
            love.graphics.print("99", x+130, y)
        else
            love.graphics.print("89", x+130, y)
        end
        return true
    elseif index == 2 then
        if Game.chapter >= 4 then
            if self:checkWeapon("cruelaxe") == true then
                local icon = Assets.getTexture("enemies/jellycruel/jellycruel")
                Draw.draw(icon, x-26, y+6, 0, 0.5, 0.5)
                love.graphics.print("Cruel", x, y, 0, 2, 1)
            else
				love.graphics.print("* Healing", x-24, y)
				love.graphics.print(15 + (self:getFlag("healing_used") or 0), x+130, y)
			end
            return true
		end
        local icon = Assets.getTexture("ui/menu/icon/demon")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        if Game.chapter == 1 then
            love.graphics.print("Crudeness", x, y, 0, 0.8, 1)
            love.graphics.print("100", x+130, y)
        elseif Game.chapter == 2 then
            love.graphics.print("Purple", x, y, 0, 0.8, 1)
            love.graphics.print("Yes", x+130, y)
        end
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        Draw.draw(icon, x+90, y+6, 0, 2, 2)
        Draw.draw(icon, x+110, y+6, 0, 2, 2)
        if Game.chapter >= 3 then
            Draw.draw(icon, x+130, y+6, 0, 2, 2)
        end
        if Game.chapter >= 4 then
            Draw.draw(icon, x+150, y+6, 0, 2, 2)
        end
        return true
    end
end

return character
