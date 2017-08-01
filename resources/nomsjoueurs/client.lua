Citizen.CreateThread(function()
    while true do
        for i=0,99 do
            N_0x31698aa80e0223f8(i)
        end
        for i=0,32 do
            if(NetworkIsPlayerActive(i) and GetPlayerPed(i)) then        
                local ped = GetPlayerPed(i)  
                local Blip = GetBlipFromEntity(ped)
                if DoesBlipExist(Blip) then
                    SetThisScriptCanRemoveBlipsCreatedByAnyScript(true)
                    SetBlipScale(Blip,0.0)
                end    
            end
        end
        Citizen.Wait(0)
    end
end)