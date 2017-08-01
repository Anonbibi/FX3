--[[Info]]--

require "resources/essentialmode/lib/MySQL"
MySQL:open("151.236.37.159", "gfavalpha", "gfavalpha", "123456")



--[[Register]]--

RegisterServerEvent('hospitalgarages:CheckForSpawnVeh')
RegisterServerEvent('hospitalgarages:CheckForVeh')
RegisterServerEvent('hospitalgarages:SetVehOut')
RegisterServerEvent('hospitalgarages:SetVehIn')
RegisterServerEvent('hospitalgarages:PutVehInHospitalGarages')
RegisterServerEvent('hospitalgarages:CheckHospitalGarageForVeh')
RegisterServerEvent('hospitalgarages:CheckForSelVeh')
RegisterServerEvent('hospitalgarages:SelVeh')



--[[Local/Global]]--

local vehicleshospi = {}



--[[Events]]--

AddEventHandler('hospitalgarages:CheckForSpawnVeh', function(veh_id)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local veh_id = veh_id
    local player = user.identifier
    local executed_query = MySQL:executeQuery("SELECT * FROM hospi_vehicle WHERE identifier = '@username' AND ID = '@ID'",{['@username'] = player, ['@ID'] = veh_id})
    local result = MySQL:getResults(executed_query, {'vehicle_model', 'vehicle_plate', 'vehicle_state', 'vehicle_colorprimary', 'vehicle_colorsecondary', 'vehicle_pearlescentcolor', 'vehicle_wheelcolor' }, "identifier")
    if(result)then
      for k,v in ipairs(result)do
        vehicle = v.vehicle_model
        plate = v.vehicle_plate
        state = v.vehicle_state
        primarycolor = v.vehicle_colorprimary
        secondarycolor = v.vehicle_colorsecondary
        pearlescentcolor = v.vehicle_pearlescentcolor
        wheelcolor = v.vehicle_wheelcolor

      local vehicle = vehicle
      local plate = plate
      local state = state      
      local primarycolor = primarycolor
      local secondarycolor = secondarycolor
      local pearlescentcolor = pearlescentcolor
      local wheelcolor = wheelcolor
      end
    end
    TriggerClientEvent('hospitalgarages:SpawnVehicle', source, vehicle, plate, state, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
  end)
end)

AddEventHandler('hospitalgarages:CheckForVeh', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local state = "Sortit"
    local player = user.identifier
    local executed_query = MySQL:executeQuery("SELECT * FROM hospi_vehicle WHERE identifier = '@username' AND vehicle_state ='@state'",{['@username'] = player, ['@vehicle'] = vehicle, ['@state'] = state})
    local result = MySQL:getResults(executed_query, {'vehicle_model', 'vehicle_plate'}, "identifier")
    if(result)then
      for k,v in ipairs(result)do
        vehicle = v.vehicle_model
        plate = v.vehicle_plate
      local vehicle = vehicle
      local plate = plate
      end
    end
    TriggerClientEvent('hospitalgarages:StoreVehicle', source, vehicle, plate)
  end)
end)

AddEventHandler('hospitalgarages:SetVehOut', function(vehicle, plate)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local vehicle = vehicle
    local state = "Sortit"
    local plate = plate

    local executed_query = MySQL:executeQuery("UPDATE hospi_vehicle SET vehicle_state='@state' WHERE identifier = '@username' AND vehicle_plate = '@plate' AND vehicle_model = '@vehicle'",
      {['@username'] = player, ['@vehicle'] = vehicle, ['@state'] = state, ['@plate'] = plate})
  end)
end)

AddEventHandler('hospitalgarages:SetVehIn', function(plate)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local plate = plate
    local state = "Rentré"
    local executed_query = MySQL:executeQuery("UPDATE hospi_vehicle SET vehicle_state='@state' WHERE identifier = '@username' AND vehicle_plate = '@plate'",
      {['@username'] = player, ['@plate'] = plate, ['@state'] = state})
  end)
end)

AddEventHandler('hospitalgarages:PutVehInHospitalGarages', function(vehicle)
  TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = user.identifier
    local state ="Rentré"

    local executed_query = MySQL:executeQuery("SELECT * FROM hospi_vehicle WHERE identifier = '@username'",{['@username'] = player})
    local result = MySQL:getResults(executed_query, {'identifier'})

    if(result)then
      for k,v in ipairs(result)do
        joueur = v.identifier
        local joueur = joueur
       end
    end

    if joueur ~= nil then

      local executed_query = MySQL:executeQuery("UPDATE hospi_vehicle SET `vehicle_state`='@state' WHERE identifier = '@username'",
      {['@username'] = player, ['@state'] = state})

    end
  end)
end)

AddEventHandler('hospitalgarages:CheckHospitalGarageForVeh', function()
  vehicleshospi = {}
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier  
    local executed_query = MySQL:executeQuery("SELECT * FROM hospi_vehicle WHERE identifier = '@username'",{['@username'] = player})
    local result = MySQL:getResults(executed_query, {'id','vehicle_model', 'vehicle_name', 'vehicle_state'}, "id")
    if (result) then
        for _, v in ipairs(result) do
                --print(v.vehicle_model)
                --print(v.vehicle_plate)
                --print(v.vehicle_state)
                --print(v.id)
            t = { ["id"] = v.id, ["vehicle_model"] = v.vehicle_model, ["vehicle_name"] = v.vehicle_name, ["vehicle_state"] = v.vehicle_state}
            table.insert(vehicleshospi, tonumber(v.id), t)
        end
    end
  end)  
    --print(vehicleshospi[1].id)
    --print(vehicleshospi[2].vehicle_model)
    TriggerClientEvent('hospitalgarages:getVehicles', source, vehicleshospi)
end)

-- AddEventHandler('hospitalgarages:CheckForSelVeh', function()
--   TriggerEvent('es:getPlayerFromId', source, function(user)
--     local state = "Sortit"
--     local player = user.identifier
--     local executed_query = MySQL:executeQuery("SELECT * FROM hospi_vehicle WHERE identifier = '@username' AND vehicle_state ='@state'",{['@username'] = player, ['@vehicle'] = vehicle, ['@state'] = state})
--     local result = MySQL:getResults(executed_query, {'vehicle_model', 'vehicle_plate'}, "identifier")
--     if(result)then
--       for k,v in ipairs(result)do
--         vehicle = v.vehicle_model
--         plate = v.vehicle_plate
--       local vehicle = vehicle
--       local plate = plate
--       end
--     end
--     TriggerClientEvent('hospitalgarages:SelVehicle', source, vehicle, plate)
--   end)
-- end)


-- AddEventHandler('hospitalgarages:SelVeh', function(plate)
--   TriggerEvent('es:getPlayerFromId', source, function(user)
--     local player = user.identifier
--     local plate = plate

--     local executed_query = MySQL:executeQuery("SELECT * FROM hospi_vehicle WHERE identifier = '@username' AND vehicle_plate ='@plate'",{['@username'] = player, ['@vehicle'] = vehicle, ['@plate'] = plate})
--     local result = MySQL:getResults(executed_query, {'vehicle_price'}, "identifier")
--     if(result)then
--       for k,v in ipairs(result)do
--         price = v.vehicle_price
--       local price = price / 2      
--       user:addMoney((price))
--       end
--     end
--     local executed_query = MySQL:executeQuery("DELETE from hospi_vehicle WHERE identifier = '@username' AND vehicle_plate = '@plate'",
--       {['@username'] = player, ['@plate'] = plate})
--     TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Véhicule vendu!\n")
--   end)
-- end)
