_addon.name = "BesiegedWidget"
_addon.version = "0.9.1"
_addon.author = "darkwaffle"
_addon.command = "bwi"

WINDOWER_PACKETS = require "packets"
WINDOWER_TEXTS = require "texts"
require "pack"

require "mapping/zones"
require "notify/notify"
require "ui/display"
PLAYER_SETTINGS = require "settings"

local RegisteredEventIDs = {}
local MamoolJaLevel = 0
local TrollLevel = 0
local UndeadLevel = 0
local MaxLevelLastUpdate = 0
local RegionInfoInterval = 600
local GetRegionCoroutine = 0

function OnLoad()
	table.insert(RegisteredEventIDs, windower.register_event('unload', OnUnload))
	table.insert(RegisteredEventIDs, windower.register_event('logout', OnLogout))
	table.insert(RegisteredEventIDs, windower.register_event('zone change', OnZone))
	table.insert(RegisteredEventIDs, windower.register_event('incoming chunk', OnChunkIn))
	table.insert(RegisteredEventIDs, windower.register_event('addon command', OnCommand))
	CreateWidget()

	if windower.ffxi.get_info() and GetZoneRegionUpdates(windower.ffxi.get_info().zone) then
		ShowWidget()
		ScheduleGetRegionInfo()
	end
end

function OnUnload()
	StopGetRegionInfo()
	for _, ID in ipairs(RegisteredEventIDs) do
		windower.unregister_event(ID)
	end
end

function OnLogout()
	StopGetRegionInfo()
	HideWidget()
end

function OnZone(new_id, old_id)
	if GetZoneRegionUpdates(new_id) then
		ShowWidget()
		ScheduleGetRegionInfo()
	else
		HideWidget()
		StopGetRegionInfo()
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

	-- Zone change starting
	elseif id == 0x00B then
		StopGetRegionInfo()
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

function GetRegionInfo()
	local RegionPacket = WINDOWER_PACKETS.new('outgoing', 0x05A)
	WINDOWER_PACKETS.inject(RegionPacket)
	ScheduleGetRegionInfo()
	--windower.add_to_chat(1, "Update request sent on " .. os.date("%X", os.time()))
end

function ScheduleGetRegionInfo()
	GetRegionCoroutine = coroutine.schedule(GetRegionInfo, RegionInfoInterval)
end

function StopGetRegionInfo()
	if type(GetRegionCoroutine) == "thread" then
		coroutine.close(GetRegionCoroutine)
	end
	GetRegionCoroutine = 0
end

function GetBesiegedLevels()
	return MamoolJaLevel, TrollLevel, UndeadLevel
end

function SetBesiegedLevels(Mamool, Troll, Undead)
	if MamoolJaLevel ~= Mamool or TrollLevel ~= Troll or UndeadLevel ~= Undead then
		local CurrentMax = math.max(Mamool, Troll, Undead)
		if CurrentMax ~= MaxLevelLastUpdate then
			SendNotify(CurrentMax)
		end
	end

	MaxLevelLastUpdate = CurrentMax
	MamoolJaLevel = Mamool
	TrollLevel = Troll
	UndeadLevel = Undead
end

OnLoad()