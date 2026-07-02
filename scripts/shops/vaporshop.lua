local MouseHole, super = Class(Shop)

function MouseHole:init()
    super.init(self)
    self.shop_music = "vape_shop"
    self.encounter_text = "[friend]* Hello, you alls.\nTake a load off.\n[wait:10]\n* Not like we've anything else to do."
    self.shop_text = "[friend][wave]* Take a load off."
    self.leaving_text = "[friend]* See you around."
    self.buy_menu_text = "[friend]What'll it be?"
    self.buy_confirmation_text = "Costs \n%s ."
    self.buy_refuse_text = "[friend]Maybe next time?"
    self.buy_text = "[friend]Thank you."
    self.buy_storage_text = "[friend]You'll find that in your storage."
    self.buy_too_expensive_text = "[friend]Not\nenough."
    self.buy_no_space_text = "[friend]You're\ncarrying\ntoo much, [wait:5]eh?"
    self.sell_no_price_text = "[friend]You should keep it."
    self.sell_menu_text = "[friend]Toss your junk."
    self.sell_nothing_text = "[friend]* Nothin' there."
    self.sell_confirmation_text = "I can pay\n%s ."
    self.sell_refuse_text = "[friend]Maybe next time?"
    -- Shown when you sell something
    self.sell_text = "Thank you."
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text = "[friend]* Nothin' there."
    -- Shown when you enter the talk menu.
    self.talk_text = "[friend]Talk to me."

    self.sell_options_text = {}
    self.sell_options_text["items"]   = "[friend]* Let's see what you got."
    self.sell_options_text["weapons"] = "[friend]* Let's see what you got."
    self.sell_options_text["armors"]  = "[friend]* Let's see what you got."
    self.sell_options_text["storage"] = "[friend]* Let's see what you got."

    self.background = "shops/mousehole_background"
    self.background_speed = 5/30

    self.shopkeeper:setActor("shopkeepers/vaporguy")
    self.shopkeeper.sprite:setPosition(0, 8)
    self.shopkeeper.slide = true

    self:registerItem("tensionbit")
    for _, party in ipairs(Game.party) do
        self:registerItem("brews/"..party.id)
    end

    self:registerTalk("Who are you?")
    self:registerTalk("PartyBrew?")
    self:registerTalk("Vapor Sanctuary?")

    self:registerTalkAfter("Vapor Sun?", 1)
    self:registerTalkAfter("Dark Shards?", 2, "talk_2", 1)
    self:registerTalkAfter("Dark Shards", 2, "talk_2", 2)
    
end

function MouseHole:postInit()
    super.postInit(self)
    local a = VaporSun()
    a.x, a.y = SCREEN_WIDTH/2, a.height
    self:addChild(a)
    self.shopkeeper:setLayer(SHOP_LAYERS["above_boxes"])
end

function MouseHole:startTalk(talk)
    if talk == "Who are you?" then
        self:startDialogue({
            "[friend]* I am the Vapor Guy. [wait:10]I run this shop.",
            "[friend]* Take a load off, dolls.\n[wait:10]* See the Vapor Sun? [wait:10]Sit back an' watch to your hearts' content.",
            
        })
    elseif talk == "Vapor Sun?" then
        self:startDialogue({
            "[friend]* The Vapor Sun? [wait:10]That's the big ol' thing out there.",
            "[friend]* It's been there for as long as I can remember.",
            "[friend]* Some say it's a portal to another world,\n[wait:10]* but I just think it's a really cool light show."
        })
    elseif talk == "PartyBrew?" then
        self:setFlag("talk_2", 1)
        self:startDialogue({
            "[friend]* Yeah, [wait:5]I make those Party Brews.[wait:10]\n* Just makin' whatever.",
            "[friend]* Taste's a little different for each one of yous, [wait:5]and which one they drink.",
        })
    elseif talk == "Dark Shards?" then
            self:setFlag("talk_2", 2)
            self:startDialogue({
            "[friend][wave]* Ahhhh, [wait:10]so you found some.",
            "[friend]* Each Sanctuary has a Dark Shard. Located in the deepest pits of them.",
            "[friend]* Each Sanctuary is bound to the [friend:unfriend][color:yellow]Grand Sanctum.",
            "[friend]* That should be your goal. [wait:10]Open the gates, [wait:5]and do yous' thing.",
            })
    elseif talk == "Dark Shards" then
        self:startDialogue({
                "[friend]* Each Sanctuary is bound to the [friend:unfriend][color:yellow]Grand Sanctum.",
                "[friend]* I see you already have [friend:unfriend][color:9999ff]"..Mod:getDarkShardCount().." Dark Shards.",
                "[friend]* Keep doing what you're doin', [wait:5]and you'll get there.",
            })
    elseif talk == "Vapor Sanctuary?" then
        self:startDialogue({
            "[friend]* Not what you expected, [wait:5]yeah?",
            "[friend]* Take a load off, [wait:5]might just be the prettiest place you've ever seen.",
        })
    end
end

return MouseHole
