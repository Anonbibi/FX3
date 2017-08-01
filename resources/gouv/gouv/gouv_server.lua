require "resources/essentialmode/lib/MySQL"
MySQL:open(database.host, database.name, database.username, database.password)

local inServiceAgents = {}

function addAgent(identifier)
	MySQL:executeQuery("INSERT INTO gouv (`identifier`) VALUES ('@identifier')", { ['@identifier'] = identifier})
end

function remAgent(identifier)
	MySQL:executeQuery("DELETE FROM gouv WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
end

RegisterServerEvent('gouv:removeAgent')
AddEventHandler('gouv:removeAgent', function()
	--print(source)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		local identifier = user.identifier
		--print(identifier)
		MySQL:executeQuery("DELETE FROM gouv WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
	end)
end)

-- jail addon
-- RegisterServerEvent('jail:teleportToJail')
-- AddEventHandler('jail:teleportToJail', function(t, amount)
-- 	TriggerClientEvent('jail:teleportPlayer', t, amount)
-- end)
-- jail addon end

function checkIsAgent(identifier, source)
	local query = MySQL:executeQuery("SELECT * FROM gouv WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
	local result = MySQL:getResults(query, {'rank'}, "identifier")
	--print("TOTO")
	--print('----Result' .. result[1].rank .. '----')
	if(not result[1]) then
		TriggerClientEvent('gouv:receiveIsAgent', source, "inconnu")
	else
		TriggerClientEvent('gouv:receiveIsAgent', source, result[1].rank)
	end
end

function s_checkIsAgent(identifier)
	local query = MySQL:executeQuery("SELECT * FROM gouv WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
	local result = MySQL:getResults(query, {'rank'}, "identifier")
	
	if(not result[1]) then
		return "nil"
	else
		return result[1].rank
	end
end

function checkInventory(target)
	local strResult = GetPlayerName(target).." possede : "
	local identifier = ""
    TriggerEvent("es:getPlayerFromId", target, function(player)
		local money = player:dirty_money
		strResult = strResult .. money .. " d'argent sale , "
		--player:setDirty_Money(0)
		identifier = player.identifier
		local executed_query = MySQL:executeQuery("SELECT * FROM `user_inventory` JOIN items ON items.id = user_inventory.item_id WHERE user_id = '@username'", { ['@username'] = identifier })
		local result = MySQL:getResults(executed_query, { 'quantity', 'libelle', 'item_id', 'isIllegal' }, "item_id")
		if (result) then
			for _, v in ipairs(result) do
				if(v.quantity ~= 0) then
					strResult = strResult .. v.quantity .. " de " .. v.libelle .. ", "
				end
				-- if(v.isIllegal == "True") then
				-- 	TriggerClientEvent('police:dropIllegalItem', target, v.item_id)
				-- end
			end
		end
		
		strResult = strResult .. " / "
		
		local executed_query = MySQL:executeQuery("SELECT * FROM user_weapons WHERE identifier = '@username'", { ['@username'] = identifier })
		local result = MySQL:getResults(executed_query, { 'weapon_model' }, 'identifier' )
		if (result) then
			for _, v in ipairs(result) do
					strResult = strResult .. "possession de " .. v.weapon_model .. ", "
			end
			--TriggerEvent("weaponshop:RemoveWeaponsToPlayer",target)
		end
	end)
	
    return strResult
end

function saisirDyrtiMoney(target)
	local strResult = GetPlayerName(target).."ne possede plus les : "
	local identifier = ""
    TriggerEvent("es:getPlayerFromId", target, function(player)
		local money = player:dirty_money
		strResult = strResult .. money .. " d'argent sale , "
		player:setDirty_Money(0)
	end)
	
    return strResult
end

function saisirIllegal(target)
	local strResult = GetPlayerName(target).."ne possede plus les : "
	local identifier = ""
    TriggerEvent("es:getPlayerFromId", target, function(player)
		identifier = player.identifier
		local executed_query = MySQL:executeQuery("SELECT * FROM `user_inventory` JOIN items ON items.id = user_inventory.item_id WHERE user_id = '@username'", { ['@username'] = identifier })
		local result = MySQL:getResults(executed_query, { 'quantity', 'libelle', 'item_id', 'isIllegal' }, "item_id")
		if (result) then
			for _, v in ipairs(result) do
				if(v.quantity ~= 0) then
					strResult = strResult .. v.quantity .. " de " .. v.libelle .. ", "
				end
				 if(v.isIllegal == "True") then
				 	TriggerClientEvent('gouv:dropIllegalItem', target, v.item_id)
				 end
			end
		end
	end)
	
    return strResult
end

function saisirAllWeapon(target)
	local strResult = GetPlayerName(target).."ne possede plus : "
	local identifier = ""
    TriggerEvent("es:getPlayerFromId", target, function(player)
		identifier = player.identifier
		local executed_query = MySQL:executeQuery("SELECT * FROM user_weapons WHERE identifier = '@username'", { ['@username'] = identifier })
		local result = MySQL:getResults(executed_query, { 'weapon_model' }, 'identifier' )
		if (result) then
			for _, v in ipairs(result) do
					strResult = strResult .. "le " .. v.weapon_model .. ", "
			end
			TriggerEvent("weaponshop:RemoveWeaponsToPlayer",target)
		end
	end)
	
    return strResult
end

function saisirNoAchaWeapon(target)
	local strResult = GetPlayerName(target).."ne possede plus les armes qu'il n a pas acheté mais est toujours en : "
	local identifier = ""
    TriggerEvent("es:getPlayerFromId", target, function(player)
		identifier = player.identifier
		local executed_query = MySQL:executeQuery("SELECT * FROM user_weapons WHERE identifier = '@username'", { ['@username'] = identifier })
		local result = MySQL:getResults(executed_query, { 'weapon_model' }, 'identifier' )
		if (result) then
			for _, v in ipairs(result) do
					strResult = strResult .. "possession de " .. v.weapon_model .. ", "
			end
			TriggerEvent("weaponshop:GiveWeaponsToPlayer",target)
		end
	end)
	
    return strResult
end

function saisirRendreWeapon(target)
	local strResult = GetPlayerName(target).."a récupéré ces armes personnelles il est en  : "
	local identifier = ""
    TriggerEvent("es:getPlayerFromId", target, function(player)
		identifier = player.identifier
		local executed_query = MySQL:executeQuery("SELECT * FROM user_weapons WHERE identifier = '@username'", { ['@username'] = identifier })
		local result = MySQL:getResults(executed_query, { 'weapon_model' }, 'identifier' )
		if (result) then
			for _, v in ipairs(result) do
					strResult = strResult .. "possession de " .. v.weapon_model .. ", "
			end
			TriggerEvent("weaponshop:GiveWeaponsToPlayer",target)
		end
	end)
	
    return strResult
end


RegisterServerEvent('gouv:targetSaisirDyrtiMoney')
AddEventHandler('gouv:targetSaisirDyrtiMoney', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, saisirDyrtiMoney(t))
end)

RegisterServerEvent('gouv:targetSaisirIllegal')
AddEventHandler('gouv:targetSaisirIllegal', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, saisirIllegal(t))
end)

RegisterServerEvent('gouv:targetSaisirAllWeapon')
AddEventHandler('gouv:targetSaisirAllWeapon', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, saisirAllWeapon(t))
end)

RegisterServerEvent('gouv:targetSaisirNoAchaWeapon')
AddEventHandler('gouv:targetSaisirNoAchaWeapon', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, saisirNoAchaWeapon(t))
end)

RegisterServerEvent('gouv:targetSaisirRendreWeapon')
AddEventHandler('gouv:targetSaisirRendreWeapon', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, saisirRendreWeapon(t))
end)

AddEventHandler('playerDropped', function()
	if(inServiceAgents[source]) then
		inServiceAgents[source] = nil
		
		for i, c in pairs(inServiceAgents) do
			TriggerClientEvent("gouv:resultAllAgentsInService", i, inServiceAgents)
		end
	end
end)

AddEventHandler('es:playerDropped', function(player)
		local isAgent = s_checkIsAgent(player.identifier)
		if(isAgent ~= "nil") then
			--TriggerEvent("jobssystem:disconnectReset", player, 7)
		end
end)

RegisterServerEvent('gouv:checkIsAgent')
AddEventHandler('gouv:checkIsAgent', function()
	--print(source)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		local identifier = user.identifier
		--print(identifier)
		checkIsAgent(identifier, source)
	end)
end)

RegisterServerEvent('gouv:takeService')
AddEventHandler('gouv:takeService', function()
	if(not inServiceAgents[source]) then
		inServiceAgents[source] = GetPlayerName(source)
		
		for i, c in pairs(inServiceAgents) do
			TriggerClientEvent("gouv:resultAllAgentsInService", i, inServiceAgents)
		end
	end
end)

RegisterServerEvent('gouv:breakService')
AddEventHandler('gouv:breakService', function()
	if(inServiceAgents[source]) then
		inServiceAgents[source] = nil
		
		for i, c in pairs(inServiceAgents) do
			TriggerClientEvent("gouv:resultAllAgentsInService", i, inServiceAgents)
		end
	end
end)

RegisterServerEvent('gouv:getAllAgentsInService')
AddEventHandler('gouv:getAllAgentsInService', function()
	TriggerClientEvent("gouv:resultAllAgentsInService", source, inServiceAgents)
end)

RegisterServerEvent('gouv:checkingPlate')
AddEventHandler('gouv:checkingPlate', function(plate)
	local executed_query = MySQL:executeQuery("SELECT Nom FROM user_vehicle JOIN users ON user_vehicle.identifier = users.identifier WHERE vehicle_plate = '@plate'", { ['@plate'] = plate })
	local result = MySQL:getResults(executed_query, { 'Nom' }, "identifier")
	if (result[1]) then
		for _, v in ipairs(result) do
			TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Le vehicule #"..plate.." appartient a " .. v.Nom)
		end
	else
		TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Le vehicule #"..plate.." n'est pas enregistré !")
	end
end)

RegisterServerEvent('gouv:confirmUnseat')
AddEventHandler('gouv:confirmUnseat', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, GetPlayerName(t).. " est sortit !")
	TriggerClientEvent('gouv:unseatme', t)
end)

RegisterServerEvent('gouv:targetCheckInventory')
AddEventHandler('gouv:targetCheckInventory', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, checkInventory(t))
end)

RegisterServerEvent('gouv:finesGranted')
AddEventHandler('gouv:finesGranted', function(t, amount, reason)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, GetPlayerName(t).. " à payé $"..amount.." d'amende pour" .. reason)
	TriggerClientEvent('gouv:payFines', t, amount, reason)
end)

RegisterServerEvent('gouv:cuffGranted')
AddEventHandler('gouv:cuffGranted', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, GetPlayerName(t).. " menotes enlevées !")
	TriggerClientEvent('gouv:getArrested', t)
end)

RegisterServerEvent('gouv:forceEnterAsk')
AddEventHandler('gouv:forceEnterAsk', function(t, v)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, GetPlayerName(t).. " entre dans la voiture)")
	TriggerClientEvent('gouv:forcedEnteringVeh', t, v)
end)

-----------------------------------------------------------------------
----------------------EVENT SPAWN GOUV VEH---------------------------
-----------------------------------------------------------------------
RegisterServerEvent('CheckGouvVeh')
AddEventHandler('CheckGouvVeh', function(vehicle)
	TriggerEvent('es:getPlayerFromId', source, function(user)

			TriggerClientEvent('FinishGouvCheckForVeh',source)
			-- Spawn police vehicle
			TriggerClientEvent('gouvveh:spawnVehicle', source, vehicle)
	end)
end)

-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP AGENT-------------------
-----------------------------------------------------------------------
TriggerEvent('es:addGroupCommand', 'agentadd', "admin", function(source, args, user)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Usage : /agentadd [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				addAgent(target.identifier)
				TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "bien compris !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Gouvernment", false, "felicitation vous etes maintenant Policier~w~.")
				TriggerClientEvent('gouv:nowAgent', player)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Pas de joueur avec cette ID")
		end
	end
end, function(source, args, user) 
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Permissions refusees")
end)

TriggerEvent('es:addGroupCommand', 'agentrem', "admin", function(source, args, user) 
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Usage : /agentrem [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				remAgent(target.identifier)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Gouvernment", false, "Vous n'etes plus Policier~w~.")
				TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Roger that !")
				--TriggerClientEvent('chatMessage', player, 'GOUVERNMENT', {255, 0, 0}, "You're no longer a agent !")
				TriggerClientEvent('gouv:noLongerAgent', player)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Pas de joueur avec cette ID")
		end
	end
end, function(source, args, user) 
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Permissions refusees")
end)

	RegisterServerEvent('gouv:setService')
	AddEventHandler('gouv:setService', function (inService)
		TriggerEvent('es:getPlayerFromId', source , function (Player)
			Player:setSessionVar('gouvInService', inService)
		end)
	end)