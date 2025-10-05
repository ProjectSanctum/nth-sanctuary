local TileObject, super = Class(Event, "TileObject")

function TileObject:init(tileset, tile, x, y, w, h, rotation, flip_x, flip_y, properties)
    local tile_width, tile_height = tileset:getTileSize(tile)

    super.init(self, x, y, {w or self.tile_width, h or self.tile_height})

    self.tileset = tileset
    self.tile = tile
    self.rotation = rotation
    self.tile_flip_x = flip_x
    self.tile_flip_y = flip_y
	self.properties = properties or {}
	self.light_area = self.properties["light"] or false
	self.light_type = self.properties["light_type"] or 1
	self.light_alpha = self.properties["light_alpha"] or 1
	self.light_color = Utils.parseColorProperty(self.properties["light_color"])
	self.light_dust = self.properties["light_dust"] or false
	self.light_amount = 1
	
    local origin = Tileset.ORIGINS[self.tileset.object_alignment] or Tileset.ORIGINS["unspecified"]
    self:setOrigin(origin[1], origin[2])
end

function TileObject:drawLightA()
	if self.light_area then
		local tile_width, tile_height = self.tileset:getTileSize(self.tileset:getDrawTile(self.tile))
		local sx = self.width / tile_width * (self.tile_flip_x and -1 or 1)
		local sy = self.height / tile_height * (self.tile_flip_y and -1 or 1)
		if self.tileset.preserve_aspect_fit then
			sx = Utils.absMin(sx, sy)
			sy = sx
		end
		love.graphics.setColor(1,1,1,1)
		if self.light_type == 1 then
			local mask_canvas = Draw.pushCanvas(self.width, self.height)
			self.tileset:drawTile(self.tile, 0, 0, 0, 1, 1)
			love.graphics.setBlendMode("alpha")
			Draw.popCanvas()
			local last_shader = love.graphics.getShader()
			love.graphics.setShader(Ch4Lib.invert_alpha)
			love.graphics.setBlendMode("multiply", "premultiplied")
			local xx, yy = self:localToScreenPos(0,0)
			Draw.draw(mask_canvas, xx+self.width/2, yy+self.height/2, 0, sx, sy, tile_width/2, tile_height/2)
			love.graphics.setShader(last_shader)
		end
	end
end

function TileObject:drawLightB()
	if self.light_area then
		local tile_width, tile_height = self.tileset:getTileSize(self.tileset:getDrawTile(self.tile))
		local sx = self.width / tile_width * (self.tile_flip_x and -1 or 1)
		local sy = self.height / tile_height * (self.tile_flip_y and -1 or 1)
		if self.tileset.preserve_aspect_fit then
			sx = Utils.absMin(sx, sy)
			sy = sx
		end
		if self.light_type == 1 then
			love.graphics.setColor(1,1,1,1)
			local xx, yy = self:localToScreenPos(0,0)
			self.tileset:drawTile(self.tile, xx+self.width/2, yy+self.height/2, 0, sx, sy, tile_width/2, tile_height/2)
		end
	end
end

function TileObject:draw()
    local tile_width, tile_height = self.tileset:getTileSize(self.tileset:getDrawTile(self.tile))
    local sx = self.width / tile_width * (self.tile_flip_x and -1 or 1)
    local sy = self.height / tile_height * (self.tile_flip_y and -1 or 1)
    if self.tileset.preserve_aspect_fit then
        sx = Utils.absMin(sx, sy)
        sy = sx
    end
	if self.light_area and self.light_type == 1 then
		love.graphics.setBlendMode("add")
		love.graphics.setColor(self.light_color[1], self.light_color[2], self.light_color[3], self.light_alpha * self.light_amount)
	end
    self.tileset:drawTile(self.tile, self.width/2, self.height/2, 0, sx, sy, tile_width/2, tile_height/2)
	love.graphics.setBlendMode("alpha")
end

return TileObject