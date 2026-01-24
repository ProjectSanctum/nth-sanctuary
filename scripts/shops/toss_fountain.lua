local TossFountain, super = Class(Shop)

function TossFountain:init()
    super.init(self)
    self.encounter_text = "* (It's a pool\nof water.)"
    self.shop_text = "* (It's a pool\nof water.)"
    self.leaving_text = ""
    self.sell_no_price_text = "No value."
    self.sell_menu_text = "Select an\nobject."
    self.sell_nothing_text = "Nothing to\ntoss."
    self.sell_confirmation_text = "Toss it for\n%s ?"
    self.sell_refuse_text = "Select an\nobject."
    -- Shown when you sell something
    self.sell_text = "Object tossed."
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "Nothing to\ntoss."
    -- Shown when you enter the talk menu.
    self.talk_text = ""

    self.sell_options = {
        { "Toss unwanted item", "items" },
        { "Toss unwanted weapon", "weapons" },
        { "Toss unwanted armor", "armors" }
    }
    self.sell_options_text = {}
    self.sell_options_text["items"]   = "Select an\nITEM\nto toss."
    self.sell_options_text["weapons"] = "Select a\nWEAPON\nto toss."
    self.sell_options_text["armors"]  = "Select an\nARMOR\nto toss."
    self.sell_options_text["storage"] = "Select an\nITEM\nto toss."

	self.shop_music = nil
    
    self.hide_world = false
	self.bg_cover.visible = false
    self.menu_options = {
        {"Toss", "SELLMENU"},
        {"Exit", "LEAVE"}
    }
end

function TossFountain:onLeave()
    self:setState("LEAVING")
end

function TossFountain:draw()
    if self.state ~= "MAINMENU" then
		super.draw(self)
	else
		-- Don't draw money
		self:drawBackground()
		super.super.draw(self)
		love.graphics.setFont(self.font)
        Draw.setColor(COLORS.white)
        for i = 1, #self.menu_options do
            love.graphics.print(self.menu_options[i][1], 480, 220 + (i * 40))
        end
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, 450, 230 + (self.main_current_selecting * 40))
		Draw.setColor(0, 0, 0, self.fade_alpha)
		love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	end
end

return TossFountain