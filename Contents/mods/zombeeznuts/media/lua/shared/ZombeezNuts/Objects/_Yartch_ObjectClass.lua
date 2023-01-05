--- ======================================================
--- An object that is identified by a unique tile texture.
--- ======================================================

ZombeezNutsObject = {
    textureName = "", -- Name of the object's tile texture
    onClicked = function (object, x, y) end, -- Action that happens when the object is clicked
}

function ZombeezNutsObject:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end