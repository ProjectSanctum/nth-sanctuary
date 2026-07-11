local Prism, super = Class(Recruit)

function Prism:init()
    super.init(self)
    self.name = "Fizzle"
    self.recruit_amount = 5
    self.description = "Dreamer of colors, \nbasks in the light of \nthe sun."
    self.chapter = "4.5?"
    self.level = 25
    self.attack = "23"
    self.defense = "17"
    self.element = "VAPOR:WATER"
    self.like = "Sleeping"
    self.dislike = "Darkness"
    self.box_gradient_type = "bright"
    self.box_gradient_color = {1,1,0}
    self.box_sprite = {"enemies/fizzle/idle", 0, 0, 1/6}
    self.recruited = 0
end

return                                                                                                                           Prism