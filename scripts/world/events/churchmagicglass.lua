local ChurchMagicGlass, super = Class(Event)

function ChurchMagicGlass:init(data)
    super.init(self, data)
    local properties = data and data.properties or {}

    self.texture = Assets.getTexture("world/events/church_magical_glass")

    self.tiles_x = math.floor(self.width/80)
    self.tiles_y = math.floor(self.height/80)

    self.glass_colliders = {}
    self.tile_alphas = {}
    self.tile_idlealphas = {}

	self.idlealpha = properties["idlealpha"] or 0.2
	self.starthidden = properties["starthidden"] or false
    for i = 1, self.tiles_x do
        for j = 1, self.tiles_y do
            local hitbox = Hitbox(self, (i - 1) * 80, (j - 1) * 80, 80, 80)
            table.insert(self.glass_colliders, hitbox)
            table.insert(self.tile_alphas, 0)
            table.insert(self.tile_idlealphas, self.idlealpha)
        end
    end

    self.collider = ColliderGroup(self, self.glass_colliders)
end

function ChurchMagicGlass:update()
    Object.startCache()
    for i,collider in ipairs(self.glass_colliders) do
        local any_collided = false
        for _,char in ipairs(Game.stage:getObjects(Character)) do
            if collider:collidesWith(char) then
                any_collided = true
                break
            end
        end
		local targalpha = self.idlealpha
        if any_collided then
            self.tile_alphas[i] = Utils.lerp(self.tile_alphas[i], 0.8, 0.125 * DTMULT)
			if self.starthidden and self.tile_alphas[i] >= 0.8 then
				self.tile_idlealphas[i] = 0.2
			end
        else
            self.tile_alphas[i] = Utils.lerp(self.tile_alphas[i], self.tile_idlealphas[i], 0.125 * DTMULT)
        end
    end
    Object.endCache()

    super.update(self)
end

function ChurchMagicGlass:draw()
    local r,g,b,a = self:getDrawColor()

    local id = 1
    for i = 1, self.tiles_x do
        for j = 1, self.tiles_y do
            Draw.setColor(r, g, b, a * self.tile_alphas[id])
            Draw.draw(self.texture, (i - 1) * 80, (j - 1) * 80, 0, 2, 2)
            id = id + 1
        end
    end

    super.draw(self)
end

return ChurchMagicGlass