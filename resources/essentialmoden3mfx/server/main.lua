-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --

_VERSION = '1.4.2'

-- Server
Users = {}
commands = {}
settings = {}
settings.defaultSettings = {
	['banReason'] = "Vous avez été bannis, aucun retour possible.",
	['listmsg'] = "You are not whitelisted !",
	['pvpEnabled'] = true, -- PLAYER VS PLAYER ?
	['permissionDenied'] = false, -- NO IMPORTANT
	['debugInformation'] = false, -- NO IMPORTANT
	['startingCash'] = 5000, -- FIRST JOIN, MONEY ?
	['startingBank'] = 1000, -- FIRST JOIN, MONEY IN BANK ?
	['enableRankDecorators'] = false, -- COLORS RANKS ?
	['moneyIcon'] = "€", -- ICON MONEY ? €, $, £ ...
	['nativeMoneySystem'] = false, -- USELESS (LET FALSE)
	['commandDelimeter'] = '/', -- NO IMPORTNT
	['dirtyMoneyShow'] = true, -- SHOW DIRTY MONEY ?
	['showBankBalance'] = false, -- SHOW BANK BALANCE ?
	['tpLastPos'] = false -- TP PLAYER TO POS WHEN DISCONNECTED ?
}
settings.sessionSettings = {}

-- Version check
-- PerformHttpRequest("http://poliakov.tk/version.txt", function(err, rText, headers)
-- 	print("\nCurrent version: " .. _VERSION)
-- 	print("Updater version: " .. rText .. "\n")

-- 	if rText ~= _VERSION then
-- 		print("\n---------------------------------------------\nVersion mismatch, you are currently not using the newest stable version of essentialmode. Please update: http://poliakov.tk\n---------------------------------------------\n")
-- 	else
-- 		print("Version OK!\n")
-- 	end
-- end, "GET", "", {what = 'this'})

AddEventHandler('playerConnecting', function(name, setCallback)
	local identifiers = GetPlayerIdentifiers(source)

	for i = 1, #identifiers do
		local identifier = identifiers[i]
		debugMsg('Checking user ban: ' .. identifier .. " (" .. name .. ")")

		local banned = isIdentifierBanned(identifier)
		local listed = isWhiteListed(identifier)
		print(listed)
    	if(listed)then
    		if(type(settings.defaultSettings.listmsg) == "string")then
    			setCallback(settings.defaultSettings.listmsg)
    		elseif(type(settings.defaultSettings.listmsg) == "function")then
    			setCallback(settings.defaultSettings.listmsg(identifier, name))
    		else
    			setCallback("Not whitelisted !")
    		end
    		CancelEvent()
    	end
		if(banned)then
			if(type(settings.defaultSettings.banreason) == "string")then
				setCallback(settings.defaultSettings.banreason)
			elseif(type(settings.defaultSettings.banreason) == "function")then
				setCallback(settings.defaultSettings.banreason(identifier, name))
			else
				setCallback("Default ban reason error")
			end
			CancelEvent()
		end
	end
end)


AddEventHandler('playerDropped', function()
	local Source = source

	if(Users[Source])then
		TriggerEvent("es:playerDropped", Users[Source])
		if(settings.defaultSettings.tpLastPos)then
			MySQL.Async.execute("UPDATE users SET `money`=@valmoney, `bankbalance`=@valbankbalance, `dirty_money`=@valdirtymoney, `lastPosition`=@vallastposition WHERE identifier = @identifier",
			{['@valmoney'] = Users[Source].getMoney(), ['@valbankbalance'] = Users[Source].getBank(), ['@valdirtymoney'] = Users[Source].getDirtyMoney(), ['vallastposition'] = json.encode(Users[Source].getCoords()), ['@identifier'] = Users[Source].getIdentifier()})
		else
			MySQL.Async.execute("UPDATE users SET `money`=@valmoney, `bankbalance`=@valbankbalance, `dirty_money`=@valdirtymoney WHERE identifier = @identifier",
			{['@valmoney'] = Users[Source].getMoney(), ['@valbankbalance'] = Users[Source].getBank(), ['@valdirtymoney'] = Users[Source].getDirtyMoney(), ['@identifier'] = Users[Source].getIdentifier()})
		end
		Users[Source] = nil
	end
end)

local justJoined = {}


RegisterServerEvent('es:firstJoinProper')
AddEventHandler('es:firstJoinProper', function()
	registerUser(GetPlayerIdentifiers(source)[1], source)
	justJoined[source] = true

	if(settings.defaultSettings.pvpEnabled)then
		TriggerClientEvent("es:enablePvp", source)
	end
end)
-- RegisterServerEvent('es:firstJoinProper')
-- AddEventHandler('es:firstJoinProper', function()
-- 	local identifiers = GetPlayerIdentifiers(source)
-- 	for i = 1, #identifiers do
-- 		if(Users[source] == nil)then
-- 			--debugMsg("Essential | Loading user: " .. GetPlayerName(source))

-- 			local identifier = identifiers[i]
-- 			registerUser(identifier, source)

-- 			--TriggerEvent('es:initialized', source)
-- 			justJoined[source] = true

-- 			if(settings.defaultSettings.pvpEnabled)then
-- 				TriggerClientEvent("es:enablePvp", source)
-- 			end
-- 		end
-- 	end
-- end)

AddEventHandler('es:setSessionSetting', function(k, v)
	settings.sessionSettings[k] = v
end)

AddEventHandler('es:getSessionSetting', function(k, cb)
	cb(settings.sessionSettings[k])
end)

local firstSpawn = {}

-- RegisterServerEvent('playerSpawn')
-- AddEventHandler('playerSpawn', function()
-- 	local Source = source
-- 	if(firstSpawn[Source] == nil)then
-- 		TriggerEvent("es:firstSpawn", Source, Users[Source])

-- 		firstSpawn[Source] = true
-- 	end
-- end)

RegisterServerEvent('playerSpawn')
AddEventHandler('playerSpawn', function()
	if(justJoined[source])then
		TriggerEvent("es:firstSpawn", source)
		justJoined[source] = nil
	end
end)

AddEventHandler("es:setDefaultSettings", function(tbl)
	for k,v in pairs(tbl) do
		if(settings.defaultSettings[k] ~= nil)then
			settings.defaultSettings[k] = v
		end
	end

	debugMsg("Default settings edited.")
end)

AddEventHandler('chatMessage', function(source, n, message)
	if(startswith(message, settings.defaultSettings.commandDelimeter))then
		local command_args = stringsplit(message, " ")

		command_args[1] = string.gsub(command_args[1], settings.defaultSettings.commandDelimeter, "")

		local command = commands[command_args[1]]

		if(command)then
			CancelEvent()
			if(command.perm > 0)then
				if(Users[source].getPermissions() >= command.perm or groups[Users[source].getGroup()].canTarget(command.group)) then
					command.cmd(source, command_args, Users[source])
					TriggerEvent("es:adminCommandRan", source, command_args, Users[source])
				else
					command.callbackfailed(source, command_args, Users[source])
					TriggerEvent("es:adminCommandFailed", source, command_args, Users[source])

					if(type(settings.defaultSettings.permissionDenied) == "string" and not WasEventCanceled())then
						TriggerClientEvent('chatMessage', source, "", {0,0,0}, defaultSettings.permissionDenied)
					end

					debugMsg("Non admin (" .. GetPlayerName(source) .. ") attempted to run admin command: " .. command_args[1])
				end
			else
				command.cmd(source, command_args, Users[source])
				TriggerEvent("es:userCommandRan", source, command_args)
			end

			TriggerEvent("es:commandRan", source, command_args, Users[source])
		else
			TriggerEvent('es:invalidCommandHandler', source, command_args, Users[source])

			if WasEventCanceled() then
				CancelEvent()
			end
		end
	else
		TriggerEvent('es:chatMessage', source, message, Users[source])
	end
end)

function addCommand(command, callback)
	commands[command] = {}
	commands[command].perm = 0
	commands[command].group = "user"
	commands[command].cmd = callback

	debugMsg("addCommand: " .. command)
end

AddEventHandler('es:addCommand', function(command, callback)
	addCommand(command, callback)
end)

function addAdminCommand(command, perm, callback, callbackfailed)
	commands[command] = {}
	commands[command].perm = perm
	commands[command].group = "superadmin"
	commands[command].cmd = callback
	commands[command].callbackfailed = callbackfailed

	debugMsg("Admin command added: " .. command .. ", requires permission level: " .. perm)
end

AddEventHandler('es:addAdminCommand', function(command, perm, callback, callbackfailed)
	addAdminCommand(command, perm, callback, callbackfailed)
end)

function addGroupCommand(command, group, callback, callbackfailed)
	commands[command] = {}
	commands[command].perm = math.maxinteger
	commands[command].group = group
	commands[command].cmd = callback
	commands[command].callbackfailed = callbackfailed

	debugMsg("Group command added: " .. command .. ", requires group: " .. group)
end

AddEventHandler('es:addGroupCommand', function(command, group, callback, callbackfailed)
	addGroupCommand(command, group, callback, callbackfailed)
end)

function addACECommand(command, group, callback)
	local allowedEveryone = false
	if group == true then allowedEveryone = true end
	RegisterCommand(command, function(source, args)
		if source ~= 0 then
			callback(source, args, Users[source])
		end
	end, allowedEveryone)

	if not allowedEveryone then
		ExecuteCommand('add_ace group.' .. group .. ' command.' .. command .. ' allow')
	end
end

AddEventHandler('es:addACECommand', function(command, group, callback)
	addACECommand(command, group, callback)
end)

RegisterServerEvent('es:updatePositions')
AddEventHandler('es:updatePositions', function(x, y, z)
	if(Users[source])then
		Users[source].setCoords(x, y, z)
	end
end)
