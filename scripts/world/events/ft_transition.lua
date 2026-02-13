---@overload fun(...) : Transition
local FastTravelTransition, super = Class(Event)

function FastTravelTransition:init(data)
    super.init(self, data)

    properties = data.properties or {}

    self.sound = properties.sound or nil
    self.pitch = properties.pitch or 1

    self.exit_delay = properties.exit_delay or 0
    self.exit_sound = properties.exit_sound or nil
    self.exit_pitch = properties.exit_pitch or 1
end

function FastTravelTransition:onEnter(chara)
    if chara.is_player then
        if self.sound then
            Assets.playSound(self.sound, 1, self.pitch)
        end

        local callback = function(map)
            if self.exit_sound then
                Assets.playSound(self.exit_sound, 1, self.exit_pitch)
            end
            Game.world.door_delay = self.exit_delay
        end

        self.world:mapTransition(Game:getFlag("ft_last_map", "0_base_sanctum/base_sanctum_center"), "entry_fast_travel", chara.facing, callback)
    end
end

return FastTravelTransition