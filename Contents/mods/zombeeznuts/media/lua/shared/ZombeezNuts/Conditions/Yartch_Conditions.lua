--- ======================================================
--- Functions for managing conditions.
--- ======================================================

local Conditions = ZombeezNuts.Conditions
local Timers = ZombeezNuts.Timers

-- Called when the condition should expire
local function expireCondition (args)
    local player = args.player
    local conditionType = args.conditionType

    -- Call the conditions expire action
    conditionType.actionExpire(player)

    -- If this is running on the server, then make sure the clients are updated again
    if isServer() then
        sendServerCommand("YartchZombieJesus", "ConditionExpired", {
            playerId = player:getOnlineID(),
            conditionTypeName = conditionType.typeName,
        })
    end
end


-- Apply a condition to a player
function Conditions:applyCondition(player, conditionType, duration)

    -- This should only be called on the server or a singleplayer client
    if isClient() then return end

    -- If no duration was given, then set it to the default for the condition type
    if duration == nil then
        duration = conditionType.durationMinutes
    end

    -- If the default duration was invalid, then cancel the application
    if duration <= 0 then
        print("Invalid time on condition application")
        return
    end

    -- Call the conditions application action
    conditionType.actionApply(player)

    -- If this is running on the server, then make sure the clients are updated
    if isServer() then
        sendServerCommand("YartchZombieJesus", "ConditionApplied", {
            playerId = player:getOnlineID(),
            conditionTypeName = conditionType.typeName,
        })
    end
    
    -- Create a timer to expire the condition
    Timers:createTimerDuration(duration, expireCondition, { player = player, conditionType = conditionType })
end
