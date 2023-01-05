--- ======================================================
--- UI for the Blessings system (long-term progression).
--- Unused currently, u have to keep this a secret ok?
--- ======================================================

require "ISUI/ISCollapsableWindow"

ZombieJesusBlessingsUI = ISCollapsableWindow:derive("ZombieJesusBlessingsUI");
ZombieJesusBlessingsUI.instance = nil;

function ZombieJesusBlessingsUI:setVisible(bVisible)
    self.javaObject:setVisible(bVisible);
    self.javaObject:setEnabled(bVisible)
end

function ZombieJesusBlessingsUI:initialise()
    ISCollapsableWindow.initialise(self);
end

function ZombieJesusBlessingsUI:close()
	ISCollapsableWindow.close(self)
end

function ZombieJesusBlessingsUI:render()
    ISCollapsableWindow.render(self);
    if self.isCollapsed then return end
end

function ZombieJesusBlessingsUI:new (character)
    local o = {};

	width = 500
	height = 250

	x = (getCore():getScreenWidth() / 2) - (width / 2);
	y = (getCore():getScreenHeight() / 2) - (height / 2);

	o = ISCollapsableWindow:new(x, y, width, height);
	o.minimumWidth = width
	o.minimumHeight = height

	o.title = "Zombie Jesus Blessings";

	setmetatable(o, self);
    self.__index = self;
	return o;
end

function ZombieJesusBlessingsUI:createChildren()
    ISCollapsableWindow.createChildren(self)
	
	y = 30

	--	There will be a list of blessings here
	--		Blessing icon	  vvv
	--		Blessing name > (tooltip = details about what the blessing does)
	--		Progress bar for blessing power (tooltip = milestones and xp numbers)
	
	-- 	Conditions will also be here, which are already in the mod (spinning curse)
	--		Condition icon	    vvv
	--		Condition name > (tooltip = details about what the condition does)
	--		Duration and power

	y = y + 15

	self.closeButton = ISButton:new(self.width / 2 - 50, y, 100, 25, "Close", self, ZombieJesusBlessingsUI.closeWindow);
    self.closeButton:initialise()
    self:addChild(self.closeButton);
end

function ZombieJesusBlessingsUI:closeWindow()
	self:setVisible(false)
end
