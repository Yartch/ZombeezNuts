--- ======================================================
--- Timer class for creating delayed actions based on the in-game time.
--- ======================================================

ZombeezNutsTimer = {
    activateTime = 0, -- The timestamp that the timer should activate at
    cancelled = false, -- Flag for when if timer is cancelled
    action = function (args) end, -- Action to be called on activation
    actionArgs = {}, -- Arguments for the action
}

function ZombeezNutsTimer:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- Called when the timer counts down to 0
function ZombeezNutsTimer:activate ()
    self.action(self.actionArgs)
end

-- Prevents the action from being called
function ZombeezNutsTimer:cancel ()
    self.cancelled = true
end