require "resources/essentialmode/lib/MySQL"
MySQL:open(database.host, database.name, database.username, database.password)

RegisterServerEvent('chasse:serverRequest')
AddEventHandler('chasse:serverRequest', function (typeRequest)
	TriggerEvent ('es:getPlayerFromId', source, function(user)
		local player = user.identifier
		
		if typeRequest == "SellViande" then
					local query = MySQL:executeQuery("SELECT quantity FROM user_inventory WHERE item_id=23 AND user_id='@identifier'", {['@identifier'] = player})
					local result = MySQL:getResults(query, { 'quantity' })
					local qte
					for _, v in ipairs(result) do
						qte = v.quantity
					end
					TriggerClientEvent('chasse:drawSellViande',source,qte)
		end
	end)
end)

