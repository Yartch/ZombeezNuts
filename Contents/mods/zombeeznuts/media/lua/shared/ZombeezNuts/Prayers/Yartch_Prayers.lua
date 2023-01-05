--- ======================================================
--- Functions for performing and managing prayers.
--- ======================================================

local Prayers = ZombeezNuts.Prayers

-- Returns the time in minutes before the player can pray again
function Prayers:getPrayerCooldown (player)
    local currentTime = getGameTime():getMinutesStamp()
    local prayerCooldown = ZombeezNuts.Settings.prayerCooldownMinutes

    -- See if the player has prayed previously
    local lastPrayerString = player:GetVariable("lastZombieJesusPrayer")
    if lastPrayerString ~= "" and lastPrayerString ~= nil and lastPrayerString ~= "nil" then
        local lastPrayerTime = tonumber(lastPrayerString)

        -- Check if there's any time remaining on the cooldown
        if lastPrayerTime ~= nil and currentTime < lastPrayerTime + prayerCooldown then
            local remainingCooldown = lastPrayerTime + prayerCooldown - currentTime
            print(remainingCooldown .. " minutes remaining")
            return remainingCooldown
        end
    end

    return 0
end

-- Gets a random result from a prayer with the provided index
function Prayers:doPrayerRoll (player, prayerIndex)

    -- Make sure the player's prayers aren't on cooldown
    local cooldown = self:getPrayerCooldown(player)
    if cooldown > 0 then return nil end

    -- Check if the prayer exists
    local prayer = self.Types[prayerIndex]
    if prayer == nil then
        print("Invalid prayer index: " .. prayerIndex)
        return nil
    end

    -- Grab a result and make sure its valid
    local result = prayer:getResult()
    if result == nil then
        print("Failed to get result from prayer")
        return nil
    end

    -- Start the prayer cooldown and return the result
    player:SetVariable("lastZombieJesusPrayer", tostring(getGameTime():getMinutesStamp()))
    return result
end
