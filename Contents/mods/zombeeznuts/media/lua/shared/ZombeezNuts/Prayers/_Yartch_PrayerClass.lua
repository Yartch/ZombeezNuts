--- ======================================================
--- A type of prayer that can be perform for Zombie Jesus.
--- ======================================================

ZombieJesusPrayer = {
    name = "", -- Name that shows up on the prayer menu button
    tooltipText = "", -- Text when hovering over the button
    prayerAnimation = "", -- Animation to use when praying
    results = {} -- Table of possible results from performing the prayer
}

function ZombieJesusPrayer:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end 

-- Grab a random result
function ZombieJesusPrayer:getResult ()

    -- Calculate the total weight of the results
    local totalWeight = 0.0
    for i,result in pairs(self.results) do
        totalWeight = totalWeight + result.weight
    end

    -- RNG
    local rolledWeight = ZombRandFloat(0.0, totalWeight)

    -- Go through each result until the rolled weight is reached
    local checkWeight = 0.0
    for i,result in pairs(self.results) do
        checkWeight = checkWeight + result.weight
        if rolledWeight <= checkWeight  then
            result.resultIndex = tostring(i)
            return result
        end
    end

    return nil
end