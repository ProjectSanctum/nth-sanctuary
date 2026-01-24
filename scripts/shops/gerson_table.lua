local GersonTable, super = Class(Shop)

function GersonTable:init()
    super.init(self)

    self.encounter_text = ""
    self.shop_text = ""
    self.leaving_text = ""
    self.buy_menu_text = "Shall we\nchoose\nsomething?"
    self.buy_refuse_text = "Shall we\nchoose\nsomething?"
    self.buy_text = "Umm, and\nhere's\nchange!"
    self.buy_storage_text = "Whee!\nInto our\nSTORAGE!"
    self.buy_too_expensive_text = "Sorry,\nKris! No\nmoney..."
	self.buy_no_space_text = "No room...\nLet's SELL\nupstairs!"
	
	self.shop_music = nil

    self:registerItem("rhapsotea")
    self:registerItem("scarlixir")
    self:registerItem("waferguard")
    self:registerItem("scarfmark")
    
    self.hide_world = false
	self.bg_cover.visible = false
end

function GersonTable:onLeave()
    self:setState("LEAVING")
end

function GersonTable:onEnter()
    self:setState("BUYMENU")
end

function GersonTable:onStateChange(old,new)
    Game.key_repeat = false
    self.buy_confirming = false
    self.sell_confirming = false
	if new == "MAINMENU" then
        self:onLeave()
		return
    end
	super.onStateChange(self, old, self.state)
end

function GersonTable:getVoice()
    return "ralsei"
end

return GersonTable