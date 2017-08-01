--
-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 22/05/2017
-- Time: 07:59
-- To change this template use File | Settings | File Templates.
--


local clothingStores = {

    { x = 1693.2647705078,      y = 4822.2797851563,    z = 42.063091278076,    markerWidth = 7.0001,  activationDist = 7.5 },
    { x = 125.83338165283,      y = -223.16986083984,   z = 54.55782699585,     markerWidth = 7.0001,  activationDist = 7.5 },
    { x = -710.16009521484,     y = -153.26420593262,   z = 37.415138244629,    markerWidth = 7.0001,  activationDist = 7.5 },
    { x = -821.69067382813,     y = -1073.900390625,    z = 11.328099250793,    markerWidth = 7.0001,  activationDist = 7.5 },
    { x = -1192.8112792969,     y = -768.24377441406,   z = 17.319314956665,    markerWidth = 7.0001,  activationDist = 7.5 },
    { x = 4.2589497566223,      y = 6512.8803710938,    z = 31.877851486206,    markerWidth = 7.0001,  activationDist = 7.5 },
    { x = -1097.98095703125,    y = 2708.9150390625,    z = 19.107873916626,    markerWidth = 7.0001,  activationDist = 7.5 },
    { x = -3170.45434570313,    y = 1045.53295898438,   z = 20.8632144927979,   markerWidth = 7.0001,  activationDist = 7.5 },
    { x = -162.942764282227,    y = -302.322326660156,  z = 39.733283996582,    markerWidth = 7.0001,  activationDist = 7.5 },
    { x = -1452.13696289063,    y = -236.172698974609,  z = 49.806259155,       markerWidth = 7.0001,  activationDist = 7.5 }
}

RegisterNetEvent("clotheshop:notifs")
AddEventHandler("clotheshop:notifs", function(msg)
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

RegisterNetEvent('clotheshop:setOutfitList')
AddEventHandler('clotheshop:setOutfitList', function(list)
    OUTFIT_LIST = {}
    for k,outfit in ipairs(list) do
        OUTFIT_LIST[k] = outfit
    end
    SendNUIMessage({outfitsList = json.encode(OUTFIT_LIST)})
    SendNUIMessage({maxOutfits = #list})
end)

RegisterNetEvent('clotheshop:setHatsList')
AddEventHandler('clotheshop:setHatsList', function(list)
    HATS_LIST = {}
    HATS_LIST= list

    SendNUIMessage({hatsList = json.encode(HATS_LIST)})
end)


RegisterNetEvent('clotheshop:setGlassesList')
AddEventHandler('clotheshop:setGlassesList', function(list)
    GLASSES_LIST = {}
    GLASSES_LIST= list
    SendNUIMessage({glassesList = json.encode(GLASSES_LIST)})
end)

RegisterNetEvent('clotheshop:setDressingList')
AddEventHandler('clotheshop:setDressingList', function(list)
    DRESSING_LIST = {}
    for k,dress in ipairs(list) do
        DRESSING_LIST[k] = dress
    end
    SendNUIMessage({dressingList = json.encode(DRESSING_LIST)})
end)

RegisterNetEvent('clotheshop:setDressingGlassesList')
AddEventHandler('clotheshop:setDressingGlassesList', function(list)
    DRESSING_GLASSES_LIST = {}
    for k,prop in ipairs(list) do
        DRESSING_GLASSES_LIST[k] = prop
    end
    SendNUIMessage({dressingGlassesList = json.encode(DRESSING_GLASSES_LIST)})
end)

RegisterNetEvent('clotheshop:setDressingHatsList')
AddEventHandler('clotheshop:setDressingHatsList', function(list)
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
    TriggerServerEvent('clotheshop:buyOutfit',{id = OUTFIT_LIST[data.id].id, price = data.price})
    closeGui()
    TriggerServerEvent('skin:loadSkinAndPosition')
    cb('ok')
end)

RegisterNUICallback('prop_pay', function(data, cb)
    Citizen.Trace(json.encode(data))
    if data.category == 'hat' then
        TriggerServerEvent('clotheshop:buyProp',{id = HATS_LIST[data.id].id, price = data.price, category = data.category})
    else
        TriggerServerEvent('clotheshop:buyProp',{id = GLASSES_LIST[data.id].id, price = data.price, category = data.category})
    end
    closeGui()
    TriggerServerEvent('skin:loadSkinAndPosition')
    cb('ok')
end)

RegisterNUICallback('outfit_wear', function(data, cb)
    TriggerServerEvent('clotheshop:wearOutfit',DRESSING_LIST[data.id])
    closeGui()
    TriggerServerEvent('skin:loadSkinAndPosition')
    cb('ok')
end)

RegisterNUICallback('prop_glasses_wear', function(data, cb)
    TriggerServerEvent('clotheshop:wearGlassesProp',DRESSING_GLASSES_LIST[data.id])
    closeGui()
    TriggerServerEvent('skin:setPlayerProps')
    cb('ok')
end)
RegisterNUICallback('prop_hats_wear', function(data, cb)
    TriggerServerEvent('clotheshop:wearHatProp',DRESSING_HATS_LIST[data.id])
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
    setMapMarker(clothingStores, 73, 60, "Magasins de vêtements")
    while true do
        Citizen.Wait(0)
        if isNearShop() then
            SetTextComponentFormat("STRING")
            AddTextComponentString("Appuyez sur la touche ~INPUT_CONTEXT~ pour ouvrir le magasin.")
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)

            if IsControlJustPressed(1, 51) then
                TriggerServerEvent('clotheshop:getModelAndList')
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