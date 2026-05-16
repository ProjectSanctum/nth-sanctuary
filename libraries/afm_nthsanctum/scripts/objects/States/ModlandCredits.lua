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
                "TheLucidLibrarian",
                "Mason",
                "Funkin's Garbage",
                { "Storywriting", COLORS.yellow },
                "KayCelestia",
                "TheLucidLibrarian",
                "",
                "",
            },
            {
                { "Contributors", COLORS.yellow },
                "Hyperboid",
                "JARU",
                "Leaff",
                "",
                { "Music", COLORS.yellow },
                "DeltaPulsar",
                "squibles",
                "deepdarkdepths__",
            }
        },
        {
            "#th Sanctuary",
            {
                { "Spritework", COLORS.yellow },
                "Runius",
                "Hyperboid",
                "Krisp / Tamato",
                "CuriousSpook",
                "",
                "",
                "",
                "",
                "",
                ""
            },
            {
                { "Borrowed Music", COLORS.yellow },
                "obj_lily",
                "therealaarami",
                "AkitA",
                "Rareblin",
                "Lucas Pucas",
                "",
                "",
                "",
                "",
            }
        },
        {
            "#th Sanctuary",
            {
                { "Extra Assets", COLORS.yellow },
                "DELTARUNE Team",
                "Toby Fox",
                "Temmie Chang",
                "duskkii",
                "",
                "",
                "",
                "",
                "",
                ""
            },
            {
                { "Special Guests", {0.5, 1, 0.7} },
                "AcousticJamm",
                "RetroSpecter",
                "",
                "",
                "",
                "",
                "",
                "",
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