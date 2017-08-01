--require "resources/mysql-async/lib/MySQL"

local CARS = {}
local maxCapacity = 100

local all_cars = MySQL.Sync.fetchAll("SELECT vehicle_plate AS plate, items.id AS id, items.libelle AS libelle, quantity FROM user_vehicle LEFT JOIN vehicle_inventory ON `user_vehicle`.`vehicle_plate` = `vehicle_inventory`.`plate` LEFT JOIN items ON `vehicle_inventory`.`item` = `items`.`id`")

for _, v in ipairs(all_cars) do
    CARS[v.plate] = {}
    if v.id and v.libelle and v.quantity then
        table.insert(CARS[v.plate], v.id, {libelle = v.libelle, quantity = v.quantity})
    end
end

RegisterServerEvent("car:getItems")
AddEventHandler("car:getItems", function(plate)
    local res = nil
    if CARS[plate] then
        res = CARS[plate]
    end
    TriggerClientEvent("car:hoodContent", source, res)
end)

RegisterServerEvent("car:receiveItem")
AddEventHandler("car:receiveItem", function(plate, item, lib, quantity)
    if (getPods(plate) + quantity <= maxCapacity) then
        add({ item, quantity, plate, lib })
        TriggerClientEvent("player:looseItem", source, item, quantity)
    end
end)

RegisterServerEvent("car:looseItem")
AddEventHandler("car:looseItem", function(plate, item, quantity)
    local cItem = CARS[plate][item]
    if (cItem.quantity >= quantity) then
        delete({ item, quantity, plate })
        TriggerClientEvent("player:receiveItem", source, item, quantity)
    end
end)

AddEventHandler('BuyForVeh', function(name, vehicle, price, plate, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
    CARS[plate] = {}
end)

function add(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local plate = arg[3]
    local lib = arg[4]
    local query
    local item
    if CARS[plate][itemId] then
        item = CARS[plate][itemId]
        query = "UPDATE vehicle_inventory SET `quantity` = @qty WHERE `plate` = @plate AND `item` = @item"
        item.quantity = item.quantity + qty
    else
        CARS[plate][itemId] = {quantity = qty, libelle = lib}
        item = CARS[plate][itemId]
        print(CARS[plate][itemId].libelle)
        query = "INSERT INTO vehicle_inventory (`quantity`,`plate`,`item`) VALUES (@qty,@plate,@item)"
    end
    MySQL.Async.execute(query,{ ['@plate'] = plate, ['@qty'] = item.quantity, ['@item'] = itemId })
end

function delete(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local plate = arg[3]
    local item = CARS[plate][itemId]
    item.quantity = item.quantity - qty
    MySQL.Async.execute("UPDATE vehicle_inventory SET `quantity` = @qty WHERE `plate` = @plate AND `item` = @item",
    { ['@plate'] = plate, ['@qty'] = item.quantity, ['@item'] = itemId })
end

function getPods(plate)
    local pods = 0
    for _, v in pairs(CARS[plate]) do
        pods = pods + v.quantity
    end
    return pods
end

-- get's the player id without having to use bugged essentials
function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

-- gets the actual player id unique to the player,
-- independent of whether the player changes their screen name
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

function stringSplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end