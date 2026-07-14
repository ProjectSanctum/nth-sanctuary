local map, super = Class(Map, "secrets/secret_sanctuary")

function map:init(...)
    super.init(self, ...)
	self.siner = 0
end

function map:onEnter()
    super.onEnter(self)
	self.fx = RecolorFX()

end
function map:update()
    super.update(self)
    self.siner = self.siner + DT
    self.fx.color = ColorUtils.mergeColor({1,0.7,0.5}, {1,0.5,1}, (math.sin(self.siner)+1)/2)
end

return map
