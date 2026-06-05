local PartyMember, super = HookSystem.hookScript(PartyMember)

function PartyMember:init()
    super.init(self)
	
	self.assist_health = 0
	self.stats["assist_health"] = 0
	self.assist_name = nil
	self.assist_path = nil
end

function PartyMember:getStat(name, default, light)
    local stat = super.getStat(self, name, default, light)
    if name == "attack" then
        local success, amount = self:checkArmor("master_medallion")
        stat = stat * (2^amount)
    end
    return stat
end

function PartyMember:canAutoHeal()
	local success, amount = self:checkArmor("master_medallion")
	if amount == 2 then
		return false
	end
    return true
end

function PartyMember:save()
    local data = {
        id = self.id,
        title = self.title,
        level = self.level,
        health = self.health,
        assist_health = self.assist_health,
        stats = self.stats,
        lw_lv = self.lw_lv,
        lw_exp = self.lw_exp,
        lw_health = self.lw_health,
        lw_stats = self.lw_stats,
        spells = self:saveSpells(),
        equipped = self:saveEquipment(),
        flags = self.flags
    }
    self:onSave(data)
    return data
end

function PartyMember:load(data)
    self.title = data.title or self.title
    self.level = data.level or self.level
    self.stats = data.stats or self.stats
    self.lw_lv = data.lw_lv or self.lw_lv
    self.lw_exp = data.lw_exp or self.lw_exp
    self.lw_stats = data.lw_stats or self.lw_stats
    if data.spells then
        self:loadSpells(data.spells)
    end
    if data.equipped then
        self:loadEquipment(data.equipped)
    end
    self.flags = data.flags or self.flags
    self.health = data.health or self:getStat("health", 0, false)
    self.assist_health = data.assist_health or self:getStat("assist_health", 0, false)
    self.lw_health = data.lw_health or self:getStat("health", 0, true)

    self:onLoad(data)
end

-- I don't see us needing assist health in the light world. If we, for some reason do, you know how to change this.  -Jamm
function PartyMember:healAssist(amount, playsound)
    if playsound == nil or playsound then
        Assets.stopAndPlaySound("power")
    end
    self:setAssistHealth(math.min(math.max(self:getStat("assist_health"), self:getAssistHealth()), self:getAssistHealth() + amount))
    return self:getStat("assist_health") <= self:getAssistHealth()
end

function PartyMember:getAssistHealth() return self.assist_health end
function PartyMember:getAssistName() return self.assist_name end
function PartyMember:hasAssist() return false end

function PartyMember:setAssistHealth(health)
    self.assist_health = health
end

return PartyMember