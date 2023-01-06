--- ======================================================
--- Gives the player items.
--- ======================================================

local Prayers = ZombeezNuts.Prayers

Prayers.Types.Greed = ZombieJesusPrayer:new {
    name = "Cry of Greed",
    tooltipText = "Materials for the materialistically minded.",
    prayerAnimation = "ZJPrayerDefault",

    results = {
        -- Chicken!
        Chicken = ZombieJesusPrayerResult:new {
            weight = 0.2,
            resultText = "Some fried chicken huh? Don't mind if I do.",
            resultColor = HaloTextHelper.getColorGreen(),
            action = function (player)
                local item = instanceItem("Base.ChickenFried")
                player:getInventory():AddItems(item, 4)
            end
        },

        -- Duct tape
        DuctTape = ZombieJesusPrayerResult:new {
            weight = 0.2,
            resultText = "Duct tape fixes everything!",
            resultColor = HaloTextHelper.getColorGreen(),
            action = function (player)
                local item = instanceItem("Base.DuctTape")
                player:getInventory():AddItems(item, 3)
            end
        },

        -- Popcorn
        Food = ZombieJesusPrayerResult:new {
            weight = 0.2,
            resultText = "POP(corn) goes the Zombie Jesus!",
            resultColor = HaloTextHelper.getColorGreen(),
            action = function (player)
                local item = instanceItem("Base.Popcorn")
                item:setCooked(true)
                player:getInventory():AddItem(item)
            end
        },

        -- Hand axe
        Axe = ZombieJesusPrayerResult:new {
            weight = 0.1,
            resultText = "Axe and ye shall receive.",
            resultColor = HaloTextHelper.getColorGreen(),
            action = function (player)
                local item = instanceItem("Base.HandAxe")
                player:getInventory():AddItem(item)
            end
        },

        -- A nailed bat
        Bat = ZombieJesusPrayerResult:new {
            weight = 0.1,
            resultText = "Okay, Nail Bat is epic!",
            resultColor = HaloTextHelper.getColorGreen(),
            action = function (player)
                local item = instanceItem("Base.BaseballBatNails")
                player:getInventory():AddItem(item)
            end
        },

        -- So sad its coal
        Coal = ZombieJesusPrayerResult:new {
            weight = 0.2,
            resultText = "Guess I was on the naughty list...",
            resultColor = HaloTextHelper.getColorRed(),
            action = function (player)
                local item = instanceItem("ZombeezNuts.ZombieJesusCoal")
                player:getInventory():AddItem(item)
            end
        },
    },
}