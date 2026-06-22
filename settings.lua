local PlayerSettings = {}
PlayerSettings.notify = {}
PlayerSettings.ui = {}
PlayerSettings.ui.pos = {}
PlayerSettings.ui.bg = {}
PlayerSettings.ui.flags = {}
PlayerSettings.ui.text = {}
PlayerSettings.ui.text.fonts = {}
PlayerSettings.ui.text.stroke = {}

	-- Settings to control the appearance of the widget
	PlayerSettings.ui.pos.x = 0
	PlayerSettings.ui.pos.y = 0

	PlayerSettings.ui.bg.alpha   = 0
	PlayerSettings.ui.bg.red     = 0
	PlayerSettings.ui.bg.green   = 0
	PlayerSettings.ui.bg.blue    = 0
	PlayerSettings.ui.bg.visible = false

	PlayerSettings.ui.flags.right     = true
	PlayerSettings.ui.flags.bottom    = false
	PlayerSettings.ui.flags.bold      = false
	PlayerSettings.ui.flags.draggable = false
	PlayerSettings.ui.flags.italic    = false

	PlayerSettings.ui.padding = 1

	PlayerSettings.ui.text.size  = 11
	PlayerSettings.ui.text.font  = 'Consolas'
	PlayerSettings.ui.text.alpha = 192
	PlayerSettings.ui.text.red   = 192
	PlayerSettings.ui.text.green = 192
	PlayerSettings.ui.text.blue  = 192

	PlayerSettings.ui.text.stroke.width = 1
	PlayerSettings.ui.text.stroke.alpha = 192
	PlayerSettings.ui.text.stroke.red   = 0
	PlayerSettings.ui.text.stroke.green = 0
	PlayerSettings.ui.text.stroke.blue  = 0

	-- Only displays the highest current besieged level rather than all three
	PlayerSettings.ui.highest = false
	-- Displays the levels in a horizontal line rather than vertical column
	PlayerSettings.ui.horizontal = false

	-- Enables a message in the chat log when the besieged level changes
	PlayerSettings.notify.chat = true
	-- Plays a sound effect when the besieged level reaches a level >= 8
	PlayerSettings.notify.sound = true

return PlayerSettings