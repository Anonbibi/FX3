-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --

-- VERSION MYSQL ASYNC BY POLIAKOV (aka PERVS)--

function LoadUser(identifier, source, new)
	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = identifier}, function (result)
		Users[source] = CreatePlayer(source, result[1].permission_level, result[1].money, result[1].bankbalance, result[1].identifier, result[1].group, result[1].dirty_money, result[1].nom, result[1].prenom, result[1].phone_number, result[1].isFirstConnection)
		TriggerEvent('es:playerLoaded', source, Users[source])

		TriggerClientEvent('es:setPlayerDecorator', source, 'rank', Users[source].getPermissions())
		TriggerClientEvent('es:setMoneyIcon', source,settings.defaultSettings.moneyIcon)

		Users[source].setMoney(result[1].money)
		if(settings.defaultSettings.showBankBalance)then
			Users[source].setBankBalance(result[1].bankbalance)
		end
		if(settings.defaultSettings.dirtyMoneyShow)then
			Users[source].setDirtyMoney(result[1].dirty_money)
		end
		if(new)then
			TriggerEvent('es:newPlayerLoaded', source, Users[source])
		end
		if(settings.defaultSettings.tpLastPos)then
			local coordsForSpawn = json.decode(result[1].lastPosition)
			TriggerClientEvent('es:setSpawnCoords_c', source, coordsForSpawn)
		end
	end)
end

function stringsplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end

function getPlayerFromId(id)
	return Users[id]
end

function isIdentifierBanned(id)
	MySQL.Async.fetchAll("SELECT * FROM bans WHERE banned = '@name'", {['@name'] = id}, function (result)

		if(result)then
			for k,v in ipairs(result)do
				if v.expires > v.timestamp then
					return true
				end
			end
		end

		return false
	end)
end

function isWhiteListed(identifier)
    MySQL.Async.fetchAll("SELECT * FROM whitelist WHERE identifier = '@name'", {['@name'] = identifier}, function (result)
    	if(result)then
    		for k,v in ipairs(result)do
    			if v.listed == 1 or v.listed == 99 then
    				return false
    			end
    		end
    	end

    	return true
  end)
end

AddEventHandler('es:getPlayers', function(cb)
	cb(Users)
end)

function hasAccount(identifier, callback)
	local result = MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = identifier}, function (result)
		if(result[1] ~= nil) then
			callback(true)
		else
			callback(false)
		end
	end)
end

function isLoggedIn(source)
	if(Users[GetPlayerName(source)] ~= nil)then
	if(Users[GetPlayerName(source)]['isLoggedIn'] == 1) then
		return true
	else
		return false
	end
	else
		return false
	end
end

function registerUser(identifier, source)
	hasAccount(identifier, function (result)
		if result then
			LoadUser(identifier, source, false)
		else
			MySQL.Async.execute("INSERT INTO users (`identifier`, `money`, `bankbalance`) VALUES (@identifier,@money,@bankbalance)", {['@identifier'] = identifier, ['@money'] = settings.defaultSettings.startingCash, ['@bankbalance'] = settings.defaultSettings.startingBank})

			LoadUser(identifier, source, true)
		end
	end)
end

AddEventHandler("es:setPlayerData", function(user, k, v, cb)
	if(Users[user])then
		if(Users[user].get(k))then
			if(k ~= "money") then
				Users[user].set(k, v)

				MySQL.Async.execute("UPDATE users SET @key=@value WHERE identifier = @identifier",
				{['@key'] = k, ['@value'] = v, ['@identifier'] = Users[user]['identifier']})
			end

			if(k == "group")then
				Users[user].set(k, v)
			end

		else
			cb("Column does not exist!", false)
		end
	else
		cb("User could not be found!", false)
	end
end)

AddEventHandler("es:setPlayerDataId", function(user, k, v, cb)
	MySQL.Async.execute("UPDATE users SET @key=@value WHERE identifier = @identifier",
	{['@key'] = k, ['@value'] = v, ['@identifier'] = user})

	cb("Player data edited.", true)
end)

AddEventHandler("es:getPlayerFromId", function(user, cb)
	if(Users)then
		if(Users[user])then
			cb(Users[user])
		else
			cb(nil)
		end
	else
		cb(nil)
	end
end)

AddEventHandler("es:getAllPlayerConnected", function(cb)
	return cb(Users)
end)

AddEventHandler("es:getPlayerFromIdentifier", function(identifier, cb)
	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = identifier}, function (result)
		if(result[1])then
			cb(result[1])
		else
			cb(nil)
		end
	end)
end)

AddEventHandler("es:getAllPlayers", function(cb)
	MySQL.Async.fetchAll("SELECT * FROM users", {}, function (result)

	if(result)then
		cb(result)
	else
		cb(nil)
	end
end)
end)
-- Function to update player money every 60 seconds.
local function savePlayerMoney()
	SetTimeout(60000, function()
			for k,v in pairs(Users)do
				if Users[k] ~= nil then
					MySQL.Async.execute("UPDATE users SET `money`=@valMoney, `bankbalance`=@valBankBalance, `dirty_money`=@valDirtyMoney WHERE identifier = @identifier",
					{['@valMoney'] = v.getMoney(), ['@valBankBalance'] = v.getBank(), ['@valDirtyMoney'] = v.getDirtyMoney(), ['@identifier'] = v.getIdentifier()})
				end
			end

		savePlayerMoney()
	end)
end

savePlayerMoney()
