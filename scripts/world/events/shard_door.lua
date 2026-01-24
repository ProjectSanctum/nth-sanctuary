local ShardDoor, super = Class(Event, "shard_door")

function ShardDoor:init(data)
    super.init(self, data)
    self.properties = data.properties or {}
    self.display = ShardDoorDisplay(self.properties.req)
    self.display.layer = 10000000
    self:addChild(self.display)
    self.display.x = self.width/2
    self.display.y = -130
    self.siner = 0
    self.mapname = self.properties.map_name or "Placeholder"
    self.marker = self.properties.marker or "spawn"
end

function ShardDoor:update()
    self.siner = self.siner + DTMULT
    super.update(self)
end

function ShardDoor:onInteract(player, dir)
    Game.world:startCutscene(function (cutscene)
        if not self.properties.text then
            cutscene:text("* A door. [wait:10]It needs [color:9999ff]"..self.properties.req.." Dark Shards[color:white] to open.")
        else
            cutscene:text(self.properties.text)
        end
        if Game:getFlag("shards") >= tonumber(self.properties.req) then
            cutscene:text("* You can actually open this![wait:10] It leads to [color:yellow]"..self.mapname.."[color:white]!")
            local choicer = cutscene:choicer({"Open", "Do not"})
            if choicer ==1 then
                Game.world.music:stop()
                Game.world.fader:fadeOut(nil, {
                    speed = 0,
                })
                Assets.playSound("locker")
                cutscene:wait(1)
                cutscene:loadMap(self.properties.map, self.marker)
                Game.world.fader:fadeIn(nil, {
                    speed = 0.25,
                })
            else
                cutscene:text("* You doorn't.")
            end
        end
    end)
end
return ShardDoor