local kickThreshold = 0.99        -- Anything equal to or higher than this value will be kicked. (0.99 Recommended as Lowest)
local kickReason = 'Stai utilizzando una vpn!'
local flags = 'm'				  -- Quickest and most accurate check. Checks IP blacklist.
local printFailed = true


------- DO NOT EDIT BELOW THIS LINE -------
function splitString(inputstr, sep)
	local t= {}; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
	if GetNumPlayerIndices() < GetConvarInt('sv_maxclients', 32) then
		deferrals.defer()
		deferrals.update("Freeroam. Controllando le informazioni.")
		playerIP = GetPlayerEP(source)
		if string.match(playerIP, ":") then
			playerIP = splitString(playerIP, ":")[1]
		end
		if IsPlayerAceAllowed(source, "blockVPN.bypass") then
			deferrals.done()
		else 
			PerformHttpRequest('http://check.getipintel.net/check.php?ip=' .. playerIP .. '&flags=' .. flags, function(statusCode, response, headers)
				if response then
					if tonumber(response) == -5 then
						print('[BlockVPN][ERROR]Errore!)')
					elseif tonumber(response) == -6 then
						print('[BlockVPN][ERROR]Errore')
					elseif tonumber(response) == -4 then
						print('[BlockVPN][ERROR] Errore!.')
					else
						if tonumber(response) >= kickThreshold then
							deferrals.done(kickReason)
							if printFailed then
								print('[BlockVPN][BLOCKED] ' .. playerName .. ' è stato impedito di unirsi con un valore di ' .. tonumber(response))
							end
						else 
							deferrals.done()
						end
					end
				end
			end)
		end
	end
end)