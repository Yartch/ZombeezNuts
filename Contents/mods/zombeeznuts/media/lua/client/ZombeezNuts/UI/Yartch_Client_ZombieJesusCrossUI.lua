--- ======================================================
--- UI window for praying to Zombie Jesus.
--- Opens when the Zombie Jesus Cross is clicked.
--- ======================================================

local Client = ZombeezNuts.Client
local Prayers = ZombeezNuts.Prayers
local Conditions = ZombeezNuts.Conditions
local Util = ZombeezNuts.Util

require "ISUI/ISCollapsableWindow"

ZombieJesusCrossUI = ISCollapsableWindow:derive("ZombieJesusCrossUI")
ZombieJesusCrossUI.instance = nil

function ZombieJesusCrossUI:setVisible(bVisible)
    self.javaObject:setVisible(bVisible)
    self.javaObject:setEnabled(bVisible)
end

function ZombieJesusCrossUI:initialise()
    ISCollapsableWindow.initialise(self)
end

function ZombieJesusCrossUI:close()
	ISCollapsableWindow.close(self)
end

function ZombieJesusCrossUI:render()
    ISCollapsableWindow.render(self);
    if self.isCollapsed then return end
end

function ZombieJesusCrossUI:new (character)
    local o = {}

	width = 350
	height = 100

	x = (getCore():getScreenWidth() / 2) - (width / 2)
	y = (getCore():getScreenHeight() / 2) - (height / 2)

	o = ISCollapsableWindow:new(x, y, width, height)
	o.minimumWidth = width
	o.minimumHeight = height

	o.resizable = false
	o.title = "Pray to Zombie Jesus";

	o.headerImage = getTexture("media/ui/ZombieJesus/Yartch_ZombieJesus_PrayHeader.png")

	setmetatable(o, self)
    self.__index = self
	return o;
end

local buttonWidth = 200
local buttonHeight = 25
local buttonSpacing = 5

local debugButtonHeight = 15
local debugButtonWidth = 80

function ZombieJesusCrossUI:createChildren(width)
    ISCollapsableWindow.createChildren(self)

	local y = 25

	-- Header image
	local headerWidth = self.headerImage:getWidthOrig()
	local headerHeight = self.headerImage:getHeightOrig()
	local headerX = (self.width / 2) - (headerWidth / 2)

	self.headerTex = ISImage:new(headerX, y, headerWidth, headerHeight, self.headerImage)
	self.headerTex:initialise()
	self.headerTex:instantiate()
	self:addChild(self.headerTex)

	y = y + headerHeight + 15

	-- Prayer buttons
	self.prayerButtons = {}
	for i, prayer in pairs(Prayers.Types) do

		local posX = (self.width / 2) - (buttonWidth / 2)

		self.prayerButtons[i] = ISButton:new(posX, y, buttonWidth, buttonHeight, prayer.name, self, ZombieJesusCrossUI.selectPrayer)
		self.prayerButtons[i]:initialise()
		self.prayerButtons[i]:setOnClick(ZombieJesusCrossUI.selectPrayer, i)
		self.prayerButtons[i]:setTooltip(prayer.tooltipText)
		self:addChild(self.prayerButtons[i]);

		y = y + buttonHeight + buttonSpacing
    end

	y = y + buttonSpacing * 3

	-- Close button
	self.closeButton = ISButton:new(self.width / 2 - 60, y, 120, buttonHeight, "Close", self, ZombieJesusCrossUI.closeWindow)
    self.closeButton:initialise()
    self:addChild(self.closeButton)

	y = y + buttonHeight + buttonSpacing

	-- Debug buttons
	if isDebugEnabled() then
		local itemX = buttonSpacing
		local onX = self.width - debugButtonWidth * 2 - buttonSpacing * 2
		local offX = self.width - debugButtonWidth - buttonSpacing

		self.debugItemFind = ISButton:new(itemX, y, debugButtonWidth, debugButtonHeight, "ITEM FIND", self, ZombieJesusCrossUI.debugItemFind)
		self.debugItemFind:initialise()
		self:addChild(self.debugItemFind)

		self.debugSpinOnButton = ISButton:new(onX, y, debugButtonWidth, debugButtonHeight, "SPIN ON", self, ZombieJesusCrossUI.debugSpinOn)
		self.debugSpinOnButton:initialise()
		self:addChild(self.debugSpinOnButton)

		self.debugSpinOffButton = ISButton:new(offX, y, debugButtonWidth, debugButtonHeight, "SPIN OFF", self, ZombieJesusCrossUI.debugSpinOff)
		self.debugSpinOffButton:initialise()
		self:addChild(self.debugSpinOffButton)

		y = y + debugButtonHeight + buttonSpacing
	end

	self:setHeight(y + 10)
	self:setY((getCore():getScreenHeight() / 2) - (y / 2))
end

function ZombieJesusCrossUI:closeWindow()
	self:setVisible(false)
end

-- Called when a prayer button is clicked
function ZombieJesusCrossUI:selectPrayer(caller, prayerName)
	Client:attemptPrayer(prayerName)
	self:setVisible(false)
end

function ZombieJesusCrossUI:debugItemFind()
	local items = Util:getPlayerClosestItems(getPlayer(), { isDamaged = true })
	
	table.sort(items, function(a,b)
		local percentA = a:getCondition() / a:getConditionMax()
		local percentB = b:getCondition() / b:getConditionMax()
		return percentA < percentB
	end)

	for i,item in pairs(items) do
		print(item:getName())
	end
end

function ZombieJesusCrossUI:debugSpinOn()
	if isClient() then
		sendClientCommand("YartchZombieJesus", "DebugSpinOn")
	else
		getPlayer():setVariable("IsCursedWithSpinning", true)
	end
end

function ZombieJesusCrossUI:debugSpinOff()
	if isClient() then
		sendClientCommand("YartchZombieJesus", "DebugSpinOff")
	else
		getPlayer():setVariable("IsCursedWithSpinning", false)
	end
end
