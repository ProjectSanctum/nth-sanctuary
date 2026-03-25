local Organikk, super = Class(Encounter)

function Organikk:init()
    super.init(self)

    self.text = "* Organikk uses Winglade to swoop down on you!"

    self.music = "ch4_battle"
    self.background = true

    self:addEnemy("organikk")
    self:addEnemy("winglade")
end

function Organikk:getPartyPosition(index)
    if #Game.battle.party > 3 then return super.getPartyPosition(self, index) end

    local krloc = {94, 50}
    local suloc = {80, 122}
    local raloc = {72, 200}

    if #Game.party == 1 then
        krloc = {80, 122}
    elseif #Game.party == 2 then
        krloc = {94, 86}
        suloc = {80, 166}
    end

    if index == 1 then
        return krloc[1]+(19 + 4), krloc[2]+(38 + 38)
    elseif index == 2 then
        return suloc[1]+(25 + 6), suloc[2]+(43 + 45)
    elseif index == 3 then
        return raloc[1]+(21 + 4), raloc[2]+(40 + 52)
    else
        return super.getPartyPosition(self, index)
    end
end

return Organikk