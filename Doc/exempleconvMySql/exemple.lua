
-- Exemple code classique

local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] =
identifier})
local result = MySQL:getResults(executed_query, {'money'},
"identifier")

TriggerClientEvent("my_event", self.source, result[1].money)


MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = identifier}, function (result)
    TriggerClientEvent("my_event", self.source, result[1].money)
end)

MySQL.Async.fetchScalar("SELECT money FROM users WHERE identifier = @name", {['@name'] = identifier}, function (money)
    TriggerClientEvent("my_event", self.source, money)
end)




--EX : VK_recolt server.lua AVANT


require "resources/essentialmode/lib/MySQL"
MySQL:open(database.host, database.name, database.username, database.password)

RegisterServerEvent("jobs:getJobs")
nbPolice = 0
local jobs = {}

AddEventHandler("jobs:getJobs", function ()
  jobs = {}
    local executed_query = MySQL:executeQuery("SELECT price, i1.`id` AS raw_id, i1.`libelle` AS raw_item, i2.`id` AS treat_id, i2.`libelle` AS treat_item, p1.x AS fx, p1.y AS fy, p1.z AS fz, p2.x AS tx, p2.y AS ty, p2.z AS tz, p3.x AS sx, p3.y AS sy, p3.z AS sz FROM recolt LEFT JOIN items i1 ON recolt.`raw_id`=i1.id LEFT JOIN items i2 ON recolt.`treated_id`=i2.id LEFT JOIN coordinates p1 ON recolt.`field_id`=p1.id LEFT JOIN coordinates p2 ON recolt.`treatment_id`=p2.id LEFT JOIN coordinates p3 ON recolt.`seller_id`=p3.id")
    local result = MySQL:getResults(executed_query, { 'price', 'raw_id', 'raw_item', 'treat_id', 'treat_item', 'fx', 'fy', 'fz', 'tx', 'ty', 'tz', 'sx', 'sy', 'sz' })
    if (result) then
        jobs = result
    end
    TriggerClientEvent("cli:getJobs", source, jobs)
end)

RegisterServerEvent('recolt:stestcop')
AddEventHandler('recolt:stestcop', function()
  getPoliceInService( function(nbPolicier)
  nbPolice = nbPolicier
  end)
  TriggerClientEvent('recolt:getcop',-1,nbPolice)
end)

function getPoliceInService(cb)
  TriggerEvent('es:getPlayers', function(players)
    local nbPolicier = 0
    for i,p in pairs(players) do
      local test = p:getSessionVar('policeInService')
      --print(test)
      if  test ~= nil and test == true then
        nbPolicier = nbPolicier + 1
      end
    end
    cb(nbPolicier)
  end)
end


--APRES § §  §§ § § § § § §

--require "resources/essentialmode/lib/MySQL"
--MySQL:open(database.host, database.name, database.username, database.password)

RegisterServerEvent("jobs:getJobs")
nbPolice = 0
local jobs = {}

AddEventHandler("jobs:getJobs", function ()
  jobs = {}
  MySQL.Async.fetchScalar("SELECT price, i1.`id` AS raw_id, i1.`libelle` AS raw_item, i2.`id` AS treat_id, i2.`libelle` AS treat_item, p1.x AS fx, p1.y AS fy, p1.z AS fz, p2.x AS tx, p2.y AS ty, p2.z AS tz, p3.x AS sx, p3.y AS sy, p3.z AS sz FROM recolt LEFT JOIN items i1 ON recolt.`raw_id`=i1.id LEFT JOIN items i2 ON recolt.`treated_id`=i2.id LEFT JOIN coordinates p1 ON recolt.`field_id`=p1.id LEFT JOIN coordinates p2 ON recolt.`treatment_id`=p2.id LEFT JOIN coordinates p3 ON recolt.`seller_id`=p3.id"}, function (jobs)

    if (jobs) then
      TriggerClientEvent("cli:getJobs", self.source, jobs)
    end
  end)
end)

RegisterServerEvent('recolt:stestcop')
AddEventHandler('recolt:stestcop', function()
  getPoliceInService( function(nbPolicier)
  nbPolice = nbPolicier
  end)
  TriggerClientEvent('recolt:getcop',-1,nbPolice)
end)

function getPoliceInService(cb)
  TriggerEvent('es:getPlayers', function(players)
    local nbPolicier = 0
    for i,p in pairs(players) do
      local test = p:getSessionVar('policeInService')
      --print(test)
      if  test ~= nil and test == true then
        nbPolicier = nbPolicier + 1
      end
    end
    cb(nbPolicier)
  end)
end


POUR LE UPDATE
AVANT


MySQL:executeQuery("UPDATE users SET `money`='@value' WHERE identifier = '@identifier'", {
    ['@value'] = 300,
    ['@identifier'] = 'steam...'
})


Maintenant

MySQL.Async.execute("UPDATE users SET `money`=@value WHERE identifier = @identifier", {
    ['@value'] = 300,
    ['@identifier'] = 'steam...'
})

Vous pouvez ajouter ceci pour avoir un retour sur le cmd


MySQL.Async.execute("UPDATE users SET `money`=@value WHERE identifier = @identifier", {
    ['@value'] = 300,
    ['@identifier'] = 'steam...'
}, function (rowsUpdate)
    print('Query executed')
end)

Debugging

To help upgrading, each call to the old API will trigger a debug log in your server, to read them you will have to change the configuration of the NLog.config file at the root of your fivem server, in order to have theses lines:

<rules>
  <logger name="*" minlevel="Debug" writeTo="console"/>
</rules>


server_script '@mysql-async/lib/MySQL.lua'
