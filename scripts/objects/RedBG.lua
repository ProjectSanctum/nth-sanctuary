local RedBG, super = Class(BattleBackground)

function RedBG:init()
    super.init(self)
    self.offset = 0
    self.img = Sprite("battle/backgrounds/redbg",0, 0)
    self.img.wrap_texture_x = true
    self.img.wrap_texture_y = true   
    self.img2 = Sprite("battle/backgrounds/redbg",self.img.width/2, 0)
    self.img2.wrap_texture_x = true
    self.img2.wrap_texture_y = true   
    
    self:addChild(self.img)
    self:addChild(self.img2)
    self.img:setScale(1)
    self.img2:setScale(2)

    self.img.alpha = 0
    self.img2.alpha = 0.5
end

function RedBG:drawBackground(fade)
    self.offset = self.offset + DTMULT
    self.offset2 = self.offset + 1

    self.img.x, self.img.y = self.img.x + 1, self.img.y + 1
    
    self.img2.x = self.img2.x - 0.5
    self.img2.y = self.img2.y - math.sin(self.offset/50)
    self.img.alpha = fade or 1
    self.img2.alpha = fade and fade/2 or 0.5

end

return RedBG