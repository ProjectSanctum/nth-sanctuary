local map, super = Class(Map)

function map:load() --When the map loads....
    super.load(self)
end

return map
