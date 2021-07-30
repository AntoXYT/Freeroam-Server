Freeroam = {}

  RegisterCommand("tpm", function(source)
    Freeroam.TPM()
end)

RegisterCommand("dv", function(source)
    Freeroam.Delete()
end)

 RegisterCommand('car', function(source, args, rawCommand)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
    local veh = args[1]
    if veh == nil then veh = "adder" end
    vehiclehash = GetHashKey(veh)
    RequestModel(vehiclehash)

    Citizen.CreateThread(function() 
        local waiting = 0
        while not HasModelLoaded(vehiclehash) do
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 5000 then
                Freeroam.Notify("~r~Non è stato possibile caricare il veicolo!.")
                break
            end
        end
        Freeroam.Notify("Il veicolo è stato spawnato!")
        CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
    end)
end)



RegisterCommand('c', function(source, args, rawCommand)
        Freeroam.Notify("~g~Curato")
        SetEntityHealth(GetPlayerPed(-1), 200)

end)



RegisterCommand('g', function(source, args, rawCommand)
        Freeroam.Notify("~b~Armatura applicata ")
        AddArmourToPed(GetPlayerPed(-1), 100)
end)


RegisterCommand('die', function(source, args, rawCommand)
    Freeroam.Notify("~b~sEI MORTO! ")
    SetEntityHealth(GetPlayerPed(-1), 0)
end)


