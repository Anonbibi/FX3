local WeedPlant = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
local passwordPreFix = {'Couga', 'Gannon', 'TheFoxeur', 'Corel', 'Bastien', 'Soroshiya', 'Charli'}
local currentPassword = ''
local oldPassword = ''
local timeGeneratePassword = 0
local timePasswordValid = 18 * 60 * 60 -- 18h
local fileName = 'illegalDataWeed.txt'

function loadData()
    local file = io.open(fileName, 'r')
    if file ~= nil then
        currentPassword = file:read()
        oldPassword = file:read()
        timeGeneratePassword = tonumber(file:read())
        file:close(file)
    end
end

function saveData()
    local file = io.open(fileName, 'w+')
    file:write(currentPassword .. '\r\n' .. oldPassword .. '\r\n' .. timeGeneratePassword)
    file:close(file)
end

function initWeed() 
    for i = 1, 19 do 
        WeedPlant[i] = os.time() - 2*60*60 - math.floor(math.random(8*60))
    end
    loadData()
end

function generatePassword()
    local p = passwordPreFix[math.random(1,#passwordPreFix)] 
    p = p .. string.sub('00' .. math.random(10,9999), -4)
    timeGeneratePassword = getTime()
    oldPassword = currentPassword
    currentPassword = p
    saveData()
    return currentPassword
end

function getCurrentPassword()
    local t = getTime()
    if timeGeneratePassword + timePasswordValid >= t then
        return currentPassword
    else
        return generatePassword()
    end
end

initWeed()

RegisterServerEvent('illegal:requestFullPlantData')
AddEventHandler('illegal:requestFullPlantData', function ()
    TriggerClientEvent('illegal:setFullPlantData', source, WeedPlant)
end)


RegisterServerEvent('illegal:PlanteSeed')
AddEventHandler('illegal:PlanteSeed', function (id)
    if WeedPlant[id] == 0 then
        local t = getTime()
        WeedPlant[id] = t
        TriggerClientEvent('illegal:seedChange', -1 , id,t)
    end
end)


RegisterServerEvent('illegal:weedTryPassowrd')
AddEventHandler('illegal:weedTryPassowrd', function (password, qte)
    local pw = getCurrentPassword()
    if password == pw then
        TriggerEvent('es:getPlayerFromId', source, function(Player)
            Player:addDirty_Money(qte * JoinVenteFull)
            TriggerClientEvent('illegal:fullVente', source, 1 , qte)
        end)
    elseif password == oldPassword then
        TriggerClientEvent('illegal:fullVente', source, 0 , 0)
    else
        TriggerClientEvent('illegal:fullVente', source, -1 , 0)
    end
end)

RegisterServerEvent('illegal:needPassword')
AddEventHandler('illegal:needPassword', function ()
    TriggerClientEvent('illegal:password', source, getCurrentPassword())
end)

RegisterServerEvent('illegal:recoltWeed')
AddEventHandler('illegal:recoltWeed', function (id)
    local t = WeedPlant[id]
    local d = math.floor(getTime()-t) / WeedGrowthTime
    if t ~= 0 and d >= 0.5 then
        local qte = 0 
        if d >= 1 then
            qte = 7
        elseif d >= 0.90 then
            qte = math.random(4,5)
        elseif d >= 0.80 then
            qte = math.random(3,4)
        elseif d >= 0.70 then
            qte = math.random(2,3)
        elseif d >= 0.60 then
            qte = math.random(1,3) 
        elseif d >= 0.50 then
            qte = math.random(1,2) 
        end    

        TriggerClientEvent('illegal:recoltWeed', source, qte)
        WeedPlant[id] = 0
        TriggerClientEvent('illegal:seedChange', -1 , id, 0)
    end
end)


function getTime()
    return os.time() -1 *60*60 + math.floor(0)
end

print('---------GC Illegal LOAD--------')