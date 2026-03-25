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

function DarkMenu:getButtonSpacing()
    if #self.buttons <= 4 then
        return 105
    else
        return 105 - (#self.buttons * #self.buttons)
    end
end

function DarkMenu:addButtons()
    -- ITEM
    self:addButton({
        ["state"]          = "ITEMMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/item"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/item_h"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/item"),
        ["callback"]       = function()
            self.box = DarkItemMenu()
            self.box.layer = 1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end
    })

    -- EQUIP
    self:addButton({
        ["state"]          = "EQUIPMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/equip"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/equip_h"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/equip"),
        ["callback"]       = function()
            self.box = DarkEquipMenu()
            self.box.layer = 1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end
    })

    -- POWER
    self:addButton({
        ["state"]          = "POWERMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/power"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/power_h"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/power"),
        ["callback"]       = function()
            self.box = DarkPowerMenu()
            self.box.layer = 1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end
    })
    
    -- TALK
    self:addButton({
        ["state"]          = "SANCTUM",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/sanctum"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/sanctum_h"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/sanctum"),
        ["callback"]       = function()
            Input.clear("confirm")
            Game.world:closeMenu()

            self.ui_select:stop()
            self.ui_select:play()

            Game.world:startCutscene("travel_button")
        end
    })

    -- CONFIG
    self:addButton({
        ["state"]          = "CONFIGMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/config"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/config_h"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/config"),
        ["callback"]       = function()
            self.box = DarkConfigMenu()
            self.box.layer = -1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end
    })
end

return DarkMenu
