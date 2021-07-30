SetDiscordAppId(cfg.DiscordAppID)

Citizen.CreateThread(function()
	while true do
		SetDiscordRichPresenceAsset(cfg.discordImageName) 
		SetDiscordRichPresenceAssetText(cfg.hoverText) 
		SetDiscordRichPresenceAssetSmall(cfg.smallDiscordImageName) 
		SetRichPresence(cfg.richPresenceText) 
		SetDiscordRichPresenceAction(0, cfg.button1.text, cfg.button1.url)
		Wait(5000)
	end
end)