return {
    indoct_end = function (cutscene)
        local static_fx = ShaderFX(Mod.staticBulletShader, {
            ["time"] = function() return Kristal.getTime() end,
            ["brightness"] = 2
        })
        cutscene:text("* There has to be some action done before this (for the future)")
        --TODO: This later ^^^^^^


        local r = Game.world:spawnNPC("randomGuy")
        local k = cutscene:getCharacter("kris")
        --delete this when we get to a better bit, this is for visual help vvv
	    for _, follower in ipairs(Game.world.followers) do
	    	follower.visible = false
	    end
        ---delete this ^^^

        r.x, r.y = 120, 120
        k.x, k.y = r.x, r.y + 300
        cutscene:wait(1)
        cutscene:fadeOut(0)
        local a, a2 =  k.x-20, k.y-90
        local spr = Sprite("party/kris/dark/battle/defeat_1", a, a2)
        Game.stage:addChild(spr)
        local spr2 = Sprite("player/heart_dodge", a+10, a2+60)
        Game.stage:addChild(spr2)
        local waw = DamageNumber("msg", "imbued", a+60, a2+60)
        waw.layer = 99999999
        Game.stage:addChild(waw)
        waw:addFX(static_fx, "static_fx")
        spr:setScale(2)
        spr:addFX(ColorMaskFX({1,0,0}))
        spr2:addFX(static_fx, "static_fx")
        Assets.playSound("indoct_break1")
        
        cutscene:wait(5)
        local function addText(target, x, y, delay)
            local txt = Sprite("misc/mind/theirmind"..target, x, y)
            txt.layer = 999999
            txt:setOrigin(0, 0.5)
            Game.world:addChild(txt)
            Game.world.timer:after(delay, function()
                if txt and txt.parent then
                    txt:remove()
                end
            end)
        end

        addText(1, a-10, a2-10, 3)
        cutscene:wait(4)
        addText(2, a-10, a2-10, 3)
        cutscene:wait(3)
        addText(3, a-10, a2-10, 4)
        cutscene:wait(5)
        addText(4, a-10, a2-10, 4)
        cutscene:wait(5)
        addText(5, a-10, a2-20, 2)
        cutscene:wait(2)
        addText(6, a-10, a2-10, 2)
        cutscene:wait(6)
        addText(7, a-10, a2-10, 6)
        cutscene:wait(3)
        addText(8, a + 150, a2-10, 3)
        cutscene:wait(3)
        addText(9, a-10, a2-10, 3)
        cutscene:wait(3)
        addText(10, a-10, a2-10, 3)
        cutscene:wait(3)
        addText(11, a-10, a2-10, 3)
        cutscene:wait(3)
        addText(12, a-10, a2-10, 3)
        cutscene:wait(6)
        
        cutscene:text("[shake:1.225][speed:0.05]* I'm sorry, [wait:5]Dess.", {auto = true})
        spr:remove()
        spr2:remove()
        Assets.playSound("indoct_break2")
    end
}