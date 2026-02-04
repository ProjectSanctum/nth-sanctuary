---@class DarkMenu : Object
---@overload fun(...) : DarkMenu
local DarkMenu, super = HookSystem.hookScript(DarkMenu)

function DarkMenu:init()
    super.init(self, 0, -80)
	self.shard_sprite = Assets.getTexture("ui/menu/icon/shard")
end


function DarkMenu:draw()
    super.draw(self)
    if not self.description_box.visible then
		Draw.setColor(COLORS.black)
		love.graphics.rectangle("fill",510, 10, 100, 60)
		Draw.setColor(COLORS.white)
        love.graphics.print(Game:getConfig("darkCurrencyShort") .. " " .. Game.money, 520, 10)
        Draw.draw(self.shard_sprite, 520, 46, 0, 2, 2)
	    local shards = tostring(Mod:getDarkShardCount())
        love.graphics.print(shards, 554, 41)
    end

end


return DarkMenu
