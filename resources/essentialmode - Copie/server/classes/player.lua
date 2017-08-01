-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --

-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"

-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open(database.host, database.name, database.username, database.password)


-- Constructor
Player = {}
Player.__index = Player

-- Meta table for users
setmetatable(Player, {
	__call = function(self, source, permission_level, money, dirty_money, identifier, group, nom, prenom, phoneNumber, isFirstConnection, jobId, jobName, jobSalary)
		local pl = {}

		pl.source = source
		pl.permission_level = permission_level
		pl.money = money
		pl.dirty_money = dirty_money
		pl.identifier = identifier
		pl.group = group
		pl.coords = {x = 0.0, y = 0.0, z = 0.0}
		pl.session = {}
		pl.nom = nom
		pl.prenom = prenom
		pl.phoneNumber = phoneNumber
		pl.jobId = jobId
		pl.jobName = jobName
		pl.jobSalary = jobSalary
		pl.isFirstConnection = isFirstConnection

		return setmetatable(pl, Player)
	end
})

------------------------------------------------- AJOUT N3MTV ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

------------ SETTER --------
function Player:setName(name)
	self.nom = name
end

function Player:setLastName(lastname)
	self.prenom = lastname
end

function Player:setPhoneNumber(phone_number)
	self.phone_number = phone_number
end

function Player:setJobId(job_id)
	self.job_id = job_id
	local executed_query = MySQL:executeQuery("SELECT * FROM jobs WHERE job_id = '@job_id'", {['@job_id'] = job_id})
	local result = MySQL:getResults(executed_query, {'job_name', 'salary'}, "job_id")
	if result[1] ~= nil then
		self.jobName = result[1].job_name
	end
end

------------ GETTER --------
function Player:getName()
	return self.nom
end

function Player:getLastName()
	return self.prenom
end

function Player:getFullName()
	return self.nom.." "..self.prenom
end

function Player:getPhoneNumber()
	return self.phoneNumber
end

function Player:getJobId()
	return self.jobId
end

function Player:getJobName()
	return self.jobName
end

---------------------------------------------- ESSENTIAL MODE BASE -----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- Getting permissions
function Player:getPermissions()
	return self.permission_level
end

-- Setting them
function Player:setPermissions(p)
	TriggerEvent("es:setPlayerData", self.source, "permission_level", p, function(response, success)
		self.permission_level = p
	end)
end

-- No need to ever call this (No, it doesn't teleport the player)
function Player:setCoords(x, y, z)
	self.coords.x, self.coords.y, self.coords.z = x, y, z
end

-- Kicks a player with specified reason
function Player:kick(reason)
	DropPlayer(self.source, reason)
end

-- Sets the player money (required to call this from now)
function Player:setMoney(m)
	local prevMoney = self.money
	local newMoney : double = m

	self.money = m

	if((prevMoney - newMoney) < 0)then
		TriggerClientEvent("es:addedMoney", self.source, math.abs(prevMoney - newMoney))
	else
		TriggerClientEvent("es:removedMoney", self.source, math.abs(prevMoney - newMoney))
	end

	TriggerClientEvent('es:activateMoney', self.source , self.money)
end

-- Adds to player money (required to call this from now)
function Player:addMoney(m)
	local newMoney : double = self.money + m

	self.money = newMoney

	TriggerClientEvent("es:addedMoney", self.source, m)
	TriggerClientEvent('es:activateMoney', self.source , self.money)
end

-- Removes from player money (required to call this from now)
function Player:removeMoney(m)
	local newMoney : double = self.money - m

	self.money = newMoney

	TriggerClientEvent("es:removedMoney", self.source, m)
	TriggerClientEvent('es:activateMoney', self.source , self.money)
end

-- Player session variables
function Player:setSessionVar(key, value)
	self.session[key] = value
end

function Player:getSessionVar(key)
	return self.session[key]
end

--==============Dirty money stuff========================
-- Sets the player dirty money (required to call this from now)
function Player:setDirty_Money(m)
	local prevMoney = self.dirty_money
	local newMoney : double = m

	self.dirty_money = m

	if((prevMoney - newMoney) < 0)then
		TriggerClientEvent("es:addedDirtyMoney", self.source, math.abs(prevMoney - newMoney))
	else
		TriggerClientEvent("es:removedDirtyMoney", self.source, math.abs(prevMoney - newMoney))
	end

	TriggerClientEvent('es:activateDirtyMoney', self.source , self.dirty_money)
end

-- Adds to player dirty money (required to call this from now)
function Player:addDirty_Money(m)
	local newMoney : double = self.dirty_money + m

	self.dirty_money = newMoney

	TriggerClientEvent("es:addedDirtyMoney", self.source, m)
	TriggerClientEvent('es:activateDirtyMoney', self.source , self.dirty_money)
end

-- Removes from player dirty money (required to call this from now)
function Player:removeDirty_Money(m)
	local newMoney : double = self.dirty_money - m

	self.dirty_money = newMoney

	TriggerClientEvent("es:removedDirtyMoney", self.source, m)
	TriggerClientEvent('es:activateDirtyMoney', self.source , self.dirty_money)
end
--=============End Dirty money stuff=====================