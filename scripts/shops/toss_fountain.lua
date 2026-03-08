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

    self.fun = Game:getFlag("fun")
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
        {"Drink", "READNOTE"},
        {"Exit", "LEAVE"}
    }

    self.note = {}
	self.hide_main_menu_currency = true
end

function TossFountain:getNote()
    local text
    if not Game:getFlag("drink_from_basin") or Game:getFlag("drink_from_basin") < 8 then
        Game:addFlag("drink_from_basin", 1)
        if self.fun <= 100 and self.fun >= 90 and love.math.random(0,10) == 10 then
            return {
                "[sound:swallow]* (You drawnk from the basin...)",
                "* (Yummers.)"
            }
        end
            return {
            "[sound:swallow]* (You drank from the basin...)",
            "* (You feel ever so slightly heavier.)"
        }
    end
    if Game:getFlag("waterboarded") then
        return {
            "* (You drank too much as is.)",
            "* (Any more and you might just turn into coins. [wait:10]For real.)",
        }
    end
    self:startCutscene("shops.fountain")
end

function TossFountain:onLeave()
    self:setState("LEAVING")
end

return TossFountain