---@class Map.dark_place : Map
local map, super = Class(Map, "2_2nd_sanctuary/ripple1_post")

function map:init(world, data)
    super.init(self, world, data)
    self.jamm_slingshot_done = false
end

function map:update()
    super.update(self)

    if not self.jamm_slingshot_done and Game.world and Game.world.player and Game:hasPartyMember("jamm") then
        local player = Game.world.player

        if player.x < 280 and player.y > 750 then
            local jamm = Game.world:getCharacter("jamm")

            if jamm then
                self.jamm_slingshot_done = true

                Assets.playSound("wing")
                jamm:shake(4)
                Game.party[4]:setWeapon(nil)

                local slingshot = Sprite("world/objects/slingshot", jamm.x - 7, jamm.y - 6)
                slingshot:setScale(2)
                slingshot.layer = (jamm.layer or 0) - 0.01
                Game.world:addChild(slingshot)
            end
        end
    end
end

return map