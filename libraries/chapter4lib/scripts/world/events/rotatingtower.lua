---@class Event.rotatingtower : Event
local RotatingTower, super = Class(Event, "rotatingtower")

function RotatingTower:init(data)
    super.init(self, data)
	local properties = data and data.properties or {}
	self.tower_width = properties["width"] or 280
	self.appearance = properties["appearance"] or 0
	self.use_tilesets = properties["usetiles"] ~= false
	self.tileset_name = TiledUtils.parsePropertyList("tilelayer", properties)
	self.collision_name = properties["collisionlayer"] or "collision_tower"
	self.background_name = TiledUtils.parsePropertyList("bglayer", properties)
	self.verticaltilecount = properties["verttiles"] or 500
	self.tower_angle = properties["angle"] or 130.91
	self.tower_angle_fine_tune = properties["anglefine"] or 0
	self.use_collision_map = properties["usecollision"] ~= false
	self.use_background_map = properties["usebg"] ~= false
	self.endclimb = false
	self.endclimbtimer = 0
	self.tower_x = self.x or 320
	self.tower_y = self.y or 0
	self.player_starting_y = 320
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
	self.tower_height = self.verticaltilecount * self.tile_height_fine
	self.tower_radius = self.tower_width / 2
	self.tower_circumference = (2 * math.pi) * self.tower_radius
	self.tower_ystart = self.tower_y
	self.tower_y_prev = self.tower_y
	self.maincharayprevious = nil
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
	if self.tower_circumference % self.tile_width_fine ~= 0 then
		for i = 0, self.tile_width_fine do
			self.tower_circumference = self.tower_circumference + 1
			if self.tower_circumference % self.tile_width_fine == 0 then
				break
			end
		end
		self.tower_radius = self.tower_circumference / (2 * math.pi)
		self.tower_width = self.tower_radius * 2
	end
	self.horizontaltilecount = self.tower_circumference / self.tile_width_fine
	self.tile_angle_difference = 360 / self.horizontaltilecount
	self.tm_tileset = {}
	self.tile_data = {}
	self.tile_id_data = {}
	self.tower_angle_record = {}
	self.yoffset_record = {}
	self.valid_tile_indices = {}
	for iii = 0, 75 do
		table.insert(self.tower_angle_record, self.tower_angle)
		table.insert(self.yoffset_record, self.tower_y)
	end
	self.using_rotating_caterpillars = false
	self.tower_angle_add = 0
    self.gradient40 = Assets.getTexture("backgrounds/gradient40")
	Game.world.map.cyltower = self
	self.x = 0
	self.y = 0
end

function RotatingTower:getTileIndex(x,y)
    return x + (y * self.horizontaltilecount) + 1
end

function RotatingTower:postLoad()
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
						local tile = layer_id:getTile(i, math.floor(self.tower_y / self.tile_height) + ii)
						local index = i + (ii * layer_id.map_width) + 1
						if #self.valid_tile_indices == 0 or self.valid_tile_indices[#self.valid_tile_indices] ~= self:getTileIndex(i, ii) then
							table.insert(self.valid_tile_indices, self:getTileIndex(i, ii))
						end
						self.tile_data[layer_id][i + 1] = {vis = 0, x = 0, angle = 360 - ((i + a) * (360 / self.horizontaltilecount)), xscale = 1, color = COLORS.white}
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
	self.tower_angle_prev = nil
	self.tower_angle_prev2 = nil
	self.maincharayprevious = Game.world.player.y
end

function RotatingTower:update()
    super.update(self)
	if self.world and self.world.player then
		local px, py = self.world.player:getRelativePos(0, 0)
		self.krisx = self.tower_x
		self.krisy = self.world.player.y
		if self.world.player.state == "CLIMB" and self.world.player.onrotatingtower then
			local adjustment = self.tower_x - self.tower_angle_fine_tune
			local last_angle = self.tower_angle
			self.tower_angle = MathUtils.lerp(0, 360, (px - adjustment) / self.tower_circumference)
			self.tower_angle = (self.tower_angle + 360) % 360
			
			if math.abs(self.tower_angle - last_angle) > 100 then
				self.tower_angle_add = self.tower_angle_add + (360 * MathUtils.sign(self.tower_angle - last_angle))
			end
			
			--self.tower_y = MathUtils.lerp(self.tower_ystart, self.tower_height, py / self.tower_height)
		end
		self.kristilex = (px / self.tile_width_fine) + 1
		self.kristiley = py / self.tile_height_fine
		if self.kristiley > self.verticaltilecount - 1 then
			self.kristiley = self.verticaltilecount - 1
		end
		if self.kristilex > self.horizontaltilecount then
			self.kristilex = self.kristilex - self.horizontaltilecount
		end
		if self.kristilex < 0 then
			self.kristilex = self.kristilex + self.horizontaltilecount
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
			for i = 0, self.horizontaltilecount do
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
					xid.x = MathUtils.lengthDirX(self.tower_radius, -math.rad(tile_angle1))
					local tile_angle2 = tile_angle1 + self.tile_angle_difference
					if tile_angle2 > 360 then
						tile_angle2 = tile_angle2 - 360
					elseif tile_angle2 < 0 then
						tile_angle2 = tile_angle2 + 360
					end
					xid.xscale = MathUtils.lengthDirX(self.tower_radius, -math.rad(tile_angle2)) - xid.x
					xid.color = ColorUtils.mergeColor(COLORS.white, self.tile_dark_color, self.col_blend * MathUtils.clamp(math.abs(xid.x + (xid.xscale * 0.5)) / 190, 0, 1))
					if xid.vis == 1 then
						table.insert(self.visible_indices, i)
					elseif xid.vis == 2 then
						table.insert(self.backface_indices, i)
					end
				end
			end
		end
	end
end

function RotatingTower:drawGridTile(layer, xid, id, x, y, col, pos, tileset, gw, gh, flip_x, flip_y, flip_diag)
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
	sx = sx * ((-xid.xscale) / self.tile_width_fine)

    local ox, oy = (w * sx) / 2, gh - (h * sy) / 2

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

function RotatingTower:draw()
    super.draw(self)
	local camy = (Game.world.camera.y - SCREEN_HEIGHT/2) - self.tower_y
	local render_ypos = MathUtils.round(camy / self.tile_height_fine)
	local render_ypos_start = render_ypos - 1
	local render_ypos_end = render_ypos + 25
	if render_ypos_start < 0 then
		render_ypos_start = 0
	end
	if render_ypos_end > self.verticaltilecount then
		render_ypos_end = self.verticaltilecount
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
				local k = (pos % self.horizontaltilecount) + 1
				local ii = math.floor(pos / self.horizontaltilecount)
				local xid = self.tile_data[layer][k]
				local xid2 = self.tile_id_data[layer][self:getTileIndex(k - 1, ii)]

				if xid and xid2 then
					local gid, flip_x, flip_y, flip_diag = TiledUtils.parseTileGid(xid2)
					local tileset, id = self.world.map:getTileset(gid)
					if tileset and xid.vis == 1 and ii >= render_ypos_start and ii <= render_ypos_end then
						Draw.setColor(xid.color)
						local xx = (self.tower_x - self.tower_xshake) + xid.x + (xid.xscale)
						local yy = (self.tile_height_fine * ii) + self.tower_ystart + 10
						self:drawGridTile(layer, xid, id, xx - cx, yy - cy, col, pos, tileset, grid_w, grid_h, flip_x, flip_y, flip_diag)
					end 
				end
			end
		end
	end
	self:drawClimbReticle()
	local cull_top = render_ypos_start * self.tile_height_fine
	local cull_bottom = render_ypos_end * self.tile_height_fine
	if self.appearance == 0 then
		Draw.setColor(0,0,0,0.6 * self.col_blend)
		Draw.draw(self.gradient40, (self.tower_x - self.tower_radius) + self.tile_width, self.tower_y, -math.rad(270), self.verticaltilecount + 1, 1)
		Draw.draw(self.gradient40, (self.tower_x + self.tower_radius) - self.tile_width, self.tower_y, -math.rad(90), -self.verticaltilecount + 1, 1)
	end
	self.tower_x = self.tower_x - self.tower_xshake
	self.tower_y = self.tower_y - self.tower_yshake
	Draw.setColor(1,1,1,1)
end

function RotatingTower:drawClimbReticle()
    local player = self.world.player
    if not player.draw_reticle or player.state ~= "CLIMB" then
        return
    end
	love.graphics.push()
    --love.graphics.translate(player.width/2, player.height - 10)

    local found = 0;
    local _alph;

    if (player.jumpchargecon ~= 0) then
        local count = 1;

        for i = 1, #player.charge_times do
            if player.jumpchargetimer > player.charge_times[i] then
                count = i + 1
            end
        end

        local px = 0;
        local py = 0;

        for i = 1, count do
            if (player.facing == "down") then
                py = 0+i;
            end

            if (player.facing == "right") then
                px = 0+i;
            end

            if (player.facing == "up") then
                py = 0-i;
            end

            if (player.facing == "left") then
                px = 0-i;
            end
            local s,o = player:canClimb(px, py)
            if s or o then
                found = i
            end
        end
		local px, py = self.world.player:getRelativePos(0, 20)
		if self.appearance == 1 then
			px = px + 40
		end
		local tilex = px / self.tile_width_fine
		local tiley = py / self.tile_height_fine
		if tilex >= self.horizontaltilecount then
			tilex = tilex - self.horizontaltilecount
		end
		if tilex < 0 then
			tilex = tilex + self.horizontaltilecount
		end
        _alph = MathUtils.clamp(player.jumpchargetimer / 14, 0.1, 0.8);
        local angle = 0;
        local xoff = 0;
        local yoff = 0;
		local shiftx = 0
		local shifty = 0

        if (player.facing == "down") then
            angle = 0;
            xoff = -22;
            yoff = 18;
			shifty = 1
        end

        if (player.facing == "right") then
            angle = 90;
            xoff = 18;
            yoff = 22;
			shiftx = 1
        end

        if (player.facing == "up") then
            angle = 180;
            xoff = 22;
            yoff = -18;
			shifty = -1
        end

        if (player.facing == "left") then
            angle = 270;
            xoff = -18;
            yoff = -22;
			shiftx = -1
        end

        -- TODO: Put these colors in the PALETTE
        local col = {200/255, 200/255, 200/255};

        if (found ~= 0) then
            col = {255/255, 200/255, 132/255};
        end
        Draw.setColor(col)
        local frame = MathUtils.wrap(math.floor(Kristal.getTime() * 15), 1,4)
        local w = (player.jumpchargetimer / (player.charge_times[#player.charge_times] or 10)) * (#player.charge_times+1)
		local tile = self.tile_data[self.tm_tileset[1]][math.floor(tilex) + 1]
		local startx = (self.tower_x + tile.x + xoff) - 20
		local starty = py + yoff + 20
		local divisor = 120
		local count = #player.charge_times
        for subsection = 0, count do
            local id, h = "ui/climb/hint_mid", 20
            if subsection == 0 then
                id = "ui/climb/hint_start"
                h = 21
            elseif subsection == #player.charge_times then
                id = "ui/climb/hint_end"
                h = 21
            end
			local tx = tilex + ((subsection + 1) * shiftx)
			local ty = tiley + ((subsection + 1) * shifty)
			if tx >= self.horizontaltilecount then
				tx = tx - self.horizontaltilecount
			end
			if tx < 0 then
				tx = tx + self.horizontaltilecount
			end
			local tile2 = self.tile_data[self.tm_tileset[1]][math.floor(tx) + 1]
			if tile2.vis == 1 then
				local jankfix = 0
				if subsection == (#player.charge_times - 1) and self.tile_width_fine ~= self.tile_width and shiftx == -1 then
					jankfix = (6 * (shiftx - 1)) / 2
				end
				local scalemult = tile2.xscale / self.tile_width_fine
				local quad = Assets.getQuad(0, 0, 22, math.floor(MathUtils.clamp(w - subsection, 0, 1) * h), 22, h)
				Draw.draw(Assets.getFrames(id)[frame], quad, startx - jankfix, starty, -math.rad(angle), 2, scalemult * -2)
				startx = startx + (scalemult * shiftx * h * -2)
				starty = starty + (shifty * h * 2)
			end
		end
    end
	
    if (player.jumpchargecon > 0 and found ~= 0) then
		local px, py = self.world.player:getRelativePos(0, 20)
		
		if self.appearance == 1 then
			px = px + 40
		end

        if (player.facing == "down") then
            py = py + (self.tile_height * found);
        end

        if (player.facing == "right") then
            px = px + (self.tile_width * found);
        end

        if (player.facing == "up") then
            py = py - (self.tile_height * found);
        end

        if (player.facing == "left") then
            px = px - (self.tile_width * found);
        end
		
		local tilex = px / self.tile_width_fine
		if tilex >= self.horizontaltilecount then
			tilex = tilex - self.horizontaltilecount
		end
		if tilex < 0 then
			tilex = tilex + self.horizontaltilecount
		end

        Draw.setColor(TableUtils.lerp({1,1,0,_alph}, {1,1,1,_alph}, 0.4 + (math.sin(player.jumpchargetimer / 3) * 0.4)));
		local tile = self.tile_data[self.tm_tileset[1]][math.floor(tilex) + 1]
		if tile.vis == 1 then
			Draw.draw(Assets.getTexture("ui/climb/reticle"), self.tower_x + tile.x, py, 0, (tile.xscale / self.tile_width_fine) * 2, 2, 2, 2)
		end
	end
    love.graphics.pop()
	Draw.setColor(1,1,1,1)
end
return RotatingTower