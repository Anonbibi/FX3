require "resources/essentialmode/lib/MySQL"
MySQL:open("151.236.37.159", "gfavalpha", "gfavalpha", "123456")

RegisterServerEvent('policegarages:CheckForSpawnVeh')
RegisterServerEvent('policegarages:CheckForVeh')
RegisterServerEvent('policegarages:SetVehOut')
RegisterServerEvent('policegarages:SetVehIn')
RegisterServerEvent('policegarages:PutVehInPolicegarages')

AddEventHandler('policegarages:PutVehInPolicegarages', function(vehicle)
  TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = user.identifier
    local state ="in"

    local executed_query = MySQL:executeQuery("SELECT * FROM police_vehicle WHERE identifier = '@username'",{['@username'] = player})
    local result = MySQL:getResults(executed_query, {'identifier'})

    if(result)then
      for k,v in ipairs(result)do
        print(v.identifier)
        joueur = v.identifier
        local joueur = joueur
       end
    end

    if joueur ~= nil then

      local executed_query = MySQL:executeQuery("UPDATE police_vehicle SET `vehicle_state`='@state' WHERE identifier = '@username'",
      {['@username'] = player, ['@state'] = state})

    end
  end)
end)

AddEventHandler('policegarages:CheckForSpawnVeh', function()
  --print(source)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local executed_query = MySQL:executeQuery("SELECT * FROM police_vehicle WHERE identifier = '@username'",{['@username'] = player})
    local result = MySQL:getResults(executed_query, {'vehicle_model', 'vehicle_plate', 'vehicle_state'}, "identifier")
    if(result)then
      for k,v in ipairs(result)do
        --print(v.personalvehicle)
        vehicle = v.vehicle_model
        plate = v.vehicle_plate
        state = v.vehicle_state
        

      local vehicle = vehicle
      local plate = plate
      local state = state      
      
      end
    end
    TriggerClientEvent('policegarages:SpawnVehicle', source, vehicle, plate, state)
  end)
end)

AddEventHandler('policegarages:CheckForVeh', function()
  --print(source)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local executed_query = MySQL:executeQuery("SELECT * FROM police_vehicle WHERE identifier = '@username'",{['@username'] = player})
    local result = MySQL:getResults(executed_query, {'vehicle_model', 'vehicle_plate'}, "identifier")
    if(result)then
      for k,v in ipairs(result)do
        vehicle = v.vehicle_model
        plate = v.vehicle_plate
      local vehicle = vehicle
      local plate = plate
      end
    end
    TriggerClientEvent('policegarages:StoreVehicle', source, vehicle, plate)
  end)
end)


AddEventHandler('policegarages:SetVehOut', function(vehicle)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local vehicle = vehicle
    local state = "out"

    MySQL:executeQuery("UPDATE police_vehicle SET vehicle_state='@state' WHERE identifier = '@username' AND vehicle_model = '@vehicle'",
      {['@username'] = player, ['@vehicle'] = vehicle, ['@state'] = state})
  end)
end)

AddEventHandler('policegarages:SetVehIn', function(plate)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local plate = plate
    local state = "in"

    MySQL:executeQuery("UPDATE police_vehicle SET vehicle_state='@state' WHERE identifier = '@username' AND vehicle_plate = '@plate'",
      {['@username'] = player, ['@plate'] = plate, ['@state'] = state})
  end)
end)
