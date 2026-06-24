_addon.name = "BesiegedWidget"
_addon.version = "0.9.1"
_addon.author = "darkwaffle"
_addon.command = "bwi"

WINDOWER_PACKETS = require "packets"
WINDOWER_TEXTS = require "texts"
require "pack"

require "mapping/zones"
require "notify/notify"
require "schedule/region_update"
require "ui/display"
PLAYER_SETTINGS = require "settings"

local RegisteredEventIDs = {}
local MamoolJaLevel = 0
local TrollLevel = 0
local UndeadLevel = 0
local MaxLevelLastUpdate = 0

function OnLoad()
	table.insert(RegisteredEventIDs, windower.register_event('unload', OnUnload))
	table.insert(RegisteredEventIDs, windower.register_event('logout', OnLogout))
	table.insert(RegisteredEventIDs, windower.register_event('zone change', OnZone))
	table.insert(RegisteredEventIDs, windower.register_event('incoming chunk', OnChunkIn))
	table.insert(RegisteredEventIDs, windower.register_event('addon command', OnCommand))
	CreateWidget()

	if GetZoneRegionUpdates(windower.ffxi.get_info().zone) then
		ShowWidget()
		EnableRegionUpdates()
	end

	InitiateRegionUpdates()
end

function OnUnload()
	for _, ID in ipairs(RegisteredEventIDs) do
		windower.unregister_event(ID)
	end
end

function OnLogout()
	HideWidget()
	DisableRegionUpdates()
end

function OnZone(new_id, old_id)
	if GetZoneRegionUpdates(new_id) then
		ShowWidget()
		EnableRegionUpdates()
	else
		HideWidget()
		DisableRegionUpdates()
	end
end

function OnChunkIn(id, original, modified, injected, blocked)
	-- Conquest/Besieged Update
	if id == 0x05E then
		local Mamool = original:unpack("b4", 161, 5)
		local Troll = original:unpack("b4", 162)
		local Undead = original:unpack("b4", 162, 5)
		SetBesiegedLevels(Mamool, Troll, Undead)
		UpdateWidget()
		SetLastRegionUpdate()

	-- Zone change starting
	elseif id == 0x00B then
		DisableRegionUpdates()
	end
end

function OnCommand(...)
	local CommandParameters = {...}

	if CommandParameters[1] == "show" then
		ShowWidget()
	elseif CommandParameters[1] == "hide" then
		HideWidget()
	end
end

function GetBesiegedLevels()
	return MamoolJaLevel, TrollLevel, UndeadLevel
end

function SetBesiegedLevels(Mamool, Troll, Undead)
	local CurrentMax = math.max(Mamool, Troll, Undead)
	if CurrentMax ~= MaxLevelLastUpdate then
		SendNotify(CurrentMax)
	end

	MaxLevelLastUpdate = CurrentMax
	MamoolJaLevel = Mamool
	TrollLevel = Troll
	UndeadLevel = Undead
end

OnLoad()