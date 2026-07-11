local character, super = Class("kris", true)

function character:init()
    super.init(self)

    self.stats = {
        health = 201,
        attack = 17,
        defense = 2,
        magic = 0
    }
end

return character