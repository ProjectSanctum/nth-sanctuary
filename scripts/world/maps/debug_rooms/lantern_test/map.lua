local map, super = Class(Map, "debug_rooms/lantern_test")

function map:onEnter()
    --super.init(self, world, data)
    print("a")
    self.tbl = {}
    for k, npc in ipairs(self.events_by_name["npc"]) do
        local h = self.world:spawnBullet("smallbullet", npc.x, npc.y, false, true)
        table.insert(self.tbl, h)
        npc.hitbox = {0,0,0,0}
        npc.alpha = 0
    end
end

function map:update()
    super.update(self)
    for k, bullet in ipairs(self.tbl) do
        bullet.x, bullet.y = self.events_by_name["npc"][k].x, self.events_by_name["npc"][k].y
    end
end
return map