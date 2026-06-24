local AllowRegionUpdates = false
local LastRegionUpdate = os.time()
local RegionInfoInterval = 599

function InitiateRegionUpdates()
	GetRegionUpdates()
end

function GetRegionUpdates()
	while true do

		-- +1 to account for the latency on receiving the region update
		-- this just means that the it won't sleep for 9m59s, check time, sleep for 1s, activate, sleep for 9m59s and repeat
		-- it should just sleep for 10m, activate, repeat
		local SleepDuration = RegionInfoInterval + 1
		
		if GetTimeSinceLastRegionUpdate() < RegionInfoInterval then
			SleepDuration = RegionInfoInterval - GetTimeSinceLastRegionUpdate()
		else
			if AllowRegionUpdates and GetZoneRegionUpdates(windower.ffxi.get_info().zone) then
				local RegionPacket = WINDOWER_PACKETS.new('outgoing', 0x05A)
				WINDOWER_PACKETS.inject(RegionPacket)
				DebugMessage("Region update request packet sent")
			end
		end

		DebugMessage("Region update request sleeping for " .. os.date("%Mm%Ss", SleepDuration))
		coroutine.sleep(SleepDuration)
	end
end

function EnableRegionUpdates()
	AllowRegionUpdates = true
end

function DisableRegionUpdates()
	AllowRegionUpdates = false
end

function GetLastRegionUpdate()
	return LastRegionUpdate
end

function SetLastRegionUpdate()
	LastRegionUpdate = os.time()
end

function GetTimeSinceLastRegionUpdate()
	return os.time() - LastRegionUpdate
end