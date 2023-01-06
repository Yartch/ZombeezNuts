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

          -- Doesn't give the player the spinning curse
          Spare = ZombieJesusPrayerResult:new {
            weight = 0.5,
            resultText = "You are one merciful angel, Michaelsanjello.",
            resultColor = HaloTextHelper.getColorGreen(),
            action = function (player)
                local hat = player:getWornItem("Hat")
                if hat ~= nil then
                    hat:setCondition(hat:getConditionMax())
                end
            end
        },

        -- Gives the player the spinning curse
        SpinCurse = ZombieJesusPrayerResult:new {
            weight = 0.5,
            resultText = "Michaelsanjello, I sure am feeling dizzy!",
            resultColor = HaloTextHelper.getColorRed(),
            action = function (player)
                Conditions:applyCondition(player, Conditions.Types.SpinCurse)
            end
        },
    },
}