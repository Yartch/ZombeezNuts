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
	self.prayerResultButtons = {}
	for i, prayer in pairs(Prayers.Types) do

		local posX = (self.width / 2) - (buttonWidth / 2)

		self.prayerButtons[i] = ISButton:new(posX, y, buttonWidth, buttonHeight, prayer.name, self, ZombieJesusCrossUI.selectPrayer)
		self.prayerButtons[i]:initialise()
		self.prayerButtons[i]:setOnClick(ZombieJesusCrossUI.selectPrayer, i)
		self.prayerButtons[i]:setTooltip(prayer.tooltipText)
		self:addChild(self.prayerButtons[i]);

		y = y + buttonHeight + buttonSpacing

		if isDebugEnabled() then
			self.prayerResultButtons[i] = { }			
			for j, res in pairs(prayer.results) do
				local debugPosX = (self.width / 2) - (buttonWidth / 2)
				self.prayerResultButtons[i][j] = ISButton:new(debugPosX, y, debugButtonWidth, debugButtonHeight, j, self, ZombieJesusCrossUI.selectPrayerResult)
				self.prayerResultButtons[i][j]:initialise()
				self.prayerResultButtons[i][j]:setOnClick(ZombieJesusCrossUI.selectPrayerResult, i, j)
				self.prayerResultButtons[i][j]:setTooltip(res.resultText)
				self:addChild(self.prayerResultButtons[i][j]);
				y = y + debugButtonHeight
			end

			y = y + buttonSpacing
		end		
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

		self.debugItemFind = ISButton:new(itemX, y, debugButtonWidth, debugButtonHeight, "DEBUG TEST", self, ZombieJesusCrossUI.debugTest)
		self.debugItemFind:initialise()
		self:addChild(self.debugItemFind)

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

function ZombieJesusCrossUI:selectPrayerResult(caller, prayerName, resultName)
	local prayer = Prayers.Types[prayerName]
    local result = prayer.results[resultName]

	Client:showPrayerResult (result, getPlayer())
	result.action(getPlayer())

	self:setVisible(false)
end


function ZombieJesusCrossUI:debugTest()
	Util:healPlayerBodyParts(getPlayer(), 3, 20)
end