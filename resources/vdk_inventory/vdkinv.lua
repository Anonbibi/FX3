ITEMS = {}
NewItems = {}
-- flag to keep track of whether player died to prevent
-- multiple runs of player dead code
local playerdead = false
local maxCapacity = 96
local refreshTime = 10000

-- register events, only needs to be done once
RegisterNetEvent("item:reset")
RegisterNetEvent("item:getItems")
RegisterNetEvent("item:updateQuantity")
RegisterNetEvent("item:setItem")
RegisterNetEvent("item:sell")
RegisterNetEvent("gui:getItems")
RegisterNetEvent("player:receiveItem")
RegisterNetEvent("player:looseItem")
RegisterNetEvent("player:sellItem")
RegisterNetEvent("player:sellItemSale")


------------------------- EVENTS -------------------------

-- handles when a player spawns either from joining or after death
AddEventHandler("playerSpawned", function()
    TriggerServerEvent("item:getItems")
    -- reset player dead flag
    playerdead = false
end)



AddEventHandler("playerDropped", function()
    updateQuantities()
end)

AddEventHandler("gui:getItems", function(THEITEMS)
    ITEMS = {}
    ITEMS = THEITEMS
end)

AddEventHandler("player:receiveItem", function(item, quantity)
    if (getPods() + quantity <= maxCapacity) then
        item = tonumber(item)
        if (ITEMS[item] == nil) then
            new(item, quantity)
        else
            add({ item, quantity })
        end
    end
end)

AddEventHandler("player:looseItem", function(item, quantity)
    item = tonumber(item)
    if (ITEMS[item].quantity >= quantity) then
        delete({ item, quantity })
    end
end)

AddEventHandler("player:sellItem", function(item, price)
    item = tonumber(item)
    if (ITEMS[item].quantity > 0) then
        sell({ item, price })
    end
end)
AddEventHandler("player:sellItemSale", function(item, price)
    item = tonumber(item)
    if (ITEMS[item].quantity > 0) then
        sellillegal({ item, price })
    end
end)

------------------------- METHODS -------------------------

function sell(arg)
    local itemId = tonumber(arg[1])
    local price = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity - 1
    NewItems[itemId] = item.quantity
    TriggerServerEvent("item:sell", itemId, item.quantity, price)
    InventoryMenu()
end

function sellillegal(arg)
    local itemId = tonumber(arg[1])
    local price = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity - 1
    NewItems[itemId] = item.quantity
    TriggerServerEvent("item:sellillegal", itemId, item.quantity, price)
    InventoryMenu()
end

function delete(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity - qty
    NewItems[itemId] = item.quantity
    -- TriggerServerEvent("item:updateQuantity", item.quantity, itemId)
    InventoryMenu()
end

function add(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity + qty
    NewItems[itemId] = item.quantity
    -- TriggerServerEvent("item:updateQuantity", item.quantity, itemId)
    InventoryMenu()
end

function new(item, quantity)
    TriggerServerEvent("item:setItem", item, quantity)
    updateQuantities()
    TriggerServerEvent("item:getItems")
end

-- function give(item)
--     local player = getNearPlayer()
--     if player then
--         local res = DisplayInput()
--         if (ITEMS[item].quantity - res >= 0) then
--             TriggerServerEvent("player:giveItem", item, ITEMS[item].libelle, res, GetPlayerServerId(player))
--         end
--     end
-- end

function updateQuantities()
    for item, quantity in pairs(NewItems) do
        TriggerServerEvent("item:updateQuantity", quantity, item)
    end
end

function PlayerIsDead()
    -- do not run if already ran
    if playerdead then
        return
    end
    --TriggerServerEvent("item:reset")
end

function use(val)
    local itemId = val[1]
    local canUse = val[2]
    if canUse ~= 0 then
        if canUse == 1 then
            drink(itemId)
            

        elseif canUse == 2 then
            eat(itemId)

        elseif canUse == 3 then
            smalldrug(itemId)
        elseif canUse == 4 then
            drug(itemId)
        elseif canUse == 5 then
            harddrug(itemId)
            
        end
        TriggerEvent('player:looseItem', itemId, 1)
    else
        Chat("Cet objet ne fait rien")
    end
end

function giveMoney()
    local playerNear = GetClosestPlayer()
    if playerNear then
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local res = tonumber(GetOnscreenKeyboardResult())
            if res > 0 then
                TriggerServerEvent("player:swapMoney", res, GetPlayerServerId(playerNear))
            end
        end
    end
end

function giveDirtyMoney()
    local playerNear = GetClosestPlayer()
    if playerNear then
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local res = tonumber(GetOnscreenKeyboardResult())
            if res > 0 then
                TriggerServerEvent("player:swapDirtyMoney", res, GetPlayerServerId(playerNear))
            end
        end
    end
end

function give(item)
    
    local playerNear = GetClosestPlayer()
    if playerNear then
        DisplayOnscreenKeyboard(1, "Quantité :", "", "", "", "", "", 3)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local res = tonumber(GetOnscreenKeyboardResult())
            if res > 0 then
                if (ITEMS[item].quantity - res >= 0) then
                    TriggerServerEvent("player:giveItem", item, ITEMS[item].libelle, res, GetPlayerServerId(playerNear))
                    Menu.hidden = not Menu.hidden
                end
            end
        end
    else
        TriggerEvent("es_freeroam:notify", "CHAR_MP_STRIPCLUB_PR", 1, "Mairie", false, "Pas de joueur proche")
        Menu.hidden = not Menu.hidden
    end
end

------------------------- USE SUBMETHODS --------------------------

function eat(item)
    if item == 30 then --Jambon beurre
        TriggerEvent("food:veat", 30)
    elseif item == 34 then -- Kebab
        TriggerEvent("food:veat", 35)
    elseif item == 37 then -- Pomme
        TriggerEvent("food:vdrink", 5)
        TriggerEvent("food:veat", 15)
    elseif item == 39 then
        TriggerEvent("food:veat", 15)
        TriggerEvent("food:vdrink", 5)
    elseif item == 40 then
        TriggerEvent("food:veat", 15)
        TriggerEvent("food:vdrink", 5)
    elseif item == 26 then
        TriggerEvent("food:veat", 15)
        TriggerEvent("food:vdrink", 5)
    elseif item == 22 then
        TriggerEvent("food:veat", 35)
    elseif item == 23 then
        TriggerEvent("food:veat", 35)
    elseif item == 42 then
        TriggerEvent("food:veat", 15)
    end
    local pid = PlayerPedId()
    RequestAnimDict("mp_player_inteat@burger")
    while (not HasAnimDictLoaded("mp_player_inteat@burger")) do Citizen.Wait(0) end
    TaskPlayAnim(pid, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 1.0, -1.0, 2000, 0, 1, true, true, true)
    
end

function drink(item)
    if item == 35 then
        TriggerEvent("food:vdrink", 25)
    elseif item == 38 then
        TriggerEvent("food:vdrink", 10)
    elseif item == 6 then
        TriggerEvent("food:vdrink", 40)
    elseif item == 36 then
        TriggerEvent("food:vdrink", 25)
    end
    local pid = PlayerPedId()
    RequestAnimDict("amb@world_human_drinking@coffee@male@idle_a")
    while (not HasAnimDictLoaded("amb@world_human_drinking@coffee@male@idle_a")) do Citizen.Wait(0) end
    TaskPlayAnim(pid, 'amb@world_human_drinking@coffee@male@idle_a', 'idle_a', 1.0, -1.0, 2000, 0, 1, true, true, true)
   
end

function drug(item)
    ToxicatedSmall()
    Citizen.Wait(180000)
    ClearPedTasks(GetPlayerPed(-1))
    Reality()
end

function smalldrug(item)
    Toxicated()
    Citizen.Wait(30000)
    ClearPedTasks(GetPlayerPed(-1))
    Reality()
end
function harddrug(item)
    ToxicatedHard()
    Citizen.Wait(300000)
    ClearPedTasks(GetPlayerPed(-1))
    Reality()
end

RegisterNetEvent("item:reset")

AddEventHandler("playerDropped", function()
    updateQuantities()
end)

            -- Any other type? Drugs??????
            -- Toxicated()
            -- Citizen.Wait(7000)
            -- ClearPedTasks(GetPlayerPed(-1))
            -- Reality()
        


             



--------------------------------------------------------
function ToxicatedSmall()
      Citizen.Wait(5000)
      DoScreenFadeOut(1000)
      Citizen.Wait(1000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      SetTimecycleModifier("spectator1")
      SetPedMotionBlur(GetPlayerPed(-1), true)
      SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@MODERATEDRUNK", true)
      SetPedIsDrunk(GetPlayerPed(-1), true)
      DoScreenFadeIn(1000)
end
function Toxicated()
      Citizen.Wait(5000)
      DoScreenFadeOut(1000)
      Citizen.Wait(1000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      SetTimecycleModifier("spectator1")
      SetPedMotionBlur(GetPlayerPed(-1), true)
      SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
      SetPedIsDrunk(GetPlayerPed(-1), true)
      DoScreenFadeIn(1000)
end

function ToxicatedHard()
      Citizen.Wait(5000)
      DoScreenFadeOut(1000)
      Citizen.Wait(1000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      SetTimecycleModifier("spectator5")
      SetPedMotionBlur(GetPlayerPed(-1), true)
      SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", true)
      SetPedIsDrunk(GetPlayerPed(-1), true)
      DoScreenFadeIn(1000)
end

function ToxicatedTeki()
  TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRUG_DEALER", 0, 1)
  DoScreenFadeOut(1000)
  Citizen.Wait(1000)
  ClearPedTasksImmediately(GetPlayerPed(-1))
  SetTimecycleModifier("spectator1")
  SetPedMotionBlur(GetPlayerPed(-1), true)
  RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
      while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
       Citizen.Wait(0)
      end
    SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
    SetPedIsDrunk(GetPlayerPed(-1), true)
    DoScreenFadeIn(1000)
  end

function Reality()
  Citizen.Wait(50000)
  DoScreenFadeOut(1000)
  Citizen.Wait(1000)
  DoScreenFadeIn(1000)
  ClearTimecycleModifier()
  ResetScenarioTypesEnabled()
  ResetPedMovementClipset(GetPlayerPed(-1), 0)
  SetPedIsDrunk(GetPlayerPed(-1), false)
  SetPedMotionBlur(GetPlayerPed(-1), false)
end

------------------------- EXPORTS METHODS -------------------------

function getQuantity(itemId)

    if (ITEMS[tonumber(itemId)] == nil) then
        local itemqty = 0
        return itemqty

    else
        return ITEMS[tonumber(itemId)].quantity
    end
end

function getPods()
    local pods = 0
    for _, v in pairs(ITEMS) do
        pods = pods + v.quantity
    end
    return pods
end

function notFull()
    if (getPods() < maxCapacity) then return true end
end

------------------------- MENU -------------------------

function PersonnalMenu()
    ped = GetPlayerPed(-1);
    MenuTitle="Menu :"
    ClearMenu()
    Menu.addButton("Inventaire", "InventoryMenu", nil)
    Menu.addButton("Animations", "animsMenu", nil)
    Menu.addButton("Donner argent", "giveMoney", nil)
    Menu.addButton("Donner argent sale", "giveDirtyMoney", nil)
end

function InventoryMenu()
    ped = GetPlayerPed(-1);
    MenuTitle="Items: " .. (getPods() or 0) .. "/" .. maxCapacity
    ClearMenu()
    for ind, value in pairs(ITEMS) do
        if (value.quantity > 0) then
            Menu.addButton(tostring(value.libelle) .. " : " .. tostring(value.quantity), "ItemMenu", {ind,value.canUse})
        end
    end
end

function ItemMenu(val)
    local itemId = val[1]
    local canUse = val[2]
    ClearMenu()
    MenuTitle="Details :"
    Menu.addButton("Donner", "give", itemId)
    Menu.addButton("Utiliser", "use", {itemId, canUse})
    Menu.addButton("Jeter", "delete", {itemId, 1})
    Menu.addButton("Mettre dans voiture", "PutInCoffre", itemId)
end

function PutInCoffre(itemId)
    local vehFront = VehicleInFront()
    if vehFront then
        local qty = DisplayInput()
        if (getQuantity(itemId) - qty >= 0) then
            TriggerServerEvent("car:receiveItem", vehFront, itemId, ITEMS[itemId].libelle, qty)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 167) then
            TriggerServerEvent("item:getItems")
        end
        if IsControlJustPressed(1, 311) then
            PersonnalMenu() -- Menu to draw
            Menu.hidden = not Menu.hidden -- Hide/Show the menu
        end
        Menu.renderGUI() -- Draw menu on each tick if Menu.hidden = false
        if IsEntityDead(PlayerPedId()) then
            PlayerIsDead()
            -- prevent the death check from overloading the server
            playerdead = true
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(refreshTime)
        if NewItems then
            updateQuantities()
        end
        NewItems = {}
    end
end)

------------------------- GENERAL METHODS -------------------------

function getPlayers()
    local playerList = {}
    for i = 0, 32 do
        local player = GetPlayerFromServerId(i)
        if NetworkIsPlayerActive(player) then
            table.insert(playerList, player)
        end
    end
    return playerList
end

function getNearPlayer()
    local players = getPlayers()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local pos2
    local distance
    local minDistance = 3
    local playerNear
    for _, player in pairs(players) do
        pos2 = GetEntityCoords(GetPlayerPed(player))
        distance = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"], pos2["x"], pos2["y"], pos2["z"], true)
        if (pos ~= pos2 and distance < minDistance) then
            playerNear = player
            minDistance = distance
        end
    end
    if (minDistance < 3) then
        return playerNear
    end
end

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 3.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return GetVehicleNumberPlateText(result)
end

function DisplayInput()
    DisplayOnscreenKeyboard(1, "FMMC_MPM_TYP8", "", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(1)
    end
    if (GetOnscreenKeyboardResult()) then
        return tonumber(GetOnscreenKeyboardResult())
    end
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = 10 --(-1 = all 10 = 10 métre )
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        --Chat(target.." TARGET")
        --Chat(ply.. " PLY")
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end
