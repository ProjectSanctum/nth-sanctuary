local map, super = Class(Map, "trailer/fifth_sanctum")

function map:init(world, data)
    super.init(self, world, data)
    print("a")
    self.timer:every(1, function()
        if self.world:inBattle() then
            local marker1 = self.markers["left_shoot"]
            local marker2 = self.markers["right_shoot"]
            local marker3 = self.markers["top_down_shoot1"]
            local marker4 = self.markers["top_down_shoot2"]
            local marker5 = self.markers["top_down_shoot3"]
            local marker6 = self.markers["top_down_shoot4"]
            self.world:spawnBullet("smallbullet", marker1.center_x,marker1.center_y, false)
            self.world:spawnBullet("smallbullet", marker2.center_x, marker2.center_y, true)
            self.world:spawnBullet("smallbullet", marker2.center_x, marker2.center_y, true)
            self.world:spawnBullet("smallbullet", marker3.center_x,marker3.center_y, false, true)
            self.world:spawnBullet("smallbullet", marker4.center_x,marker4.center_y, false, true)
            self.world:spawnBullet("smallbullet", marker5.center_x,marker5.center_y, false, true)
            self.world:spawnBullet("smallbullet", marker6.center_x,marker6.center_y, false, true)
            
        end
    end)
end

function map:onEnter()
    for _, event in ipairs(self.events) do
        		if event.layer == self.layers["objects_parallax2"] then
			event.parallax_x = 0.5
            event.parallax_y = 1
		end
		if event.layer == self.layers["objects_parallax1"] then
			 event.parallax_x = 0.3
            event.parallax_y = 1
            event.color = {0.8, 0.8, 0.8}
		end
    end
end

function map:update()
    super.update(self)
end

return map