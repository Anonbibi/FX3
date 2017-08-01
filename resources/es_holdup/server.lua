local stores = {
	["braquage_superette_san_andreas_avenue"] = {
		position = { ['x'] = -1220.89, ['y'] = -915.861, ['z'] = 10.826 },
		reward = math.random(7500, 10000),
		nameofstore = "SUPERETTE à SAN ANDREAS AVENUE (ROLS LIQUOR)",
		lastrobbed = 0,
		timeholdup = 180000,
		timetext = "3"

	},
	["braquage_superette_vespucci_boulvard"] = {
		position = { ['x'] = 1126.99, ['y'] = -980.134, ['z'] = 45.016 },
		reward = math.random(7500, 10000),
		nameofstore = "SUPERETTE à VESPUCCI BOULVARD (ROLS LIQUOR)",
		lastrobbed = 0,
		timeholdup = 180000,
		timetext = "3"
	},
	["braquage_superette_prosperity_street"] = {
		position = { ['x'] = -1478.93, ['y'] = -375.365, ['z'] = 38.663 },
		reward = math.random(7500, 10000),
		nameofstore = "SUPERETTE à PROSPERITY STREET (ROLS LIQUOR)",
		lastrobbed = 0,
		timeholdup = 180000,
		timetext = "3"
	},
	["braquage_superette_clinton_avenue"] = {
		position = { ['x'] = 380.29, ['y'] = 332.024, ['z'] = 103.056 },
		reward = math.random(7500, 10000),
		nameofstore = "SUPERETTE à CLINTON AVENUE (247 SUPER MARKET)",
		lastrobbed = 0,
		timeholdup = 180000,
		timetext = "3"
	}
}

local robbers = {}


function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('es_holdup:toofar')
AddEventHandler('es_holdup:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_holdup:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "Braquage annulé de : ^2" .. stores[robb].nameofstore)
	end
end)

RegisterServerEvent('es_holdup:stestcop')
AddEventHandler('es_holdup:stestcop', function(k)
	getPoliceInService( function(nbPolice) 
	TriggerEvent('es_holdup:rob',k,nbPolice,source)
	end)
end)

RegisterServerEvent('es_holdup:notifycop')
AddEventHandler('es_holdup:notifycop', function(storename)

	TriggerClientEvent('es_holdup:notifycop2',-1, "braquage en cours de : " .. storename .. ".")

end)


RegisterServerEvent('es_holdup:rob')
AddEventHandler('es_holdup:rob', function(robb,nbPolice,source)
	if nbPolice >= 3 then
		if stores[robb] then
			local store = stores[robb]

			if (os.time() - store.lastrobbed) < 600 and store.lastrobbed ~= 0 then
				TriggerClientEvent('chatMessage', source, 'BRAQUAGE', {255, 0, 0}, "Ce store à déja été cambriolé: ^2" .. (1800 - (os.time() - store.lastrobbed)) .. "^0 secondes.")
				return
			end
			TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "Braquage en cours ^2" .. store.nameofstore)
			TriggerEvent('es_holdup:notifycop',store.nameofstore)
			TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "vous avez commncer un braquage à ^2" .. store.nameofstore .. "^0, ne vous éloignez pas du magazin")
			TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "L'alarme à été déclanchée !")
			TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "tenez la position pendant ^1" .. store.timetext .. "^0minutes et empochez l'argent")
			TriggerClientEvent('es_holdup:currentlyrobbing', source, robb)
			stores[robb].lastrobbed = os.time()
			robbers[source] = robb
			local savedSource = source
			SetTimeout(store.timeholdup, function()
				if(robbers[savedSource])then
					TriggerClientEvent('es_holdup:robberycomplete', savedSource, job)
					TriggerEvent('es:getPlayerFromId', savedSource, function(target) 
						if(target)then
						target:addDirty_Money(store.reward) 
						TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "Braquage fini de : ^2" .. store.nameofstore)
						end
					end)
				end
			end)		
		end
	else
		TriggerClientEvent('chatMessage', source, 'HOLDUP', {255, 0, 0}, "Pas assez de policiers en ligne")
	end
end)



function getPoliceInService(cb)
	TriggerEvent('es:getPlayers', function(players)
		local nbPolice = 0
		for i,p in pairs(players) do
			if p:getSessionVar('policeInService') == true then
				nbPolice = nbPolice + 1
			end
		end
		cb(nbPolice)
	end)
end