CARITEMS = {}

RegisterNetEvent("car:hoodContent")
AddEventHandler("car:hoodContent", function(items)
    if items then
        CARITEMS = items
        CoffreMenu()
    else
        CARITEMS = {}
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if IsControlJustPressed(1, 182) then
            local vehFront = VehicleInFront()
            if vehFront > 0 then
                if Menu.hidden then
                    ClearMenu()
                    SetVehicleDoorOpen(vehFront, 5, false, false)
                    TriggerServerEvent("car:getItems", GetVehicleNumberPlateText(vehFront))
                else
                    SetVehicleDoorShut(vehFront, 5, false)
                end
                Menu.hidden = not Menu.hidden
            end
        end
        Menu.renderGUI()
    end
end)

function CoffreMenu()
    MenuTitle = "Coffre"
    for ind, value in pairs(CARITEMS) do
        if (value.quantity > 0) then
            Menu.addButton(value.libelle .. " : " .. tostring(value.quantity), "GetItem", ind)
        end
    end
end

function GetItem(id)
    local vehFront = VehicleInFront()
    if vehFront > 0 then
        local qty = DisplayInput()
        TriggerServerEvent("car:looseItem", GetVehicleNumberPlateText(vehFront), id, qty)
    end
    Menu.hidden = true
end



function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 3.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

function DisplayInput()
    DisplayOnscreenKeyboard(1, "FMMC_MPM_TYP8", "", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(1)
    end
    if GetOnscreenKeyboardResult() then
        return tonumber(GetOnscreenKeyboardResult())
    end
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end