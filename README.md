# BesiegedWidget

## Notice: If you downloaded release 0.9.1 please update to at least 0.9.2 to avoid a potential crash.

Example of [default widget settings](https://i.imgur.com/ymPmM9x.png)

## How To
1. Download besiegedwidget.lua, settings.lua and each folder. besiegedwidget.lua and the folders can be found in the zip file under [Releases](https://github.com/darkewaffle/BesiegedWidget/releases). You only need to download the settings file if you do not already have one - although it could change over time if new settings are supported.
2. Place them in Windower\addons\BesiegedWidget.
3. Modify settings.lua to your liking.
4. If you are so inclined you can overwrite the .wav files in the notify folder so that your own custom sounds play to announce higher besieged levels.
5. "lua l besiegedwidget" in game to initialize the addon.

## Description
BesiegedWidget is a simple UI addition that will display the current besieged levels without needing to manually open Region Info. It will update this information anytime new Region Info is received by the client - this occurs every time you zone or when you open Region Info (but you can only receive new data from the server approximately every two minutes). Additionally anytime you are in a non-instanced 'real world' zone BesiegedWidget will automatically send a packet to request new Region Info every ten minutes.

BesiegedWidget will also provide notifications when the highest current besieged level changes. These can be messages in your chat log that will occur every time the level changes or sound effects that are played anytime the highest level becomes >= 8. Both types of notifications can be disabled in the settings if you prefer.

BesiegedWidget does inject one packet in order to request new Region Info. This is only done once every 10 minutes and will only occur in non-instanced 'real world' zones based off of the RegionUpdates value in mapping/zones.lua.

## Commands
| Command | Usage |
| --- | --- |
| bwi show | Show the widget if hidden. |
| bwi hide | Hide the widget if visible. |
| bwi debug | Enable debug messages in the chat log to report when Region Info is recieved, requested and how long the request loop is asleep (time to next run). |

- - - -

Drum sound effects used for notifications

'Small' level 8-9 = African Drum4.WAV by eyenorth -- https://freesound.org/s/460084/ -- License: Attribution 4.0

'Medium' level 10-11 = Doumbek_Doum3.wav by pjcohen -- https://freesound.org/s/413805/ -- License: Attribution 4.0

'Big' level 12-13 = djembe_roll2.wav by Infinita08 -- https://freesound.org/s/460977/ -- License: Creative Commons 0