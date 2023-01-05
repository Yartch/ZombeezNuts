--- ======================================================
--- Grants temporary buffs/debuffs.
--- ======================================================

local Prayers = ZombeezNuts.Prayers
local Conditions = ZombeezNuts.Conditions

Prayers.Types.TemporalPlea = ZombieJesusPrayer:new {
    name = "Michaelsanjello's Temporal Plea",
    tooltipText = "Time is of the essence as they say...",
    prayerAnimation = "ZJPrayerDefault",

    results = {
        -- Gives the player the spinning curse
        SpinCurse = ZombieJesusPrayerResult:new {
            weight = 1.0,
            resultText = "Michaelsanjello, I sure am feeling dizzy!",
            resultColor = HaloTextHelper.getColorRed(),
            action = function (player)
                Conditions:applyCondition(player, Conditions.Types.SpinCurse)
            end
        },
    },
}