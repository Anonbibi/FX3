--require "resources/essentialmode/lib/MySQL"
-- MySQL:open("IP", "databasname", "user", "password")
--MySQL:open(database.host, database.name, database.username, database.password)

AddEventHandler("es:playerLoaded", function(user)
    TriggerEvent('es:getPlayerFromId', user, function(user)
        if user.isFirstConnection == 1 then
            TriggerClientEvent('skin:openSkinCreator', user.source)
        end
    end)
end)

RegisterServerEvent('skin:getOutfits')
AddEventHandler('skin:getOutfits', function(model)
    MySQL.Async.fetchAll("SELECT * FROM clothes_outfits WHERE category = 'skincreator' AND skin_model='@model'", {['@model'] = model}, function (outfits)
        local outfitsList = {}
        if outfits[1] then
            for k,outfit in ipairs(outfits)do
                outfitsList[k] = outfit
            end
            TriggerClientEvent('skin:setOutfitList', source, outfitsList )
        end
    end)
end)

RegisterServerEvent('skin:saveOutfitForNewPlayer')
AddEventHandler('skin:saveOutfitForNewPlayer', function(current_skin)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        MySQL.Async.executey("INSERT INTO skin (identifier, model, head, body_color, hair, hair_color, beard, beard_color, eyebrows, eyebrows_color) VALUES ('@id', '@a', '@b', '@c', '@d', '@e', '@f', '@g', '@h', '@i')",
            {
                ['@id'] = user.identifier,
                ['@a']  = current_skin.model,
                ['@b']  = tonumber(current_skin.head) or 0,
                ['@c']  = tonumber(current_skin.body_color) or 0,
                ['@d']  = tonumber(current_skin.hair) or 0,
                ['@e']  = tonumber(current_skin.hair_color) or 0,
                ['@f']  = tonumber(current_skin.beard) or 0,
                ['@g']  = tonumber(current_skin.beard_color) or 0,
                ['@h']  = tonumber(current_skin.eyebrows) or 0,
                ['@i']  = tonumber(current_skin.eyebrows_color) or 0,
            })
        MySQL.Async.execute("INSERT INTO clothes_users_outfits (identifier, current, outfit_id ) VALUES ('@id', '@b', '@c')",
            {
                ['@id'] = user.identifier,
                ['@b']  = 1,
                ['@c']  = current_skin.outfit_id
            })
        MySQL.Async.execute("UPDATE users SET `isFirstConnection`=0 WHERE identifier='@id'", { ['@id'] = user.identifier })
        TriggerClientEvent('phone:notifs', source, "Votre personnnalisation est terminé, bienvenue sur le serveur !")
        TriggerEvent('skin:firstSkinCreated', source)
    end)
end)

function getSkin(player)
    MySQL.Async.fetchAll("SELECT * FROM skin WHERE identifier = '@username'", {['@username'] = player}, function (skin)
        if(skin)then
            for k,v in ipairs(skin)do
                if v.head ~= nil then
                    TriggerClientEvent("skin:setPlayerSkin", source, v)
                end
            end
        end
    end)
end

function getOutfit(player)
    MySQL.Async.fetchAll("SELECT * FROM clothes_users_outfits JOIN clothes_outfits ON `clothes_users_outfits`.`outfit_id` = `clothes_outfits`.`id` WHERE identifier = '@username' AND current= 1", {['@username'] = player}, function (outfits)
        if outfits[1] then
            for k,outfit in ipairs(outfits)do
                TriggerClientEvent("skin:setPlayerOutfit", source, outfit)
            end
        end
    end)
end

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

RegisterServerEvent("skin:reloadSkin")
AddEventHandler('skin:reloadSkin', function()
    local player = getPlayerID(source)
    getSkin(player)
end)


RegisterServerEvent('skin:getPlayerModel')
AddEventHandler('skin:getPlayerModel', function()
    local player = getPlayerID(source)
        MySQL.Async.fetchAll("SELECT * FROM skin WHERE identifier = '@username'", {['@username'] = player}, function (result)
        if result[1] ~= nil then
            TriggerClientEvent('skin:getPlayerModelFromDb', source, result[1].model)
        else
            TriggerClientEvent('skin:getPlayerModelFromDb', source,  "mp_m_freemode_01")
        end
    end)
end)

RegisterServerEvent('skin:firstSpawn')
AddEventHandler('skin:firstSpawn', function()
    local player = getPlayerID(source)
    getSkin(player)
    getOutfit(player)
end)

RegisterServerEvent("skin:loadSkinAndPosition")
AddEventHandler("skin:loadSkinAndPosition", function()
    local player = getPlayerID(source)
    getSkin(player)
    getOutfit(player)
    getProps(player)
end)

RegisterServerEvent("skin_customization:SpawnPlayer")
AddEventHandler("skin_customization:SpawnPlayer", function()
    local player = getPlayerID(source)
    getSkin(player)
    getOutfit(player)
    getProps(player)
end)

function getProps(player)
    MySQL.Async.fetchAll("SELECT * FROM clothes_users_props JOIN clothes_props ON `clothes_users_props`.`prop_id` = `clothes_props`.`id` WHERE identifier = '@username' AND current= 1", {['@username'] = player}, function (props)
        if props[1] then
            for k,prop in ipairs(props)do
                TriggerClientEvent("skin:setPlayerProps", source, prop)
            end
        end
    end)
end

