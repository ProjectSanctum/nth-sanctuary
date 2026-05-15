local Compelled, super = Class(StatusCondition)

function Compelled:init(amplifier)
    super.init(self)

    self.name = "Compelled"
    self.amplifier = amplifier or 2

    self.desc = "MAGIC is increased by 2 per given stack to allow a harder hitting spell. [STACK: ".. self.amplifier .. "]"

    self.default_turns = 3

    self.icon = "ui/status/compel"
end

function Compelled:applyStatModifier(stat, value)
    if stat == "magic" then
        value = 2 * self.amplifier
    end
    return value
end

function Compelled:onMerge(battler, new)
    if new[1] > self.amplifier then
        self.amplifier = new[1]
    end
end

return Compelled