--- ======================================================
--- A possible result from performing a prayer.
--- ======================================================

ZombieJesusPrayerResult = {
    weight = 1.0, -- Chance to get picked (more is better)
    resultIndex = "", -- Unique index for the result
    resultText = "", -- Text that appears above the players head
    resultColor = nil, -- Colour of the text that appears
    action = function () end, -- Callback when the result is picked
}

function ZombieJesusPrayerResult:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
