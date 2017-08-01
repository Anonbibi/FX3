require "resources/essentialmode/lib/MySQL"
MySQL:open(database.host, database.name, database.username, database.password)

local inServiceMembres = {}

function addMembre(identifier)
	MySQL:executeQuery("INSERT INTO hcdh (`identifier`) VALUES ('@identifier')", { ['@identifier'] = identifier})
end

function remMembre(identifier)
	MySQL:executeQuery("DELETE FROM hcdh WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
end

RegisterServerEvent('hcdh:removeMembre')
AddEventHandler('hcdh:removeMembre', function()
	--print(source)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		local identifier = user.identifier
		--print(identifier)
		MySQL:executeQuery("DELETE FROM hcdh WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
	end)
end)

-- jail addon
-- RegisterServerEvent('jail:teleportToJail')
-- AddEventHandler('jail:teleportToJail', function(t, amount)
-- 	TriggerClientEvent('jail:teleportPlayer', t, amount)
-- end)
-- jail addon end

function checkIsMembre(identifier, source)
	local query = MySQL:executeQuery("SELECT * FROM hcdh WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
	local result = MySQL:getResults(query, {'rank'}, "identifier")
	--print("TOTO")
	--print('----Result' .. result[1].rank .. '----')
	if(not result[1]) then
		TriggerClientEvent('hcdh:receiveIsMembre', source, "inconnu")
	else
		TriggerClientEvent('hcdh:receiveIsMembre', source, result[1].rank)
	end
end

function s_checkIsMembre(identifier)
	local query = MySQL:executeQuery("SELECT * FROM hcdh WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
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
				 	TriggerClientEvent('hcdh:dropIllegalItem', target, v.item_id)
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


RegisterServerEvent('hcdh:targetSaisirDyrtiMoney')
AddEventHandler('hcdh:targetSaisirDyrtiMoney', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, saisirDyrtiMoney(t))
end)

RegisterServerEvent('hcdh:targetSaisirIllegal')
AddEventHandler('hcdh:targetSaisirIllegal', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, saisirIllegal(t))
end)

RegisterServerEvent('hcdh:targetSaisirAllWeapon')
AddEventHandler('hcdh:targetSaisirAllWeapon', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, saisirAllWeapon(t))
end)

RegisterServerEvent('hcdh:targetSaisirNoAchaWeapon')
AddEventHandler('hcdh:targetSaisirNoAchaWeapon', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, saisirNoAchaWeapon(t))
end)

RegisterServerEvent('hcdh:targetSaisirRendreWeapon')
AddEventHandler('hcdh:targetSaisirRendreWeapon', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, saisirRendreWeapon(t))
end)

AddEventHandler('playerDropped', function()
	if(inServiceMembres[source]) then
		inServiceMembres[source] = nil
		
		for i, c in pairs(inServiceMembres) do
			TriggerClientEvent("hcdh:resultAllMembresInService", i, inServiceMembres)
		end
	end
end)

AddEventHandler('es:playerDropped', function(player)
		local isMembre = s_checkIsMembre(player.identifier)
		if(isMembre ~= "nil") then
			--TriggerEvent("jobssystem:disconnectReset", player, 7)
		end
end)

RegisterServerEvent('hcdh:checkIsMembre')
AddEventHandler('hcdh:checkIsMembre', function()
	--print(source)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		local identifier = user.identifier
		--print(identifier)
		checkIsMembre(identifier, source)
	end)
end)

RegisterServerEvent('hcdh:takeService')
AddEventHandler('hcdh:takeService', function()
	if(not inServiceMembres[source]) then
		inServiceMembres[source] = GetPlayerName(source)
		
		for i, c in pairs(inServiceMembres) do
			TriggerClientEvent("hcdh:resultAllMembresInService", i, inServiceMembres)
		end
	end
end)

RegisterServerEvent('hcdh:breakService')
AddEventHandler('hcdh:breakService', function()
	if(inServiceMembres[source]) then
		inServiceMembres[source] = nil
		
		for i, c in pairs(inServiceMembres) do
			TriggerClientEvent("hcdh:resultAllMembresInService", i, inServiceMembres)
		end
	end
end)

RegisterServerEvent('hcdh:getAllMembresInService')
AddEventHandler('hcdh:getAllMembresInService', function()
	TriggerClientEvent("hcdh:resultAllMembresInService", source, inServiceMembres)
end)

RegisterServerEvent('hcdh:checkingPlate')
AddEventHandler('hcdh:checkingPlate', function(plate)
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

RegisterServerEvent('hcdh:confirmUnseat')
AddEventHandler('hcdh:confirmUnseat', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, GetPlayerName(t).. " est sortit !")
	TriggerClientEvent('hcdh:unseatme', t)
end)

RegisterServerEvent('hcdh:targetCheckInventory')
AddEventHandler('hcdh:targetCheckInventory', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, checkInventory(t))
end)

RegisterServerEvent('hcdh:finesGranted')
AddEventHandler('hcdh:finesGranted', function(t, amount, reason)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, GetPlayerName(t).. " à payé $"..amount.." d'amende pour" .. reason)
	TriggerClientEvent('hcdh:payFines', t, amount, reason)
end)

RegisterServerEvent('hcdh:cuffGranted')
AddEventHandler('hcdh:cuffGranted', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, GetPlayerName(t).. " menotes enlevées !")
	TriggerClientEvent('hcdh:getArrested', t)
end)

RegisterServerEvent('hcdh:forceEnterAsk')
AddEventHandler('hcdh:forceEnterAsk', function(t, v)
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, GetPlayerName(t).. " entre dans la voiture)")
	TriggerClientEvent('hcdh:forcedEnteringVeh', t, v)
end)

-----------------------------------------------------------------------
----------------------EVENT SPAWN GOUV VEH---------------------------
-----------------------------------------------------------------------
RegisterServerEvent('CheckHcdhVeh')
AddEventHandler('CheckHcdhVeh', function(vehicle)
	TriggerEvent('es:getPlayerFromId', source, function(user)

			TriggerClientEvent('FinishHcdhCheckForVeh',source)
			-- Spawn police vehicle
			TriggerClientEvent('hcdhveh:spawnVehicle', source, vehicle)
	end)
end)

-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP AGENT-------------------
-----------------------------------------------------------------------
TriggerEvent('es:addGroupCommand', 'membreadd', "admin", function(source, args, user)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Usage : /membreadd [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				addMembre(target.identifier)
				TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "bien compris !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Hcdhernment", false, "felicitation vous etes maintenant Policier~w~.")
				TriggerClientEvent('hcdh:nowMembre', player)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Pas de joueur avec cette ID")
		end
	end
end, function(source, args, user) 
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Permissions refusees")
end)

TriggerEvent('es:addGroupCommand', 'membrerem', "admin", function(source, args, user) 
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Usage : /membrerem [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				remMembre(target.identifier)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Hcdhernment", false, "Vous n'etes plus Policier~w~.")
				TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Roger that !")
				--TriggerClientEvent('chatMessage', player, 'GOUVERNMENT', {255, 0, 0}, "You're no longer a membre !")
				TriggerClientEvent('hcdh:noLongerMembre', player)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Pas de joueur avec cette ID")
		end
	end
end, function(source, args, user) 
	TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "Permissions refusees")
end)

	RegisterServerEvent('hcdh:setService')
	AddEventHandler('hcdh:setService', function (inService)
		TriggerEvent('es:getPlayerFromId', source , function (Player)
			Player:setSessionVar('hcdhInService', inService)
		end)
	end)