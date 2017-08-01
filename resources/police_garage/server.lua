--[[Info]]--

require "resources/essentialmode/lib/MySQL"
MySQL:open(database.host, database.name, database.username, database.password)



--[[Register]]--

RegisterServerEvent('police_garages:CheckForSpawnVeh')
RegisterServerEvent('police_garages:CheckForVeh')
RegisterServerEvent('police_garages:SetVehOut')
RegisterServerEvent('police_garages:SetVehIn')
RegisterServerEvent('police_garages:PutVehInGarages')
RegisterServerEvent('police_garages:CheckGarageForVeh')
RegisterServerEvent('police_garages:CheckForSelVeh')
RegisterServerEvent('police_garages:SelVeh')



--[[Local/Global]]--

vehicles = {}


--[[Events]]--

AddEventHandler('police_garages:CheckForSpawnVeh', function(veh_id)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local veh_id = veh_id
    local player = user.identifier
    local executed_query = MySQL:executeQuery("SELECT * FROM police_vehicle WHERE identifier = '@username' AND ID = '@ID'",{['@username'] = player, ['@ID'] = veh_id})
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
    TriggerClientEvent('police_garages:SpawnVehicle', source, vehicle, plate, state, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
  end)
end)

AddEventHandler('police_garages:CheckForVeh', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local state = "Sortit"
    local player = user.identifier
    local executed_query = MySQL:executeQuery("SELECT * FROM police_vehicle WHERE identifier = '@username' AND vehicle_state ='@state'",{['@username'] = player, ['@vehicle'] = vehicle, ['@state'] = state})
    local result = MySQL:getResults(executed_query, {'vehicle_model', 'vehicle_plate'}, "identifier")
    if(result)then
      for k,v in ipairs(result)do
        vehicle = v.vehicle_model
        plate = v.vehicle_plate
      local vehicle = vehicle
      local plate = plate
      end
    end
    TriggerClientEvent('police_garages:StoreVehicle', source, vehicle, plate)
  end)
end)

AddEventHandler('police_garages:SetVehOut', function(vehicle, plate)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local vehicle = vehicle
    local state = "Sortit"
    local plate = plate

    local executed_query = MySQL:executeQuery("UPDATE police_vehicle SET vehicle_state='@state' WHERE identifier = '@username' AND vehicle_plate = '@plate' AND vehicle_model = '@vehicle'",
      {['@username'] = player, ['@vehicle'] = vehicle, ['@state'] = state, ['@plate'] = plate})
  end)
end)

AddEventHandler('police_garages:SetVehIn', function(plate)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local plate = plate
    local state = "Rentré"
    local executed_query = MySQL:executeQuery("UPDATE police_vehicle SET vehicle_state='@state' WHERE identifier = '@username' AND vehicle_plate = '@plate'",
      {['@username'] = player, ['@plate'] = plate, ['@state'] = state})
  end)
end)

AddEventHandler('police_garages:PutVehInGarages', function(vehicle)
  TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = user.identifier
    local state ="Rentré"

    local executed_query = MySQL:executeQuery("SELECT * FROM police_vehicle WHERE identifier = '@username'",{['@username'] = player})
    local result = MySQL:getResults(executed_query, {'identifier'})

    if(result)then
      for k,v in ipairs(result)do
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

AddEventHandler('police_garages:CheckGarageForVeh', function()
  vehicles = {}
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier  
    local executed_query = MySQL:executeQuery("SELECT * FROM police_vehicle WHERE identifier = '@username'",{['@username'] = player})
    local result = MySQL:getResults(executed_query, {'id','vehicle_model', 'vehicle_name', 'vehicle_state'}, "id")
    if (result) then
        for _, v in ipairs(result) do
                --print(v.vehicle_model)
                --print(v.vehicle_plate)
                --print(v.vehicle_state)
                --print(v.id)
            t = { ["id"] = v.id, ["vehicle_model"] = v.vehicle_model, ["vehicle_name"] = v.vehicle_name, ["vehicle_state"] = v.vehicle_state}
            table.insert(vehicles, tonumber(v.id), t)
        end
    end
  end)  
    --print(vehicles[1].id)
    --print(vehicles[2].vehicle_model)
    TriggerClientEvent('police_garages:getVehicles', source, vehicles)
end)

AddEventHandler('police_garages:CheckForSelVeh', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local state = "Sortit"
    local player = user.identifier
    local executed_query = MySQL:executeQuery("SELECT * FROM police_vehicle WHERE identifier = '@username' AND vehicle_state ='@state'",{['@username'] = player, ['@vehicle'] = vehicle, ['@state'] = state})
    local result = MySQL:getResults(executed_query, {'vehicle_model', 'vehicle_plate'}, "identifier")
    if(result)then
      for k,v in ipairs(result)do
        vehicle = v.vehicle_model
        plate = v.vehicle_plate
      local vehicle = vehicle
      local plate = plate
      end
    end
    TriggerClientEvent('police_garages:SelVehicle', source, vehicle, plate)
  end)
end)




AddEventHandler('playerConnecting', function()
	local player_state = 1
	local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE player_state = '@player_state'",
      {['@player_state'] = player_state})
	local result = MySQL:getResults(executed_query, {'player_state'})
	if (result) then
		for i,v in ipairs(result) do
			sum = sum + v.player_state
		end
	else
		sum = 0
	end
	if (sum < 1) then
		local old_state = "Sortit"
		local state = "Rentré"
		local executed_query = MySQL:executeQuery("UPDATE police_vehicle SET `vehicle_state`='@state' WHERE vehicle_state = '@old_state'",
		{['@old_state'] = old_state, ['@state'] = state})
	end
end)

AddEventHandler('playerSpawn', function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		playerID = user.identifier
		local player_state = "1"
		MySQL:executeQuery("UPDATE users SET `player_state`='@player_state' WHERE identifier = '@identifier'",
		{['@player_state'] = player_state, ['@identifier'] = playerID})
	end)
end)

AddEventHandler('playerDropped', function()
		local player_state = "0"
		MySQL:executeQuery("UPDATE users SET `player_state`='@player_state' WHERE identifier = '@identifier'",
		{['@player_state'] = player_state, ['@identifier'] = playerID})
end)
