--
-- User: KRIS
-- Date: 21/05/2017
-- Time: 12:58
--

----------------------------------------------------- INIT DATABASE  ---------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--require "resources/essentialmode/lib/MySQL"
--MySQL:open(database.host, database.name, database.username, database.password)

------------------------------------------------------- HELPERS --------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

------------------------------------------------------ LISTENERS -------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("barber:getOldSkin")
AddEventHandler("barber:getOldSkin", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local player    = user.identifier
        local skin      = getCurrentSkin(player)
        TriggerClientEvent('barber:getOldSkinFromServer', source, skin)
    end)
end)

RegisterServerEvent('barber:pay')
AddEventHandler('barber:pay', function(price, newSkin)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        if tonumber(user.money) > tonumber(price) and tonumber(user.money) > 0 then
            user:removeMoney(price)
            TriggerClientEvent('barber:closeMenu', source, {transaction = true, price = price})
            TriggerEvent('barber:saveHeadSkin', user.identifier, {
                hair = newSkin.hair or nil,
                hair_color= newSkin.hair_color or nil,
                beard = newSkin.beard or nil,
                beard_color = newSkin.beard_color or nil,
                lipstick = newSkin.lipstick or nil,
                lipstick_color = newSkin.lipstick_color or nil,
                makeup = newSkin.makeup or nil,
                makeup_opacity = newSkin.makeup_opacity or nil
            })
        else
            TriggerClientEvent('barber:closeMenu', source, {transaction = false, price = price})
        end
    end)
end)

RegisterServerEvent("barber:saveHeadSkin")
AddEventHandler('barber:saveHeadSkin', function(player, newSkin)
    if newSkin.hair then
        saveHeadSkin(player, { type = 'hair', val = newSkin.hair })
    end
    if newSkin.hair_color then
        saveHeadSkin(player, { type = 'hair_color', val = newSkin.hair_color })
    end
    if newSkin.beard then
        saveHeadSkin(player, { type = 'beard', val = newSkin.beard })
    end
    if newSkin.beard_color then
        saveHeadSkin(player, { type = 'beard_color', val = newSkin.beard_color })
    end
    if newSkin.makeup then
        saveHeadSkin(player, { type = 'makeup', val = newSkin.makeup })
    end
    if newSkin.makeup_opacity then
        saveHeadSkin(player, { type = 'makeup_opacity', val = newSkin.makeup_opacity })
    end
    if newSkin.lipstick then
        saveHeadSkin(player, { type = 'lipstick', val = newSkin.lipstick })
    end
    if newSkin.lipstick_color then
        saveHeadSkin(player, { type = 'lipstick_color', val = newSkin.lipstick_color })
    end
    TriggerClientEvent('bs:notifs', source, "Nouveau skin enregistré!")
end)

------------------------------------------------------ FUNCTIONS -------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function getCurrentSkin(player)
    MySQL.Async.fetchAll("SELECT * FROM skin WHERE identifier = '@username'", {['@username'] = player}, function (skin)
        if skin[1] then
            return skin[1]
        end
    end)
end



function saveHeadSkin(player,skin)
    MySQL.Async.execute("UPDATE skin SET "..skin.type.."='@a' WHERE `identifier`='@id'",
        {
            ['@id'] = player,
            ['@a']  = tonumber(skin.val)
        }, function (rowsUpdate)
        print('Query executed')
    end)
end


