local map, super = Class(Map)

function map:init(...)
    super.init(self, ...)
    self.siner = 0
    self.siner = 0
end

function map:onEnter()
    super.onEnter(self)
    self.target = self:getTileLayer("tiles")
	self.fx = RecolorFX()
    self.target:addFX(self.fx)
end
function map:update()
    super.update(self)
    self.siner = self.siner + DT
    self.fx.color = ColorUtils.mergeColor({1,0.7,0.5}, {1,0.5,1}, (math.sin(self.siner)+1)/2)
end

return map