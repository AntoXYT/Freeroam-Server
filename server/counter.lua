RegisterServerEvent("freeroam:GetAllPlayer")
AddEventHandler("freeroam:GetAllPlayer", function()
    TriggerClientEvent("freeroam:Callback", source, GetPlayers())
end)