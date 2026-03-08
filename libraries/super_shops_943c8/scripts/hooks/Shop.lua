local Shop, super = Utils.hookScript(Shop)

function Shop:init()
	super.init(self)
	
	self.current_x = 1
	self.current_y = 1
	
	-- Cutscenes
	self.cutscene = nil
	
	-- Haggling
	self.haggle_rate = self:getFlag("haggle_rate", 1)
	self.haggle_marks = {} -- {position, rate}, calculated after discounts
	self.can_haggle = false
	self.haggle_current = self:getFlag("haggle_current", 0)
	self.haggle_max = 100
	
	-- Deny texts
	self.deny_text = {}
	
	self.deny_item = {}
	
	self.deny_sell = {}
	
	-- Genocide
	self.note = {
		"* Test note"
	}
	
	self.counter_money = 0
	self.steal_1 = "* You took "
	self.steal_2 = " from behind the counter."
	self.steal_nothing = "* Nothing left."
	
	-- Bonus card
	self.card_width = 5
	self.card_height = 3
	self.list = {1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0}
	self.images = {Assets.getTexture("ui/shop/scratch_card/fail"), Assets.getTexture("ui/shop/scratch_card/excellent"), Assets.getTexture("ui/shop/scratch_card/great"), Assets.getTexture("ui/shop/scratch_card/good"),}
	self.rewards = {0, 0.4, 0.2, 0.1}
	self.bonus_selected = false
	self.bonus_timer = 0
	self.bonus_money = 0
	self.bonus_game = false
	self.bonus_fail_dialogue = "* Too bad![wait:5]\n* Better luck next time!"
	self.bonus_win_dialogue_1 = "* Good job![wait:5] You got a rank "
	self.bonus_win_dialogue_2 = " win!"
	
	-- Stock Market
	self.stock_timer = 300
	self.stock_range = {0.6, 1.4}
	if not self:getFlag("stock_money") then
		self:setFlag("stock_money", 0)
		self:setFlag("stock_list", {nil, nil, nil, nil, nil})
	else
		if (Game.playtime / self.stock_timer) > (self:getFlag("last_time") / self.stock_timer) then
			self:handleStock()
		end
	end
	self.stock_add = 0
	self.stock_mode = 0
	
	-- Bounties
	self.bounties = {}
	
	-- Trading
	self.trades = {}
	self.current_trade_text = ""
    -- Shown when you enter the trade menu.
    self.trade_text = "Trade\ntext"
    -- Shown when you try to trade, but you don't have enough items.
    self.trade_fail = "Trade\nfail"
    -- Shown when you trade.
    self.trade_succeed = "Trade\nsucceed"
    -- Shown when you try to trade, but a trade isn't registered in the selected slot.
    self.trade_empty = "Trade\nempty"
	
	-- Loyalty Points
	if not self:getFlag("loyalty_points") then
		self:setFlag("loyalty_points", 0)
	end
	self.loyalty_increment = 1
	self.loyalty_items = {}
	self.loyalty_confirming = false
	self.loyalty_text = "LP"
	-- Shown when you're in the LOYALTY menu
    self.loyalty_menu_text = "Purchase\ntext\nLoyalty"
    -- Shown when you're about to buy something.
    self.loyalty_confirmation_text = "Buy it for\n%s " .. self.loyalty_text .. "?"
    -- Shown when you refuse to buy something
    self.loyalty_refuse_text = "Loyal\nrefused\ntext"
    -- Shown when you buy something
    self.loyalty_texti = "Loyal text"
    -- Shown when you buy something and it goes in your storage
    self.loyalty_storage_text = "Storage\nloyal text"
    -- Shown when you don't have enough money to buy something
    self.loyalty_too_expensive_text = "Not\nenough\n" .. self.loyalty_text .. "."
    -- Shown when you don't have enough space to buy something.
    self.loyalty_no_space_text = "You're\ncarrying\ntoo much."
end

function Shop:doHaggle(amount)
	self.haggle_current = self.haggle_current + amount
	self.haggle_current = math.min(math.max(self.haggle_current, 0), self.haggle_max)
	self:setFlag("haggle_current", self.haggle_current)
	
	self:updatePrices()
end

function Shop:registerBounty(name, info, flag, reward)
    self.bounties[#self.bounties + 1] = {
        name = name,
		info = info,
        flag = flag,
        reward = reward,
        claimed = Game:getFlag(flag .. "_claimed", false)
    }
end

function Shop:registerTrade(from, to, options)
	options = options or {}
	local to_name = Registry.createItem(to):getName()
	if options["item_name"] then
		to_name = options["item_name"]
	end
    self.trades[#self.trades + 1] = {
        from = from,
		to = to,
        fromname = Registry.createItem(from):getName(),
		toname = to_name,
    }
end

function Shop:updateHaggle()
	local mark_current = 0
	local did_mark = false
	for k,v in pairs(self.haggle_marks) do
		if v[1] > mark_current and self.haggle_current >= v[1] then
			mark_current = v[1]
			self.haggle_rate = v[2]
			self:setFlag("haggle_rate", v[2])
			did_mark = true
		end
	end
	if not did_mark then
		self.haggle_rate = 1
		self:setFlag("haggle_rate", 1)
	end
	for k,v in pairs(self.items) do
		v.options["price"] = math.floor(v.options["price"] * self.haggle_rate)
	end
end

function Shop:updateDiscounts()
	for k,v in pairs(self.items) do
		if v.options["discount"] then
			if Game:getFlag(v.options["discount"][1], false) then
				v.options["color"] = {0, 1, 1, 1}
				v.options["price"] = math.floor(v.options["price"] * v.options["discount"][2])
			else
				v.options["color"] = v.options["basecolor"]
			end
		end
	end
end

function Shop:resetPrices()
	for k,v in pairs(self.items) do
		v.options["price"] = v.options["baseprice"]
	end
end

function Shop:updatePrices()
	self:resetPrices()
	self:updateDiscounts()
	self:updateHaggle()
end

function Shop:denyDialogue(reason)
	self:setState("DIALOGUE")
	if type(self.deny_text[reason]) == "function" then
		self.deny_text[reason]()
	else
		local note = {}
		for k, v in pairs(self.deny_text[reason]) do
			note[k] = v
		end
		self:setDialogueText(note)
	end

    self.dialogue_text.advance_callback = (function()
        self:setState("MAINMENU", "DIALOGUE")
    end)
end

function Shop:denyItemDialogue(reason)
	self:setState("DIALOGUE")
	if type(self.deny_item[reason]) == "function" then
		self.deny_item[reason]()
	else
		local note = {}
		for k, v in pairs(self.deny_item[reason]) do
			note[k] = v
		end
		self:setDialogueText(note)
	end

    self.dialogue_text.advance_callback = (function()
        self:setState("BUYMENU", "DIALOGUE")
    end)
end

function Shop:denySellDialogue(reason)
	self:setState("DIALOGUE")
	if type(self.deny_sell[reason]) == "function" then
		self.deny_sell[reason]()
	else
		local note = {}
		for k, v in pairs(self.deny_sell[reason]) do
			note[k] = v
		end
		self:setDialogueText(note)
	end

	self.dialogue_text.advance_callback = (function()
		self:enterSellMenu(self.sell_options[self.sell_current_selecting])
	end)
end

function Shop:setState(state, reason)
	if self.deny_text[state] and self:doesDeny(state) then
		self:denyDialogue(state)
		return
	end
	
	super.setState(self, state, reason)
end

function Shop:doesDeny(state)
	return true
end

function Shop:replaceItem(index, item, options)
    if type(item) == "string" then
        item = Registry.createItem(item)
    end
    if item then
        options = options or {}
        options["name"]        = options["name"]        or item:getName()
        options["description"] = options["description"] or item:getShopDescription()
        options["baseprice"]   = options["price"]       or item:getBuyPrice()
        options["price"]       = (options["price"]      or item:getBuyPrice()) * self.haggle_rate
        options["bonuses"]     = options["bonuses"]     or item:getStatBonuses()
        options["discount"]    = options["discount"]    or (item.getDiscountPrice and item:getDiscountPrice(self.id)) or false -- {flag, decimal modifier}
        options["basecolor"]   = options["color"]       or {1, 1, 1, 1}
        options["color"]       = (options["discount"]   and Game:getFlag(options["discount"][1], false)    and {0, 1, 1, 1} or options["basecolor"])
        options["flag"]        = options["flag"]        or ("stock_" .. tostring(index) .. "_" .. item.id)
        options["loyalty"]     = options["loyalty"]     or self.loyalty_increment

        options["stock"] = self:getFlag(options["flag"], options["stock"])

        self.items[index] = {
            item = item,
            options = options
        }
        return true
    else
        return false
    end
end

function Shop:registerLoyaltyItem(item, options)
    return self:replaceLoyaltyItem(#self.loyalty_items + 1, item, options)
end

function Shop:replaceLoyaltyItem(index, item, options)
    if type(item) == "string" then
        item = Registry.createItem(item)
    end
    if item then
        options = options or {}
        options["name"]        = options["name"]        or item:getName()
        options["description"] = options["description"] or item:getShopDescription()
        options["price"]       = options["price"]       or item:getLoyaltyPrice()
        options["bonuses"]     = options["bonuses"]     or item:getStatBonuses()
        options["color"]       = options["color"]       or {1, 1, 1, 1}
        options["flag"]        = options["flag"]        or ("stock_" .. tostring(index) .. "_" .. item.id)

        options["stock"] = self:getFlag(options["flag"], options["stock"])

        self.loyalty_items[index] = {
            item = item,
            options = options
        }
        return true
    else
        return false
    end
end

function Shop:getNote()
	return self.note
end

function Shop:readNote()
	local note = {}
	local snote = self:getNote()
	
	if snote then
		for k, v in pairs(snote) do
			note[k] = v
		end
		
		self:setDialogueText(note)

		self.dialogue_text.advance_callback = (function()
			self:setState("MAINMENU", "READNOTE")
		end)
	end
end

function Shop:handleStealing()
	if self:getFlag("stole_from") then
		self:setDialogueText({self.steal_nothing})
	else
		Game.money = Game.money + self.counter_money
		self:setDialogueText({self.steal_1 .. string.format(self.currency_text, self.counter_money) .. self.steal_2})
		self:setFlag("stole_from", true)
	end

    self.dialogue_text.advance_callback = (function()
        self:setState("MAINMENU", "STEALFROMSHOP")
    end)
end

function Shop:handleStock()
	local mult = Utils.random(Utils.unpack(self.stock_range))
	self:setFlag("stock_money", Utils.round(self:getFlag("stock_money", 0) * mult, 1))
	-- "stock_list", {nil, nil, nil, nil, nil}
	mult = Utils.round(100 * mult, 1)
	mult = mult - 100
	local list = self:getFlag("stock_list", {nil, nil, nil, nil, nil})
	list[5] = list[4]
	list[4] = list[3]
	list[3] = list[2]
	list[2] = list[1]
	list[1] = mult
	self:setFlag("stock_list", list)
end

function Shop:onKeyPressed(key, is_repeat)
	if self.state == "BUYMENU" and self.buy_confirming and Input.isConfirm(key) and self.deny_item[self.items[self.current_selecting].item.id] then
		self:denyItemDialogue(self.items[self.current_selecting].item.id)
		return
	end
	
	if self.state == "SELLING" and Input.isConfirm(key) and self.deny_sell[Game.inventory:getStorage(self.state_reason[2])[self.item_current_selecting].id] then
		self:denySellDialogue(Game.inventory:getStorage(self.state_reason[2])[self.item_current_selecting].id)
		return
	end
	
	if self.state == "BONUS" then
		if not self.bonus_selected then
			if Input.isConfirm(key) then
				self.bonus_selected = true
			elseif Input.is("up", key) then
				self.current_y = self.current_y - 1
				if self.current_y < 1 then
					self.current_y = 1
				end
			elseif Input.is("down", key) then
				self.current_y = self.current_y + 1
				if self.current_y > self.card_height then
					self.current_y = self.card_height
				end
			elseif Input.is("left", key) then
				self.current_x = self.current_x - 1
				if self.current_x < 1 then
					self.current_x = 1
				end
			elseif Input.is("right", key) then
				self.current_x = self.current_x + 1
				if self.current_x > self.card_width then
					self.current_x = self.card_width
				end
			end
		end
	elseif self.state == "BONUSCONFIRM" then
        if Input.isConfirm(key) and self.bonus_timer > 0.1 then
            if self.current_x == 1 then
				self:setState("BONUS")
			else
				self.bonus_money = 0
				self:setState("MAINMENU")
			end
		elseif Input.is("left", key) or Input.is("right", key) then
            self.current_x = self.current_x + 1
			if self.current_x > 2 then
				self.current_x = 1
			end
        end
	elseif self.state == "STOCKVIEW" then
        if Input.isConfirm(key) and self.bonus_timer > 0.1 then
            if self.stock_mode ~= 2 then
				self:setState("STOCKMODIFY")
			else
				self:setState("MAINMENU")
			end
		elseif Input.isCancel(key) then
			self:setState("MAINMENU")
		elseif Input.is("up", key) then
            self.stock_mode = self.stock_mode - 1
			if self.stock_mode < 0 then
				self.stock_mode = 0
			end
		elseif Input.is("down", key) then
            self.stock_mode = self.stock_mode + 1
			if self.stock_mode > 2 then
				self.stock_mode = 2
			end
        end
	elseif self.state == "STOCKMODIFY" then
        if Input.isConfirm(key) and self.bonus_timer > 0.1 then
			if self.stock_mode == 0 then		-- Deposit
				local val = math.min(self.stock_add, Game.money)
				Game.money = Game.money - val
				self:setFlag("stock_money", self:getFlag("stock_money", 0) + val)
			elseif self.stock_mode == 1 then	-- Withdraw
				local val = math.min(self.stock_add, self:getFlag("stock_money", 0))
				Game.money = Game.money + val
				self:setFlag("stock_money", self:getFlag("stock_money", 0) - val)
			else
				error("What??? Did you do???")
			end
			self:setState("STOCKVIEW")
        elseif Input.isMenu(key) then
			if self.stock_mode == 0 then
				self.stock_add = Game.money
			elseif self.stock_mode == 1 then
				self.stock_add = self:getFlag("stock_money", 0)
			else
				error("What??? Did you do???")
			end
		elseif Input.isCancel(key) then
			self:setState("STOCKVIEW")
		elseif Input.is("up", key) then
            self.stock_add = self.stock_add + 10
			local maxval = Game.money
			if self.stock_mode == 1 then
				maxval = self:getFlag("stock_money", 0)
			end
			if self.stock_add > maxval then
				self.stock_add = maxval
			end
		elseif Input.is("down", key) then
            self.stock_add = self.stock_add - 10
			if self.stock_add < 0 then
				self.stock_add = 0
			end
		elseif Input.is("right", key) then
            self.stock_add = self.stock_add + 1
			local maxval = Game.money
			if self.stock_mode == 1 then
				maxval = self:getFlag("stock_money", 0)
			end
			if self.stock_add > maxval then
				self.stock_add = maxval
			end
		elseif Input.is("left", key) then
            self.stock_add = self.stock_add - 1
			if self.stock_add < 0 then
				self.stock_add = 0
			end
        end
    elseif self.state == "BOUNTIES" then
        local old_selecting = self.current_selecting
        if Input.isConfirm(key) and self.bonus_timer > 0.1 then
            if self.current_selecting == math.max(#self.bounties, 4) + 1 then
                self:setState("MAINMENU")
            elseif self.bounties[self.current_selecting] then
                if Game:getFlag(self.bounties[self.current_selecting].flag) and not self.bounties[self.current_selecting].claimed then
					Game:setFlag(self.bounties[self.current_selecting].flag .. "_claimed", true)
					Game.money = Game.money + self.bounties[self.current_selecting].reward
					self.bounties[self.current_selecting].claimed = true
					Assets.playSound("locker")
				end
            end
        elseif Input.isCancel(key) then
            self:setState("MAINMENU")
        elseif Input.is("up", key) then
            self.current_selecting = self.current_selecting - 1
            if (self.current_selecting <= 0) then
                self.current_selecting = math.max(#self.bounties, 4) + 1
            end
        elseif Input.is("down", key) then
            self.current_selecting = self.current_selecting + 1
            if (self.current_selecting > math.max(#self.bounties, 4) + 1) then
                self.current_selecting = 1
            end
        end
        if Input.is("up", key) or Input.is("down", key) then
            if self.current_selecting >= #self.bounties + 1 then
                self.box_ease_timer = 0
                self.box_ease_beginning = self.info_box.height
                self.box_ease_top = -8
                self.box_ease_method = "linear"
                self.box_ease_multiplier = 8
            elseif (old_selecting >= #self.bounties + 1) and (self.current_selecting <= #self.bounties) then
                self.box_ease_timer = 0
                self.box_ease_beginning = self.info_box.height
                self.box_ease_top = 220 - 48
                self.box_ease_method = "outExpo"
                self.box_ease_multiplier = 1
            end
        end
    elseif self.state == "TRADING" then
        local old_selecting = self.current_selecting
        if Input.isConfirm(key) and self.bonus_timer > 0.1 then
            if self.current_selecting == math.max(#self.trades, 4) + 1 then
                self:setState("MAINMENU")
            elseif self.trades[self.current_selecting] then
				if Game.inventory:hasItem(self.trades[self.current_selecting].from) then
					Game.inventory:replaceItem(self.trades[self.current_selecting].from, self.trades[self.current_selecting].to)
					self.current_trade_text = self.trade_succeed
					Assets.playSound("locker")
				else
					self.current_trade_text = self.trade_fail
				end
			else
				self.current_trade_text = self.trade_empty
            end
        elseif Input.isCancel(key) then
            self:setState("MAINMENU")
        elseif Input.is("up", key) then
            self.current_selecting = self.current_selecting - 1
            if (self.current_selecting <= 0) then
                self.current_selecting = math.max(#self.trades, 4) + 1
            end
        elseif Input.is("down", key) then
            self.current_selecting = self.current_selecting + 1
            if (self.current_selecting > math.max(#self.trades, 4) + 1) then
                self.current_selecting = 1
            end
        end
	elseif self.state == "LOYALTYMENU" then
        if self.loyalty_confirming then
            if Input.isConfirm(key) then
                self.loyalty_confirming = false
                local current_item = self.loyalty_items[self.current_selecting]
                if self.current_selecting_choice == 1 then
                    self:buyItemLoyalty(current_item)
                elseif self.current_selecting_choice == 2 then
                    self:setRightText(self.loyalty_refuse_text)
                else
                    self:setRightText("What?????[wait:5]\ndid you\ndo????")
                end
            elseif Input.isCancel(key) then
                self.loyalty_confirming = false
                self:setRightText(self.loyalty_refuse_text)
            elseif Input.is("up", key) or Input.is("down", key) then
                if self.current_selecting_choice == 1 then
                    self.current_selecting_choice = 2
                else
                    self.current_selecting_choice = 1
                end
            end
        else
            local old_selecting = self.current_selecting
            if Input.isConfirm(key) then
                if self.current_selecting == math.max(#self.items, 4) + 1 then
                    self:setState("MAINMENU")
                elseif self.loyalty_items[self.current_selecting] then
                    if self.loyalty_items[self.current_selecting].options["stock"] then
                        if self.loyalty_items[self.current_selecting].options["stock"] <= 0 then
                            return
                        end
                    end
                    self.loyalty_confirming = true
                    self.current_selecting_choice = 1
                    self:setRightText("")
                end
            elseif Input.isCancel(key) then
                self:setState("MAINMENU")
            elseif Input.is("up", key) then
                self.current_selecting = self.current_selecting - 1
                if (self.current_selecting <= 0) then
                    self.current_selecting = math.max(#self.loyalty_items, 4) + 1
                end
            elseif Input.is("down", key) then
                self.current_selecting = self.current_selecting + 1
                if (self.current_selecting > math.max(#self.loyalty_items, 4) + 1) then
                    self.current_selecting = 1
                end
            end
            if Input.is("up", key) or Input.is("down", key) then
                if self.current_selecting >= #self.loyalty_items + 1 then
                    self.box_ease_timer = 0
                    self.box_ease_beginning = self.info_box.height
                    self.box_ease_top = -8
                    self.box_ease_method = "linear"
                    self.box_ease_multiplier = 8
                elseif (old_selecting >= #self.loyalty_items + 1) and (self.current_selecting <= #self.loyalty_items) then
                    self.box_ease_timer = 0
                    self.box_ease_beginning = self.info_box.height
                    self.box_ease_top = 220 - 48
                    self.box_ease_method = "outExpo"
                    self.box_ease_multiplier = 1
                end
            end
        end
	end

	super.onKeyPressed(self, key, is_repeat)
	
	self:updatePrices()
end

function Shop:onStateChange(old,new)
	Game.key_repeat = false
	self.bonus_timer = 0
	self.loyalty_confirming = false
	super.onStateChange(self, old, new)
	self.loyalty_confirming = false
	if old == "BUYMENU" and self.bonus_money > 0 and self.bonus_game then
		self:setState("BONUSCONFIRM")
	end
	if new == "BONUSCONFIRM" then
		self.large_box.visible = false
        self.left_box.visible = true
        self.right_box.visible = true
        self.info_box.visible = false
        self.dialogue_text.width = 372
		self.current_x = 1
		self:setDialogueText("")
		self:setRightText("")
		self.bonus_timer = 0
	elseif new == "BONUS" then
		self.large_box.visible = false
        self.left_box.visible = true
        self.right_box.visible = true
        self.info_box.visible = false
        self.dialogue_text.width = 372
		self.current_x = 1
		self.current_y = 1
		self:setDialogueText("")
		self:setRightText("Select a box!")
		self.list = Utils.shuffle(self.list)
		self.bonus_timer = 0
	elseif old == "BONUSCONFIRM" or old == "BONUS" then
		self.bonus_selected = false
		self.current_x = 1
		self.current_y = 1
	elseif new == "READNOTE" then
		self.large_box.visible = true
        self.left_box.visible = false
        self.right_box.visible = false
        self.info_box.visible = false
        self.dialogue_text.width = 598
		self:readNote()
	elseif new == "STEALFROMSHOP" then
		self.large_box.visible = true
        self.left_box.visible = false
        self.right_box.visible = false
        self.info_box.visible = false
        self.dialogue_text.width = 598
		self:handleStealing()
	elseif new == "STOCKVIEW" then
        self.large_box.visible = false
        self.left_box.visible = true
        self.right_box.visible = true
        self.info_box.visible = false
        self.dialogue_text.width = 372
        self:setDialogueText("")
        self:setRightText("")
		self.stock_selected = 0
		self.bonus_timer = 0
		self.stock_add = 0
	elseif new == "STOCKMODIFY" then
        self.large_box.visible = false
        self.left_box.visible = true
        self.right_box.visible = true
        self.info_box.visible = false
        self.dialogue_text.width = 372
        self:setDialogueText("")
        self:setRightText("")
		self.stock_selected = 0
		self.bonus_timer = 0
    elseif new == "BOUNTIES" then
        self:setDialogueText("")
        self:setRightText("")
        self.large_box.visible = true
        self.left_box.visible = false
        self.right_box.visible = false
        self.info_box.visible = true
        self.info_box.height = -8
        self.box_ease_timer = 0
        self.box_ease_beginning = -8
        if #self.items > 0 then
            self.box_ease_top = 220 - 48
        else
            self.box_ease_top = -8
        end
        self.box_ease_method = "outExpo"
        self.box_ease_multiplier = 1
        self.current_selecting = 1
	elseif new == "TRADING" then
        self:setDialogueText("")
        self:setRightText("")
        self.large_box.visible = true
        self.left_box.visible = false
        self.right_box.visible = false
        self.info_box.visible = true
        self.info_box.height = -8
        self.box_ease_timer = 0
        self.box_ease_beginning = -8
        if #self.items > 0 then
            self.box_ease_top = 220 - 48
        else
            self.box_ease_top = -8
        end
        self.box_ease_method = "outExpo"
        self.box_ease_multiplier = 1
        self.current_selecting = 1
		self.current_trade_text = self.trade_text
	elseif new == "LOYALTYMENU" then
        self:setDialogueText("")
        self:setRightText(self.loyalty_menu_text)
        self.large_box.visible = false
        self.left_box.visible = true
        self.right_box.visible = true
        self.info_box.visible = true
        self.info_box.height = -8
        self.box_ease_timer = 0
        self.box_ease_beginning = -8
        if #self.items > 0 then
            self.box_ease_top = 220 - 48
        else
            self.box_ease_top = -8
        end
        self.box_ease_method = "outExpo"
        self.box_ease_multiplier = 1
        self.current_selecting = 1
		self.loyalty_confirming = false
	elseif new == "CUTSCENE" then
		self.large_box.visible = true
        self.left_box.visible = false
        self.right_box.visible = false
        self.info_box.visible = false
        self.dialogue_text.width = 598
        self:setDialogueText("")
        self:setRightText("")
	end
end

function Shop:buyItem(current_item)
    if (current_item.options["price"] or 0) > self:getMoney() then
        self:setRightText(self.buy_too_expensive_text)
    else
        -- PURCHASE THE ITEM
        -- Remove the gold
        self:removeMoney(current_item.options["price"] or 0)
		self:setFlag("loyalty_points", self:getFlag("loyalty_points") + current_item.options["loyalty"])
		if self.bonus_game then
			self.bonus_money = self.bonus_money + (current_item.options["price"] or 0)
		end

        -- Decrement the stock
        if current_item.options["stock"] then
            current_item.options["stock"] = current_item.options["stock"] - 1
            self:setFlag(current_item.options["flag"], current_item.options["stock"])
        end

        -- Add the item to the inventory
        local new_item = Registry.createItem(current_item.item.id)
        new_item:load(current_item.item:save())
        if Game.inventory:addItem(new_item) then
            -- Visual/auditorial feedback (did I spell that right?)
            Assets.playSound("locker")
            self:setRightText(self.buy_text)
        else
            -- Not enough space, oops
            self:setRightText(self.buy_no_space_text)
        end
    end
end

function Shop:buyItemLoyalty(current_item)
    if (current_item.options["price"] or 0) > self:getFlag("loyalty_points") then
        self:setRightText(self.loyalty_too_expensive_text)
    else
        -- Decrement the stock
        if current_item.options["stock"] then
            current_item.options["stock"] = current_item.options["stock"] - 1
            self:setFlag(current_item.options["flag"], current_item.options["stock"])
        end

        -- Add the item to the inventory
        local new_item = Registry.createItem(current_item.item.id)
        new_item:load(current_item.item:save())
        if Game.inventory:addItem(new_item) then
            -- Visual/auditorial feedback (did I spell that right?)
            Assets.playSound("locker")
            self:setRightText(self.loyalty_texti)

            -- PURCHASE THE ITEM
            -- Remove the LP
			self:setFlag("loyalty_points", self:getFlag("loyalty_points") - (current_item.options["price"] or 0))
        else
            -- Not enough space, oops
            self:setRightText(self.loyalty_no_space_text)
        end
    end
end

function Shop:update()
	super.update(self)
	
	if self.state == "BONUS" then
		if self.bonus_selected then
			self.bonus_timer = self.bonus_timer + DT
		end
		if self.bonus_timer >= 1 then
			self.prize_selected = self.list[self.current_x + (self.current_y-1)*self.card_width]
			Game.money = Game.money + self.bonus_money*self.rewards[self.prize_selected+1]
			if self.prize_selected == 0 then
				self:startDialogue({self.bonus_fail_dialogue},"MAINMENU")
			else
				self:startDialogue({self.bonus_win_dialogue_1 .. self.prize_selected .. self.bonus_win_dialogue_2 .. "\n* You win " .. string.format(self.currency_text, self.bonus_money*self.rewards[self.prize_selected+1]) .. " (" .. math.floor(self.rewards[self.prize_selected+1]*100) .. "%)."},"MAINMENU")
			end
			self.bonus_money = 0
		end
	elseif self.state == "BONUSCONFIRM" or self.state == "STOCKVIEW" or self.state == "STOCKMODIFY" or self.state == "BOUNTIES" or self.state == "TRADING" or self.state == "LOYALTYMENU" then
		self.bonus_timer = self.bonus_timer + DT
	end
	
	if (Game.playtime - DT) % self.stock_timer > Game.playtime % self.stock_timer then
		self:handleStock()
	end
	
	self:setFlag("last_time", Game.playtime)
	if self.stock_mode == 1 then
		self.stock_add = math.min(self.stock_add, self:getFlag("stock_money", 0))
	end
	
	if self.state == "BOUNTIES" or self.state == "TRADING" or self.state == "LOYALTYMENU" or self.state == "LOYALTYMENU" then
        self.info_box.height = Utils.ease(self.box_ease_beginning, self.box_ease_top, self.box_ease_timer, self.box_ease_method)
	end
	
	if self.cutscene then
        if not self.cutscene.ended then
            self.cutscene:update()
            if self.stage == nil then
                return
            end
        else
            self.cutscene = nil
        end
    end
end

function Shop:draw()
    self:drawBackground()

    Object.draw(self)

    love.graphics.setFont(self.font)
    if self.state == "MAINMENU" then
        Draw.setColor(COLORS.white)
        for i = 1, #self.menu_options do
            love.graphics.print(self.menu_options[i][1], 480, 220 + (i * 40))
        end
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, 450, 230 + (self.main_current_selecting * 40))
    elseif self.state == "BUYMENU" then

        while self.current_selecting - self.item_offset > 5 do
            self.item_offset = self.item_offset + 1
        end

        while self.current_selecting - self.item_offset < 1 do
            self.item_offset = self.item_offset - 1
        end

        if self.item_offset + 5 > #self.items + 1 then
            if #self.items + 1 > 5 then
                self.item_offset = self.item_offset - 1
            end
        end

        if #self.items + 1 == 5 then
            self.item_offset = 0
        end

        -- Item type (item, key, weapon, armor)
        for i = 1 + self.item_offset, self.item_offset + math.max(4, math.min(5, #self.items)) do
            if i == math.max(4, #self.items) + 1 then break end
            local y = 220 + ((i - self.item_offset) * 40)
            local item = self.items[i]
            if not item then
                -- If the item is null, add some empty space
                Draw.setColor(COLORS.dkgray)
                love.graphics.print("--------", 60, y)
            elseif item.options["stock"] and (item.options["stock"] <= 0) then
                -- If we've depleted the stock, show a "sold out" message
                Draw.setColor(COLORS.gray)
                love.graphics.print("--SOLD OUT--", 60, y)
            else
                Draw.setColor(item.options["color"])
                love.graphics.print(item.options["name"], 60, y)
                if not self.hide_price then
					Draw.setColor(COLORS.white)
					love.graphics.print(string.format(self.currency_text, item.options["price"] or 0), 300, y)
					if item.options["discount"] and Game:getFlag(item.options["discount"][1]) then
						Draw.setColor({0.5,0.5,0.5})
						love.graphics.setFont(Assets.getFont("main", 16))
						love.graphics.print(math.floor((item.options["baseprice"] or 0) * self.haggle_rate), 302+self.font:getWidth(string.format(self.currency_text, item.options["price"] or 0)), y+13)
						love.graphics.setLineWidth(2)
						love.graphics.line( 302+self.font:getWidth(string.format(self.currency_text, item.options["price"] or 0)), y+22, 302+self.font:getWidth(string.format(self.currency_text, item.options["price"] or 0))+Assets.getFont("main", 16):getWidth(math.floor((item.options["baseprice"] or 0) * self.haggle_rate)), y+22)
					end
                end
            end
			love.graphics.setFont(self.font)
        end
        Draw.setColor(COLORS.white)
        if self.item_offset == math.max(4, #self.items) - 4 then
            love.graphics.print("Exit", 60, 220 + (math.max(4, #self.items) + 1 - self.item_offset) * 40)
        end
        Draw.setColor(Game:getSoulColor())
        if not self.buy_confirming then
            Draw.draw(self.heart_sprite, 30, 230 + ((self.current_selecting - self.item_offset) * 40))
        else
            Draw.draw(self.heart_sprite, 30 + 420, 230 + 80 + 10 + (self.current_selecting_choice * 30))
            Draw.setColor(COLORS.white)
            local lines = Utils.split(string.format(self.buy_confirmation_text, string.format(self.currency_text, self.items[self.current_selecting].options["price"] or 0)), "\n")
            for i = 1, #lines do
                love.graphics.print(lines[i], 60 + 400, 420 - 160 + ((i - 1) * 30))
            end
            love.graphics.print("Yes", 60 + 420, 420 - 80)
            love.graphics.print("No",  60 + 420, 420 - 80 + 30)
        end
        Draw.setColor(COLORS.white)

        if (self.current_selecting <= #self.items) then
            local current_item = self.items[self.current_selecting]
            local box_left, box_top = self.info_box:getBorder()

            local left = self.info_box.x - self.info_box.width - (box_left / 2) * 1.5
            local top = self.info_box.y - self.info_box.height - (box_top / 2) * 1.5
            local width = self.info_box.width + box_left * 1.5
            local height = self.info_box.height + box_top * 1.5

            Draw.pushScissor()
            Draw.scissor(left, top, width, height)

            Draw.setColor(COLORS.white)
            love.graphics.print(current_item.options["description"], left + 32, top + 20)

            if current_item.item.type == "armor" or current_item.item.type == "weapon" then
                for i = 1, #Game.party do
                    -- Turn the index into a 2 wide grid (0-indexed)
                    local transformed_x = (i - 1) % 2
                    local transformed_y = math.floor((i - 1) / 2)

                    -- Transform the grid into coordinates
                    local offset_x = transformed_x * 100
                    local offset_y = transformed_y * 45

                    local party_member = Game.party[i]
                    local can_equip = party_member:canEquip(current_item.item)
                    local head_path = ""

                    love.graphics.setFont(self.plain_font)
                    Draw.setColor(COLORS.white)

                    if can_equip then
                        head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head")
                        if current_item.item.type == "armor" then
                            Draw.draw(self.stat_icons["defense_1"], offset_x + 470, offset_y + 127 + top)
                            Draw.draw(self.stat_icons["defense_2"], offset_x + 470, offset_y + 147 + top)

                            for j = 1, 2 do
                                self:drawBonuses(party_member, party_member:getArmor(j), current_item.options["bonuses"], "defense", offset_x + 470 + 21, offset_y + 127 + ((j - 1) * 20) + top)
                            end

                        elseif current_item.item.type == "weapon" then
                            Draw.draw(self.stat_icons["attack"], offset_x + 470, offset_y + 127 + top)
                            Draw.draw(self.stat_icons["magic" ], offset_x + 470, offset_y + 147 + top)
                            self:drawBonuses(party_member, party_member:getWeapon(), current_item.options["bonuses"], "attack", offset_x + 470 + 21, offset_y + 127 + top)
                            self:drawBonuses(party_member, party_member:getWeapon(), current_item.options["bonuses"], "magic",  offset_x + 470 + 21, offset_y + 147 + top)
                        end
                    else
                        head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head_error")
                    end

                    Draw.draw(head_path, offset_x + 426, offset_y + 132 + top)
                end
            end

            Draw.popScissor()

            Draw.setColor(COLORS.white)

            if not self.hide_storage_text then
                local current_storage = Game.inventory:getDefaultStorage(current_item.item)
                if not Game:getConfig("newShopSpaceUI") then
                    local space = Game.inventory:getFreeSpace(current_storage)
                    love.graphics.setFont(self.plain_font)

                    if space <= 0 then
                        love.graphics.print("NO SPACE", 521, 430)
                    else
                        love.graphics.print("Space:" .. space, 521, 430)
                    end
                else
                    local item_type = current_item.item.type
                    
                    local space = Game.inventory:getFreeSpace(current_storage, false)
                    local space_count = Game.inventory:getItemCount(current_storage, false)
                    local total_space = space + space_count
                    
                    local storage_space = Game.inventory:getFreeSpace("storage")
                    local storage_space_count = Game.inventory:getItemCount("storage")
                    local storage_total_space = storage_space + storage_space_count
                    
                    love.graphics.setFont(self.space_font)
                    if item_type ~= "armor" and item_type ~= "weapon" and item_type ~= "key" then
                        Draw.draw(self.ui_hold_sprite, 555, 398)
                        love.graphics.print(string.format("%02d", space_count) .. "/" .. string.format("%02d", total_space), 556, 412, 0, 0.5, 0.5)
                        Draw.draw(self.ui_storage_sprite, 555, 430)
                        love.graphics.print(string.format("%02d", storage_space_count) .. "/" .. string.format("%02d", storage_total_space), 556, 444, 0, 0.5, 0.5)
                    else
                        love.graphics.print(string.format("%02d", space_count) .. "/" .. string.format("%02d", total_space), 556, 436, 0, 0.5, 0.5)
                        Draw.draw(self.ui_hold_sprite, 555, 422)
                        if item_type == "armor" then
                            Draw.draw(self.ui_armor_sprite, 555, 410)
                        elseif item_type == "weapon" then
                            Draw.draw(self.ui_weapon_sprite, 555, 410)
                        elseif item_type == "key" then
                            Draw.draw(self.ui_pocket_sprite, 555, 410)
                        end
                    end
                end
            end
        end
	elseif self.state == "LOYALTYMENU" then

        while self.current_selecting - self.item_offset > 5 do
            self.item_offset = self.item_offset + 1
        end

        while self.current_selecting - self.item_offset < 1 do
            self.item_offset = self.item_offset - 1
        end

        if self.item_offset + 5 > #self.loyalty_items + 1 then
            if #self.loyalty_items + 1 > 5 then
                self.item_offset = self.item_offset - 1
            end
        end

        if #self.loyalty_items + 1 == 5 then
            self.item_offset = 0
        end

        -- Item type (item, key, weapon, armor)
        for i = 1 + self.item_offset, self.item_offset + math.max(4, math.min(5, #self.loyalty_items)) do
            if i == math.max(4, #self.loyalty_items) + 1 then break end
            local y = 220 + ((i - self.item_offset) * 40)
            local item = self.loyalty_items[i]
            if not item then
                -- If the item is null, add some empty space
                Draw.setColor(COLORS.dkgray)
                love.graphics.print("--------", 60, y)
            elseif item.options["stock"] and (item.options["stock"] <= 0) then
                -- If we've depleted the stock, show a "sold out" message
                Draw.setColor(COLORS.gray)
                love.graphics.print("--SOLD OUT--", 60, y)
            else
                Draw.setColor(item.options["color"])
                love.graphics.print(item.options["name"], 60, y)
                if not self.hide_price then
					Draw.setColor(COLORS.white)
					love.graphics.print(string.format(self.loyalty_text .. " %d", item.options["price"] or 0), 300, y)
                end
            end
			love.graphics.setFont(self.font)
        end
        Draw.setColor(COLORS.white)
        if self.item_offset == math.max(4, #self.items) - 4 then
            love.graphics.print("Exit", 60, 220 + (math.max(4, #self.items) + 1 - self.item_offset) * 40)
        end
        Draw.setColor(Game:getSoulColor())
        if not self.loyalty_confirming then
            Draw.draw(self.heart_sprite, 30, 230 + ((self.current_selecting - self.item_offset) * 40))
        else
            Draw.draw(self.heart_sprite, 30 + 420, 230 + 80 + 10 + (self.current_selecting_choice * 30))
            Draw.setColor(COLORS.white)
            local lines = Utils.split(string.format(self.loyalty_confirmation_text, self.loyalty_items[self.current_selecting].options["price"] or 0), "\n")
            for i = 1, #lines do
                love.graphics.print(lines[i], 60 + 400, 420 - 160 + ((i - 1) * 30))
            end
            love.graphics.print("Yes", 60 + 420, 420 - 80)
            love.graphics.print("No",  60 + 420, 420 - 80 + 30)
        end
        Draw.setColor(COLORS.white)

        if (self.current_selecting <= #self.loyalty_items) then
            local current_item = self.loyalty_items[self.current_selecting]
            local box_left, box_top = self.info_box:getBorder()

            local left = self.info_box.x - self.info_box.width - (box_left / 2) * 1.5
            local top = self.info_box.y - self.info_box.height - (box_top / 2) * 1.5
            local width = self.info_box.width + box_left * 1.5
            local height = self.info_box.height + box_top * 1.5

            Draw.pushScissor()
            Draw.scissor(left, top, width, height)

            Draw.setColor(COLORS.white)
            love.graphics.print(current_item.options["description"], left + 32, top + 20)

            if current_item.item.type == "armor" or current_item.item.type == "weapon" then
                for i = 1, #Game.party do
                    -- Turn the index into a 2 wide grid (0-indexed)
                    local transformed_x = (i - 1) % 2
                    local transformed_y = math.floor((i - 1) / 2)

                    -- Transform the grid into coordinates
                    local offset_x = transformed_x * 100
                    local offset_y = transformed_y * 45

                    local party_member = Game.party[i]
                    local can_equip = party_member:canEquip(current_item.item)
                    local head_path = ""

                    love.graphics.setFont(self.plain_font)
                    Draw.setColor(COLORS.white)

                    if can_equip then
                        head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head")
                        if current_item.item.type == "armor" then
                            Draw.draw(self.stat_icons["defense_1"], offset_x + 470, offset_y + 127 + top)
                            Draw.draw(self.stat_icons["defense_2"], offset_x + 470, offset_y + 147 + top)

                            for j = 1, 2 do
                                self:drawBonuses(party_member, party_member:getArmor(j), current_item.options["bonuses"], "defense", offset_x + 470 + 21, offset_y + 127 + ((j - 1) * 20) + top)
                            end

                        elseif current_item.item.type == "weapon" then
                            Draw.draw(self.stat_icons["attack"], offset_x + 470, offset_y + 127 + top)
                            Draw.draw(self.stat_icons["magic" ], offset_x + 470, offset_y + 147 + top)
                            self:drawBonuses(party_member, party_member:getWeapon(), current_item.options["bonuses"], "attack", offset_x + 470 + 21, offset_y + 127 + top)
                            self:drawBonuses(party_member, party_member:getWeapon(), current_item.options["bonuses"], "magic",  offset_x + 470 + 21, offset_y + 147 + top)
                        end
                    else
                        head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head_error")
                    end

                    Draw.draw(head_path, offset_x + 426, offset_y + 132 + top)
                end
            end

            Draw.popScissor()

            Draw.setColor(COLORS.white)

            if not self.hide_storage_text then
                love.graphics.setFont(self.plain_font)

                local current_storage = Game.inventory:getDefaultStorage(current_item.item)
                local space = Game.inventory:getFreeSpace(current_storage)
				local space2 = Game.inventory:getItemCount(current_storage)
                local total_space = space+space2
				--this is really stupid but current_storage.max wasnt working??
				local storagespace = Game.inventory:getItemCount("storage")
                local total_storagespace = Game.inventory:getItemCount("storage")+Game.inventory:getFreeSpace("storage")

                if not Game:getConfig("shopspaceui") then
                    if space <= 0 then
                        love.graphics.print("NO SPACE", 521, 430)
                    else
                        love.graphics.print("Space:" .. space, 521, 430)
				    end
			    else
					love.graphics.setFont(Assets.getFont("8bitsmall"))
					if current_item.item.type ~= "armor" and current_item.item.type ~= "weapon" and current_item.item.type ~= "key" then 
						love.graphics.print(space2 .. "/" .. total_space, 556, 413)
						love.graphics.print(storagespace .. "/" .. total_storagespace, 556, 445)
						Draw.draw(Assets.getTexture("ui/shop/ui_hold"), 555, 398)
						Draw.draw(Assets.getTexture("ui/shop/ui_storage"), 555, 430)
					else
						love.graphics.print(space2 .. "/" .. total_space, 556, 437)
						Draw.draw(Assets.getTexture("ui/shop/ui_hold"), 555, 422)
						if current_item.item.type == "armor" then
							Draw.draw(Assets.getTexture("ui/shop/ui_armor"), 555, 410)
						elseif current_item.item.type == "weapon" then
							Draw.draw(Assets.getTexture("ui/shop/ui_weapon"), 555, 410)
						elseif current_item.item.type == "key" then
							Draw.draw(Assets.getTexture("ui/shop/ui_pocket"), 555, 410)
						end
					end
                end
            end
        end
    elseif self.state == "SELLMENU" then
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, 50, 230 + (self.sell_current_selecting * 40))
        Draw.setColor(COLORS.white)
        love.graphics.setFont(self.font)
        for i, v in ipairs(self.sell_options) do
            love.graphics.print(v[1], 80, 220 + (i * 40))
        end
        love.graphics.print("Return", 80, 220 + ((#self.sell_options + 1) * 40))
    elseif self.state == "SELLING" then
        if self.item_current_selecting - self.item_offset > 5 then
            self.item_offset = self.item_offset + 1
        end

        if self.item_current_selecting - self.item_offset < 1 then
            self.item_offset = self.item_offset - 1
        end

        local inventory = Game.inventory:getStorage(self.state_reason[2])

        if inventory and inventory.sorted then
            if self.item_offset + 5 > #inventory then
                if #inventory > 5 then
                    self.item_offset = self.item_offset - 1
                end
            end
            if #inventory == 5 then
                self.item_offset = 0
            end
        end

        Draw.setColor(Game:getSoulColor())

        Draw.draw(self.heart_sprite, 30, 230 + ((self.item_current_selecting - self.item_offset) * 40))
        if self.sell_confirming then
            Draw.draw(self.heart_sprite, 30 + 420, 230 + 80 + 10 + (self.current_selecting_choice * 30))
            Draw.setColor(COLORS.white)
            local lines = Utils.split(string.format(self.sell_confirmation_text, string.format(self.currency_text, inventory[self.item_current_selecting]:getSellPrice())), "\n")
            for i = 1, #lines do
                love.graphics.print(lines[i], 60 + 400, 420 - 160 + ((i - 1) * 30))
            end
            love.graphics.print("Yes", 60 + 420, 420 - 80)
            love.graphics.print("No",  60 + 420, 420 - 80 + 30)
        end

        Draw.setColor(COLORS.white)

        if inventory then
            for i = 1 + self.item_offset, self.item_offset + math.min(5, inventory.max) do
                local item = inventory[i]
                love.graphics.setFont(self.font)

                if item then
                    Draw.setColor(COLORS.white)
                    love.graphics.print(item:getName(), 60, 220 + ((i - self.item_offset) * 40))
                    if item:isSellable() then
                        love.graphics.print(string.format(self.currency_text, item:getSellPrice()), 60 + 240, 220 + ((i - self.item_offset) * 40))
                    end
                else
                    Draw.setColor(COLORS.dkgray)
                    love.graphics.print("--------", 60, 220 + ((i - self.item_offset) * 40))
                end
            end

            local max = inventory.max
            if inventory.sorted then
                max = #inventory
            end

            Draw.setColor(COLORS.white)

            if max > 5 then

                for i = 1, max do
                    local percentage = (i - 1) / (max - 1)
                    local height = 129

                    local draw_location = percentage * height

                    local tocheck = self.item_current_selecting
                    if self.sell_confirming then
                        tocheck = self.current_selecting_choice
                    end

                    if i == tocheck then
                        love.graphics.rectangle("fill", 372, 292 + draw_location, 9, 9)
                    elseif inventory.sorted then
                        love.graphics.rectangle("fill", 372 + 3, 292 + 3 + draw_location, 3, 3)
                    end
                end

                -- Draw arrows
                if not self.sell_confirming then
                    local sine_off = math.sin((Kristal.getTime()*30)/6) * 3
                    if self.item_offset + 4 < (max - 1) then
                        Draw.draw(self.arrow_sprite, 370, 149 + sine_off + 291)
                    end
                    if self.item_offset > 0 then
                        Draw.draw(self.arrow_sprite, 370, 14 - sine_off + 291 - 25, 0, 1, -1)
                    end
                end
            end
        else
            love.graphics.print("Invalid storage", 60, 220 + (1 * 40))
        end
    elseif self.state == "TALKMENU" then
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, 50, 230 + (self.current_selecting * 40))
        Draw.setColor(COLORS.white)
        love.graphics.setFont(self.font)
        for i = 1, math.max(4, #self.talks) do
            local v = self.talks[i]
            if v then
                Draw.setColor(v[2].color)
                love.graphics.print(v[1], 80, 220 + (i * 40))
            else
                Draw.setColor(COLORS.dkgray)
                love.graphics.print("--------", 80, 220 + (i * 40))
            end
        end
        Draw.setColor(COLORS.white)
        love.graphics.print("Exit", 80, 220 + ((math.max(4, #self.talks) + 1) * 40))
	elseif self.state == "BONUSCONFIRM" then
		Draw.setColor(COLORS.white)
		love.graphics.setFont(Assets.getFont("main", 16))
		love.graphics.print("Prize pool: " .. string.format(self.currency_text, self.bonus_money), 30, 450)
		love.graphics.setFont(self.font)
		love.graphics.print("Scratch a bonus card?", 60, 300)
		love.graphics.print("Yes", 80, 360)
		love.graphics.print("No", 300, 360)
		Draw.setColor(Game:getSoulColor())
		if self.current_x == 1 then
			Draw.draw(self.heart_sprite, 60, 370)
		else
			Draw.draw(self.heart_sprite, 280, 370)
		end
	elseif self.state == "BONUS" then
		Draw.setColor(COLORS.white)
		love.graphics.setFont(Assets.getFont("main", 16))
		love.graphics.print("Prize pool: " .. string.format(self.currency_text, self.bonus_money), 30, 450)
		love.graphics.setFont(self.font)
		for i = 1, #self.list do -- 60, 280
			local x = 60 + 60*((i-1)%self.card_width)
			local y = 280 + 50*math.floor((i-1)/self.card_width)
			local xfind = i%self.card_width
			if xfind == 0 then
				xfind = 5
			end
			if (not self.bonus_selected) or self.current_x ~= xfind or self.current_y ~= math.ceil(i/self.card_width) then
				love.graphics.rectangle("fill", x, y, 46, 40)
			else
				Draw.draw(self.images[self.list[i]+1], x, y, 0, 2, 2)
			end
		end
		if not self.bonus_selected then
			Draw.setColor(Game:getSoulColor())
			Draw.draw(self.heart_sprite, 75 + 60*(self.current_x-1), 292 + 50*(self.current_y-1))
		end
	elseif self.state == "STOCKVIEW" then
		Draw.setColor(COLORS.white)
        love.graphics.print("Stock Cash", 440, 260)
        love.graphics.print(string.format(self.currency_text, self:getFlag("stock_money", 0)), 440, 300)
        love.graphics.print("Money", 440, 380)
		
		local list = self:getFlag("stock_list", {nil, nil, nil, nil, nil})
		for k,v in pairs(list) do
			if v ~= nil then
				local prefix = ""
				if v < 0 then
					Draw.setColor({1, 0, 0, (6-k) * 0.2})
				elseif v > 0 then
					Draw.setColor({0, 1, 0, (6-k) * 0.2})
					prefix = "+"
				else
					Draw.setColor({1, 1, 1, (6-k) * 0.2})
				end
				love.graphics.print(prefix .. v .. "%", 40, 220 + ((6-k) * 40))
			end
		end
		
		Draw.setColor(COLORS.white)
        love.graphics.setLineWidth(6)
        love.graphics.line(160, 250, 160, 470)
		
        for k,v in pairs({"Deposit", "Withdraw", "Exit"}) do
            love.graphics.print(v, 240, 220 + (k * 60))
        end
		
		Draw.setColor(Game:getSoulColor())
		Draw.draw(self.heart_sprite, 210, 290 + (self.stock_mode * 60))
	elseif self.state == "STOCKMODIFY" then
		Draw.setColor(COLORS.white)
        love.graphics.print("Stock Cash", 440, 260)
        love.graphics.print(string.format(self.currency_text, self:getFlag("stock_money", 0)), 440, 300)
        love.graphics.print("Money", 440, 380)
		
		local modes = {"Depositing", "Withdrawing"}
		love.graphics.printf(modes[self.stock_mode+1], 14, 280, 388, "center")
		
		love.graphics.printf("<   " .. self.stock_add .. "   >", 14, 360, 388, "center")
		Draw.draw(self.arrow_sprite, 201, 400)
		Draw.draw(self.arrow_sprite, 201, 355, 0, 1, -1)
		love.graphics.print(Input.getText("menu") .. ": Max", 40, 420)
	elseif self.state == "BOUNTIES" then
		Draw.setColor(COLORS.white)
		for i = 1 + self.item_offset, self.item_offset + math.max(4, math.min(5, #self.bounties)) do
            if i == math.max(4, #self.items) + 1 then break end
            local y = 220 + ((i - self.item_offset) * 40)
            local bounty = self.bounties[i]
            if not bounty then
                Draw.setColor(COLORS.dkgray)
                love.graphics.print("--------", 60, y)
            elseif bounty.claimed then
                Draw.setColor(COLORS.white)
                love.graphics.print("COMPLETED", 60, y)
            else
                Draw.setColor(COLORS.white)
                love.graphics.print(bounty.name, 60, y)
                love.graphics.print("Reward: " .. string.format(self.currency_text, bounty.reward), 430, y)
            end
			love.graphics.setFont(self.font)
        end
        Draw.setColor(COLORS.white)
        if self.item_offset == math.max(4, #self.bounties) - 4 then
            love.graphics.print("Exit", 60, 220 + (math.max(4, #self.bounties) + 1 - self.item_offset) * 40)
        end
        Draw.setColor(Game:getSoulColor())
		Draw.draw(self.heart_sprite, 30, 230 + ((self.current_selecting - self.item_offset) * 40))
		
        Draw.setColor(COLORS.white)
		if (self.current_selecting <= #self.bounties) then
            local current_bounty = self.bounties[self.current_selecting]
            local box_left, box_top = self.info_box:getBorder()

            local left = self.info_box.x - self.info_box.width - (box_left / 2) * 1.5
            local top = self.info_box.y - self.info_box.height - (box_top / 2) * 1.5
            local width = self.info_box.width + box_left * 1.5
            local height = self.info_box.height + box_top * 1.5

            Draw.pushScissor()
            Draw.scissor(left, top, width, height)

            Draw.setColor(COLORS.white)
            love.graphics.print("DESCRIPTION\n" .. current_bounty.info, left + 32, top + 20)
			Draw.popScissor()
		end
	elseif self.state == "TRADING" then
		Draw.setColor(COLORS.white)
		for i = 1 + self.item_offset, self.item_offset + math.max(4, math.min(5, #self.trades)) do
            if i == math.max(4, #self.trades) + 1 then break end
            local y = 220 + ((i - self.item_offset) * 40)
            local trade = self.trades[i]
            if not trade then
                Draw.setColor(COLORS.dkgray)
                love.graphics.print("--------", 60, y)
            else
                Draw.setColor(COLORS.white)
                love.graphics.print(trade.fromname, 60, y)
                love.graphics.print("-->  " .. trade.toname, 300, y)
            end
			love.graphics.setFont(self.font)
		end
        Draw.setColor(COLORS.white)
        if self.item_offset == math.max(4, #self.trades) - 4 then
            love.graphics.print("Exit", 60, 220 + (math.max(4, #self.trades) + 1 - self.item_offset) * 40)
        end
        Draw.setColor(Game:getSoulColor())
		Draw.draw(self.heart_sprite, 30, 230 + ((self.current_selecting - self.item_offset) * 40))
		
		local current_bounty = self.bounties[self.current_selecting]
        local box_left, box_top = self.info_box:getBorder()

        local left = self.info_box.x - self.info_box.width - (box_left / 2) * 1.5
        local top = self.info_box.y - self.info_box.height - (box_top / 2) * 1.5
        local width = self.info_box.width + box_left * 1.5
        local height = self.info_box.height + box_top * 1.5

        Draw.pushScissor()
        Draw.scissor(left, top, width, height)

        Draw.setColor(COLORS.white)
        love.graphics.print(self.current_trade_text, left + 32, top + 20)
		Draw.popScissor()
    end

    if (self.state == "MAINMENU" and not self:shouldHideMainMenuCurrency()) or
       self.state == "BUYMENU"  	or
       self.state == "SELLMENU" 	or
       self.state == "SELLING"  	or
       self.state == "BONUSCONFIRM" or
       self.state == "BONUS"  		or
       self.state == "STOCKVIEW"	or
       self.state == "STOCKMODIFY"  or
       self.state == "TALKMENU" 	then
        Draw.setColor(COLORS.white)
        love.graphics.setFont(self.font)
        love.graphics.print(string.format(self.currency_text, self:getMoney()), 440, 420)
    elseif self.state == "LOYALTYMENU" 	then
        Draw.setColor(COLORS.white)
        love.graphics.setFont(self.font)
        love.graphics.print(string.format(self.loyalty_text .. " %d", self:getFlag("loyalty_points")), 440, 420)
    end

    Draw.setColor(0, 0, 0, self.fade_alpha)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	
	if self.can_haggle then
		love.graphics.setColor({1, 1, 1})
		love.graphics.setFont(Assets.getFont("main", 16))
		love.graphics.rectangle("fill", 38, 18, 564, 14)
		love.graphics.print("Hag-O-Bar: " .. self.haggle_current .. "/" .. self.haggle_max .. " (" .. math.floor(self.haggle_rate * 100) .. "% Price)", 38, 2)
		love.graphics.setColor({0, 0, 0})
		love.graphics.rectangle("fill", 40, 20, 560, 10)
		love.graphics.setColor({0, 1, 0})
		love.graphics.rectangle("fill", 40, 20, 560 * self.haggle_current / self.haggle_max, 10)
		love.graphics.setColor({1, 1, 1})
		for k,v in pairs(self.haggle_marks) do
			love.graphics.rectangle("fill", 39 + 560 * v[1] / self.haggle_max, 23, 2, 4)
		end
	end
end

function Shop:startCutscene(group, id, ...)
	if self.cutscene and not self.cutscene.ended then
        local cutscene_name = ""
        if type(group) == "string" then
            cutscene_name = group
            if type(id) == "string" then
                cutscene_name = group.."."..id
            end
        elseif type(group) == "function" then
            cutscene_name = "<function>"
        end
        error("Attempt to start a cutscene "..cutscene_name.." while already in cutscene "..self.cutscene.id)
    end
    if Kristal.Console.is_open then
        Kristal.Console:close()
    end
    self.cutscene = ShopCutscene(group, id, ...)
    return self.cutscene
end

function Shop:hasCutscene()
    return self.cutscene and not self.cutscene.ended
end

function Shop:stopCutscene()
    if not self.cutscene then
        error("Attempt to stop a cutscene while none are active.")
    end
    self.cutscene:onEnd()
    coroutine.yield(self.cutscene)
    self.cutscene = nil
end

return Shop