AddEventHandler('playerConnecting', function(name, setKickReason, deferrals, playerId)
    local source = source
    local identifiers = GetPlayerIdentifiers(source)
    local identifier
    local playername =  GetPlayerName(source)


    for k, v in ipairs(identifiers) do 
        if string.match(v, 'steam:') then
            identifier = v
            break
        end
    end

    if not identifier then
        deferrals.done('Hai bisogno di steam aperto!')
    else
        deferrals.done()
        exports.ghmattimysql:scalar('SELECT 1 FROM users WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(result)
            if not result then
                exports.ghmattimysql:execute('INSERT INTO users (identifier, nomesteam) VALUES (@identifier, @nomesteam)', {
                    ['@identifier'] = identifier,
                    ['@nomesteam'] = playername 
                })
            end
        end)
      end
end)

PerformHttpRequest('https://raw.githubusercontent.com/AntoXYT/freeroam-version/main/fxmanifest.lua', function (errorCode, result, headers)
    local version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)

    if string.find(tostring(result), version) == nil then
        print('^1[Freeroam]^1 versione non aggiornata! ')
        print('^7[Freeroam]^7 ^2Gamemode Freeroam avviata!.^7')
        print('[Freeroam-Discord] https://discord.gg/mcgTsSu9')
    else
        print('^3[Freeroam]^3 ^2Complimenti, non hai bisogno di aggiornare la gm!^7')
        print('^3[Freeroam]^3 ^2Gamemode Freeroam avviata!.^7')
        print('[Freeroam-Discord] https://discord.gg/mcgTsSu9')
    end
end, 'GET', '', '')
