local NotifyRoot = windower.addon_path .. "notify/"
local NotifyBig = NotifyRoot .. "big.wav"
local NotifyMedium = NotifyRoot .. "medium.wav"
local NotifySmall = NotifyRoot .. "small.wav"

-- Numeric indexes in Lua start at 1 so this is actually Besieged Level +1
local NotifySoundLevelMap =
{
	[1] = NotifySmall,
	[2] = nil,
	[3] = nil,
	[4] = nil,
	[5] = nil,
	[6] = nil,
	[7] = nil,
	[8] = nil,
	[9] = NotifySmall,
	[10] = NotifySmall,
	[11] = NotifyMedium,
	[12] = NotifyMedium,
	[13] = NotifyBig,
	[14] = NotifyBig,
}

function SendNotify(Level)
	Level = Level or 0
	ChatNotify(Level)
	SoundNotify(Level)
end

function ChatNotify(Level)
	if PLAYER_SETTINGS.notify.chat then
		local ChatMessage = "- - - Besieged level has reached " .. Level .. " - - -"
		windower.add_to_chat(1, ChatMessage)
	end
end

function SoundNotify(Level)
	local NotifyFile = NotifySoundLevelMap[Level + 1]

	if PLAYER_SETTINGS.notify.sound and NotifyFile then
		windower.play_sound(NotifyFile)
	end
end