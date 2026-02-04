local FileButton, super = Class(FileButton)

function FileButton:init(list, id, data, x, y, width, height)
    super.init(self, list, id, data, x, y, width, height)

    self.shard_icon = Assets.getTexture("ui/menu/icon/shard")
end

function FileButton:setData(data)
    super.setData(self, data)
    self.shards = 0
    if not data then
        -- Do nothing
    elseif data.dark_shards then
        self.shards = Mod:getDarkShardCount(data.dark_shards)
    -- Display legacy shards counter
    elseif data.flags["shards"] then
        self.shards = data.flags["shards"]
    end
end

function FileButton:draw()
    -- Draw the transparent background
    Draw.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)

    -- Draw the rectangle outline
    Draw.setColor(self:getDrawColor())
    Draw.drawMenuRectangle(0, 0, self.width, self.height)

    -- Draw text inside the button rectangle
    Draw.pushScissor()
    Draw.scissor(0, 0, self.width, self.height)

    if not self.prompt then
        -- Draw the name shadow
        Draw.setColor(0, 0, 0)
        love.graphics.print(self.name, 50 + 2, 10 + 2)
        -- Draw the name
        Draw.setColor(self:getDrawColor())
        love.graphics.print(self.name, 50, 10)

        -- Draw the time shadow
        local time_x = self.width-96-self.font:getWidth(self.time) + 2
        Draw.setColor(0, 0, 0)
        love.graphics.print(self.time, time_x + 2, 10 + 2)
        -- Draw the time
        Draw.setColor(self:getDrawColor())
        love.graphics.print(self.time, time_x, 10)
		
        -- Draw the shards shadow
        local shards_x = self.width-64
        Draw.setColor(0, 0, 0)
		Draw.draw(self.shard_icon, shards_x + 2, 16 + 2, 0, 2, 2)
		local shard_x_scale = 1
		if self.shards >= 100 then
			shard_x_scale = 0.5
		end
        love.graphics.print(self.shards, shards_x + 26 + 2, 10 + 2, 0, shard_x_scale, 1)
        -- Draw the shards
        Draw.setColor(self:getDrawColor())
		Draw.draw(self.shard_icon, shards_x, 16, 0, 2, 2)
        love.graphics.print(self.shards, shards_x+26, 10, 0, shard_x_scale, 1)
    else
        -- Draw the prompt shadow
        Draw.setColor(0, 0, 0)
        love.graphics.print(self.prompt, 50 + 2, 10 + 2)
        -- Draw the prompt
        Draw.setColor(self:getDrawColor())
        love.graphics.print(self.prompt, 50, 10)
    end

    if not self.choices then
        -- Draw the area shadow
        Draw.setColor(0, 0, 0)
        love.graphics.print(self.area, 50 + 2, 44 + 2)
        -- Draw the area
        Draw.setColor(self:getDrawColor())
        love.graphics.print(self.area, 50, 44)
    else
        -- Draw the shadow for choice 1
        Draw.setColor(0, 0, 0)
        love.graphics.print(self.choices[1], 70+2, 44+2)
        -- Draw choice 1
        if self.selected_choice == 1 then
            Draw.setColor(PALETTE["filemenu_selected"])
        else
            Draw.setColor(PALETTE["filemenu_deselected"])
        end
        love.graphics.print(self.choices[1], 70, 44)

        -- Draw the shadow for choice 2
        Draw.setColor(0, 0, 0)
        love.graphics.print(self.choices[2], 250+2, 44+2)
        -- Draw choice 2
        if self.selected_choice == 2 then
            Draw.setColor(PALETTE["filemenu_selected"])
        else
            Draw.setColor(PALETTE["filemenu_deselected"])
        end
        love.graphics.print(self.choices[2], 250, 44)
    end

    Draw.popScissor()
end

return FileButton
