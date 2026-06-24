local AllowRegionUpdates = false
local LastRegionUpdate = os.time()
local RegionInfoInterval = 600

function InitiateRegionUpdates()
	GetRegionUpdates()
end

function GetRegionUpdates()
	while true do

		local SleepDuration = RegionInfoInterval
		
		if GetTimeSinceLastRegionUpdate() < RegionInfoInterval then
			SleepDuration = RegionInfoInterval - GetTimeSinceLastRegionUpdate()
		else
			if AllowRegionUpdates and GetZoneRegionUpdates(windower.ffxi.get_info().zone) then
				local RegionPacket = WINDOWER_PACKETS.new('outgoing', 0x05A)
				WINDOWER_PACKETS.inject(RegionPacket)
				--windower.add_to_chat(1, "BWI region update request sent " .. os.date("%X", os.time()))
			end
		end

		--windower.add_to_chat(1, "GetRegionUpdate completed at " .. os.date("%X", os.time()))
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
	--windower.add_to_chat(1, "BWI region update received " .. os.date("%X", LastRegionUpdate))
end

function GetTimeSinceLastRegionUpdate()
	return os.time() - LastRegionUpdate
end