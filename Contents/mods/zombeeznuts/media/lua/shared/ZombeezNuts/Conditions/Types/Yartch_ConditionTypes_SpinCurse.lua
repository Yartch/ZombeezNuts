--- ======================================================
--- This condition makes you spin.
--- ======================================================

local Conditions = ZombeezNuts.Conditions

Conditions.Types.SpinCurse = ZombeezNutsCondition:new {
    name = "Curse of Spinning",
    typeName = "SpinCurse",
    isCurse = true,
    durationMinutes = 20,
    
    actionApply = function (player)
        player:setVariable("IsCursedWithSpinning", true)
    end,

    actionExpire = function (player)
        player:setVariable("IsCursedWithSpinning", false)
    end,
}