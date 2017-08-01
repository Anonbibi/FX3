--
-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 22/05/2017
-- Time: 07:59
-- To change this template use File | Settings | File Templates.
--
--require "resources/essentialmode/lib/MySQL"
-- MySQL:open("IP", "databasname", "user", "password")
--MySQL:open(database.host, database.name, database.username, database.password)

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

RegisterServerEvent("clothevest:getModelAndList")
AddEventHandler("clothevest:getModelAndList", function()
    local pedSource = source
    MySQL.Async.fetchAll("SELECT * FROM skin WHERE identifier = '@id'", {['@id'] = getPlayerID(pedSource)}, function (model)
        if model[1] then
            TriggerEvent('clothevest:getOutfits',           { source = pedSource, model = model[1].model })
            TriggerEvent('clothevest:getHats',              { source = pedSource, model = model[1].model })
            TriggerEvent('clothevest:getGlasses',           { source = pedSource, model = model[1].model })
            TriggerEvent('clothevest:getDressing',          { source = pedSource, identifier = model[1].identifier})
            TriggerEvent('clothevest:getDressingGlasses',   { source = pedSource, identifier = model[1].identifier})
            TriggerEvent('clothevest:getDressingHats',   { source = pedSource, identifier = model[1].identifier})
        else
            return false
        end
    end)
end)

RegisterServerEvent('clothevest:getOutfits')
AddEventHandler('clothevest:getOutfits', function(arg)
    MySQL.Async.fetchAll("SELECT * FROM clothes_outfits WHERE skin_model='@model'", {['@model'] = arg.model}, function (outfits)
        local outfitsList = {}
        if outfits[1] then
            for k,outfit in ipairs(outfits)do
                outfitsList[k] = outfit
            end
            TriggerClientEvent('clothevest:setOutfitList', arg.source, outfitsList )
        end
    end)
end)

RegisterServerEvent('clothevest:getDressing')
AddEventHandler('clothevest:getDressing', function(arg)
    MySQL.Async.fetchAll("SELECT * FROM clothes_users_outfits JOIN clothes_outfits ON `clothes_users_outfits`.`outfit_id` = `clothes_outfits`.`id` WHERE identifier = '@username'", {['@username'] = arg.identifier}, function (outfits)
        local dressingList = {}
        if outfits[1] then
            for k,outfit in ipairs(outfits)do
                dressingList[k] = outfit
            end
            TriggerClientEvent('clothevest:setDressingList', arg.source, dressingList )
        end
    end)
end)

RegisterServerEvent('clothevest:getDressingGlasses')
AddEventHandler('clothevest:getDressingGlasses', function(arg)
    MySQL.Async.fetchAll("SELECT * FROM clothes_users_props JOIN clothes_props ON `clothes_users_props`.`prop_id` = `clothes_props`.`id` WHERE identifier = '@username' AND `clothes_users_props`.`category`='glasses'", {['@username'] = arg.identifier}, function (props)
        local dressingGlassesList = {}
        if props[1] then
            for k,prop in ipairs(props)do
                dressingGlassesList[k] = prop
            end
            TriggerClientEvent('clothevest:setDressingGlassesList', arg.source, dressingGlassesList )
        end
    end)
end)
RegisterServerEvent('clothevest:getDressingHats')
AddEventHandler('clothevest:getDressingHats', function(arg)
    MySQL.Async.fetchAll("SELECT * FROM clothes_users_props JOIN clothes_props ON `clothes_users_props`.`prop_id` = `clothes_props`.`id` WHERE identifier = '@username' AND `clothes_users_props`.`category`='hat'", {['@username'] = arg.identifier}, function (props)
        local dressingHatList = {}
        if props[1] then
            for k,prop in ipairs(props)do
                dressingHatList[k] = prop
            end
            TriggerClientEvent('clothevest:setDressingHatsList', arg.source, dressingHatList )
        end
    end)
end)
RegisterServerEvent('clothevest:getHats')
AddEventHandler('clothevest:getHats', function(arg)
    MySQL.Async.fetchAll("SELECT * FROM clothes_props WHERE model='@model' AND category='hat'", {['@model'] = arg.model}, function (props)
        local propsList = {}
        if props[1] then
            for k,prop in ipairs(props)do
                propsList[k] = prop
            end
            TriggerClientEvent('clothevest:setHatsList', arg.source, propsList )
        end
    end)
end)

RegisterServerEvent('clothevest:getGlasses')
AddEventHandler('clothevest:getGlasses', function(arg)
    MySQL.Async.fetchAll("SELECT * FROM clothes_props WHERE model='@model' AND category='glasses'", {['@model'] = arg.model}, function (props)
        local propsList = {}
        if props[1] then
            for k,prop in ipairs(props)do
                propsList[k] = prop
            end
            TriggerClientEvent('clothevest:setGlassesList', arg.source, propsList )
        end
    end)
end)

RegisterServerEvent('clothevest:buyOutfit')
AddEventHandler('clothevest:buyOutfit', function(outfit)
    if not checkOutfit(source, outfit.id) then
        TriggerEvent('es:getPlayerFromId', source, function(user)
            if tonumber(user.money) >= tonumber(outfit.price) and tonumber(user.money) > 0 then
                MySQL.Async.execute("UPDATE clothes_users_outfits SET `current`=0 WHERE identifier='@id'",
                    {
                        ['@id']     = getPlayerID(user.source)
                    })
                MySQL.Async.execute("INSERT INTO clothes_users_outfits ( outfit_id, identifier, current ) VALUES ( '@outfit', '@id', 1)", {
                    ['@outfit'] = outfit.id,
                    ['@id'] = getPlayerID(user.source)
                })
                user:removeMoney(outfit.price)
                TriggerEvent('clothevest:getDressing', {identifier = getPlayerID(user.source)})
                TriggerClientEvent('clothevest:notifs', user.source, "Vous venez de payer ~y~"..outfit.price.." pour cet article"  )
                TriggerClientEvent('clothevest:notifs', user.source, "Cet article à été enregistré dans votre garde robe !"  )
            else
                TriggerClientEvent('clothevest:notifs', user.source, "Vous n'avez pas assez d'argent en poche"  )
            end
        end)
    end
end)

RegisterServerEvent('clothevest:buyProp')
AddEventHandler('clothevest:buyProp', function(prop)
    if not checkProp(source, prop.id) then
        print(json.encode(prop))
        TriggerEvent('es:getPlayerFromId', source, function(user)
            if tonumber(user.money) >= tonumber(prop.price) and tonumber(user.money) > 0 then
                MySQL.Async.execute("UPDATE clothes_users_props SET `current`=0 WHERE identifier='@id' AND category='@category'",
                    {
                        ['@id']         = getPlayerID(user.source),
                        ['@category']   = prop.category
                    })
                MySQL.Async.execute("INSERT INTO clothes_users_props ( prop_id, identifier, current, category ) VALUES ( '@prop', '@id', 1, '@category')", {
                    ['@prop']       = prop.id,
                    ['@id']         = getPlayerID(user.source),
                    ['@category']   = prop.category
                })
                user:removeMoney(prop.price)
                TriggerEvent('clothevest:getDressingGlasses', {identifier = getPlayerID(user.source)})
                TriggerEvent('clothevest:getDressingHats', {identifier = getPlayerID(user.source)})
                TriggerClientEvent('clothevest:notifs', user.source, "Vous venez de payer ~y~"..prop.price.." pour cet article"  )
                TriggerClientEvent('clothevest:notifs', user.source, "Cet article à été enregistré dans votre garde robe !"  )
            else
                TriggerClientEvent('clothevest:notifs', user.source, "Vous n'avez pas assez d'argent en poche"  )
            end
        end)
    end
end)



RegisterServerEvent('clothevest:wearOutfit')
AddEventHandler('clothevest:wearOutfit', function(outfit)
    MySQL.Async.execute("UPDATE clothes_users_outfits SET `current`=0 WHERE identifier='@id'",
        {
            ['@id']     = getPlayerID(source)
        })
    MySQL.Async.execute("UPDATE clothes_users_outfits SET `current`=1 WHERE identifier='@id' AND outfit_id='@outfit_id'",
        {
            ['@id']     = getPlayerID(source),
            ['@outfit_id'] = tonumber(outfit.id)
        })
    TriggerClientEvent('clothevest:notifs', source, "Vous avez changé de tenue !"  )
end)

RegisterServerEvent('clothevest:wearGlassesProp')
AddEventHandler('clothevest:wearGlassesProp', function(prop)
    MySQL.Async.execute("UPDATE clothes_users_props SET `current`=0 WHERE identifier='@id' AND category='glasses'",
        {
            ['@id']     = getPlayerID(source)
        })
    MySQL.Async.execute("UPDATE clothes_users_props SET `current`=1 WHERE identifier='@id' AND prop_id='@prop_id'",
        {
            ['@id']     = getPlayerID(source),
            ['@prop_id'] = tonumber(prop.id)
        })
    TriggerClientEvent('clothevest:notifs', source, "Vous avez changé de tenue !"  )
end)

RegisterServerEvent('clothevest:wearHatProp')
AddEventHandler('clothevest:wearHatProp', function(prop)
    MySQL.Async.execute("UPDATE clothes_users_props SET `current`=0 WHERE identifier='@id' AND category='hat'",
        {
            ['@id']     = getPlayerID(source)
        })
    MySQL.Async.execute("UPDATE clothes_users_props SET `current`=1 WHERE identifier='@id' AND prop_id='@prop_id'",
        {
            ['@id']     = getPlayerID(source),
            ['@prop_id'] = tonumber(prop.id)
        })
    TriggerClientEvent('clothevest:notifs', source, "Vous avez changé de tenue !"  )
end)

function checkOutfit(source, outfit)
    MySQL.Async.fetchAll("SELECT * FROM clothes_users_outfits WHERE outfit_id='@outfit' AND identifier='@id'", {['@outfit'] = outfit, ['@id'] =  getPlayerID(source)}, function (user_outfit)
        if user_outfit[1] then
            TriggerClientEvent('clothevest:notifs', source, "Vous possédez déjà cette article" )
            return true
        end
        return false
    end)
end

function checkProp(source, prop)
    MySQL.Async.fetchAll("SELECT * FROM clothes_users_props WHERE prop_id='@prop' AND identifier='@id'", {['@prop'] = prop, ['@id'] =  getPlayerID(source)}, function (user_prop)
     if user_prop[1] then
        TriggerClientEvent('clothevest:notifs', source, "Vous possédez déjà cette article" )
        return true
        end
        return false
    end)
end
