local map, super = Class(Map)

function map:load() --When the map loads....
    super.load(self)
    self.siner = 0 --[i] Required setup variable. 
		for _, event in ipairs(self.events_by_name["window_glow"]) do
		event.scale_y = -1
	end
end

function map:onEnter()

end

function map:update() --Every time the game updates...
	super.update(self)
	local chars = {
		"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
		"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
		"<",">",",",".","?","!","@","#","$","%","^","&","*","(",")","_","+","-","=","|","/","\\","\"","'","`","~","1","2","3","4","5","6","7","8","9","0",
		-- Greek uppercase
		"Α","Β","Γ","Δ","Ε","Ζ","Η","Θ","Ι","Κ","Λ","Μ","Ν","Ξ","Ο","Π","Ρ","Σ","Τ","Υ","Φ","Χ","Ψ","Ω",
		-- Greek lowercase
		"α","β","γ","δ","ε","ζ","η","θ","ι","κ","λ","μ","ν","ξ","ο","π","ρ","σ","τ","υ","φ","χ","ψ","ω",
		-- Cyrillic uppercase
		"А","Б","В","Г","Д","Е","Ж","З","И","Й","К","Л","М","Н","О","П","Р","С","Т","У","Ф","Х","Ц","Ч","Ш","Щ","Ъ","Ы","Ь","Э","Ю","Я",
		-- Cyrillic lowercase
		"а","б","в","г","д","е","ж","з","и","й","к","л","м","н","о","п","р","с","т","у","ф","х","ц","ч","ш","щ","ъ","ы","ь","э","ю","я",
	}
	local name = "FRACTURED"
	local randomized = {}
	for i = 1, #name do
		local r = math.random(1, #chars)
		randomized[i] = chars[r]
	end
	local rndname = table.concat(randomized)
	if math.floor(Kristal:getTime()%2) == 0 then
		self.name = "Fractured Sanctuary"
		else
			self.name = rndname .. " Sanctuary"
	end
   -- self.world.color = {ColorUtils.HSLToRGB(Kristal.getTime()/5 %1, 1, 1)}
end


return map