---@class ModlandCredits : MainMenuCredits
---@overload fun(menu: FileSelectMenu): ModlandCredits
local ModlandCredits, super = Class(MainMenuCredits)

function ModlandCredits:init(menu)
    super.init(self,menu)
    self.pages = TableUtils.merge({
        {
            "#th Sanctuary",
            {
                { "Lead Developers", COLORS.yellow },
                "Ralszor",
                "DiamondDeltahedron",
                "",
                "",
                { "Spritework", COLORS.yellow },
                "Runius",
                "",
                "",
                "",
                "",
            },
            {
                { "Contributors", COLORS.yellow },
                "AcousticJamm",
                "nazareth",
                "",
                "",
                { "Music", COLORS.silver },
                "DeltaPulsar",
                "obj_lily",
                "therealaarami",
                "",
                ""
            }
        },
    }, self.pages)
end

function ModlandCredits:onKeyPressed(key)
    if Input.isCancel(key) or Input.isConfirm(key) then
		if Input.isConfirm(key) then
			Assets.stopAndPlaySound("ui_select")
		else		
			Assets.stopAndPlaySound("ui_cancel")
		end
        self.menu:popState()
        return
    end
    super.onKeyPressed(self,key)
end

return ModlandCredits