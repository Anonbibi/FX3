

RegisterServerEvent('stores:CheckMoneyForVeh')
RegisterServerEvent('stores:BuyForVeh')

AddEventHandler('stores:CheckMoneyForVeh', function(name, vehicle, price)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local vehicle = vehicle
    local name = name
    local price = tonumber(price)
        if (tonumber(user.getMoney()) >= tonumber(price)) then
          user.removeMoney(price)
          TriggerClientEvent('stores:FinishMoneyCheckForVeh', source, name, vehicle, price)
          TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Bonne route!\n")
        else
          TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Fonds insuffisants!\n")
       end
  end)
end)
AddEventHandler('stores:BuyForVeh', function(name, vehicle, price, plate, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
  TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = user.identifier
    local name = name
    local price = price
    local vehicle = vehicle
    local plate = plate
    local state = "Sortit"
    local primarycolor = primarycolor
    local secondarycolor = secondarycolor
    local pearlescentcolor = pearlescentcolor
    local wheelcolor = wheelcolor
     MySQL.Async.execute("INSERT INTO user_vehicle SET `identifier`= @username, `vehicle_name` = @name, `vehicle_model` = @vehicle, `vehicle_plate`= @plate, `vehicle_state` = @state, `vehicle_colorprimary`=@primarycolor, `vehicle_colorsecondary` = @secondarycolor, `vehicle_pearlescentcolor`= @pearlescentcolor, `vehicle_wheelcolor` = @wheelcolor",
    {
      ['@username'] = player,
      ['@name'] = name,
      ['@vehicle'] = vehicle,

      ['@plate'] = plate,
      ['@state'] = state,
      ['@primarycolor'] = primarycolor,
      ['@secondarycolor'] = secondarycolor,
      ['@pearlescentcolor'] = pearlescentcolor,
      ['@wheelcolor'] = wheelcolor
    })
    MySQL.Async.execute("INSERT INTO user_vehmods set plate='"..plate.."'" )



  end)
end)


