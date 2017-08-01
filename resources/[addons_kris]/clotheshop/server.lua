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

RegisterServerEvent("clotheshop:getModelAndList")
AddEventHandler("clotheshop:getModelAndList", function()
    local pedSource = source
    MySQL.Async.fetchScalar("SELECT * FROM skin WHERE identifier = '@id'", {['@id'] = getPlayerID(pedSource)}, function (model)
        if model[1] then
            TriggerEvent('clotheshop:getOutfits',           { source = pedSource, model = model[1].model })
            TriggerEvent('clotheshop:getHats',              { source = pedSource, model = model[1].model })
            TriggerEvent('clotheshop:getGlasses',           { source = pedSource, model = model[1].model })
            TriggerEvent('clotheshop:getDressing',          { source = pedSource, identifier = model[1].identifier})
            TriggerEvent('clotheshop:getDressingGlasses',   { source = pedSource, identifier = model[1].identifier})
            TriggerEvent('clotheshop:getDressingHats',   { source = pedSource, identifier = model[1].identifier})
        else
            return false
        end
    end)
end)

RegisterServerEvent('clotheshop:getOutfits')
AddEventHandler('clotheshop:getOutfits', function(arg)
    MySQL.Async.fetchScalar("SELECT * FROM clothes_outfits WHERE skin_model='@model'", {['@model'] = arg.model}, function (outfits)
        local outfitsList = {}
        if outfits[1] then
            for k,outfit in ipairs(outfits)do
                outfitsList[k] = outfit
            end
            TriggerClientEvent('clotheshop:setOutfitList', arg.source, outfitsList )
        end
    end)
end)

RegisterServerEvent('clotheshop:getDressing')
AddEventHandler('clotheshop:getDressing', function(arg)
    MySQL.Async.fetchScalar("SELECT * FROM clothes_users_outfits JOIN clothes_outfits ON `clothes_users_outfits`.`outfit_id` = `clothes_outfits`.`id` WHERE identifier = '@username'", {['@username'] = arg.identifier}, function (outfits)
        local dressingList = {}
        if outfits[1] then
            for k,outfit in ipairs(outfits)do
                dressingList[k] = outfit
            end
            TriggerClientEvent('clotheshop:setDressingList', arg.source, dressingList )
        end
    end)
end)

RegisterServerEvent('clotheshop:getDressingGlasses')
AddEventHandler('clotheshop:getDressingGlasses', function(arg)
    MySQL.Async.fetchScalar("SELECT * FROM clothes_users_props JOIN clothes_props ON `clothes_users_props`.`prop_id` = `clothes_props`.`id` WHERE identifier = '@username' AND `clothes_users_props`.`category`='glasses'", {['@username'] = arg.identifier}, function (props)
        local dressingGlassesList = {}
        if props[1] then
            for k,prop in ipairs(props)do
                dressingGlassesList[k] = prop
            end
            TriggerClientEvent('clotheshop:setDressingGlassesList', arg.source, dressingGlassesList )
        end
    end)
end)


RegisterServerEvent('clotheshop:getDressingHats')
AddEventHandler('clotheshop:getDressingHats', function(arg)
    MySQL.Async.fetchScalar("SELECT * FROM clothes_users_props JOIN clothes_props ON `clothes_users_props`.`prop_id` = `clothes_props`.`id` WHERE identifier = '@username' AND `clothes_users_props`.`category`='hat'", {['@username'] = arg.identifier}, function (props)
        local dressingHatList = {}
        if props[1] then
            for k,prop in ipairs(props)do
                dressingHatList[k] = prop
            end
            TriggerClientEvent('clotheshop:setDressingHatsList', arg.source, dressingHatList )
        end
    end)
end)
RegisterServerEvent('clotheshop:getHats')
AddEventHandler('clotheshop:getHats', function(arg)
    MySQL.Async.fetchScalar("SELECT * FROM clothes_props WHERE model='@model' AND category='hat'", {['@model'] = arg.model}, function (props)
        local propsList = {}
        if props[1] then
            for k,prop in ipairs(props)do
                propsList[k] = prop
            end
            TriggerClientEvent('clotheshop:setHatsList', arg.source, propsList )
        end
    end)
end)

RegisterServerEvent('clotheshop:getGlasses')
AddEventHandler('clotheshop:getGlasses', function(arg)
    MySQL.Async.fetchScalar("SELECT * FROM clothes_props WHERE model='@model' AND category='glasses'", {['@model'] = arg.model}, function (props)
        local propsList = {}
        if props[1] then
            for k,prop in ipairs(props)do
                propsList[k] = prop
            end
            TriggerClientEvent('clotheshop:setGlassesList', arg.source, propsList )
        end
    end)
end)

RegisterServerEvent('clotheshop:buyOutfit')
AddEventHandler('clotheshop:buyOutfit', function(outfit)
    if not checkOutfit(source, outfit.id) then
        TriggerEvent('es:getPlayerFromId', source, function(user)
            if tonumber(user.money) >= tonumber(outfit.price) and tonumber(user.money) > 0 then
                MySQL.Async.execute("UPDATE clothes_users_outfits SET `current`=0 WHERE identifier='@id'",
                    {
                        ['@id']     = getPlayerID(user.source)
                    },function (rowsUpdate)
                    print('Query executed')
                end)
                MySQL.Async.execute("INSERT INTO clothes_users_outfits ( outfit_id, identifier, current ) VALUES ( '@outfit', '@id', 1)",
                    {
                        ['@outfit'] = outfit.id,
                        ['@id'] = getPlayerID(user.source)
                    },function (rowsUpdate)
                    print('Query executed')
                end)
                user:removeMoney(outfit.price)
                TriggerEvent('clotheshop:getDressing', {identifier = getPlayerID(user.source)})
                TriggerClientEvent('clotheshop:notifs', user.source, "Vous venez de payer ~y~"..outfit.price.." pour cet article"  )
                TriggerClientEvent('clotheshop:notifs', user.source, "Cet article à été enregistré dans votre garde robe !"  )
            else
                TriggerClientEvent('clotheshop:notifs', user.source, "Vous n'avez pas assez d'argent en poche"  )
            end
        end)
    end
end)

RegisterServerEvent('clotheshop:buyProp')
AddEventHandler('clotheshop:buyProp', function(prop)
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
                TriggerEvent('clotheshop:getDressingGlasses', {identifier = getPlayerID(user.source)})
                TriggerEvent('clotheshop:getDressingHats', {identifier = getPlayerID(user.source)})
                TriggerClientEvent('clotheshop:notifs', user.source, "Vous venez de payer ~y~"..prop.price.." pour cet article"  )
                TriggerClientEvent('clotheshop:notifs', user.source, "Cet article à été enregistré dans votre garde robe !"  )
            else
                TriggerClientEvent('clotheshop:notifs', user.source, "Vous n'avez pas assez d'argent en poche"  )
            end
        end)
    end
end)



RegisterServerEvent('clotheshop:wearOutfit')
AddEventHandler('clotheshop:wearOutfit', function(outfit)
    MySQL.Async.execute("UPDATE clothes_users_outfits SET `current`=0 WHERE identifier='@id'",
        {
            ['@id']     = getPlayerID(source)
        })
    MySQL.Async.execute("UPDATE clothes_users_outfits SET `current`=1 WHERE identifier='@id' AND outfit_id='@outfit_id'",
        {
            ['@id']     = getPlayerID(source),
            ['@outfit_id'] = tonumber(outfit.id)
        })
    TriggerClientEvent('clotheshop:notifs', source, "Vous avez changé de tenue !"  )
end)

RegisterServerEvent('clotheshop:wearGlassesProp')
AddEventHandler('clotheshop:wearGlassesProp', function(prop)
    MySQL.Async.execute("UPDATE clothes_users_props SET `current`=0 WHERE identifier='@id' AND category='glasses'",
        {
            ['@id']     = getPlayerID(source)
        })
    MySQL.Async.execute("UPDATE clothes_users_props SET `current`=1 WHERE identifier='@id' AND prop_id='@prop_id'",
        {
            ['@id']     = getPlayerID(source),
            ['@prop_id'] = tonumber(prop.id)
        })
    TriggerClientEvent('clotheshop:notifs', source, "Vous avez changé de tenue !"  )
end)

RegisterServerEvent('clotheshop:wearHatProp')
AddEventHandler('clotheshop:wearHatProp', function(prop)
    MySQL.Async.execute("UPDATE clothes_users_props SET `current`=0 WHERE identifier='@id' AND category='hat'",
        {
            ['@id']     = getPlayerID(source)
        })
    MySQL.Async.execute("UPDATE clothes_users_props SET `current`=1 WHERE identifier='@id' AND prop_id='@prop_id'",
        {
            ['@id']     = getPlayerID(source),
            ['@prop_id'] = tonumber(prop.id)
        })
    TriggerClientEvent('clotheshop:notifs', source, "Vous avez changé de tenue !"  )
end)

function checkOutfit(source, outfit)
    MySQL.Async.fetchScalar("SELECT * FROM clothes_users_outfits WHERE outfit_id='@outfit' AND identifier='@id'", {['@outfit'] = outfit, ['@id'] =  getPlayerID(source)}, function (user_outfit)
        if user_outfit[1] then
            TriggerClientEvent('clotheshop:notifs', source, "Vous possédez déjà cette article" )
            return true
        end
        return false
    end)
end

function checkProp(source, prop)
    MySQL.Async.fetchScalar("SELECT * FROM clothes_users_props WHERE prop_id='@prop' AND identifier='@id'", {['@prop'] = prop, ['@id'] =  getPlayerID(source)}, function (user_prop)
        if user_prop[1] then
            TriggerClientEvent('clotheshop:notifs', source, "Vous possédez déjà cette article" )
            return true
        end
        return false
    end)
end
