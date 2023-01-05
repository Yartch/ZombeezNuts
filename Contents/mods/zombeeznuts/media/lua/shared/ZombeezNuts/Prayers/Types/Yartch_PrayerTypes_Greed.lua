--- ======================================================
--- Gives the player items.
--- ======================================================

local Prayers = ZombeezNuts.Prayers

Prayers.Types.Greed = ZombieJesusPrayer:new {
    name = "Cry of Greed",
    tooltipText = "Materials for the materialistically minded.",
    prayerAnimation = "ZJPrayerDefault",

    results = {
        -- Gives player an item that is heavy and takes long to transfer
        Coal = ZombieJesusPrayerResult:new {
            weight = 1.0,
            resultText = "Guess I was on the naughty list!",
            resultColor = HaloTextHelper.getColorRed(),
            action = function (player)
                local item = instanceItem("ZombeezNuts.ZombieJesusCoal")
                player:getInventory():AddItem(item)
            end
        },
    },
}