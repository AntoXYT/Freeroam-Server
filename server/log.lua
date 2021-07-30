function sendToDiscord (name,message,color)
  local DiscordWebHook = "https://discord.com/api/webhooks/827262760831287317/sniNdZKrfN8CKVua2UOsgZ_FYekq1oFko1PDkjjaP2GRNtdhwWxU1JNsST0xQqugRO3h"

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
        ["text"]= "AntoX",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

  sendToDiscord('Freeroam', 'Il Freeroam è online!' , 56108)



----------------------------------------------------------------- IP LOG----------------------------------------
local logs = "https://discord.com/api/webhooks/827274706067259422/ivWJJAFE28Nkvr-Lwhett_tUeQ2Oze9XjqQ8pMO5HeIeEQRjk9_teH70O-guvuAvtxlG"
local communityname = "Freeroam"
local communtiylogo = "https://i.imgur.com/716J5KY.jpg" 
AddEventHandler('playerConnecting', function()
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local ping = GetPlayerPing(source)
local steamhex = GetPlayerIdentifier(source)
local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "Entrate",
            ["description"] = "Player: **"..name.."**\nIP: **"..ip.."**\n Steam Hex: **"..steamhex.."**",
	        ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
            },
        }
    }

PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Freeroam Server Logger", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('playerDropped', function(reason)
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local ping = GetPlayerPing(source)
local steamhex = GetPlayerIdentifier(source)
local disconnect = {
        {
            ["color"] = "8663711",
            ["title"] = "Uscite",
            ["description"] = "Player: **"..name.."** \nReason: **"..reason.."**\nIP: **"..ip.."**\n Steam Hex: **"..steamhex.."**",
	        ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
            },
        }
    }

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Freeroam Server Logger", embeds = disconnect}), { ['Content-Type'] = 'application/json' })
end)