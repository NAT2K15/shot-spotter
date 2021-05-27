local active_leos = {}
local on = false;

RegisterCommand("duty", function(source, args, message) 
    local player = {src = source, name = GetPlayerName(source)}
    local status = args[1];
    if(status == nil) then return end;
    status = status:lower()
    if(notconfig.enableaceperms == true) then
        if IsPlayerAceAllowed(source, notconfig.aceperms) then
            if(status == "on") then
                if(active_leos[source]) then
                    TriggerClientEvent('chatMessage', source, "[^3Dispatch^0] Your blips are already enabled!")
                else 
                    active_leos[player.src] = player;
                    TriggerClientEvent('chatMessage', source, "[^3Dispatch^0] You have enabled LEO blips!")
                end
            elseif(status == "off") then
                if not active_leos[source] then
                    TriggerClientEvent('chatMessage', source, "[^3Dispatch^0] Your blips are already disabled!")
                else 
                    active_leos[source] = nil
                    TriggerClientEvent('chatMessage', source, "[^3Dispatch^0] You have disabled LEO blips!")
                end
            else 
                TriggerClientEvent('chatMessage', source, "^1 Invaild Args")
            end
        else 
            TriggerClientEvent('chatMessage', source, "^1 Access Denied")
        end
    else 
        local check = false;
        for src, role in ipairs(notconfig.perms) do
            local perms_check = IsRolePresent(source, role)
            if(perms_check == true) then
                check = true;
            end
        end
        Citizen.Wait(1)
        if(check == true) then
            if(status == "on") then
                if(active_leos[source]) then
                    TriggerClientEvent('chatMessage', source, "[^3Dispatch^0] Your blips are already enabled!")
                else 
                    active_leos[player.src] = player;
                    TriggerClientEvent('chatMessage', source, "[^3Dispatch^0] You have enabled LEO blips!")
                end
            elseif(status == "off") then
                if not active_leos[source] then
                    TriggerClientEvent('chatMessage', source, "[^3Dispatch^0] Your blips are already disabled!")
                else 
                    active_leos[source] = nil
                    TriggerClientEvent('chatMessage', source, "[^3Dispatch^0] You have disabled LEO blips!")
                end
            else 
                TriggerClientEvent('chatMessage', source, "^1 Invaild Args")
            end
        else 
            TriggerClientEvent('chatMessage', source, "^1 Access Denied")
        end
    end
end)

RegisterNetEvent("REDRUMDDIDNOTMAKETHIS_S")
AddEventHandler("REDRUMDDIDNOTMAKETHIS_S", function(serverid, street1, street2, x, y, z) 
    if not active_leos[serverid] then
    if(on == true) then return end;
        on = true;
        Citizen.Wait(notconfig.shotspotter_timer)
        Citizen.Wait(2)
        for _, player in ipairs(GetPlayers()) do
            player = tonumber(player)
            if(active_leos[player]) then
                if(notconfig.usechat == false) then
                    local fix = "~b~[DISPATCH]~w~ Gunshots detacted near " .. street1 .. " " .. street2
                    TriggerClientEvent('BETTERTHANREDRUMS-NOTIFY', player, fix)
                else 
                    TriggerClientEvent("chatMessage", player, "^2[DISPATCH]", {255,255,255}, " ^7We have received a 911 call about an active shooter in " ..street1.. " " ..street2)
                end            
                TriggerClientEvent("REDRUMDDIDNOTMAKETHIS_C", player, street1, street2, x, y, z)
            end
        end
        turnoff()
   end
end)


function turnoff() 
    Citizen.Wait(notconfig.wait_time_before_next_blip)
    on = false;
end