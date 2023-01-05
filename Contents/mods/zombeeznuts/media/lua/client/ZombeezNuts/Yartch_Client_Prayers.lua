--- ======================================================
--- Prayer functions for the client.
--- ======================================================

local Client = ZombeezNuts.Client
local Prayers = ZombeezNuts.Prayers

-- Displays the prayer result text above the players head
function Client:showPrayerResult(result, player)
    if result == nil then
        return
    end

    HaloTextHelper.addText(player, result.resultText, result.resultColor)
end

-- Attempts to make the player to the requested prayer
function Client:attemptPrayer(prayerName)
    if isClient() then
        -- Send the request to the server if its multiplayer
        sendClientCommand("YartchZombieJesus", "DoPrayer", { prayerName = prayerName })
    else
        -- For singleplayer, do a roll and process the result
        local player = getPlayer()
        local result = Prayers:doPrayerRoll(player, prayerName)
        if result ~= nil then 
            self:showPrayerResult (result, player)
            result.action(getPlayer())
        end
    end
end

-- Toggle the prayer window on or off
function Client:togglePrayerWindow()
    -- If the window wasn't created yet, create it and turn it on
    if not ZombieJesusCrossUI.instance then
        ZombieJesusCrossUI.instance = ZombieJesusCrossUI:new(getPlayer());
        ZombieJesusCrossUI.instance:initialise();
        ZombieJesusCrossUI.instance:addToUIManager();
        ZombieJesusCrossUI.instance:setVisible(true);
    else
        ZombieJesusCrossUI.instance:setVisible(not ZombieJesusCrossUI.instance:getIsVisible());
    end
end
