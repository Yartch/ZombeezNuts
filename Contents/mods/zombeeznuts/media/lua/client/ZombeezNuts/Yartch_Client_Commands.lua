--- ======================================================
--- Handlers for commands coming from the server.
--- ======================================================

local Client = ZombeezNuts.Client
local Commands = ZombeezNuts.Client.Commands
local Conditions = ZombeezNuts.Conditions
local Prayers = ZombeezNuts.Prayers

-- Called when any player gets a result from praying
function Commands.PrayerResult (args)
    local playerId = args.playerId
    local success = args.success
    local prayerName = args.prayerName
    local resultName = args.resultName

    local player = getPlayerByOnlineID(playerId)
    if player == nil then
        print("Invalid player id:" .. tostring(playerId))
        return
    end

    local prayer = Prayers.Types[prayerName]
    if prayer == nil then
        print("Invalid prayer type: " .. prayerName)
        return
    end

    local result = prayer.results[resultName]
    if result == nil then
        print("Invalid prayer result type: " .. resultName)
        return
    end

    -- Show the result text above the players head
    if player == getPlayer() then
        Client:showPrayerResult(result, player)
    end

    result.action(player)

    -- Set the players last prayer time to now
    player:SetVariable("lastZombieJesusPrayer", tostring(getGameTime():getMinutesStamp()))
end

-- Called when a player obtains a condition
function Commands.ConditionApplied (args)
    local playerId = args.playerId
    local conditionTypeName = args.conditionTypeName

    local player = getPlayerByOnlineID(playerId)
    if player == nil then
        print("Invalid player id:" .. tostring(playerId))
        return
    end

    local condition = Conditions.Types[conditionTypeName]
    if condition == nil then
        print("Invalid condition type name: " .. conditionTypeName)
        return
    end

    condition.actionApply(player)
end

-- Called when a player loses a condition
function Commands.ConditionExpired (args)
    local playerId = args.playerId
    local conditionTypeName = args.conditionTypeName

    local player = getPlayerByOnlineID(playerId)
    if player == nil then
        print("Invalid player id:" .. tostring(playerId))
        return
    end

    local condition = Conditions.Types[conditionTypeName]
    if condition == nil then
        print("Invalid condition type name: " .. conditionTypeName)
        return
    end

    condition.actionExpire(player)
end