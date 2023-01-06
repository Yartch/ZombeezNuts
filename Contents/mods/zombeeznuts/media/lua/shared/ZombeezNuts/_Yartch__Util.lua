--- ======================================================
--- Utility functions.
--- ======================================================

local Util = ZombeezNuts.Util
local IsoUtils = ZombeezNuts.IsoUtils

local function getLimitedTable(inTable, amount)
    if amount == nil then
        return inTable
    end

    local outTable = { }

    for i,obj in pairs(inTable) do
        table.insert(outTable, obj)
        amount = amount - 1
        if amount == 0 then
            break
        end
    end

    return outTable
end

-- Recursively adds item to the items table if it passes the filter
function Util:addItem(items, item, filters)
    local pass = true

    if pass and filters["isDamaged"] ~= nil and filters["isDamaged"] == true then
        if item:IsClothing() or item:IsWeapon() then
            pass = item:getCondition() ~= item:getConditionMax()
        else
            pass = false
        end
    end

    if pass then
        table.insert(items, item)
    end

    if item:IsInventoryContainer() then
        self:getFilteredItemsFromContainer (items, item:getInventory(), filters)
    end
end

-- Fills the given items table with items that are on the given tile
function Util:getFilteredItemsFromTile (items, tile, filters)
    local floor = tile:getFloor()

    for i=0,tile:getObjects():size() - 1 do
        local obj = tile:getObjects():get(i)
        if obj["getItem"] ~= nil then
            local item = obj:getItem()
            self:addItem(items, item, filters)
        end
    end

    self:getFilteredItemsFromContainer(items, floor:getContainer(), filters)
end

-- Fills the given items table with items from a container that meet the filter conditions
function Util:getFilteredItemsFromContainer (items, container, filters)
    if container == nil then return end
    for i=0,container:getItems():size() - 1 do
        local item = container:getItems():get(i)
        self:addItem(items, item, filters)
    end
end

-- Returns a table of items 
function Util:getPlayerClosestItems (player, filters)
    local items = { }

    -- Check the players main inventory
    self:getFilteredItemsFromContainer(items, player:getInventory(), filters)

    -- Check the containers on the player
    local containerCount = player:getContainerCount()
    for i=0,containerCount - 1 do
        self:getFilteredItemsFromContainer(items, player:getContainerByIndex(i), filters)
    end   

    -- Check the floor tile the player is on, and every tile adjacent
    local mainTile = player:getSquare()
    local tiles = IsoUtils.GetIsoRange(mainTile, 2)
    for i,tile in pairs(tiles) do
        self:getFilteredItemsFromTile (items, tile, filters)
    end

    return items
end

-- Repairs the most damaged items near a player (including their inventory)
function Util:repairItemsNearPlayer(player, numItems, repairAmount)
    if isServer() then return end

    -- Get items close the player, then sort them by condition percent ascending
    local items = Util:getPlayerClosestItems(player, { isDamaged = true })
    table.sort(items, function(a,b)
        local percentA = a:getCondition() / a:getConditionMax()
        local percentB = b:getCondition() / b:getConditionMax()
        return percentA < percentB
    end)

    items = getLimitedTable(items, numItems)

    for i,item in pairs(items) do
        local newCondition = math.min(item:getCondition() + repairAmount, item:getConditionMax())
        item:setCondition(newCondition)
    end
end



local function getPlayerBodyParts(player, onlyDamaged, amount)
    local parts = { }
    for i=0,player:getBodyDamage():getBodyParts():size() - 1 do
        local part = player:getBodyDamage():getBodyParts():get(i)
        if not onlyDamaged or part:getHealth() < 100 then
            table.insert(parts, part)
        end
    end
    return getLimitedTable(parts, amount)
end

local function getPlayerBodyPartsSorted(player, onlyDamaged, sortHighToLow, amount) 
    if amount ~= nil and amount <= 0 then
        return { }
    end
    
    local parts = getPlayerBodyParts(player, onlyDamaged)

    if sortHighToLow then
        table.sort(parts, function(a,b) return a:getHealth() > b:getHealth() end)
    else
        table.sort(parts, function(a,b) return a:getHealth() < b:getHealth() end)
    end

    return getLimitedTable(parts, amount)
end

-- Heals the players most damaged body parts
function Util:healPlayerBodyParts(player, numParts, healAmount)
    local parts = getPlayerBodyPartsSorted(player, true, false, numParts)
    
     for i,part in pairs(parts) do
        part:AddHealth(healAmount)
    end
end

-- Damages the players most healthy body parts
function Util:damagePlayerBodyParts(player, numParts, damageAmount)
    local parts = getPlayerBodyPartsSorted(player, false, true, numParts)
    
     for i,part in pairs(parts) do
        part:AddDamage(damageAmount)
    end
end

-- Makes random body parts bleed
function Util:bleedPlayerBodyParts(player, numParts, severity)
    local parts = getPlayerBodyParts(player, false, numParts)
    
     for i,part in pairs(parts) do
        local currentBleedDuration = part:getBleedingTime()
        part:setBleedingTime(currentBleedDuration + severity)
    end
end