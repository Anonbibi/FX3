local WeedRecoltesRayon = 0.7
local Weeds = {}

DecorRegister('illegal_lastBuyWeed', 3)

Weeds.recoltes = {
    { pos = {x = 2215.85, y = 5575.36, z = 53.69}, time = 0},
    { pos = {x = 2216.24, y = 5577.55, z = 53.78}, time = 0},
    { pos = {x = 2218.19, y = 5575.20, z = 53.70}, time = 0},
    { pos = {x = 2221.00, y = 5575.00, z = 53.71}, time = 0},
    { pos = {x = 2222.70, y = 5574.80, z = 53.73}, time = 0},
    { pos = {x = 2227.30, y = 5574.60, z = 53.79}, time = 0},
    { pos = {x = 2230.70, y = 5574.40, z = 53.90}, time = 0},
    { pos = {x = 2232.43, y = 5576.30, z = 53.97}, time = 0},
    { pos = {x = 2230.22, y = 5576.55, z = 53.93}, time = 0},
    { pos = {x = 2227.74, y = 5576.66, z = 53.86}, time = 0},
    { pos = {x = 2225.44, y = 5576.90, z = 53.85}, time = 0},
    { pos = {x = 2223.05, y = 5577.12, z = 53.83}, time = 0},
    { pos = {x = 2220.60, y = 5577.06, z = 53.83}, time = 0},
    { pos = {x = 2218.60, y = 5577.26, z = 53.85}, time = 0},
    { pos = {x = 2219.00, y = 5579.42, z = 53.89}, time = 0},
    { pos = {x = 2223.80, y = 5579.30, z = 53.91}, time = 0},
    { pos = {x = 2225.40, y = 5578.94, z = 53.88}, time = 0},
    { pos = {x = 2230.15, y = 5579.00, z = 53.97}, time = 0},
    { pos = {x = 2233.90, y = 5578.70, z = 54.11}, time = 0}
}
Weeds.tranformCoord = {x = 3726.72290039063, y = 4539.39208984375, z = 22.0390720367432}
Weeds.tranformRayon = 10.0
Weeds.tranformTime = 4000
Weeds.FullVenteCoord = { x = -1175.94, y = -1547.63, z = 17.33}
Weeds.VenteUnityCenter = {x = -2200.0, y= -1700.0, z = 0.0}
Weeds.VenteUnityRayon = 1070.0
Weeds.passNbTry = 0
Weeds.inRayon = false

Weeds.Text = {
    NoPlant = '~o~Aucune plante',
    RecolteKo = '~o~La pouse n\'est pas encore à maturité',
    RecoltePremature = '~b~Récolte prémature possible',
    RecolteOk = '~g~Prête à être récolter',
    ActionRecolte = '~INPUT_PICKUP~ Recolter',
    ActionPanter = '~INPUT_PICKUP~ Planter une graine',
    ActionInteraction = '~INPUT_PICKUP~ Interagir',
    TransformEncours = '~b~Transformation du cannabis en cours',
    TransformOk = '+1 ~o~Joins',
    NoPassword = '...',
    PasswordKo = '~r~C\'est pas le bon mot de passe, Dégage !',
    PasswordOld  = '~b~C\'est l\'ancien mot de passe çà !',
    PasswordCorrect = '~g~Je t\'achète tous à ~w~100$ ~g~unité pour un total de ~r~',
    GoodPlaceToSell = '~o~Sa semble un bon emplacement pour ventre des joins, trouve des clients',
    PasswordSend = "Pres de ~b~la boutique~w~, quelqu'un achète en masse.\n~o~Mot de passe: ~r~",
    Buy2 = '~g~Je te prend deux ~b~joins~w~ pour ~o~',
    Buy1 = '~b~Je te prend un ~b~join~w~ pour ~o~',
    Buy0 = '~o~Garde ta merde, j\'en veux pas',
    DejaPropo = '~d~Encore ?, Va voir ailleur, j\'ai déjà ce qu\'il me faut~',
    RecolteEncours = '~b~Récolte en cours',
    PlantationEncours = '~b~Plantation en cours',
}

local myPed
local myPos

Weeds.recolte = function(id)
    TriggerServerEvent('illegal:recoltWeed', id)
end


Weeds.planteSeed = function(id)
    TriggerServerEvent('illegal:PlanteSeed', id)
    showMessageInformation(Weeds.Text.PlantationEncours, 20000)
    PlayEmote('WORLD_HUMAN_GARDENER_PLANT', 20000)
    Citizen.Wait(20000 + 6000)
end

Weeds.systemGrowth = function (id, seed)
    if seed.time == 0 then
        showMessageInformation(Weeds.Text.NoPlant)
        showActionInfo(Weeds.Text.ActionPanter)
        if IsControlJustPressed(1, 38) then
            Weeds.planteSeed(id)
        end
    else
        local d = math.floor((getTime()-seed.time) / WeedGrowthTime * 10000) / 100
        if d < 50 then
            showMessageInformation(Weeds.Text.RecolteKo .. ' ~d~ (' .. d .. '%)') 
        else
            if d >= 100 then
                showMessageInformation(Weeds.Text.RecolteOk .. '~f~ 7') 
            elseif d >= 90 then
                showMessageInformation(Weeds.Text.RecoltePremature .. '~w~ (4-5) ~d~ [' .. d .. '%]')
            elseif d >= 80 then
                showMessageInformation(Weeds.Text.RecoltePremature .. '~w~ (3-4) ~d~ [' .. d .. '%]')
            elseif d >= 70 then
                showMessageInformation(Weeds.Text.RecoltePremature .. '~w~ (2-3) ~d~ [' .. d .. '%]')
            elseif d >= 60 then
                showMessageInformation(Weeds.Text.RecoltePremature .. '~w~ (1-3) ~d~ [' .. d .. '%]') 
            elseif d >= 50 then
                showMessageInformation(Weeds.Text.RecoltePremature .. '~w~ (1-2) ~d~ [' .. d .. '%]') 
            end
            showActionInfo(Weeds.Text.ActionRecolte)
            if IsControlJustPressed(1, 38) then
                Weeds.recolte(id,2)
            end
        end
    end
end

Weeds.checkRecoltes = function ()
    local myPed = GetPlayerPed(-1)
    local myPos = GetEntityCoords(myPed)
    for id, seed in pairs(Weeds.recoltes) do 
        local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, seed.pos.x, seed.pos.y, seed.pos.z, false)
        if dist < 0.7 then
            Weeds.systemGrowth(id,seed)
            break
        end
    end

end

Weeds.checkTranform = function ()
    local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, Weeds.tranformCoord.x, Weeds.tranformCoord.y, Weeds.tranformCoord.z, false)
        
    if dist <= Weeds.tranformRayon then
        --Citizen.Trace('tranform' .. dist)
        if exports.vdk_inventory:getQuantity(WeedItemId) > 0 then
            showMessageInformation(Weeds.Text.TransformEncours,Weeds.tranformTime)
            Citizen.Wait(Weeds.tranformTime  - 800)
            showMessageInformation(Weeds.Text.TransformOk)
            Citizen.Wait(800)
            TriggerEvent("player:looseItem", WeedItemId, 1)
            TriggerEvent("player:receiveItem", JoinItemId, 1)
        end
    end
end

Weeds.tryFullVente = function ()
    local pw = openTextInput('', 'Mot de passe', 22)
    --Citizen.Trace('pw ' .. pw )
    if pw == nil or pw == '' or pw == 'Mot de passe' then
        showActionInfo(Weeds.Text.NoPassword)
    else
        local qte = exports.vdk_inventory:getQuantity(JoinItemId)
        TriggerServerEvent('illegal:weedTryPassowrd', pw, qte)
    end
end

Weeds.checkFullVente = function()
    local totalItem = exports.vdk_inventory:getQuantity(JoinItemId)
    if totalItem == 0 then
        return
    end
    local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z,Weeds.FullVenteCoord.x, Weeds.FullVenteCoord.y, Weeds.FullVenteCoord.z, true)
    local dist2 = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z,Weeds.VenteUnityCenter.x, Weeds.VenteUnityCenter.y, Weeds.VenteUnityCenter.z, false)
    if dist <= 2.0 then
        showActionInfo(Weeds.Text.ActionInteraction)
        if IsControlJustPressed(1, 38) then
            Weeds.tryFullVente()
        end
    elseif dist2 <= Weeds.VenteUnityRayon then
        if Weeds.inRayon == false then
            showMessageInformation(Weeds.Text.GoodPlaceToSell, 8000)
            Weeds.inRayon = true 
        end
        if IsControlJustPressed(1, 38) then 
            --local ped = 0
            --Citizen.InvokeNative(0xC33AB876A77F8164, myPos.x, myPos.y, myPos.z, 5.0, 1,0, Citizen.PointerValueInt(ped),1,0, -1)
            --local ped = GetRandomPedAtCoord(myPos.x, myPos.y, myPos.z, 1.0, 1.0, 1.0, 26, _r)
            local ped = GetRandomPedAtCoord(myPos.x, myPos.y, myPos.z, 3.0, 3.0, 3.0, 26)
           -- local ped = GetRandomPedAtCoord(myPos.x, myPos.y, myPos.z, 3.0, 3.0, 3.0, -1)
            if ped ~= 0 then
                local lastBuy = DecorGetInt(ped, 'illegal_lastBuyWeed')
                if lastBuy == 0 or lastBuy + PNJ_TIME_SELL < getTime() then
                    local r = math.random() 
                    if r > 0.995 then -- 0.995
                       TriggerServerEvent('illegal:needPassword')
                    elseif r > 0.9 and totalItem > 2 then
                        local total = math.random(JoinVenteUnite[1], JoinVenteUnite[2])
                        TriggerEvent("player:sellItemSale", JoinItemId, total)
                        TriggerEvent("player:sellItemSale", JoinItemId, total)
                        showMessageInformation(Weeds.Text.Buy2 .. total*2 .. '$',3000)
                    elseif r > 0.67 then
                        local total = math.random(JoinVenteUnite[1], JoinVenteUnite[2])
                        showMessageInformation(Weeds.Text.Buy1 .. total .. '$', 3000)
                        TriggerEvent("player:sellItemSale", JoinItemId, total)
                    else
                        showMessageInformation(Weeds.Text.Buy0,3000)
                    end
                    DecorSetInt(ped, 'illegal_lastBuyWeed', getTime())
                    SetPedIsDrunk(ped,true)
                else
                    showMessageInformation(Weeds.Text.DejaPropo,3000)
                end
            -- else
            --     showMessageInformation("DEBUG notfound")
            end
        end
    else
        Weeds.inRayon = false
    end
end



Weeds.drawDebug = function ()
    for _, k in pairs(Weeds.recoltes) do 
        ShowVerticalLineAtPos(k.pos) 
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        myPed = GetPlayerPed(-1)
        myPos = GetEntityCoords(myPed)
        Weeds.checkRecoltes()
        Weeds.checkTranform()
        Weeds.checkFullVente()
        --Weeds.drawDebug()
    end
end)



--=============================================================================
--  Event
--=============================================================================
RegisterNetEvent('illegal:setFullPlantData')
AddEventHandler('illegal:setFullPlantData',function(data)
    for i, t in pairs(data) do
        Weeds.recoltes[i].time = t
    end
end)

RegisterNetEvent('illegal:seedChange')
AddEventHandler('illegal:seedChange',function(id, time)
    Weeds.recoltes[id].time = time
end)

RegisterNetEvent('illegal:recoltWeed')
AddEventHandler('illegal:recoltWeed',function(qte)
    TriggerEvent('player:receiveItem',WeedItemId, qte) 
    showMessageInformation(Weeds.Text.RecolteEncours, 20000)
    PlayEmote('WORLD_HUMAN_GARDENER_PLANT', 20000)
    Citizen.Wait(20000 + 6000)
end)

RegisterNetEvent('illegal:fullVente')
AddEventHandler('illegal:fullVente', function( sta, qte)
    if sta == 0 then
        showMessageInformation(Weeds.Text.PasswordOld,8000)
    elseif sta == 1 then
        local total = qte * JoinVenteFull
        showMessageInformation(Weeds.Text.PasswordCorrect .. total .. '$', 8000)
        TriggerEvent("player:looseItem", JoinItemId, qte)
    else
        showMessageInformation(Weeds.Text.PasswordKo, 8000)
        Weeds.passNbTry = Weeds.passNbTry + 1 
    end
end)


RegisterNetEvent('illegal:password')
AddEventHandler('illegal:password', function(password)
    showMessageInformation(Weeds.Text.PasswordSend .. password, 30000)
    Citizen.Wait(15000)
end)


--=============================================================================
--  Initialisation
--=============================================================================
TriggerServerEvent('illegal:requestFullPlantData')


--=============================================================================
--  DEBUG
--=============================================================================
-- TriggerEvent("player:receiveItem", JoinItemId, 9)

-- --SetEntityCoords(GetPlayerPed(-1),2215.854, 5575.367,53.690)
-- --SetEntityCoords(GetPlayerPed(-1),-35.7672, 346.133,  113.915)
-- --SetEntityCoords(GetPlayerPed(-1),-1165.11,-1566.41,4.54)


-- local myPed = GetPlayerPed(-1)
-- local myCoord = GetEntityCoords(myPed)
-- Citizen.Trace('Pos init: ' .. myCoord.x .. ', ' .. myCoord.y .. ', ' .. myCoord.z)
-- -- ClearPedSecondaryTask(myPed)
-- -- ClearPedTask(myPed)
-- --PlayEmote('WORLD_HUMAN_GARDENER_PLANT', 20000)


-- Citizen.CreateThread( function () 
-- while true do
--     Citizen.Wait(0)
--      DrawMarker(1, Weeds.VenteUnityCenter.x, Weeds.VenteUnityCenter.y, Weeds.VenteUnityCenter.z - 1.0, 0, 0, 0, 0, 0, 0, Weeds.VenteUnityRayon*2, Weeds.VenteUnityRayon*2, 200.0, 0, 0, 255, 200, 0, 0, 0, 0)

-- end
   
-- end)