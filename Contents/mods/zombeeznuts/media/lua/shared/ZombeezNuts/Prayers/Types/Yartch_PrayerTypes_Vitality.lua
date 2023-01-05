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

        -- Heals health and a random damaged body part
        --[[Spared = ZombieJesusPrayerResult:new {
            weight = 1.0,
            resultText = "The doctor works fast.",
            resultColor = HaloTextHelper.getColorGreen(),
            action = function (player)

                -- The client will receive the heal messages from the server
                if isServer() then return end

                

            end
        },]]--

        -- Repairs the player's most damaged items
        Repair = ZombieJesusPrayerResult:new {
            weight = 1.0,
            resultText = "I sense that some items just got repaired.",
            resultColor = HaloTextHelper.getColorGreen(),
            action = function (player)

                -- The client will receive the repair messages from the server
                if isServer() then return end

                -- Get items close the player, then sort them by condition percent ascending
                local items = Util:getPlayerClosestItems(getPlayer(), { isDamaged = true })
                table.sort(items, function(a,b)
                    local percentA = a:getCondition() / a:getConditionMax()
                    local percentB = b:getCondition() / b:getConditionMax()
                    return percentA < percentB
                end)

                -- Add from the list until the quota is met
                local remainingCount = 3
                for i,item in pairs(items) do
                    local newCondition = math.min(item:getCondition() + 3, item:getConditionMax())
                    item:setCondition(newCondition)

                    if isServer() then
                        sendServerCommand(player, "YartchZombieJesus", "ItemConditionUpdate", { })
                    end

                    remainingCount = remainingCount - 1
                    if remainingCount == 0 then
                        break
                    end
                end
            end
        },
    }
}