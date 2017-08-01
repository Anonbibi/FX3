AddEventHandler('playerConnecting', function()
	TriggerClientEvent('showNotification', -1,"~g~".. GetPlayerName(source).."~w~ est arriver en Ville.")
	sendToDiscord('SYSTEM', GetPlayerName(source) .. ' est arriver en Ville.')
end)

AddEventHandler('playerDropped', function()
	TriggerClientEvent('showNotification', -1,"~r~".. GetPlayerName(source).."~w~ est parti de la Ville.")
	sendToDiscord('SYSTEM', GetPlayerName(source) .. ' est parti de la Ville.')
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason)
	if killer == "**Invalid**" then --Can't figure out what's generating invalid, it's late. If you figure it out, let me know. I just handle it as a string for now.
		reason = 2
	end
	if reason == 0 then
		TriggerClientEvent('showNotification', -1,"~o~".. GetPlayerName(source).."~w~ s'est sucider. ")
		sendToDiscord('SYSTEM', GetPlayerName(source).."s'est sucider. ")
	elseif reason == 1 then
		TriggerClientEvent('showNotification', -1,"~o~".. killer .. "~w~ à tué ~o~"..GetPlayerName(source).."~w~.")
		sendToDiscord('SYSTEM', killer .. " à tué"..GetPlayerName(source)..".")
	else
		TriggerClientEvent('showNotification', -1,"~o~".. GetPlayerName(source).."~w~ est mort.")
		sendToDiscord('SYSTEM', killer .. "à tué"..GetPlayerName(source)..".")
	end
end)



function sendToDiscord(name, message)
  if message == nil or message == '' then return FALSE end
  PerformHttpRequest('https://discordapp.com/api/webhooks/333855783177420802/JrTNDTMPE1Qnt7n7yB68Z8gXJpJI-ZslDYzt37-rSj308xfpzm1Cgl7gtxvTEIqNt55i', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end