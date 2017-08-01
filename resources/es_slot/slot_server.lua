RegisterServerEvent('es_slot:sv:1')
AddEventHandler('es_slot:sv:1', function(amount,a,b,c)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.dirty_money) >= tonumber(amount)) then
			user:removeDirty_Money(amount)
			TriggerClientEvent("es_slot:1",source,tonumber(amount),tostring(a),tostring(b),tostring(c))
		else
			TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Vous n'avez pas assez d'argent sale!^0")
		end
	end)
end)
RegisterServerEvent('es_slot:sv:2')
AddEventHandler('es_slot:sv:2', function(amount)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		user:addMoney(amount)
	end)
end)
