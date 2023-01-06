--- ======================================================
--- A cross with Zombie Jesus' head that can be used for prayer.
--- ======================================================

local Client = ZombeezNuts.Client
local Objects = ZombeezNuts.Objects
local Prayers = ZombeezNuts.Prayers

local function getCooldownTimeText(cooldownMinutes)
    if cooldownMinutes <= 1 then 
        return "I just have to wait 1 more minute."
    elseif cooldownMinutes <= 60 then
        return "I have to wait " .. tostring(cooldownMinutes) .. " more minutes."
    end

    local hours = math.ceil(cooldownMinutes / 60)
    return "I have to wait " .. tostring(hours) .. " hours."
end


Objects.Types.ZombieJesusCross = ZombeezNutsObject:new{
    textureName = "yartch_tiles_01_0",
    onClicked = function (object, x, y)
        -- Check if the player has a cooldown on praying
        local prayerCooldown = Prayers:getPrayerCooldown(getPlayer())
        if prayerCooldown <= 0 then
            Client:togglePrayerWindow()
        else
            -- Notify the player how long is left on the cooldown
            HaloTextHelper.addText(getPlayer(), getCooldownTimeText(prayerCooldown), 230, 115, 115)
        end
    end,
}