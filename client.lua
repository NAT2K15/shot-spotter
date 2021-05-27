local weapons = { "WEAPON_UNARMED", "WEAPON_STUNGUN", "WEAPON_KNIFE", "WEAPON_KNUCKLE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", "WEAPON_BAT", "WEAPON_GOLFCLUB", "WEAPON_CROWBAR", "WEAPON_BOTTLE", "WEAPON_DAGGER", "WEAPON_HATCHET", "WEAPON_MACHETE", "WEAPON_FLASHLIGHT", "WEAPON_SWITCHBLADE", "WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN", "WEAPON_SNOWBALL", "WEAPON_FLARE", "WEAPON_BALL"}


Citizen.CreateThread(function() 
    while true do 
        Citizen.Wait(10)
        local ped = GetPlayerPed(-1)
        local shottingped = IsPedShooting(ped)
        local blacklistweapon = false;
        x,y,z = table.unpack(GetEntityCoords(ped))
        x = tonumber(x)
        y = tonumber(y)
        z = tonumber(z)
        for i, v in ipairs(weapons) do
            if GetSelectedPedWeapon(ped) == GetHashKey(v) then
                blacklistedweapons = true;
            end
        end
        if shottingped and not blacklistedweapons then
            local silence = IsPedCurrentWeaponSilenced(ped)
            if not silence then
                local serverid = GetPlayerServerId(PlayerId())
                local hash1, hash2 = GetStreetNameAtCoord(x, y, z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
                local street1 = GetStreetNameFromHashKey(hash1)
                local street2 = GetStreetNameFromHashKey(hash2)
                TriggerServerEvent("REDRUMDDIDNOTMAKETHIS_S", serverid, street1, street2, x, y, z)
            end
        end
    end
end)



RegisterNetEvent("REDRUMDDIDNOTMAKETHIS_C")
AddEventHandler("REDRUMDDIDNOTMAKETHIS_C", function(street1, street2, x, y, z) 
    local blip = AddBlipForRadius(x, y, z, 100.0);
    SetBlipColour(blip, 40)
    SetBlipAlpha(blip, 80)
    SetBlipSprite(blip, 9)
    blipActive = true
    if(blipActive == true) then 
        Citizen.Wait(60000)
        RemoveBlip(blip)
        blipActive =  false;
        activeshooting = false;
    end
end)

RegisterNetEvent("BETTERTHANREDRUMS-NOTIFY")
AddEventHandler('BETTERTHANREDRUMS-NOTIFY', function(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, true)
end)
  