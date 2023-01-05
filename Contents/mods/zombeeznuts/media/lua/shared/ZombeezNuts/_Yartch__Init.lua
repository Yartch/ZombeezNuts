--- ======================================================
--- Defines the global table and registers global events.
--- ======================================================

ZombeezNuts = {
    Settings = {
        prayerCooldownMinutes = 1, -- 690 for live, which is 11.5 hours 
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