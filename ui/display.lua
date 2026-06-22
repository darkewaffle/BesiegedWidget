local Widget = 0

function CreateWidget()
	local WidgetSettings = PLAYER_SETTINGS.ui
	Widget = WINDOWER_TEXTS.new("Besieged Widget", WidgetSettings)
	HideWidget()
	UpdateWidget()
end

function UpdateWidget()
	local Mamool, Troll, Undead = GetBesiegedLevels()
	local WidgetText = ""

	if PLAYER_SETTINGS.ui.highest then
		local MaxLevel = math.max(Mamool, Troll, Undead)
		WidgetText = string.format("%2s", MaxLevel)
	else
		local Separator = "\n"
		if PLAYER_SETTINGS.ui.horizontal then
			Separator = "  "
		end

		WidgetText = string.format("%2s" .. Separator ..  "%2s" .. Separator .. "%2s", Mamool, Troll, Undead)
	end

	Widget:text(WidgetText)
end

function HideWidget()
	Widget:visible(false)
end

function ShowWidget()
	Widget:visible(true)
end