--- EnemyStatusConditions are statuses that affect single battlers and do things to enemies. \
--- Status files should be placed inside `scripts/battle/statuses/`.
---
---@class EnemyStatusCondition : Class
---
---@field default_turns         number
---@field amplifier             number
---@field icon                  string
---@field hidden                boolean
---@field ampadd				boolean

---@overload fun(...) : EnemyStatusCondition
local EnemyStatusCondition = Class()

function EnemyStatusCondition:init()
	-- Default turn counter.
	self.default_turns = 3
	
	-- Default amplifier. If greater than zero, will display.
	self.amplifier = 0
	
	-- The icon of the effect.
	self.icon = "ui/status/burn"
	
	-- Does the status effect hide itself from the status overlay?
	self.hidden = false
	
	-- Does stacking the status effect add the amplifier, rather than replace it?
	self.ampadd = false
end

-- *(Override)* Called when the status effect is applied.
function EnemyStatusCondition:onStatus(battler) end

-- *(Override)* Called when the status effect is overritten by another of the same ID.
function EnemyStatusCondition:onMerge(battler, new) end

-- *(Override)* Called every frame.
function EnemyStatusCondition:onUpdate(battler) end

-- *(Override)* Called when your turn starts, before you select all of your actions.
function EnemyStatusCondition:onTurnStart(battler) end

-- *(Override)* Called after all actions have been finished.
function EnemyStatusCondition:onActionsEnd(battler) end

-- *(Override)* Called when defense starts.
function EnemyStatusCondition:onDefenseStart(battler) end

-- *(Override)* Called when the battler gets damaged.
---@return number new_amount -- The new attack damage
function EnemyStatusCondition:onHurt(battler, amount) return amount end

-- *(Override)* Called when other battlers gets damaged.
function EnemyStatusCondition:onOtherHurt(battler, other, amount) end

-- *(Override)* Called when the status effect is cured.
function EnemyStatusCondition:onCure(battler, reason) end

function EnemyStatusCondition:__tostring()
	if self.amplifier > 0 then
		return "EnemyStatusCondition(" .. self.id .. ", amp " .. tostring(self.amplifier) .. ")"
	end
	return "EnemyStatusCondition(" .. self.id .. ")"
end

return EnemyStatusCondition