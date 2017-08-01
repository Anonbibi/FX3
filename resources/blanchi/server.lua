
RegisterServerEvent('blanchi:transform')
AddEventHandler('blanchi:transform', function ()
	TriggerEvent('es:getPlayerFromId', source, function(user)
			local sale = user:dirty_money
			if sale > 0 then
				user:addMoney(tonumber(sale))
				user:removeDirty_Money(tonumber(sale))
			end
				TriggerClientEvent('blanchi:drawTransform',source,sale)
	end)
end)

RegisterServerEvent('blanchi:stestcop')
AddEventHandler('blanchi:stestcop', function()
	getPoliceInService( function(nbPolicier) 
	local nbPolice = nbPolicier
	TriggerClientEvent('blanchi:getcop',-1,nbPolice)
	end)
	
end)

function getPoliceInService(cb)
	TriggerEvent('es:getPlayers', function(players)
		local nbPolicier = 0
		for i,p in pairs(players) do
			if p:getSessionVar('policeInService') == true then
				nbPolicier = nbPolicier + 1
			end
		end
		cb(nbPolicier)
	end)
end
