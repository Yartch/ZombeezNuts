--- ======================================================
--- Functions for object management and interaction.
--- ======================================================

local Objects = ZombeezNuts.Objects

-- Keep track of the last object with a mouse down event
local lastClickedObject = nil

-- Makes a table of the object types with their texture name as the index
function Objects:createTextureIndex ()
    if self.TextureIndex ~= nil then return end

    self.TextureIndex = { }
    for i,obj in pairs(Objects.Types) do
        if obj.textureName ~= nil and obj.textureName ~= "" then
            self.TextureIndex[obj.textureName] = obj
        end
    end
end

-- Down click only adds a reference to the object that was clicked
local function yartchObjectClickDown(object, x, y)
    if getPlayer():isAiming() then return end

    lastClickedObject = object
end

-- Checks if the object was the same for the down click and up click 
local function yartchObjectClickUp(object, x, y)
    if lastClickedObject ~= nil then
        if lastClickedObject == object then
            local textureName = object:getTextureName()

            -- Get the clicked object type by the texture of its tile
            local objType = Objects.TextureIndex[textureName]
            if objType ~= nil then
                objType.onClicked(object, x, y)
            end
        end
        lastClickedObject = nil
    end
end

Events.OnObjectLeftMouseButtonDown.Add(yartchObjectClickDown)
Events.OnObjectLeftMouseButtonUp.Add(yartchObjectClickUp)