-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --

-- restart essentialmode

function CreatePlayer(source, permission_level, money, bank, identifier, group, dirtymoney)
	local self = {}

	self.source = source
	self.permission_level = permission_level
	self.money = money
	self.dirtymoney = dirtymoney
	self.bank = bank
	self.identifier = identifier
	self.group = group
	self.coords = {x = 0.0, y = 0.0, z = 0.0}
	self.session = {}
	self.bankDisplayed = true

	local rTable = {}

	rTable.setMoney = function(m)
		local prevMoney = self.money
		local newMoney = m

		self.money = m

		if((prevMoney - newMoney) < 0)then
			TriggerClientEvent("es:addedMoney", self.source, math.abs(prevMoney - newMoney))
		else
			TriggerClientEvent("es:removedMoney", self.source, math.abs(prevMoney - newMoney))
		end
		TriggerClientEvent('es:activateMoney', self.source , self.money)
	end

	rTable.getMoney = function()
		return self.money
	end

	rTable.setDirtyMoney = function(m)
		local prevMoney = self.dirtymoney
		local newMoney = m

		self.dirtymoney = m

		if((prevMoney - newMoney) < 0)then
			TriggerClientEvent("es:addedDirtyMoney", self.source, math.abs(prevMoney - newMoney))
		else
			TriggerClientEvent("es:removedDirtyMoney", self.source, math.abs(prevMoney - newMoney))
		end
		TriggerClientEvent('es:activateDirtyMoney', self.source , self.dirtymoney, settings.defaultSettings.dirtyMoneyShow)
	end

	rTable.getDirtyMoney = function()
		return self.dirtymoney
	end

	rTable.setBankBalance = function(m)
		self.bank = m
		if(settings.defaultSettings.showBankBalance)then
			TriggerClientEvent('es:activateBankMoney', self.source , self.bank, settings.defaultSettings.showBankBalance)
		end
	end

	rTable.getBank = function()
		return self.bank
	end

	rTable.getCoords = function()
		return self.coords
	end

	rTable.setCoords = function(x, y, z)
		self.coords = {x = x, y = y, z = z}
	end

	rTable.kick = function(r)
		DropPlayer(self.source, r)
	end

	rTable.addMoney = function(m)
		local newMoney = self.money + m

		self.money = newMoney

		TriggerClientEvent("es:addedMoney", self.source, m)
		TriggerClientEvent('es:activateMoney', self.source , self.money)
	end

	rTable.removeMoney = function(m)
		local newMoney = self.money - m

		self.money = newMoney

		TriggerClientEvent("es:removedMoney", self.source, m)
		TriggerClientEvent('es:activateMoney', self.source , self.money)
	end

	rTable.addDirtyMoney = function(m)
		local newMoney = self.dirtymoney + m

		self.dirtymoney = newMoney
		if(settings.defaultSettings.dirtyMoneyShow)then
			TriggerClientEvent("es:addedMoney", self.source, m)
			TriggerClientEvent('es:activateDirtyMoney', self.source , self.dirtymoney, settings.defaultSettings.dirtyMoneyShow)
		end
	end

	rTable.removeDirtyMoney = function(m)
		local newMoney = self.dirtymoney - m

		self.dirtymoney = newMoney
		if(settings.defaultSettings.dirtyMoneyShow)then
			TriggerClientEvent("es:removedMoney", self.source, m)
			TriggerClientEvent('es:activateDirtyMoney', self.source , self.dirtymoney, settings.defaultSettings.dirtyMoneyShow)
		end
	end

	rTable.addBank = function(m)
		local newBank = self.bank + m
		self.bank = newBank
		if(settings.defaultSettings.showBankBalance)then
			TriggerClientEvent('es:activateBankMoney', self.source , self.bank, settings.defaultSettings.showBankBalance)
		end
	end

	rTable.removeBank = function(m)
		local newBank = self.bank - m
		self.bank = newBank
		if(settings.defaultSettings.showBankBalance)then
			TriggerClientEvent('es:activateBankMoney', self.source , self.bank, settings.defaultSettings.showBankBalance)
		end
	end

	rTable.displayMoney = function(m)
		TriggerClientEvent('es:activateMoney', self.source , self.money)
	end

	rTable.setSessionVar = function(key, value)
		self.session[key] = value
	end

	rTable.getSessionVar = function(k)
		return self.session[k]
	end

	rTable.getPermissions = function()
		return self.permission_level
	end

	rTable.setPermissions = function(p)
		self.permission_level = p
	end

	rTable.getIdentifier = function()
		return self.identifier
	end

	rTable.getGroup = function()
		return self.group
	end

	rTable.set = function(k, v)
		self[k] = v
	end

	rTable.get = function(k)
		return self[k]
	end

	rTable.setGlobal = function(g, default)
		self[g] = default or ""

		rTable["get" .. g:gsub("^%l", string.upper)] = function()
			return self[g]
		end

		rTable["set" .. g:gsub("^%l", string.upper)] = function(e)
			self[g] = e
		end

		Users[self.source] = rTable
	end

	return rTable
end