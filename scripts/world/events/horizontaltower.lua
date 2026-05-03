---@class Event.horizontaltower : Event
local HorizontalRotTower, super = Class(Event, "horizontaltower")

function HorizontalRotTower:init(data)
    super.init(self, data)
	local properties = data and data.properties or {}
	self.tower_height = properties["height"] or 280
	self.appearance = properties["appearance"] or 0
	self.use_tilesets = properties["usetiles"] ~= false
	self.tileset_name = TiledUtils.parsePropertyList("tilelayer", properties)
	self.collision_name = properties["collisionlayer"] or "collision_tower"
	self.background_name = TiledUtils.parsePropertyList("bglayer", properties)
	self.horizontaltilecount = properties["horztiles"] or 500
	self.tower_angle = properties["angle"] or 130.91
	self.tower_angle_fine_tune = properties["anglefine"] or 0
	self.use_collision_map = properties["usecollision"] ~= false
	self.use_background_map = properties["usebg"] ~= false
	self.endclimb = false
	self.endclimbtimer = 0
	self.tower_x = self.x or 0
	self.tower_y = self.y or 240
	self.player_starting_x = 320
	self.destroy_climbstarter = true
	self.turnobjectsintotilevariants = true
	self.tiledefaultclimbable = true
	self.cull_objects = false
	self.tile_dark_color = properties["darkcol"] and TiledUtils.parseColorProperty(properties["darkcol"]) or COLORS.gray
	self.col_blend = 1
	self.visible_indices = {}
	self.backface_indices = {}
	self.tower_xshake = 0
	self.tower_yshake = 0
	self.tower_angle_prev = nil
	self.tower_angle_prev2 = nil
	self.tile_width = 40
	self.tile_height = 40
	self.tile_width_fine = self.tile_width
	self.tile_height_fine = self.tile_height
	if self.appearance == 1 then
		self.tile_width_fine = self.tile_width_fine * 0.5
		self.tile_height_fine = self.tile_height_fine * 0.5
	end
	self.tower_width = self.horizontaltilecount * self.tile_height_fine
	self.tower_radius = self.tower_height / 2
	self.tower_circumference = (2 * math.pi) * self.tower_radius
	self.tower_xstart = self.tower_x
	self.tower_x_prev = self.tower_x
	self.maincharaxprevious = nil
	self.towertype = 0
	self.timer = 0
	self.angle_extra = 0
	self.checkdamagefloor = 0
	self.krisx = 0
	self.krisy = 0
	self.kristilex = 1
	self.kristiley = 1
	self.px = 0
	self.py = 0
	self.reticle = 0
	self.found = 0
	self.dodraw = false
	self.tower_circumference = MathUtils.round(self.tower_circumference)
	if self.tower_circumference % self.tile_height_fine ~= 0 then
		for i = 0, self.tile_height_fine do
			self.tower_circumference = self.tower_circumference + 1
			if self.tower_circumference % self.tile_height_fine == 0 then
				break
			end
		end
		self.tower_radius = self.tower_circumference / (2 * math.pi)
		self.tower_width = self.tower_radius * 2
	end
	self.verticaltilecount = self.tower_circumference / self.tile_height_fine
	self.tile_angle_difference = 360 / self.verticaltilecount
	self.tm_background = {}
	self.tm_tileset = {}
	self.tile_data = {}
	self.tile_id_data = {}
	self.tower_angle_record = {}
	self.xoffset_record = {}
	self.valid_tile_indices = {}
	for iii = 0, 75 do
		table.insert(self.tower_angle_record, self.tower_angle)
		table.insert(self.xoffset_record, self.tower_x)
	end
	self.using_rotating_caterpillars = false
	self.tower_angle_add = 0
    self.gradient40 = Assets.getTexture("backgrounds/gradient40")
	Game.world.map.cyltower = self
	self.x = 0
	self.y = 0
	self.horizontal = true
end

function HorizontalRotTower:getTileIndex(x,y)
    return y + (x * self.verticaltilecount) + 1
end

function HorizontalRotTower:postLoad()
	self.tm_tileset = {}
	self.tile_data = {}
	self.tile_id_data = {}
	local a = 16
	if self.use_tilesets then
		for _, layer in ipairs(self.tileset_name) do
			local layer_id = self.world.map:getTileLayer(layer)
			if layer_id then
				layer_id.visible = false
				table.insert(self.tm_tileset, layer_id)
				self.tile_data[layer_id] = {}
				self.tile_id_data[layer_id] = {}
				for ii = 0, self.verticaltilecount do
					for i = 0, self.horizontaltilecount + 1 do
						local tile = layer_id:getTile(math.floor(self.tower_x / self.tile_width) + i, ii)
						local index = i + (ii * layer_id.map_width) + 1
						if #self.valid_tile_indices == 0 or self.valid_tile_indices[#self.valid_tile_indices] ~= self:getTileIndex(i, ii) then
							table.insert(self.valid_tile_indices, self:getTileIndex(i, ii))
						end
						self.tile_data[layer_id][i + 1] = {vis = 0, y = 0, angle = 360 - ((i + a) * (360 / self.verticaltilecount)), yscale = 1, color = COLORS.white}
						self.tile_id_data[layer_id][self:getTileIndex(i, ii)] = layer_id.tile_data[index]
					end
				end
			end
		end
	end
	if self.use_collision_map then
		--local layer_id = Game.world.map:loadHitboxes(self.collision_name)
		--self.tm_collision = layer_id
	end
	if self.use_background_map then
		for _, layer in ipairs(self.background_name) do
			local layer_id = self.world.map:getTileLayer(layer)
			table.insert(self.tm_background, layer_id)
		end
	end
	self.tower_angle_prev = nil
	self.tower_angle_prev2 = nil
	self.maincharaxprevious = Game.world.player.x
	self.reticle_drawer = HorizontalTowerReticleDrawer(self)
	self.reticle_drawer.layer = Game.world.player and Game.world.player.layer or self.layer
	Game.world:addChild(self.reticle_drawer)
end

function HorizontalRotTower:update()
    super.update(self)
	if self.world and self.world.player then
		local px, py = self.world.player:getRelativePos(0, 0)
		self.krisx = self.world.player.x
		self.krisy = self.tower_y
		if self.world.player.state == "CLIMB" and self.world.player.onrotatingtower then
			local adjustment = self.tower_y - self.tower_angle_fine_tune
			local last_angle = self.tower_angle
			self.tower_angle = MathUtils.lerp(0, 360, (py - adjustment) / self.tower_circumference)
			self.tower_angle = (self.tower_angle + 360) % 360
			
			if math.abs(self.tower_angle - last_angle) > 100 then
				self.tower_angle_add = self.tower_angle_add + (360 * MathUtils.sign(self.tower_angle - last_angle))
			end
			
			--self.tower_y = MathUtils.lerp(self.tower_ystart, self.tower_height, py / self.tower_height)
		end
		self.kristilex = px / self.tile_width_fine
		self.kristiley = (py / self.tile_height_fine) + 1
		if self.kristiley > self.verticaltilecount then
			self.kristiley = self.kristiley - self.verticaltilecount
		end
		if self.kristiley < 0 then
			self.kristiley = self.kristiley + self.verticaltilecount
		end
		if self.kristilex > self.horizontaltilecount - 1 then
			self.kristilex = self.horizontaltilecount - 1
		end
	end
	if self.endclimb then
		self.endclimbtimer = self.endclimbtimer + DTMULT
	end
	if self.tower_angle ~= self.tower_angle_prev2 then
		self.tower_angle_prev2 = self.tower_angle
		self.visible_indices = {}
		self.backface_indices = {}
		for _, layer in ipairs(self.tm_tileset) do
			for i = 0, self.verticaltilecount do
				local xid = self.tile_data[layer][i + 1]
				local tile_angle1 = xid.angle + self.tower_angle
				if tile_angle1 >= 360 then
					tile_angle1 = tile_angle1 - 360
				elseif tile_angle1 < 0 then
					tile_angle1 = tile_angle1 + 360
				end
				if self.appearance < 2 then
					xid.vis = (tile_angle1 > 350 or tile_angle1 <= 170) and 1 or 0
				else			
					xid.vis = (tile_angle1 >= 345 or tile_angle1 <= 165) and 1 or 0
				end
				if self.appearance == 1 and xid.vis == 0 and (tile_angle1 >= 340 or tile_angle1 <= 190) then
					xid.vis = 2
				end
				if xid.vis ~= 0 then
					xid.y = MathUtils.lengthDirX(self.tower_radius, -math.rad(tile_angle1))
					local tile_angle2 = tile_angle1 + self.tile_angle_difference
					if tile_angle2 > 360 then
						tile_angle2 = tile_angle2 - 360
					elseif tile_angle2 < 0 then
						tile_angle2 = tile_angle2 + 360
					end
					xid.yscale = MathUtils.lengthDirX(self.tower_radius, -math.rad(tile_angle2)) - xid.y
					xid.color = ColorUtils.mergeColor(COLORS.white, self.tile_dark_color, self.col_blend * MathUtils.clamp(math.abs(xid.y + (xid.yscale * 0.5)) / 190, 0, 1))
					if xid.vis == 1 then
						table.insert(self.visible_indices, i)
					elseif xid.vis == 2 then
						table.insert(self.backface_indices, i)
					end
				end
			end
		end
	end
	if self.use_background_map then
		for _, layer in ipairs(self.tm_background) do
			layer.y = -360 + ((self.tower_angle + 360) % 360)
		end
	end
end

function HorizontalRotTower:drawGridTile(layer, xid, id, x, y, col, pos, tileset, gw, gh, flip_x, flip_y, flip_diag)
    local draw_id = tileset:getDrawTile(id)
    local w, h = self.tile_width_fine, self.tile_height_fine

    x, y = x or 0, y or 0
    gw, gh = gw or w, gh or h

    local rot = 0
    if flip_diag then
        flip_y = not flip_y
        rot = -math.pi / 2
    end

    local sx, sy = 1, 1
    if tileset.fill_grid and gw and gh and (w ~= gw or h ~= gh) then
        sx = gw / w
        sy = gh / h
        if self.preserve_aspect_fit then
            sx = MathUtils.absMin(sx, sy)
            sy = sx
        end
    end
	sy = sy * ((-xid.yscale) / self.tile_height_fine)

    local ox, oy = gw - (w * sx) / 2, (h * sy) / 2

    local info = tileset.tile_info[draw_id]
	Draw.setColor(col)
    if info and info.texture then
        if not info.quad then
            Draw.draw(info.texture, (x or 0) + ox, (y or 0) + oy, rot, flip_x and -sx or sx, flip_y and -sy or sy, w / 2, h / 2)
        else
            Draw.draw(info.texture, info.quad, (x or 0) + ox, (y or 0) + oy, rot, flip_x and -sx or sx, flip_y and -sy or sy, w / 2, h / 2)
        end
    else
        Draw.draw(tileset.texture, tileset.quads[draw_id], (x or 0) + ox, (y or 0) + oy, rot, flip_x and -sx or sx, flip_y and -sy or sy, w / 2, h / 2)
    end
end

function HorizontalRotTower:draw()
    super.draw(self)
	local camx = (Game.world.camera.x - SCREEN_WIDTH/2) - self.tower_x
	local render_xpos = MathUtils.round(camx / self.tile_width_fine)
	local render_xpos_start = render_xpos - 1
	local render_xpos_end = render_xpos + 33
	if render_xpos_start < 0 then
		render_xpos_start = 0
	end
	if render_xpos_end > self.horizontaltilecount then
		render_xpos_end = self.horizontaltilecount
	end
	self.tower_x = self.tower_x + self.tower_xshake
	self.tower_y = self.tower_y + self.tower_yshake
	if self.use_tilesets then
		local cx = 0
		local cy = 0
		local statictile = nil
		local statictilecount = nil
		local staticyoffset = 760
		for _, layer in ipairs(self.tm_tileset) do
			for i = 1, #self.valid_tile_indices do
				local pos = self.valid_tile_indices[i]
				local k = (pos % self.verticaltilecount) + 1
				local ii = math.floor(pos / self.verticaltilecount)
				local xid = self.tile_data[layer][k]
				local xid2 = self.tile_id_data[layer][self:getTileIndex(ii, k - 1)]

				if xid and xid2 then
					local gid, flip_x, flip_y, flip_diag = TiledUtils.parseTileGid(xid2)
					local tileset, id = self.world.map:getTileset(gid)
					if tileset and xid.vis == 1 and ii >= render_xpos_start and ii <= render_xpos_end then
						Draw.setColor(xid.color)
						local xx = (self.tile_width_fine * ii) + self.tower_xstart
						local yy = (self.tower_y - self.tower_yshake) + xid.y + (xid.yscale)
						self:drawGridTile(layer, xid, id, xx - cx, yy - cy, xid.color, pos, tileset, grid_w, grid_h, flip_x, flip_y, flip_diag)
					end 
				end
			end
		end
	end
	local cull_top = render_xpos_start * self.tile_width_fine
	local cull_bottom = render_xpos_end * self.tile_width_fine
	local yscale_scaled = 1 / self.tile_height_fine
	for _, event in ipairs(self.world.map.events) do
		if event and event.climb_obstacle then
			if event.id == "ClimbWaterBucket" then
				local tiley = math.floor((event.y * yscale_scaled) + 1)
				if tiley > self.verticaltilecount - 1 then
					tiley = tiley - self.verticaltilecount - 1
				elseif tiley < 0 then
					tiley = tiley + self.verticaltilecount - 1
				end
				local tile = self.tile_data[self.tm_tileset[1]][tiley - 1]
				if tile.vis == 1 then
					Draw.setColor(tile.color)
					if event.generator then
						Draw.draw(event.sprite.texture, event.x + event.graphics.shake_x - 40, self.tower_y + event.graphics.shake_y + tile.y, 0, 2, (tile.yscale * 2) / self.tile_height_fine, 0, 10)
						if event.drawwater > 0 then
							local sprite = Assets.getFrames("world/events/climbwater/climb_waterbucket_splash")
							local frame = math.floor(#sprite - (event.drawwater / 3)) + 1
							Draw.draw(sprite[frame], event.x + event.graphics.shake_x - 40, self.tower_y + event.graphics.shake_y + tile.y, 0, 2, (tile.yscale * -2.2) / self.tile_height_fine, 0, 13)
						end
					else
						Draw.draw(event.sprite.texture, event.x + event.graphics.shake_x - 40, self.tower_y + event.graphics.shake_y + tile.y, 0, 2, (tile.yscale * -2.2) / self.tile_height_fine, 0, 10)
						if event.drawwater > 0 then
							local sprite = Assets.getFrames("world/events/climbwater/climb_waterbucket_splash")
							local frame = math.floor(#sprite - (event.drawwater / 3)) + 1
							Draw.draw(sprite[frame], event.x + event.graphics.shake_x - 40, self.tower_y + event.graphics.shake_y + tile.y, 0, 2, (tile.yscale * -2.2) / self.tile_height_fine, 0, 13)
						end
					end
				end
			end
		end
	end
	for _, flash in ipairs(Game.stage:getObjects(FlashFadeTower)) do
		if flash then
			local ox, oy = flash:getOriginExact()
			local tiley = math.floor((flash.y * yscale_scaled) + 1)
			if tiley > self.verticaltilecount - 1 then
				tiley = tiley - self.verticaltilecount - 1
			elseif tiley < 0 then
				tiley = tiley + self.verticaltilecount - 1
			end
			local yoff = flash.y % self.tile_height_fine
			local tile = self.tile_data[self.tm_tileset[1]][tiley - 1]
			if tile.vis == 1 then
				Draw.setColor(tile.color)
				local last_shader = love.graphics.getShader()
				local shader = Kristal.Shaders["AddColor"]
				love.graphics.setShader(shader)
				shader:send("inputcolor", COLORS.white)
				shader:send("amount", flash.alpha)
				Draw.draw(flash.texture, self.tower_x + flash.graphics.shake_x, flash.y + flash.graphics.shake_y + tile.y + yoff, 0, flash.scale_x, (tile.yscale * flash.scale_y) / self.tile_height_fine, ox, oy)
				shader:send("amount", 1)
				love.graphics.setShader(last_shader)
			end
		end
	end
	for _, cuthalf in ipairs(Game.stage:getObjects(AfterImageCutHalfTower)) do
		if cuthalf then
			local ox, oy = cuthalf:getOriginExact()
			local tiley = math.floor((cuthalf.y * yscale_scaled) + 1)
			if tiley > self.verticaltilecount - 1 then
				tiley = tiley - self.verticaltilecount - 1
			elseif tiley < 0 then
				tiley = tiley + self.verticaltilecount - 1
			end
			local xoff = cuthalf.y % self.tile_height_fine
			local tile = self.tile_data[self.tm_tileset[1]][tiley - 1]
			if tile.vis == 1 then
				local y = self.tower_y + cuthalf.graphics.shake_y + tile.y - 20 
				if cuthalf.flash then
					cuthalf.flash = false
				else
					local r, g, b, a = cuthalf:getDrawColor()
					
					local hw = cuthalf.width/2
					local hh = cuthalf.height/2

					local m = Utils.ease(0, hh, (cuthalf.siner + 2)/10, "out-sine")
					love.graphics.setColor(r, g, b, cuthalf.spr_alpha)
					
					Draw.drawPart(cuthalf.texture, cuthalf.x - (cuthalf.width / 2), y - m - ((cuthalf.yo * cuthalf.scale_y) / 2), 0, 0, hw * 2, hh, ox, oy)
					Draw.drawPart(cuthalf.texture, cuthalf.x - (cuthalf.width / 2), y + m - ((cuthalf.yo * cuthalf.scale_y) / 2), 0, hh, hw * 2, hh, ox, oy)
				end
			end
		end
	end
	if self.appearance == 0 then
		Draw.setColor(0,0,0,0.6 * self.col_blend)
		Draw.draw(self.gradient40, self.tower_x, (self.tower_y - self.tower_radius) + self.tile_height, -math.rad(180), -self.horizontaltilecount + 1, 1)
		Draw.draw(self.gradient40, self.tower_x, (self.tower_y + self.tower_radius) - self.tile_height, -math.rad(0), self.horizontaltilecount - 1, 1)
	end
	self.tower_x = self.tower_x - self.tower_xshake
	self.tower_y = self.tower_y - self.tower_yshake
	Draw.setColor(1,1,1,1)
end

function HorizontalRotTower:drawTowerCoin(event, angle)
	local dist_from_tower = 15
	if self.appearance == 2 then
		dist_from_tower = 45
	end
	local coin_x = self.tower_x + MathUtils.lengthDirX(self.tower_radius + dist_from_tower, -math.rad(angle))
	local factor = math.sin(math.rad(angle))
	local spr = event.silver_tex[(math.floor(event.siner/4)%4)+1]
	local xoff = 4
	local yoff = 4
	if event.value > 5 then
		spr = event.gold_tex[(math.floor(event.siner/4)%4)+1]
		yoff = 5
	end
	Draw.setColor(ColorUtils.mergeColor(COLORS.white, COLORS.black, MathUtils.clamp(1 - factor, 0, 1)))
	if event.con == 0 then
		Draw.draw(spr, coin_x, event.y + 30 + math.sin(event.siner / 20) * 4, 0, 2, 2, xoff, yoff)
	end
end

function HorizontalRotTower:drawTowerText(text, angle)
	local dist_from_tower = 25
	if self.appearance == 2 then
		dist_from_tower = 55
	end
	local text_x = self.tower_x - text.x_offset + MathUtils.lengthDirX(self.tower_radius + dist_from_tower, -math.rad(angle))
	local factor = math.sin(math.rad(angle))
	Draw.setColor(ColorUtils.mergeColor(COLORS.white, COLORS.black, MathUtils.clamp(1 - factor, 0, 1)))
	Draw.draw(text.canvas, text_x, text.y)
end

function HorizontalRotTower:drawTowerBell(event, angle)
	local xscale = 2
	local dist_from_tower = 15
	if self.appearance == 2 then
		dist_from_tower = 45
	end
	local xx = self.tower_x + MathUtils.lengthDirX(self.tower_radius + dist_from_tower, -math.rad(angle))
	local factor = math.sin(math.rad(angle))
	Draw.setColor(ColorUtils.mergeColor(ColorUtils.hexToRGB("#B4D6CA"), COLORS.black, MathUtils.clamp(1 - factor, 0, 1)))
	Draw.draw(event.fill_tex, xx, event.y, 0, xscale, -event.bellcordlength)
	Draw.draw(event.gradient_tex, xx, event.y - event.bellcordlength - (40 * event.bellcordfadelength), 0, xscale / 40, event.bellcordfadelength)
	Draw.setColor(ColorUtils.mergeColor(COLORS.white, COLORS.black, MathUtils.clamp(1 - factor, 0, 1)))
	Draw.draw(event.sprite.texture, xx, event.y, event.sprite.rotation, xscale, 2, 9, 2)
end

return HorizontalRotTower