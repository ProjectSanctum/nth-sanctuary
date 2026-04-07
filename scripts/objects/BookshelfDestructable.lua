local BookshelfDestructable, super = Class(Event)

function BookshelfDestructable:init(data)
    super.init(self, data)

    self.solid = true
	self:setHitbox(0, 80, 80, 80)
    local properties = data and data.properties or {}
	
	self.texture = properties["sprite"] or "world/events/bookshelf/2x2"
    self:setSprite(self.texture)
    self.set_flag = properties["setflag"]
    self.set_value = properties["setvalue"]
	self.once = properties["once"] or true
	self.con = 0
	self.special = 0
	self.solid_breakable = true
	self.start_layer = self.layer
end

function BookshelfDestructable:onAdd(parent)
    super.onAdd(self,parent)
	self.start_layer = self.layer
end

function BookshelfDestructable:onLoad()
    super.onLoad(self)
    if self.once and self:getFlag("used_once", false) then
		local this_id = math.floor((self.x / 80) + (self.y / 80))
		local debris = Sprite("world/events/bookshelf/debris", self.x, self.y + 80)
		debris:setFrame((this_id % 5) + 1)
		debris.layer = self.layer - 0.4
		Game.world:addChild(debris)
		if Game.world.map.bookshelf_debris_sprites then
			table.insert(Game.world.map.bookshelf_debris_sprites, debris)
		end
		self:remove()
	end
end

function BookshelfDestructable:update()
    super.update(self)
	local tx = self.x + 20
	local ty = self.y + 80 + 20
	local wid = 40
	local hei = 40
	Object.startCache()
	local collided = false
	local collider = nil
	local bound_check = Hitbox(self.world, tx + 1, ty + 1, wid - 2, hei - 2)
	for _, piano in ipairs(Game.world.map:getEvents("remotepianomove")) do
		if piano.collider:collidesWith(bound_check) then
			collided = true
			collider = piano
			break
		end
		if piano.engaged and self.y + 80 < piano.y then
			self.layer = piano.layer - 0.01
		else
			self.layer = self.start_layer
		end
	end
	Object.endCache()
	if collided and collider then
		if collider.con ~= 4 then
			Assets.playSound("impact")
			for _, piano in ipairs(Game.world.map:getEvents("remotepianomove")) do
				piano.myhspeed = piano.myhspeed * 0.7
				piano.myvspeed = piano.myvspeed * 0.7
			end
			self.con = 1
		end
	end
	if self.con == 1 then
		local explosion = Sprite("effects/explosion_round")
		explosion:setScale(2, 2)
		explosion:setPosition(self.x + 10, self.y + 40)
		explosion.layer = self.layer + 0.01
        explosion:play(1 / 18, false, function(s) s:remove() end)
        Game.world:addChild(explosion)
		if self.special == 3 then
			-- WIP
		else
			local this_id = math.floor((self.x / 80) + (self.y / 80))
			local scatter
			if this_id % 2 == 1 then
				scatter = Sprite("world/events/bookshelf/scatter2", self.x, self.y + 80)
			else			
				scatter = Sprite("world/events/bookshelf/scatter1", self.x, self.y + 80)
			end
			scatter:play(1 / 9, false, function(s) s:remove() end)
			scatter.layer = self.layer + 0.01
			Game.world:addChild(scatter)
			local debris = Sprite("world/events/bookshelf/debris", self.x, self.y + 80)
			debris:setFrame((this_id % 5) + 1)
			debris.layer = self.layer - 0.4
			Game.world:addChild(debris)
			if Game.world.map.bookshelf_debris_sprites then
				table.insert(Game.world.map.bookshelf_debris_sprites, debris)
			end
			local afterimage = AfterImageCutHalf(self.sprite.texture_path)
			afterimage:setScale(2, 2)
			afterimage:setPosition(self.x + 40, self.y + 40)
			afterimage.layer = self.layer
			afterimage:setOriginExact(0, 0)
			Game.world:addChild(afterimage)
			if self.set_flag then
				Game:setFlag(self.set_flag, (self.set_value == nil and true) or self.set_value)
			end
			if self.once then
				self:setFlag("used_once", true)
			end
			self:remove()
		end
	end
end

return BookshelfDestructable