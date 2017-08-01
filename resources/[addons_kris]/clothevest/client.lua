--
-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 22/05/2017
-- Time: 07:59
-- To change this template use File | Settings | File Templates.
--


local clothingStores = {

    { x = 1397.83,      y = 1163.07,    z = 113.834,    markerWidth = 2.0001,  activationDist = 2 },
    { x = 129.955,      y = -608.563,   z = 205.547,     markerWidth = 2.0001,  activationDist = 2 }
    
}

RegisterNetEvent("clothevest:notifs")
AddEventHandler("clothevest:notifs", function(msg)
    notifs(msg)
end)
function notifs(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString( msg )
    DrawNotification(false, false)
end

local OUTFIT_LIST = {}
local GLASSES_LIST = {}
local HATS_LIST = {}
local DRESSING_LIST = {}
local DRESSING_GLASSES_LIST = {}
local DRESSING_HATS_LIST = {}

RegisterNetEvent('clothevest:setOutfitList')
AddEventHandler('clothevest:setOutfitList', function(list)
    OUTFIT_LIST = {}
    for k,outfit in ipairs(list) do
        OUTFIT_LIST[k] = outfit
    end
    SendNUIMessage({outfitsList = json.encode(OUTFIT_LIST)})
    SendNUIMessage({maxOutfits = #list})
end)

RegisterNetEvent('clothevest:setHatsList')
AddEventHandler('clothevest:setHatsList', function(list)
    HATS_LIST = {}
    HATS_LIST= list

    SendNUIMessage({hatsList = json.encode(HATS_LIST)})
end)


RegisterNetEvent('clothevest:setGlassesList')
AddEventHandler('clothevest:setGlassesList', function(list)
    GLASSES_LIST = {}
    GLASSES_LIST= list
    SendNUIMessage({glassesList = json.encode(GLASSES_LIST)})
end)

RegisterNetEvent('clothevest:setDressingList')
AddEventHandler('clothevest:setDressingList', function(list)
    DRESSING_LIST = {}
    for k,dress in ipairs(list) do
        DRESSING_LIST[k] = dress
    end
    SendNUIMessage({dressingList = json.encode(DRESSING_LIST)})
end)

RegisterNetEvent('clothevest:setDressingGlassesList')
AddEventHandler('clothevest:setDressingGlassesList', function(list)
    DRESSING_GLASSES_LIST = {}
    for k,prop in ipairs(list) do
        DRESSING_GLASSES_LIST[k] = prop
    end
    SendNUIMessage({dressingGlassesList = json.encode(DRESSING_GLASSES_LIST)})
end)

RegisterNetEvent('clothevest:setDressingHatsList')
AddEventHandler('clothevest:setDressingHatsList', function(list)
    DRESSING_HATS_LIST = {}
    for k,prop in ipairs(list) do
        DRESSING_HATS_LIST[k] = prop
    end
    SendNUIMessage({dressingHatsList = json.encode(DRESSING_HATS_LIST)})
end)

---------------------------------------------------- FUNCTIONS ---------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- Check if player is near a bank
function isNearShop()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for _, item in pairs(clothingStores) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance <= item.activationDist ) then
            return true
        end
    end
end

function setMapMarker(stores, blipIcon, blipColor, blipName)
    for k,v in ipairs(stores)do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, blipIcon)
        SetBlipColour(blip, blipColor)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipName)
        EndTextCommandSetBlipName(blip)
    end
end


---------------------------------------------------- LISTENERS ---------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------- NUI ------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

local currentUiState = false
-- Open Gui and Focus NUI
function openGui()
    SetNuiFocus(true)
    SendNUIMessage({openUI = true})
end

-- Close Gui and disable NUI
function closeGui()
    SetNuiFocus(false)
    SendNUIMessage({closeUI = true})
    currentUiState = false
end

RegisterNUICallback('debug', function(data, cb)
    Citizen.Trace(data.debug)
    cb('ok')
end)
RegisterNUICallback('main', function(data, cb)
    SendNUIMessage({openMain = true})
    cb('ok')
end)

RegisterNUICallback('outfits', function(data, cb)
    SendNUIMessage({openOutfits = true})
    cb('ok')
end)

RegisterNUICallback('outfit_switcher', function(data, cb)
    outfitSelector(OUTFIT_LIST[data.id])
end)

RegisterNUICallback('dressing_switcher', function(data, cb)
    outfitSelector(DRESSING_LIST[data.id])
end)

RegisterNUICallback('hat_switcher', function(data, cb)
    hatSelector(data.id)
end)

RegisterNUICallback('glasses_switcher', function(data, cb)
    glassesSelector(data.id)
end)
RegisterNUICallback('glasses_dressing_switcher', function(data, cb)
    glassesSelector(DRESSING_GLASSES_LIST[data.id].item_id)
end)
RegisterNUICallback('hats_dressing_switcher', function(data, cb)
    hatSelector(DRESSING_HATS_LIST[data.id].item_id)
end)

RegisterNUICallback('close', function(data, cb)
    closeGui()
    TriggerServerEvent('skin:loadSkinAndPosition')
    cb('ok')
end)
RegisterNUICallback('outfit_pay', function(data, cb)
    TriggerServerEvent('clothevest:buyOutfit',{id = OUTFIT_LIST[data.id].id, price = data.price})
    closeGui()
    TriggerServerEvent('skin:loadSkinAndPosition')
    cb('ok')
end)

RegisterNUICallback('prop_pay', function(data, cb)
    Citizen.Trace(json.encode(data))
    if data.category == 'hat' then
        TriggerServerEvent('clothevest:buyProp',{id = HATS_LIST[data.id].id, price = data.price, category = data.category})
    else
        TriggerServerEvent('clothevest:buyProp',{id = GLASSES_LIST[data.id].id, price = data.price, category = data.category})
    end
    closeGui()
    TriggerServerEvent('skin:loadSkinAndPosition')
    cb('ok')
end)

RegisterNUICallback('outfit_wear', function(data, cb)
    TriggerServerEvent('clothevest:wearOutfit',DRESSING_LIST[data.id])
    closeGui()
    TriggerServerEvent('skin:loadSkinAndPosition')
    cb('ok')
end)

RegisterNUICallback('prop_glasses_wear', function(data, cb)
    TriggerServerEvent('clothevest:wearGlassesProp',DRESSING_GLASSES_LIST[data.id])
    closeGui()
    TriggerServerEvent('skin:setPlayerProps')
    cb('ok')
end)
RegisterNUICallback('prop_hats_wear', function(data, cb)
    TriggerServerEvent('clothevest:wearHatProp',DRESSING_HATS_LIST[data.id])
    closeGui()
    TriggerServerEvent('skin:setPlayerProps')
    cb('ok')
end)

function hatSelector(hat)
    ClearPedProp(GetPlayerPed(-1),0)
    SetPedPropIndex(GetPlayerPed(-1), 0, hat, 0, 0)
end
function glassesSelector(glasses)

    ClearPedProp(GetPlayerPed(-1),1)
    SetPedPropIndex(GetPlayerPed(-1), 1, glasses, 0, 0)
end

function outfitSelector(outfit)
    SetPedComponentVariation(GetPlayerPed(-1), 3, outfit.arm, outfit.arm_txt, 0)
    -- set tshirt
    SetPedComponentVariation(GetPlayerPed(-1), 8, outfit.tshirt, outfit.tshirt_txt, 0)
    -- set jacket
    SetPedComponentVariation(GetPlayerPed(-1), 11, outfit.jacket, outfit.jacket_txt, 0)
    -- set pants
    SetPedComponentVariation(GetPlayerPed(-1), 4, outfit.pant, outfit.pant_txt, 0)
    -- set shoes
    SetPedComponentVariation(GetPlayerPed(-1), 6, outfit.shoe, outfit.shoe_txt, 0)
    if outfit.mask ~= 0 then
        SetPedComponentVariation(GetPlayerPed(-1), 1, outfit.mask, outfit.mask_txt, 0)
    end
    if outfit.glasses ~= 0 then
        SetPedPropIndex(GetPlayerPed(-1), 1, outfit.glasses,outfit.glasses_txt, 0)
    else
        ClearPedProp(GetPlayerPed(-1),1)
    end
    if outfit.hat ~= 0 then
        SetPedPropIndex(GetPlayerPed(-1), 0, outfit.hat,outfit.hat_txt, 0)
    else
        ClearPedProp(GetPlayerPed(-1),0)
    end

end
------------------------------------------------------ THREAD ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------


Citizen.CreateThread(function()
    --setMapMarker(clothingStores, 73, 60, "Vestiaire")
    while true do
        Citizen.Wait(0)
        if isNearShop() then
            SetTextComponentFormat("STRING")
            AddTextComponentString("Appuyez sur la touche ~INPUT_CONTEXT~ pour ouvrir le vestiaire.")
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)

            if IsControlJustPressed(1, 51) then
                TriggerServerEvent('clothevest:getModelAndList')
                if currentUiState == false then
                    openGui()
                    currentUiState = true
                else
                    closeGui()
                    currentUiState = false
                end
            end
            if IsDisabledControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({type = "click"})
            end
        end
        if currentUiState == true then
            DisableControlAction(0, 1, active) -- LookLeftRight
            DisableControlAction(0, 2, active) -- LookUpDown
            DisableControlAction(0, 24, active) -- Attack
            DisablePlayerFiring( GetPlayerPed(-1), true) -- Disable weapon firing
            DisableControlAction(0, 142, active) -- MeleeAttackAlternate
            DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
        end

    end
end)