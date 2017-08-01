TriggerEvent("es:addGroup", "admin", "user", function(group) end)

--Help Commands
TriggerEvent('es:addCommand', 'help', function(source, args, user)
  TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "Player Commands ")
	TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "-------------------------------------------------------")
	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "/pv - Get teleported in your personal vehicle")
	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "/rmwanted - Remove your wanted level")
end)

TriggerEvent('es:addCommand', 'group', function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Group: ^2" .. user.group.group)
end)

-- Kicking
TriggerEvent('es:addGroupCommand', 'kick', "admin", function(source, args, user)
		if(GetPlayerName(tonumber(args[2])))then
			local player = tonumber(args[2])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)
				if(tonumber(target.permission_level) > tonumber(user.permission_level))then
					TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "vous ne pouvez pas cibler cette personne")
					return
				end

				local reason = args
				table.remove(reason, 1)
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "Kicker: Vous avez été kicker du serveur"
				else
					reason = "Kicked: " .. table.concat(reason, " ")
				end

				TriggerClientEvent('chatMessage', -1, "SYSTEM", {255, 0, 0}, "Le joueur ^2" .. GetPlayerName(player) .. "^0 a été kicker(^2" .. reason .. "^0)")
				DropPlayer(player, reason)
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID du joueur incorrecte !")
		end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Vous n'avez pas la permission !")
end)


TriggerEvent('es:addCommand', 'rmwanted', function(source)
  TriggerEvent("es:getPlayerFromId", source, function(user)
    if(user.money > 100) then
			user:removeMoney((100))
			TriggerClientEvent('es_freeroam:wanted', source)
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_LESTER", 1, "Lester", false, "Troubles in paradise are fixed")
		else
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_LESTER", 1, "Lester", false, "Désolé mais vous avez besoin de plus d'argent avant de pouvoir avoir mon aide")
		end
	end)
end)
