--- ======================================================
--- Affects the players vitals and item conditions.
--- ======================================================

local Prayers = ZombeezNuts.Prayers
local Util = ZombeezNuts.Util

Prayers.Types.Vitality = ZombieJesusPrayer:new {
    name = "Vitality Invocation",
    tooltipText = "Pray for good health, but be weary of bad health.",
    prayerAnimation = "ZJPrayerDefault",

    results = {
        -- Heals the player's most damaged body parts
        Doctor = ZombieJesusPrayerResult:new {
            weight = 0.3,
            resultText = "The doctor works fast.",
            resultColor = HaloTextHelper.getColorGreen(),
            action = function (player)
                Util:healPlayerBodyParts(player, 3, 40)
            end
        },

        -- Repairs the player's most damaged items
        Repair = ZombieJesusPrayerResult:new {
            weight = 0.3,
            resultText = "I sense that some items just got repaired.",
            resultColor = HaloTextHelper.getColorGreen(),
            action = function (player)
                Util:repairItemsNearPlayer(player, 3, 3)
            end
        },

        -- Damages the player's healthiest body parts
        Damage = ZombieJesusPrayerResult:new {
            weight = 0.1,
            resultText = "Pain fills my soul, and I'm not a fan.",
            resultColor = HaloTextHelper.getColorRed(),
            action = function (player)
                Util:damagePlayerBodyParts(player, 5, 20)
            end
        },

        -- Causes a random body part to bleed
        Bleed = ZombieJesusPrayerResult:new {
            weight = 0.1,
            resultText = "Bloody heck...",
            resultColor = HaloTextHelper.getColorRed(),
            action = function (player)
                Util:bleedPlayerBodyParts(player, 2, 20)
            end
        },
    }
}