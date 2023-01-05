--- ======================================================
--- Functions for creating and managing timers.
--- ======================================================

local Timers = ZombeezNuts.Timers

-- Creates and registers a timer that activates after the given amount of minutes
function Timers:createTimerDuration (durationMinutes, action, actionArgs)
    if isClient() then return nil end

    local currentTime = getGameTime():getMinutesStamp()
    local timestamp = currentTime + durationMinutes
    return self:createTimerTimestamp(timestamp, action, actionArgs)
end

-- Creates and registers a timer that activates at the given timestamp
function Timers:createTimerTimestamp (timestamp, action, actionArgs)
    if isClient() then return nil end

    local timer = ZombeezNutsTimer:new()
    timer.activateTime = timestamp
    timer.action = action
    timer.actionArgs = actionArgs
    table.insert(self.ActiveTimers, timer)
    return timer
end

-- Called every minute to see if there's any timers to activate
local function updateTimers ()
    local currentTime = getGameTime():getMinutesStamp()

    for i=#Timers.ActiveTimers,1,-1 do
        local timer = Timers.ActiveTimers[i]
        local removeTimer = false

        -- Flag the timer for removal if it's been cancelled
        if timer.cancelled then
            removeTimer = true

        -- Otherwise check if it's ready to activate
        elseif currentTime >= timer.activateTime then
            removeTimer = true
            timer:activate()
        end

        if removeTimer then
            table.remove(Timers.ActiveTimers, i)
        end
    end
end

Events.EveryOneMinute.Add(updateTimers)