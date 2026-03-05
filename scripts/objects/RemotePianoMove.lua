---@field move_speed number *[Property `move_speed`]* Maximum movement speed (Defaults to `28`)
---@field jump_strength number *[Property `jump_strength`]* Jump velocity (Defaults to `16`)
---@field gravity number *[Property `gravity`]* Gravity strength during jump (Defaults to `0.65`)
---@field end_time number *[Property `end_time`]* Time to hold cancel before disengaging (Defaults to `15`)
---@field shake_duration number *[Property `shake_duration`]* Screen shake duration (Defaults to `8`)
---@field move_sound string *[Property `move_sound`]* Sound played when moving (Defaults to `"wing"`)
---@field land_sound string *[Property `land_sound`]* Sound played when landing (Defaults to `"bomb"`)
---@field jump_sound string *[Property `jump_sound`]* Sound played when jumping (Defaults to `"motor_upper_2"`)
---@field impact_sound string *[Property `impact_sound`]* Sound played on impact (Defaults to `"impact"`)
---@field explode_sound string *[Property `explode_sound`]* Sound played during explosion (Defaults to `"impact"`)
---@field piano_instrument string *[Property `piano_instrument`]* Piano sound instrument (Defaults to `"piano"`)
---@field carpet_sprite string *[Property `carpet_sprite`]* Carpet sprite (Defaults to `"dw_churchb_movingpianocarpet"`)
---@field shadow_sprite string *[Property `shadow_sprite`]* Shadow sprite when jumping (Defaults to `"saucershadow"`)
---@field dust_sprite string *[Property `dust_sprite`]* Dust particle sprite (Defaults to `"climb_dust_small"`)
---@field width number *[Property `width`]* Collision width (Defaults to `80`)
---@field height number *[Property `height`]* Collision height (Defaults to `80`)
---@field solid_width number *[Property `solid_width`]* Solid trigger width (Defaults to `68`)
---@field solid_height number *[Property `solid_height`]* Solid trigger height (Defaults to `18`)
---@field camera_offset_x number *[Property `camera_offset_x`]* Camera X offset when engaged (Defaults to `-281`)
---@field camera_offset_y number *[Property `camera_offset_y`]* Camera Y offset when engaged (Defaults to `-206`)
---@field camera_lerp_speed number *[Property `camera_lerp_speed`]* Camera interpolation speed (Defaults to `1/99`)
---@field camera_strength number *[Property `camera_strength`]* Camera follow strength (Defaults to `4`)
---@field kris_offset_x number *[Property `kris_offset_x`]* Kris X offset from piano (Defaults to `20`)
---@field kris_offset_y number *[Property `kris_offset_y`]* Kris Y offset from piano (Defaults to `-4`)
---@field susie_offset_x number *[Property `susie_offset_x`]* Susie X offset from piano (Defaults to `36`)
---@field susie_offset_y number *[Property `susie_offset_y`]* Susie Y offset from piano (Defaults to `-10`)
---@field ralsei_offset_x number *[Property `ralsei_offset_x`]* Ralsei X offset from piano (Defaults to `4`)
---@field ralsei_offset_y number *[Property `ralsei_offset_y`]* Ralsei Y offset from piano (Defaults to `-6`)
---@field auto_engage boolean *[Property `auto_engage`]* Automatically engage when player enters (Defaults to `false`)
---@field final_room boolean *[Property `final_room`]* Is this the final room variant (Defaults to `false`)
---@field save_position boolean *[Property `save_position`]* Save position to flags (Defaults to `true`)
---@field enable_camera_control boolean *[Property `enable_camera_control`]* Allow camera control (Defaults to `true`)
---@field enable_jump boolean *[Property `enable_jump`]* Allow jumping mechanics (Defaults to `true`)
---@field enable_explosion boolean *[Property `enable_explosion`]* Enable explosion sequence (Defaults to `true`)
---@field debug_mode boolean *[Property `debug_mode`]* Enable debug controls (Defaults to `false`)
---@field show_collision boolean *[Property `show_collision`]* Show collision bounds (Defaults to `false`)
---@field log_state boolean *[Property `log_state`]* Log state changes to console (Defaults to `false`)

local RemotePianoMove, super = Class(Event, "RemotePianoMove")

local function scr_returnwait(x1, y1, x2, y2, spd)
	return math.max(1, MathUtils.round(MathUtils.dist(x1, y1, x2, y2) / spd))
end

local function scr_piano_determinepitch(sound)
	if sound == 0 then
		return 1
	elseif sound == 1 then
		return 1.12
	elseif sound == 2 then
		return 1.155
	elseif sound == 3 then
		return 1.19
	elseif sound == 4 then
		return 1.0414285714285714
	elseif sound == 5 then 
		return 0.8928571428571428
	elseif sound == 6 then
		return 0.6964285714285714
	elseif sound == 7 then
		return 0.5
	elseif sound == 8 then
		return 0.3035714286
	end
end

function RemotePianoMove:findSafeExit()
	-- Check all four sides for a safe exit
	local sides = {
		{name = "up", x = self.x + self.width/2, y = self.y - 40},
		{name = "down", x = self.x + self.width/2, y = self.y + self.height + 40},
		{name = "left", x = self.x - 40, y = self.y + self.height/2},
		{name = "right", x = self.x + self.width + 40, y = self.y + self.height/2}
	}
	
	for _, side in ipairs(sides) do
		-- Check if there's space for the party to exit
		local exit_x = side.x - 20
		local exit_y = side.y - 20
		
		if not self:checkCollision(exit_x, exit_y) then
			return side.name, exit_x, exit_y
		end
	end
	
	-- Fallback: return up position even if not ideal
	return "up", self.x + self.width/2 - 20, self.y - 60
end

function RemotePianoMove:checkCollision(x, y)
	-- Use the built-in collider for collision detection
	if self.collider then
		-- Temporarily move collider to test position
		local original_x, original_y = self.collider.x, self.collider.y
		self.collider.x = x
		self.collider.y = y
		
		-- Check map boundaries
		if x < 0 or y < 0 or x + self.width > Game.world.map.width * Game.world.map.tile_width 
		   or y + self.height > Game.world.map.height * Game.world.map.tile_height then
			self.collider.x, self.collider.y = original_x, original_y
			return true
		end
		
		-- Check collision with solid tiles
		local tile_size = Game.world.map.tile_width
		local tile_left = math.floor(x / tile_size)
		local tile_right = math.floor((x + self.width - 1) / tile_size)
		local tile_top = math.floor(y / tile_size)
		local tile_bottom = math.floor((y + self.height - 1) / tile_size)
		
		for ty = tile_top, tile_bottom do
			for tx = tile_left, tile_right do
				if tx >= 0 and ty >= 0 and tx < Game.world.map.width and ty < Game.world.map.height then
					-- Check collision layer
					local collision_tile = Game.world.map:getTile("collision", tx, ty)
					if collision_tile then
						self.collider.x, self.collider.y = original_x, original_y
						return true
					end
					
					-- Check regular tile solidity
					local tile = Game.world.map:getTile(tx, ty)
					if tile and tile.type and tile.type.solid then
						self.collider.x, self.collider.y = original_x, original_y
						return true
					end
				end
			end
		end
		
		-- Check collision with other solid events using collider
		local collision = Game.world:checkCollision(self.collider)
		
		-- Restore original position
		self.collider.x, self.collider.y = original_x, original_y
		
		return collision ~= nil and collision ~= false
	else
		-- Fallback if no collider
		return false
	end
end

function RemotePianoMove:init(x, y, properties)
    super.init(self, x, y)
    
    print("=== REMOTE PIANO MOVE INIT CALLED ===")
    print("Data:", data)
    print("X:", self.x, "Y:", self.y)
    print("Width:", self.width, "Height:", self.height)
    
    self.solid = true
    self.move_speed = properties["move_speed"] or 28
    self.jump_strength = properties["jump_strength"] or 16
    self.gravity = properties["gravity"] or 0.65
    self.end_time = properties["end_time"] or 15
    self.shake_duration = properties["shake_duration"] or 8
    self.move_sound = properties["move_sound"] or "wing"
    self.land_sound = properties["land_sound"] or "bomb"
    self.jump_sound = properties["jump_sound"] or "motor_upper_2"
    self.impact_sound = properties["impact_sound"] or "impact"
    self.explode_sound = properties["explode_sound"] or "impact"
    self.piano_instrument = properties["piano_instrument"] or "piano"
    self.carpet_sprite = properties["carpet_sprite"] or "dw_churchb_movingpianocarpet"
    self.shadow_sprite = properties["shadow_sprite"] or "saucershadow"
    self.dust_sprite = properties["dust_sprite"] or "climb_dust_small"
    self.width = properties["width"] or 40
    self.height = properties["height"] or 40
    self.solid_width = properties["solid_width"] or 68
    self.solid_height = properties["solid_height"] or 18
    self.camera_offset_x = properties["camera_offset_x"] or -281
    self.camera_offset_y = properties["camera_offset_y"] or -206
    self.camera_lerp_speed = properties["camera_lerp_speed"] or 1/99
    self.camera_strength = properties["camera_strength"] or 4
    self.kris_offset_x = properties["kris_offset_x"] or 20
    self.kris_offset_y = properties["kris_offset_y"] or -4
    self.susie_offset_x = properties["susie_offset_x"] or 36
    self.susie_offset_y = properties["susie_offset_y"] or -10
    self.ralsei_offset_x = properties["ralsei_offset_x"] or 4
    self.ralsei_offset_y = properties["ralsei_offset_y"] or -6
    self.auto_engage = properties["auto_engage"] or false
    self.final_room = properties["final_room"] or false
    self.save_position = properties["save_position"] or true
    self.enable_camera_control = properties["enable_camera_control"] or true
    self.enable_jump = properties["enable_jump"] or true
    self.enable_explosion = properties["enable_explosion"] or true
    self.debug_mode = properties["debug_mode"] or false
    self.show_collision = properties["show_collision"] or false
    self.log_state = properties["log_state"] or false
    
    print("Properties loaded successfully")
    
    self.carpet_texture = Assets.getTexture("world/objects/spr_dw_churchb_movingpianocarpet")
    self.piano_texture = Assets.getTexture("world/objects/spr_dw_churchb_movingpiano")
    
    if self.carpet_texture then
        print("Carpet texture loaded successfully")
    else
        print("WARNING: Carpet texture not found, using fallback")
    end
    
    if self.piano_texture then
        print("Piano texture loaded successfully")
    else
        print("WARNING: Piano texture not found, using fallback")
    end
    
    self:setOrigin(0.5, 0.5)
    self:setSprite("world/objects/spr_dw_churchb_movingpiano")
    self.sprite_offset_x = 0
    self.sprite_offset_y = -20
    
    -- Set collision hitbox smaller than sprite to only cover piano body (not carpet)
    -- Piano sprite is 80x80, but we want collision only on the piano part
    local collision_width = 90  -- Narrower than full sprite
    local collision_height = 30  -- Shorter than full sprite
    local collision_x = (self.width - collision_width) / 2  -- Center horizontally
    local collision_y = self.height - collision_height - 40  -- Position on piano body
    
    self:setHitbox(collision_x, collision_y, collision_width, collision_height)
    
    -- Store collision dimensions for our custom collision detection
    self.collision_width = collision_width
    self.collision_height = collision_height
    self.collision_x = collision_x
    self.collision_y = collision_y
    
    -- Update collider directly if it exists
    if self.collider then
        self.collider.width = collision_width
        self.collider.height = collision_height
        self.collider.x = collision_x
        self.collider.y = collision_y
    end
    
    -- Set interaction hitbox - same as collision hitbox
    self.interact_width = collision_width
    self.interact_height = collision_height
    self.interact_x = -collision_width / 2  -- Center on piano center
    self.interact_y = collision_y
    
    print("Sprite and hitbox set")
    
    self.con = 0
    self.engaged = false
    self.buffer = 0
    self.solved = false
    self.progress = {}
    self.memvolume = -1
    self.resetlight = false
    self.catafollow = true
    
    -- UI Properties
    self.soundtoplay = -1
    self.difficulty = 0
    self.canceltimer = 0
    self.canceltime = 15
    self.drawspace = 30
    self.siner = 0
    self.dontdrawmenu = false
    self.drawalpha = 0
    self.arrowspr = "ui/arrow_10x10"
    self.circlespr = "ui/circle_7x7"
    self.drawunits = {}
    
    -- Sliding properties
    self.is_sliding = false
    self.slide_direction = nil
    self.slide_speed = 8
    self.slide_remaining = 0
    
    -- Initialize drawunits
    local space = 28
    table.insert(self.drawunits, {sound = 3, x = 0, y = space, offx = 5, offy = 5, rot = math.rad(0), tex = self.arrowspr})
    table.insert(self.drawunits, {sound = 5, x = space, y = 0, offx = 5, offy = 5, rot = math.rad(-90), tex = self.arrowspr})
    table.insert(self.drawunits, {sound = 7, x = 0, y = -space, offx = 5, offy = 5, rot = math.rad(180), tex = self.arrowspr})
    table.insert(self.drawunits, {sound = 1, x = -space, y = 0, offx = 5, offy = 5, rot = math.rad(-270), tex = self.arrowspr})
    table.insert(self.drawunits, {sound = 0, x = 0, y = 0, offx = 3, offy = 3, rot = math.rad(0), tex = self.circlespr})
    
    print("=== REMOTE PIANO MOVE INIT COMPLETE ===")
end

function RemotePianoMove:onAdd(parent)
    super.onAdd(self,parent)
    if not Game.stage:getObjects(TutorialText)[1] then
		local tuttext = TutorialText(1, self)
		Game.world:addChild(tuttext)
	end
end

function RemotePianoMove:onInteract(player, dir)
    -- Check if player is within interaction hitbox
    local player_x = player.x
    local player_y = player.y
    local interact_left = self.x + self.interact_x
    local interact_right = interact_left + self.interact_width
    local interact_top = self.y + self.interact_y
    local interact_bottom = interact_top + self.interact_height
    
    -- Only allow interaction if player is in the interaction area
    if not (player_x >= interact_left and player_x <= interact_right and
            player_y >= interact_top and player_y <= interact_bottom) then
        return false  -- Don't interact if not in the right spot
    end
    
    -- Original interaction logic continues here...
	if self.con == 0 and self.buffer <= 0 then
		if not self.solved then
			self.progress = {}
		end
		if Game.stage:getObjects(TutorialText)[1] then
			Game.stage:getObjects(TutorialText)[1].target = self
		end
		if Game.world.music then
			self.memvolume = Game.world.music.volume
			Game.world.music:fade(self.memvolume * 0.125, 15/30)
		end
		local cutscene = self.world:startCutscene(function(cutscene)
		
			cutscene:detachFollowers()
			local leader = Game.world:getCharacter(Game.party[1]:getActor().id)
			local party2, party3, party4 = nil, nil, nil
			if #Game.party >= 2 then
				party2 = Game.world:getCharacter(Game.party[2]:getActor().id)
			end
			if #Game.party >= 3 then
				party3 = Game.world:getCharacter(Game.party[3]:getActor().id)
			end
			if #Game.party >= 4 then
				party4 = Game.world:getCharacter(Game.party[4]:getActor().id)
			end
			-- Calculate interaction position relative to piano's current position
			local target_x = self.x
			local target_y = leader.y  -- Keep Kris's current Y position
			
			local pointdist = MathUtils.dist(target_x, target_y, leader.x, leader.y)
			if pointdist > 4 then
				local walkwait = math.min(scr_returnwait(leader.x, leader.y, target_x, target_y, 4), 15)
				cutscene:wait(cutscene:walkToSpeed(leader, target_x, target_y, walkwait, "up"))
			else
				leader.x = target_x
				leader.y = target_y
				cutscene:look(leader, "up")
				print("no need to move")
			end
			if self.catafollow then
				if party2 then
					local p2x, p2y = target_x + 30, target_y + 5
					pointdist = MathUtils.dist(p2x, p2y, party2.x, party2.y)
					if pointdist > 4 then
						local walkwait = math.min(scr_returnwait(party2.x, party2.y, p2x, p2y, 4), 15)
						cutscene:wait(cutscene:walkToSpeed(party2, p2x, p2y, walkwait, "up"))
					else
						party2.x = p2x
						party2.y = p2y
						cutscene:look(party2, "up")
					end
				end
				if party3 then
					local p3x, p3y = target_x - 30, target_y + 5
					pointdist = MathUtils.dist(p3x, p3y, party3.x, party3.y)
					if pointdist > 4 then
						local walkwait = math.min(scr_returnwait(party3.x, party3.y, p3x, p3y, 4), 15)
						cutscene:wait(cutscene:walkToSpeed(party3, p3x, p3y, walkwait, "up"))
					else
						party3.x = p3x
						party3.y = p3y
						cutscene:look(party3, "up")
					end
				end
				if party4 then
					local p4x, p4y = target_x, target_y + 10
					pointdist = MathUtils.dist(p4x, p4y, party4.x, party4.y)
					if pointdist > 4 then
						local walkwait = math.min(scr_returnwait(party4.x, party4.y, p4x, p4y, 4), 15)
						cutscene:wait(cutscene:walkToSpeed(party4, p4x, p4y, walkwait, "up"))
					else
						party4.x = p4x
						party4.y = p4y
						cutscene:look(party4, "up")
					end
				end
			end
			self.resetlight = true
			cutscene:wait(1/30)
			cutscene:interpolateFollowers()
		end)
		cutscene:after(function()
			Game.lock_movement = true
			self.con = 0.2
		end)
		return true
	end
end

function RemotePianoMove:update()
    super.update(self)
    if self.debug_mode then
        print("RemotePianoMove update called at:", self.x, self.y)
    end
    if math.random() < 0.02 then -- 2% chance per frame
        print("Piano at:", self.x, self.y, "Visible:", self.visible)
    end
    
    if self.buffer > 0 then
        self.buffer = self.buffer - 1 * DTMULT
    end
    
    if self.resetlight then
        self.resetlight = false
    end
    
    if self.con == 0.2 then
        self.con = 1
        self.engaged = true
    end
    
    if self.con == 1 then
        Game.lock_movement = true
        if Input.down("cancel") then
            self.canceltimer = self.canceltimer + 1 * DTMULT
        else
            self.canceltimer = 0
        end
        
        if self.canceltimer >= self.canceltime or self.forceend then
            if Game.world.music and self.memvolume ~= -1 then
                Game.world.music:fade(self.memvolume, 15/30)
            end
            local tx, ty = Game.world.camera:getTargetPosition()
            Game.world.camera:panTo(tx, ty, 4/30, "linear", function() Game.world:setCameraAttached(true) end)
            Game.world.timer:after(8/30, function() self.con = 4 end)
        end
        
        -- Directional input handling for ice puzzle sliding
        self.soundtoplay = -1
        
        if self.difficulty == 0 then
            if not Input.down("left") and not Input.down("down") and not Input.down("right") and not Input.down("up") then
                self.soundtoplay = 0
            end
            if Input.down("left") then
                self.soundtoplay = 1
            end
            if Input.down("down") then
                self.soundtoplay = 3
            end
            if Input.down("right") then
                self.soundtoplay = 5
            end
            if Input.down("up") then
                self.soundtoplay = 7
            end
        end
        
        -- Start sliding when confirm is pressed
        if Input.pressed("confirm") and self.soundtoplay ~= -1 and not Input.down("cancel") and not self.is_sliding then
            local mypitch = scr_piano_determinepitch(self.soundtoplay)
            Assets.playSound(self.piano_instrument, 0.7, mypitch)
            
            -- Determine slide direction based on sound
            if self.soundtoplay == 1 then -- Left
                self.slide_direction = "left"
            elseif self.soundtoplay == 3 then -- Down
                self.slide_direction = "down"
            elseif self.soundtoplay == 5 then -- Right
                self.slide_direction = "right"
            elseif self.soundtoplay == 7 then -- Up
                self.slide_direction = "up"
            end
            
            if self.slide_direction then
                self.is_sliding = true
                self.slide_remaining = 1000 -- Large value, will stop on collision
                Assets.playSound(self.move_sound)
            end
            
            self.buffer = 0
        end
        
        -- Handle sliding movement
        if self.is_sliding then
            local move_x = 0
            local move_y = 0
            local move_distance = self.slide_speed * DTMULT
            
            if self.slide_direction == "left" then
                move_x = -move_distance
            elseif self.slide_direction == "right" then
                move_x = move_distance
            elseif self.slide_direction == "up" then
                move_y = -move_distance
            elseif self.slide_direction == "down" then
                move_y = move_distance
            end
            
            -- Check collision before moving (using collider)
            local new_x = self.x + move_x
            local new_y = self.y + move_y
            
            if not self:checkCollision(new_x, new_y) then
                -- Move piano
                self.x = self.x + move_x
                self.y = self.y + move_y
                self.slide_remaining = self.slide_remaining - 1
                
                -- Move party with piano
                if Game.leader then
                    Game.leader.x = Game.leader.x + move_x
                    Game.leader.y = Game.leader.y + move_y
                end
                if Game.world.player then
                    Game.world.player.x = Game.world.player.x + move_x
                    Game.world.player.y = Game.world.player.y + move_y
                end
                if Game.world.followers then
                    for _, member in ipairs(Game.world.followers) do
                        if member and member.x and member.y then
                            member.x = member.x + move_x
                            member.y = member.y + move_y
                        end
                    end
                end
                
                -- Move camera to follow piano
                if self.enable_camera_control then
                    Game.world.camera.x = Game.world.camera.x + move_x
                    Game.world.camera.y = Game.world.camera.y + move_y
                end
            else
                -- Hit collision, stop sliding
                self.is_sliding = false
                se_direction = nil
                Assets.playSound(self.impact_sound)
                
                -- Create impact particles (only when actually stopping from collision)
                for i = 1, 5 do
                    local dust_sprite = self.dust_sprite or "climb_dust_small"
                    local dust = Sprite("effects/climb_dust_small")
                    if dust then
                        dust.layer = self.layer + 10
                        dust:setScale(2, 2)
                        if dust.physics then
                            dust.physics.direction = math.rad(MathUtils.random(360))
                            dust.physics.speed = MathUtils.random(2, 4)
                            dust.physics.friction = 0.3
                        end
                        dust:fadeOutAndRemove(0.5)
                        if Game.world and Game.world.addChild then
                            Game.world:addChild(dust)
                        end
                    end
                end
            end
            
            -- Stop if slide limit reached (safety check)
            if self.slide_remaining <= 0 then
                self.is_sliding = false
                self.slide_direction = nil
            end
        end
    end
    
    if self.con == 4 then
        self.forceend = false
        self.con = 0
        self.timer = 0
        self.buffer = 6
        self.canceltimer = 0
        self.dontdrawmenu = false
        
        -- Move party to safe exit position (only once)
        local piano_center_x = self.x + self.width/2
        local piano_center_y = self.y + self.height/2
        local exit_x = piano_center_x - 20  -- Center party member
        local exit_y = piano_center_y + 20  -- 20px below center
        
        -- Move party to safe exit position
        if Game.leader then
            Game.leader.x = exit_x
            Game.leader.y = exit_y
        end
        for _, member in ipairs(Game.world.followers) do
            if member then
                member.x = exit_x + (member.id == "susie" and 30 or -30)
                member.y = exit_y + 30
            end
        end
        
        -- Reset camera
        if self.enable_camera_control then
            Game.world:setCameraAttached(true)
        end
        
        -- Unlock movement after a short delay
        Game.world.timer:after(0.1, function()
            Game.lock_movement = false
        end)
    end
end

function RemotePianoMove:draw()
    local center_x = 40  -- Half of 80 + 1 tile right
    local center_y = 40  -- Half of 80 + 1 tile down
    
    -- Adjust carpet position: up 2px, right 8px
    local carpet_x = center_x + 4
    local carpet_y = center_y - 1
    
    -- Draw carpet sprite first (underneath)
    if self.carpet_texture then
        Draw.setColor(1, 1, 1, 1)
        Draw.draw(self.carpet_texture, carpet_x, carpet_y, 0, 1, 1, self.carpet_texture:getWidth()/2, self.carpet_texture:getHeight()/2)
    else
        -- Fallback if carpet sprite not found
        love.graphics.setColor(0.5, 0.3, 0.2, 1)
        love.graphics.rectangle("fill", carpet_x - 40, carpet_y - 40, 80, 80)
    end
    
    -- Draw piano sprite using the sprite system (proper scaling)
    love.graphics.push()
    love.graphics.translate(self.sprite_offset_x, self.sprite_offset_y)
    super.draw(self)
    love.graphics.pop()
    
    love.graphics.setColor(1, 1, 1, 1)
    
    -- UI Drawing
    self.siner = self.siner + 1 * DTMULT
    if self.con == 1 then
        self.engaged = true
    else
        self.engaged = false
    end
    
    local alphtarg = 0
    if self.con == 1 and not self.dontdrawmenu then
        alphtarg = 1
    end
    self.drawalpha = MathUtils.lerp(self.drawalpha, alphtarg, 0.1*DTMULT)
    self.drawspace = 18
    local drawx = center_x
    local drawy = center_y - 100  -- Shifted up 20px (was -80)
    love.graphics.setColor(0,0,0,self.drawalpha*0.5)
    love.graphics.circle("fill", drawx, drawy, 44 + math.sin(self.siner / 64) * 2)
    local litblue = ColorUtils.hexToRGB("#698DE6FF")
    local sinstrength = 2
    local basealpha = 0.35
    for i, unit in ipairs(self.drawunits) do
        local bonusalpha = 0
        local xloc = drawx + unit.x
        local yloc = drawy + unit.y + (math.sin((self.siner + (i * 42)) / 9) * sinstrength)
        
        if self.soundtoplay == unit.sound then
            bonusalpha = 0.6
            if Input.pressed("confirm") and self.con == 1 and not Input.down("cancel") then
                local note = Sprite(unit.tex, xloc, yloc + 20)  -- Add 20px offset to match UI shift
                note.layer = self.layer + 1
                note:setColor(litblue)
                note:setScale(2,2)
                note:setOriginExact(unit.offx, unit.offy)
                note.rotation = unit.rot
                note.physics.direction = math.rad(MathUtils.random(360))
                note.physics.speed = 5
                note.physics.friction = 0.35
                note.physics.direction = unit.rot + math.rad(90)
                if self.soundtoplay == 0 then
                    note.physics.speed = 0
                end
                Game.world.timer:tween(20/30, note, {alpha = 0}, 'out-quad', function()
                    note:remove()
                end)
                self:addChild(note)
            end
        end
        love.graphics.setColor(litblue[1], litblue[2], litblue[3], (basealpha + bonusalpha) * self.drawalpha)
        Draw.draw(Assets.getTexture(unit.tex), xloc, yloc, unit.rot, 2, 2, unit.offx, unit.offy)
    end
    love.graphics.setColor(1,1,1,1)
    
    -- Debug info
    if self.debug_mode then
        love.graphics.setColor(1, 1, 0, 1)
        love.graphics.print("REMOTE PIANO", center_x - 40, center_y - 60)
        love.graphics.print("X: "..math.floor(self.x).." Y: "..math.floor(self.y), center_x - 40, center_y - 45)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

return RemotePianoMove
