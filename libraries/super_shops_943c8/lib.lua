local Lib = {}

function Lib:init()
	Utils.hook(Item, "getDiscountPrice", function(orig, self, id)
		return false
	end)
    
    print("[Super Shops] Loaded Super Shops")
	if Mod.libs["magical-glass"] and Kristal.getLibConfig("super_shops", "magical-glass") then
		print("[Super Shops] Magical Glass detected and changes allowed.")
		if LightShop then
			print("[Super Shops] LightShop detected. Modifying...")
			
			Utils.hook(LightShop, "init", function(orig, self)
				orig(self)
	
				self.cutscene = nil
				
				-- Genocide
				self.note = {
					"* Test note"
				}
				
				self.counter_money = 0
				self.steal_1 = "* You took "
				self.steal_2 = " from behind the counter."
				self.steal_nothing = "* Nothing left."
	
				-- Deny texts
				self.deny_text = {}
			end)
			
			Utils.hook(LightShop, "getNote", function(orig, self)
				return self.note
			end)
			
			Utils.hook(LightShop, "readNote", function(orig, self)
				local note = {}
				for k, v in pairs(self:getNote()) do
					note[k] = v
				end
				self:setDialogueText(note)

				self.dialogue_text.advance_callback = (function()
					self:setState("MAINMENU", "READNOTE")
				end)
			end)
			
			Utils.hook(LightShop, "handleStealing", function(orig, self)
				if self:getFlag("stole_from") then
					self:setDialogueText({self.steal_nothing})
				else
					Game.lw_money = Game.lw_money + self.counter_money
					self:setDialogueText({self.steal_1 .. string.format(self.currency_text, self.counter_money) .. self.steal_2})
					self:setFlag("stole_from", true)
				end

				self.dialogue_text.advance_callback = (function()
					self:setState("MAINMENU", "STEALFROMSHOP")
				end)
			end)
			
			Utils.hook(LightShop, "onStateChange", function(orig, self, old, new)
				orig(self, old, new)
				if new == "READNOTE" then
					self.dialogue_text.width = 598
					self:setRightText("")
					self.info_box.visible = false
					self:readNote()
				end
				if new == "STEALFROMSHOP" then
					self.dialogue_text.width = 598
					self:setRightText("")
					self.info_box.visible = false
					self:handleStealing()
				end
			end)
			
			Utils.hook(LightShop, "denyDialogue", function(orig, self, reason)
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
			end)
			
			Utils.hook(LightShop, "setState", function(orig, self, state, reason)
				if self.deny_text[state] and self:doesDeny(state) then
					self:denyDialogue(state)
					return
				end
				
				orig(self, state, reason)
			end)
			
			Utils.hook(LightShop, "doesDeny", function(orig, self, state)
				return true
			end)
			
			Utils.hook(LightShop, "startCutscene", function(orig, self, group, id, ...)
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
			end)
			
			Utils.hook(LightShop, "hasCutscene", function(orig, self)
				return self.cutscene and not self.cutscene.ended
			end)
			
			Utils.hook(LightShop, "stopCutscene", function(orig, self)
				if not self.cutscene then
					error("Attempt to stop a cutscene while none are active.")
				end
				self.cutscene:onEnd()
				coroutine.yield(self.cutscene)
				self.cutscene = nil
			end)
			
			Utils.hook(LightShop, "update", function(orig, self)
				orig(self)
				
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
			end)
			
			Utils.hook(LightShop, "onStateChange", function(orig, self, old, new)
				orig(self, old, new)
				
				if new == "CUTSCENE" then
					self.dialogue_text.width = 598
					self:setRightText("")
					self.info_box.visible = false
					self:setDialogueText("")
				end
			end)
			
			print("[Super Shops] LightShop modified successfully!")
		else
			Kristal.Console:warn("Magical Glass LightShop not detected.")
		end
	end
end

function Lib:onRegistered()
	Registry.shopcut = { }
	
	for _,path,shopcuts in Registry.iterScripts("shopcutscenes") do
		assert(shopcuts ~= nil, '"shopcutscenes/' .. path .. '.lua" does not return value')
		shopcuts.id = shopcuts.id or path
		Registry.shopcut[shopcuts.id] = shopcuts
	end
end

function Lib.getShopCutscene(group, id)
    local cutscene = Registry.shopcut[group]
    if type(cutscene) == "table" then
        return cutscene[id], true
    elseif type(cutscene) == "function" then
        return cutscene, false
    end
end

---@param debug DebugSystem
function Lib:registerDebugOptions(debug)
    local in_game = function() return Kristal.getState() == Game end
    local in_shop = function() return in_game() and Game.state == "SHOP" end
	
    debug:registerOption("main", "Play Cutscene", "Play a shop cutscene.", function() debug:enterMenu("shop_cutscenes", 1) end, in_shop)
	
	debug:registerMenu("shop_cutscenes", "Shop Cutscene Select", "search")
    for group, cutscene in pairs(Registry.shopcut) do
		if type(cutscene) == "table" then
            for id, _ in pairs(cutscene) do
				if id ~= "id" then
					debug:registerOption("shop_cutscenes", group .. "." .. id, "Start this cutscene.", function ()
						if not Game.shop:hasCutscene() then
							Game.shop:startCutscene(group, id)
						end
						debug:closeMenu()
					end)
				end
            end
        else
            debug:registerOption("shop_cutscenes", group, "Start this cutscene.", function ()
                if not Game.shop:hasCutscene() then
                    Game.shop:startCutscene(group)
                end
                debug:closeMenu()
            end)
        end
    end
end

function Lib:unload()
	Registry.shopcut = nil
end

return Lib
