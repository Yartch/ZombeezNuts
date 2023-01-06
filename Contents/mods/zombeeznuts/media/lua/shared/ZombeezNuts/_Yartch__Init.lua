--- ======================================================
--- Defines the global table and registers global events.
--- ======================================================

ZombeezNuts = {
    Settings = {
        prayerCooldownMinutes = 330, -- 330 for live, which is 5.5 hours 
    },

    Util = { },
    IsoUtils = { },
    
    Timers = {
        ActiveTimers = { },
    },

    Prayers = {
        Types = { },
    },

    Conditions = {
        Types = { },
    },

    Objects = {
        Types = { },
    },
    
    Client = {
        Commands = { },
    },

    Server = {
        Commands = { },
    },
}

local function OnGameBoot()
	ZombeezNuts.Objects:createTextureIndex()
end

Events.OnGameBoot.Add(OnGameBoot)