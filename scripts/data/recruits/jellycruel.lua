local Jellycruel, super = Class(Recruit)

function Jellycruel:init()
    super.init(self)
    self.name = "Jellycruel"
    self.recruit_amount = 1
    self.description = "Somehow, you managed to \nrecruit it. God knows how, \nbut you did it."
    self.chapter = 2.5
    self.level = 66
    self.attack = "JLY"
    self.defense = "CRL"
    self.element = "CRUEL:EVIL:HATEFUL:CHAOTIC:JELLY"
    self.like = "Chaos and hate"
    self.dislike = "Peace and love"
    self.box_gradient_type = "bright"
    self.box_gradient_color = {1, 0, 0, 1}
    self.box_sprite = {"enemies/jellycruel/idle", 0, 0}
    self.recruited = 0
end

return                                                                                                                           Jellycruel