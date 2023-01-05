--- ======================================================
--- A temporary buff or debuff that can be applied to a player.
--- ======================================================

ZombeezNutsCondition = {
    name = "", -- Display name of the condition
    typeName = "", -- The name of the type (might be redundant)
    isCurse = false, -- Should be labelled as a negative effect
    durationMinutes = 0, -- The default duration of the condition

    actionApply = function (player) end, -- Action that happens on application
    actionExpire = function (player) end, -- Action that happens on expiration
}

function ZombeezNutsCondition:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end