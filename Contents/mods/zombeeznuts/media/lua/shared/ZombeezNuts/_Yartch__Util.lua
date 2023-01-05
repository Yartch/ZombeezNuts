--- ======================================================
--- Utility functions.
--- ======================================================

local Util = ZombeezNuts.Util
local IsoUtils = ZombeezNuts.IsoUtils

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

