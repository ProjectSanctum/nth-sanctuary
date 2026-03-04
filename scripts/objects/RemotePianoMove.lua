local RemotePianoMove, super = Class(Object)

-- Tiled custom properties
function RemotePianoMove:getProperties()
    return {
        -- Movement properties
        ["move_speed"] = {type="number", default=28, description="Maximum movement speed"},
        ["jump_strength"] = {type="number", default=16, description="Jump velocity"},
        ["gravity"] = {type="number", default=0.65, description="Gravity strength during jump"},
        
        -- Timer properties
        ["end_time"] = {type="number", default=15, description="Time to hold cancel before disengaging"},
        ["shake_duration"] = {type="number", default=8, description="Screen shake duration"},
        
        -- Sound properties
        ["move_sound"] = {type="string", default="wing", description="Sound played when moving"},
        ["land_sound"] = {type="string", default="bomb", description="Sound played when landing"},
        ["jump_sound"] = {type="string", default="motor_upper_2", description="Sound played when jumping"},
        ["impact_sound"] = {type="string", default="impact", description="Sound played on impact"},
        ["explode_sound"] = {type="string", default="impact", description="Sound played during explosion"},
        ["piano_instrument"] = {type="string", default="piano", description="Piano sound instrument"},
        
        -- Visual properties
        ["carpet_sprite"] = {type="string", default="dw_churchb_movingpianocarpet", description="Carpet sprite"},
        ["shadow_sprite"] = {type="string", default="saucershadow", description="Shadow sprite when jumping"},
        ["dust_sprite"] = {type="string", default="climb_dust_small", description="Dust particle sprite"},
        
        -- Collision properties
        ["width"] = {type="number", default=80, description="Collision width"},
        ["height"] = {type="number", default=80, description="Collision height"},
        ["solid_width"] = {type="number", default=68, description="Solid trigger width"},
        ["solid_height"] = {type="number", default=18, description="Solid trigger height"},
        
        -- Camera properties
        ["camera_offset_x"] = {type="number", default=-281, description="Camera X offset when engaged"},
        ["camera_offset_y"] = {type="number", default=-206, description="Camera Y offset when engaged"},
        ["camera_lerp_speed"] = {type="number", default=0.010101010101010102, description="Camera interpolation speed"},
        ["camera_strength"] = {type="number", default=4, description="Camera follow strength"},
        
        -- Party positioning
        ["kris_offset_x"] = {type="number", default=20, description="Kris X offset from piano"},
        ["kris_offset_y"] = {type="number", default=-4, description="Kris Y offset from piano"},
        ["susie_offset_x"] = {type="number", default=36, description="Susie X offset from piano"},
        ["susie_offset_y"] = {type="number", default=-10, description="Susie Y offset from piano"},
        ["ralsei_offset_x"] = {type="number", default=4, description="Ralsei X offset from piano"},
        ["ralsei_offset_y"] = {type="number", default=-6, description="Ralsei Y offset from piano"},
        
        -- Behavior flags
        ["auto_engage"] = {type="boolean", default=false, description="Automatically engage when player enters"},
        ["final_room"] = {type="boolean", default=false, description="Is this the final room variant"},
        ["save_position"] = {type="boolean", default=true, description="Save position to flags"},
        ["enable_camera_control"] = {type="boolean", default=true, description="Allow camera control"},
        ["enable_jump"] = {type="boolean", default=true, description="Allow jumping mechanics"},
        ["enable_explosion"] = {type="boolean", default=true, description="Enable explosion sequence"},
        
        -- Debug properties
        ["debug_mode"] = {type="boolean", default=false, description="Enable debug controls"},
        ["show_collision"] = {type="boolean", default=false, description="Show collision bounds"},
        ["log_state"] = {type="boolean", default=false, description="Log state changes to console"}
    }
end

function RemotePianoMove:init(x, y, properties)
    super:init(self, x, y)
    
    -- Store properties with defaults
    properties = properties or {}
    self.move_speed = properties.move_speed or 28
    self.jump_strength = properties.jump_strength or 16
    self.gravity = properties.gravity or 0.65
    self.end_time = properties.end_time or 15
    self.shake_duration = properties.shake_duration or 8
    self.move_sound = properties.move_sound or "wing"
    self.land_sound = properties.land_sound or "bomb"
    self.jump_sound = properties.jump_sound or "motor_upper_2"
    self.impact_sound = properties.impact_sound or "impact"
    self.explode_sound = properties.explode_sound or "impact"
    self.piano_instrument = properties.piano_instrument or "piano"
    self.carpet_sprite = properties.carpet_sprite or "dw_churchb_movingpianocarpet"
    self.shadow_sprite = properties.shadow_sprite or "saucershadow"
    self.dust_sprite = properties.dust_sprite or "climb_dust_small"
    self.width = properties.width or 80
    self.height = properties.height or 80
    self.solid_width = properties.solid_width or 68
    self.solid_height = properties.solid_height or 18
    self.camera_offset_x = properties.camera_offset_x or -281
    self.camera_offset_y = properties.camera_offset_y or -206
    self.camera_lerp_speed = properties.camera_lerp_speed or 0.010101010101010102
    self.camera_strength = properties.camera_strength or 4
    self.kris_offset_x = properties.kris_offset_x or 20
    self.kris_offset_y = properties.kris_offset_y or -4
    self.susie_offset_x = properties.susie_offset_x or 36
    self.susie_offset_y = properties.susie_offset_y or -10
    self.ralsei_offset_x = properties.ralsei_offset_x or 4
    self.ralsei_offset_y = properties.ralsei_offset_y or -6
    self.auto_engage = properties.auto_engage or false
    self.final_room = properties.final_room or false
    self.save_position = properties.save_position or true
    self.enable_camera_control = properties.enable_camera_control or true
    self.enable_jump = properties.enable_jump or true
    self.enable_explosion = properties.enable_explosion or true
    self.debug_mode = properties.debug_mode or false
    self.show_collision = properties.show_collision or false
    self.log_state = properties.log_state or false
    
    -- Create UI instance
    self.ui = RemotePianoMoveUI(self.x, self.y)
    self.ui.depth = 500
    
    -- Initialize variables
    self.con = 0
    self.timer = 0
    self.yoffset = 0
    self.yspeed = 0
    self.shakex = 0
    self.ralshakex = 0
    self.currentdir = -1
    self.movedir = -1
    self.shakey = 0
    
    -- Create solid trigger
    self.mysolid = World:spawnObject(TriggerInteract(self.x, self.y), "objects")
    self.mysolid:setSprite("pxwhite")
    self.mysolid.width = self.solid_width
    self.mysolid.height = self.solid_height
    self.mysolid.alpha = 0.4
    self.mysolid.color = {1, 1, 0} -- Yellow
    self.mysolid.solid = true
    self.mysolid.strict = true
    
    self.engaged = false
    self.ralsei_knocked_down = 0
    
    -- Check if not in library room
    self.final = self.final_room or (Game.world.map.id ~= "dw_churchb_library")
    
    -- Restore position from flag if exists
    if self.save_position and Game:getFlag("1585", false) and not self.final then
        local flag_value = Game:getFlag("1585")
        self.x = math.floor(flag_value / 1000) * 40
        self.y = (flag_value % 1000) * 40
    end
    
    -- Input buffers
    self.ubuff = 0
    self.rbuff = 0
    self.lbuff = 0
    self.dbuff = 0
    self.xbuff = 0
    self.cbuff = 0
    self.zbuff = 0
    
    -- Camera control
    self.hijackcamera = true
    self.camcont = false
    self.engaged = false
    self.con = 0
    self.movedir = -1
    self.myhspeed = 0
    self.myvspeed = 0
    self.timer = 0
    self.endtimer = 0
    self.endtime = self.end_time
    self.buffer = 0
    self.followshelf = false
    self.hitstop = 0
    self.camcontrol = false
    self.camx = 0
    self.camy = 0
    self.camcon = 0
    self.camstrength = 1
    self.alpha = 0
    self.siner = 0
    self.soundtoplay = -1
    self.makenote = 0
    self.drawx = self.x + 40
    self.drawy = self.y - 70
    
    -- Create tutorial text if not exists
    if not Game.world:getObjectOfType("TutorialText") then
        Game.world:spawnObject(TutorialText(), "objects")
    end
    
    self:setSprite("dw_churchb_movingpiano")
end

function RemotePianoMove:update()
    super:update(self)
    
    -- Handle interaction
    if self.mysolid.interact and Input.pressed("confirm") then
        if self.con == 0 then
            self.con = 1
            self.timer = 0
        end
        self.mysolid.interact = false
    end
    
    -- Set depth
    self:setLayer(-22)
    
    -- Handle different states
    if self.con >= 1 and self.con < 2 then
        self:handleEngagementStart()
    end
    
    if self.engaged then
        self:handleEngagedState()
    end
    
    -- Handle movement states
    if self.con == 2 then
        self:handleMovementState()
    elseif self.con == 3 then
        self:handleMovingState()
    elseif self.con == 4 then
        self:handleJumpingState()
    elseif self.con == 98 then
        self:handleDisengagement()
    elseif self.con == 99 then
        self:handleResetState()
    elseif self.con == 400 then
        self:handleExplosionState()
    end
    
    -- Update shake effects
    if self.shakex > 0 then
        self.shakex = self.shakex - 1
    end
    if self.shakey > 0 then
        self.shakey = self.shakey - 1
    end
end

function RemotePianoMove:handleEngagementStart()
    if self.con == 1 then
        self.con = 1.1
        local pos = {self.x + 20, self.y - 4}
        local walktime = math.max(math.round(Utils.dist(pos[1], pos[2], Game.world.player.x, Game.world.player.y) / 4), 4)
        
        if walktime <= 11 and (self.y - 10) < Game.party:getCharacter("ralsei").y then
            self.con = 1.2
            Game.world.player:freeze()
            Game.world.player:setAnimation("fun")
            Game:setFlag("7", 1)
            
            -- Start cutscene
            local cutscene = Cutscene.start(self, "piano_engagement", {
                walktime = walktime,
                pos = pos
            })
        else
            Game.world.player.cutscene = true
            Game.world.player:freeze()
            Game.world.player:setAnimation("fun")
            Game:setFlag("7", 1)
            
            -- Handle camera pan
            if Game:getFlag("1538", 0) == 0 and not self.final then
                local cam_pos = self:getCameraPosition()
                Game.world.camera:slideTo(cam_pos[1], cam_pos[2], 15 / 30)
            else
                local cx = Utils.clamp(self.x - 281, 0, Game.world.map.width - 640)
                local cy = Utils.clamp(self.y - 206, 0, Game.world.map.height - 480)
                Game.world.camera:slideTo(cx, cy, walktime / 30)
            end
            
            Assets.playSound("wing")
            self:handlePartyJump(pos, 12)
        end
    end
    
    if self.con >= 1.1 and self.con < 1.2 then
        self.con = self.con + 0.001
        
        if self.con >= 1.116 then
            self.con = 1.2
            Assets.playSound("noise")
            
            -- Position player
            Game.world.player:setPosition(self.x + 20, self.y - 4)
            Game.world.player.visible = true
            Game.world.player.alpha = 1
            Game.world.player.cutscene = false
            Game:setFlag("interact", 0)
            Game.world.player:unfreeze()
            
            -- Position party members
            for _, char in ipairs(Game.party) do
                if char.id == "susie" then
                    char:setPosition(self.x + 36, self.y - 10)
                elseif char.id == "ralsei" then
                    char:setPosition(self.x + 4, self.y - 6)
                end
                char.visible = true
                char.alpha = 1
            end
        end
    end
    
    if self.con >= 1.2 and not Game.world:getCutscene() then
        self.con = 2
        self.engaged = true
        
        if Game:getFlag("1538", 0) == 0 and not self.final then
            self.camcon = 1
            self.camcontrol = true
            local pos = self:getCameraPosition()
            self.camx = pos[1]
            self.camy = pos[2]
        end
    end
end

function RemotePianoMove:handleEngagedState()
    -- Decrease input buffers
    self.ubuff = self.ubuff - 1
    self.rbuff = self.rbuff - 1
    self.lbuff = self.lbuff - 1
    self.dbuff = self.dbuff - 1
    self.xbuff = self.xbuff - 1
    self.zbuff = self.zbuff - 1
    
    local this_frame_directions = {}
    
    -- Check input directions
    if Input.down("up") then
        table.insert(this_frame_directions, 2)
    end
    if Input.down("down") then
        table.insert(this_frame_directions, 0)
    end
    if Input.down("right") then
        table.insert(this_frame_directions, 1)
    end
    if Input.down("left") then
        table.insert(this_frame_directions, 3)
    end
    
    local num_inputs = #this_frame_directions
    self.movedir = -1
    
    if num_inputs == 0 then
        self.currentdir = -1
    elseif num_inputs == 1 or self.currentdir == -1 then
        self.currentdir = this_frame_directions[1]
        self.movedir = self.currentdir
    else
        -- Remove current direction from list
        for i, dir in ipairs(this_frame_directions) do
            if dir == self.currentdir then
                table.remove(this_frame_directions, i)
                break
            end
        end
        self.movedir = this_frame_directions[1]
    end
    
    -- Update direction buffers
    if self.movedir == 3 and self.lbuff < 3 then self.lbuff = 3 end
    if self.movedir == 1 and self.rbuff < 3 then self.rbuff = 3 end
    if self.movedir == 2 and self.ubuff < 3 then self.ubuff = 3 end
    if self.movedir == 0 and self.dbuff < 3 then self.dbuff = 3 end
    
    if Input.down("cancel") then self.xbuff = 3 end
    if Input.pressed("menu") then self.zbuff = 3 end
    
    -- Check for kill trigger
    if self.enable_explosion then
        local killblock = Game.world:checkCollision(self.x, self.y, self.x + self.width, self.y + self.height, "killpiano")
        if killblock and self.con < 400 then
            self.con = 400
            self.timer = 0
        end
    end
end

function RemotePianoMove:handleMovementState()
    local dir = -1
    
    -- Debug controls
    if self.debug_mode then
        if Input.pressed("numpad2") then dir = 0 end
        if Input.pressed("numpad6") then dir = 1 end
        if Input.pressed("numpad8") then dir = 2 end
        if Input.pressed("numpad4") then dir = 3 end
    end
    
    if self.xbuff and not self.final then
        self.dbuff = 0
        self.rbuff = 0
        self.ubuff = 0
        self.lbuff = 0
        self.zbuff = 0
        self.endtimer = self.endtimer + 1
    else
        self.endtimer = 0
    end
    
    if self.endtimer >= self.endtime then
        self.timer = 0
        self.con = 98
        self.endtimer = 0
    end
    
    dir = self.movedir
    
    if Input.pressed("confirm") then
        self.soundtoplay = -1
        
        if not Input.down("left") and not Input.down("down") and not Input.down("right") and not Input.down("up") then
            self.soundtoplay = 0
        end
        
        if Input.down("left") then self.soundtoplay = 1 end
        if Input.down("down") then self.soundtoplay = 3 end
        if Input.down("right") then self.soundtoplay = 5 end
        if Input.down("up") then self.soundtoplay = 7 end
        
        local mypitch = self:determinePitch(self.soundtoplay)
        self.makenote = 1
        Assets.playSound(self.piano_instrument, 0.7, mypitch)
    end
    
    if dir ~= -1 and self.zbuff > 0 then
        self.zbuff = 0
        local px, py = 0, 0
        local stoppingpoint = false
        
        -- Set movement direction
        if dir == 0 then py = 1
        elseif dir == 1 then px = 1
        elseif dir == 2 then py = -1
        elseif dir == 3 then px = -1
        end
        
        -- Check for collision
        local check_x = self.x + (px * 40)
        local check_y = self.y + (py * 40)
        local collision = Game.world:checkCollision(check_x, check_y, check_x + self.width, check_y + self.height, "solid")
        
        if not collision then
            if self.camcon == 1 then
                self.camcon = 2
                Game:setFlag("1538", 1)
            end
            
            self.con = 3
            
            if self.ralsei_knocked_down > 0 then
                self.ralshakex = 8
            end
            
            self.ralsei_knocked_down = 0
            Assets.playSound(self.move_sound)
            self.myhspeed = 0
            self.myvspeed = 0
            
            -- Set velocity based on direction
            if dir == 0 then self.myvspeed = 2
            elseif dir == 1 then self.myhspeed = 2
            elseif dir == 2 then self.myvspeed = -2
            elseif dir == 3 then self.myhspeed = -2
            end
        end
    end
end

function RemotePianoMove:handleMovingState()
    if self.myhspeed ~= 0 then
        self.myhspeed = Utils.lerp(math.abs(self.myhspeed), self.move_speed, 0.25) * Utils.sign(self.myhspeed)
    end
    
    if self.myvspeed ~= 0 then
        self.myvspeed = Utils.lerp(math.abs(self.myvspeed), self.move_speed, 0.25) * Utils.sign(self.myvspeed)
    end
    
    -- Check for jump points
    if self.enable_jump then
        local jumppoint = Game.world:getMarkerAt(self.x, self.y, "jump")
        if jumppoint then
            self.con = 4
            Assets.playSound(self.jump_sound)
            self.yspeed = -self.jump_strength
            self.yoffset = self.yspeed
            return
        end
    end
    
    -- Check for camera markers
    if self.enable_camera_control then
        local camlock = Game.world:getMarkerAt(self.x, self.y, "camlock")
        if camlock then
            self.camcontrol = 1
            self.camx = Game.world.camera.x
            self.camy = Game.world.camera.y
        end
        
        local camfree = Game.world:getMarkerAt(self.x, self.y, "camfree")
        if camfree then
            self.camcontrol = 0
            Game.world.player.cutscene = false
        end
    end
    
    if self.enable_explosion then
        local explode = Game.world:getMarkerAt(self.x, self.y, "explode")
        if explode then
            self.con = 400
        end
    end
    
    -- Check collision
    local new_x = self.x + self.myhspeed
    local new_y = self.y + self.myvspeed
    local collision = Game.world:checkCollision(new_x, new_y, new_x + self.width, new_y + self.height, "solid")
    
    -- Create dust effect
    if math.floor(os.clock() * 60) % 2 == 0 then
        local x_offset = 0.5
        local y_offset = love.math.random() * 0.6 + 0.2
        
        if self.myvspeed ~= 0 then
            x_offset = y_offset
            y_offset = 0.5
        end
        
        local dust = Game.world:spawnObject(Particle(self.x + (x_offset * self.width), self.y + (y_offset * self.height), self.dust_sprite), "objects")
        dust.scale_x = 2
        dust.scale_y = 2
        dust.physics.speed_x = love.math.random(-1, 1)
        dust:setLayer(self.layer + 10)
    end
    
    if collision then
        -- Snap to grid and stop
        self.myhspeed = math.round(self.myhspeed)
        self.myvspeed = math.round(self.myvspeed)
        self.x = math.round(self.x)
        self.y = math.round(self.y)
        
        -- Move step by step until collision
        for i = 1, math.max(math.abs(self.myhspeed), math.abs(self.myvspeed)) + 1 do
            local test_x = self.x + self.myhspeed
            local test_y = self.y + self.myvspeed
            if not Game.world:checkCollision(test_x, test_y, test_x + self.width, test_y + self.height, "solid") then
                self.x = test_x
                self.y = test_y
                break
            else
                if self.myhspeed ~= 0 then
                    self.myhspeed = (math.abs(self.myhspeed) - 1) * Utils.sign(self.myhspeed)
                end
                if self.myvspeed ~= 0 then
                    self.myvspeed = (math.abs(self.myvspeed) - 1) * Utils.sign(self.myvspeed)
                end
            end
        end
        
        -- Snap to grid
        self.x = math.round(self.x / 40) * 40
        self.y = math.round(self.y / 40) * 40
        Assets.playSound(self.land_sound)
        
        if self.myhspeed ~= 0 then
            self.shakex = self.shake_duration
        else
            self.shakey = self.shake_duration
        end
        
        self.con = 2
    elseif not self.hitstop then
        self.x = self.x + math.round(self.myhspeed)
        self.y = self.y + math.round(self.myvspeed)
    else
        self.hitstop = self.hitstop - 1
    end
end

function RemotePianoMove:handleJumpingState()
    if self.enable_explosion then
        local jumppoint = Game.world:getMarkerAt(self.x, self.y, "explode")
        if jumppoint then
            self.con = 400
            self.timer = 0
        end
    end
    
    if self.myhspeed ~= 0 then
        self.myhspeed = Utils.lerp(math.abs(self.myhspeed), self.move_speed, 0.25) * Utils.sign(self.myhspeed)
    end
    
    if self.myvspeed ~= 0 then
        self.myvspeed = Utils.lerp(math.abs(self.myvspeed), self.move_speed, 0.25) * Utils.sign(self.myvspeed)
    end
    
    self.x = self.x + math.round(self.myhspeed)
    self.y = self.y + math.round(self.myvspeed)
    self.yspeed = self.yspeed + self.gravity
    self.yoffset = self.yoffset + self.yspeed
    
    if self.yoffset >= 0 then
        self.yoffset = 0
        self.con = 3
        Assets.playSound(self.impact_sound)
        self.shakex = self.shake_duration
        self.yspeed = 0
    end
end

function RemotePianoMove:handleDisengagement()
    Game:setFlag("interact", 1)
    Game.world.player:setAnimation("walk")
    Game.world.player:unfreeze()
    if self.save_position then
        Game:setFlag("1585", math.floor((self.x / 40) * 1000) + math.floor(self.y / 40))
    end
    self.camcontrol = 0
    self.camcon = 0
    self.engaged = false
    self.con = 99
    
    -- Start cutscene for disengagement
    local cutscene = Cutscene.start(self, "piano_disengagement", {
        x = self.x,
        y = self.y
    })
end

function RemotePianoMove:handleResetState()
    if not Game.world:getCutscene() then
        self.ubuff = 0
        self.dbuff = 0
        self.lbuff = 0
        self.rbuff = 0
        self.xbuff = 0
        self.zbuff = 0
        Game:setFlag("facing", 0)
        self.timer = 0
        self.con = 0
        Game:setFlag("interact", 0)
        Game:setFlag("7", 0)
    end
end

function RemotePianoMove:handleExplosionState()
    self.timer = self.timer + 1
    local jumptime = 16
    local jumpheight = self.jump_strength
    local explodedelay = 26
    
    if self.myhspeed ~= 0 then
        self.myhspeed = Utils.lerp(math.abs(self.myhspeed), self.move_speed, 0.25) * Utils.sign(self.myhspeed)
    end
    
    if self.myvspeed ~= 0 then
        self.myvspeed = Utils.lerp(math.abs(self.myvspeed), self.move_speed, 0.25) * Utils.sign(self.myvspeed)
    end
    
    self.x = self.x + math.round(self.myhspeed)
    self.y = self.y + math.round(self.myvspeed)
    self.yspeed = self.yspeed + self.gravity
    self.yoffset = self.yoffset + self.yspeed
    
    if self.yoffset >= 0 then
        self.alpha = self.alpha - 0.1
    end
    
    if self.timer == 1 then
        Game.world.player:freeze()
        Game.world.player:setAnimation("fun")
        Game.world.player.cutscene = true
        
        local pos = self:getHeroMarker("kr", "killpiano")
        local cx = Utils.clamp(pos[1] + self.camera_offset_x, 0, Game.world.map.width - 640)
        local cy = Utils.clamp(pos[2] + self.camera_offset_y, 0, Game.world.map.height - 480)
        Game.world.camera:slideTo(cx, cy, jumptime / 30)
        
        self.engaged = false
        Assets.playSound(self.move_sound)
        
        -- Handle party jumping to safety
        self:handlePartyExplosionJump(pos, jumpheight, jumptime)
    end
    
    if self.alpha <= 0 then
        self.visible = false
        Game.world:shakeCamera(0, self.shake_duration)
        Assets.playSound(self.explode_sound)
        if self.mysolid then
            self.mysolid:remove()
        end
        self:remove()
    end
    
    if self.timer == (1 + jumptime) then
        Assets.playSound("noise")
        Game:setFlag("facing", 0)
        
        -- Reset party state
        for _, char in ipairs(Game.party) do
            if char.id == "ralsei" or char.id == "susie" then
                char:setAnimation("walk")
                char.following = true
            end
        end
        
        Game.world.player:setAnimation("walk")
        Game.world.player:unfreeze()
        Game:setFlag("7", 0)
    end
end

function RemotePianoMove:draw()
    super:draw(self)
    
    -- Draw shadow when jumping
    if self.con == 4 then
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.draw(Assets.getTexture(self.shadow_sprite), self.x, self.y, 0, 1.5, 3.5)
        love.graphics.setColor(1, 1, 1, 1)
    end
    
    -- Draw carpet
    love.graphics.draw(Assets.getTexture(self.carpet_sprite), self.x, self.y + self.yoffset)
    
    -- Apply shake effect
    local shake_x = math.sin(self.shakex * 1.5) * (self.shakex / 2)
    local shake_y = math.sin(self.shakey * 1.5) * (self.shakey / 2)
    
    love.graphics.draw(self.sprite, self.x + shake_x, self.y + shake_y + self.yoffset)
    
    -- Debug collision display
    if self.show_collision then
        love.graphics.setColor(1, 0, 0, 0.5)
        love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
        love.graphics.setColor(0, 1, 0, 0.5)
        if self.mysolid then
            love.graphics.rectangle("line", self.mysolid.x, self.mysolid.y, self.mysolid.width, self.mysolid.height)
        end
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function RemotePianoMove:onRemove()
    if self.ui then
        self.ui:remove()
    end
    super:onRemove(self)
end

-- Helper functions
function RemotePianoMove:determinePitch(sound_index)
    local pitches = {0, 2, 4, 5, 7, 9, 11, 12}
    if sound_index >= 0 and sound_index <= 7 then
        return pitches[sound_index + 1]
    end
    return 0
end

function RemotePianoMove:getCameraPosition()
    -- This would need to be implemented based on your map markers
    return {self.x, self.y}
end

function RemotePianoMove:getHeroMarker(char, marker_type)
    -- This would need to be implemented based on your map markers
    return {self.x, self.y}
end

function RemotePianoMove:handlePartyJump(pos, jumpstrength)
    -- Handle party members jumping to piano
    for _, char in ipairs(Game.party) do
        local jump_pos = {}
        local sprite = ""
        
        if char.id == "kris" then
            jump_pos = pos
            sprite = "kris_jump_ball_fixed"
        elseif char.id == "susie" then
            jump_pos = {self.x + 36, self.y - 10}
            sprite = "susie_dw_jump_ball"
        elseif char.id == "ralsei" then
            jump_pos = {self.x + 4, self.y - 6}
            sprite = "ralsei_jump_ball"
        end
        
        if jump_pos[1] then
            char.visible = false
            char.alpha = 0
            -- Create jump effect and move character
            -- This would need proper implementation in Kristal
        end
    end
end

function RemotePianoMove:handlePartyExplosionJump(pos, jumpheight, jumptime)
    -- Handle party jumping to safety during explosion
    for _, char in ipairs(Game.party) do
        local jump_pos = {}
        local sprite = ""
        
        if char.id == "kris" then
            jump_pos = pos
            sprite = "kris_jump_ball_fixed"
        elseif char.id == "susie" then
            jump_pos = self:getHeroMarker("su", "killpiano")
            sprite = "susie_dw_jump_ball"
            char.scale_x = 2
        elseif char.id == "ralsei" then
            jump_pos = self:getHeroMarker("ra", "killpiano")
            sprite = "ralsei_jump_ball"
        end
        
        if jump_pos[1] then
            char.visible = false
            char.alpha = 0
            char:setAnimation("fun")
            -- Create jump effect and move character
            -- This would need proper implementation in Kristal
        end
    end
end

-- End Step event equivalent
function RemotePianoMove:endStep()
    -- Update solid position
    if self.mysolid then
        self.mysolid.x = self.x + 6
        self.mysolid.y = self.y + 32
    end
    
    -- Update party positions when engaged
    if self.engaged then
        local kris = Game.party:getCharacter("kris")
        if kris then
            kris:setPosition(self.x + self.kris_offset_x, (self.y + self.kris_offset_y) + (self.yoffset * 1.1))
            kris:setLayer(self.layer - 1)
            kris:setSprite("kris_piano_loop_1")
        end
        
        local susie = Game.party:getCharacter("susie")
        if susie then
            susie.scale_x = 2
            susie:setPosition(self.x + self.susie_offset_x, (self.y + self.susie_offset_y) + (self.yoffset * 1.05))
            
            if self.yoffset < 0 then
                susie:setSprite("susie_dw_fall_brace")
                if self.myhspeed < 0 then
                    susie.scale_x = -2
                    susie:setPosition(self.x + 96, (self.y + self.susie_offset_y) + (self.yoffset * 1.05))
                end
            else
                susie:setSprite("susie_up_dw")
            end
            
            if self.shakex >= 9 then
                susie:setSprite("susie_dw_landed")
                if self.myhspeed > 0 then
                    susie.scale_x = -2
                    susie:setPosition(self.x + 96, (self.y + self.susie_offset_y) + (self.yoffset * 1.05))
                end
            end
            
            susie:setLayer(self.layer - 2)
        end
        
        local ralsei = Game.party:getCharacter("ralsei")
        if ralsei then
            local xoff = 0
            if self.ralshakex > 0 then
                xoff = ((self.ralshakex % 2) - 0.5) * 2 * self.ralshakex
            end
            
            ralsei:setPosition(self.x + self.ralsei_offset_x + xoff, (self.y + self.ralsei_offset_y) + (self.yoffset * 1.2))
            
            if self.yoffset < 0 then
                self.ralsei_knocked_down = 16
                if self.myhspeed > 0 then
                    ralsei:setSprite("ralsei_shocked_right_landed")
                else
                    ralsei:setSprite("ralsei_shocked_left_landed")
                end
                ralsei.sprite_index = 0
            elseif not self.ralsei_knocked_down then
                ralsei:setSprite("ralsei_up")
            else
                self.ralsei_knocked_down = self.ralsei_knocked_down - 1
                if self.ralsei_knocked_down == 0 then
                    self.ralshakex = 8
                end
                if self.myhspeed > 0 then
                    ralsei:setSprite("ralsei_shocked_right_landed")
                else
                    ralsei:setSprite("ralsei_shocked_left_landed")
                end
                ralsei.sprite_index = 1
            end
            
            self.ralshakex = self.ralshakex - 1
            ralsei:setLayer(self.layer - 2)
        end
    end
    
    -- Handle camera control
    if self.camcontrol and self.enable_camera_control then
        Game.world.player.cutscene = true
        Game.world.camera.x = self.camx
        Game.world.camera.y = self.camy
        
        if self.camcon == 2 then
            local roomw = Game.world.map.width
            local roomh = Game.world.map.height
            local vieww = 640
            local viewh = 480
            local plcamx = Utils.clamp(Game.world.player.x - math.floor((vieww / 2) - (Game.world.player.width / 2)), 0, roomw - vieww)
            local plcamy = Utils.clamp(Game.world.player.y - math.floor((viewh / 2) - (Game.world.player.height / 2)), 0, roomh - viewh)
            self.camstrength = Utils.lerp(self.camstrength, self.camera_strength, self.camera_lerp_speed)
            self.camx = Utils.lerp(self.camx, plcamx, self.camstrength / 8)
            self.camy = Utils.lerp(self.camy, plcamy, self.camstrength / 8)
            
            if Utils.dist(plcamx, plcamy, self.camx, self.camy) < 2 then
                self.camcon = 3
                self.camcontrol = 0
                Game.world.player.cutscene = false
            end
        end
    end
end

return RemotePianoMove
