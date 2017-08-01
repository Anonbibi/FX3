--
-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 17/05/2017
-- Time: 16:50
-- To change this template use File | Settings | File Templates.
--

---------------------------------------------- DATABASE INITIALIZER ----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

require "resources/essentialmode/lib/MySQL"
MySQL:open(database.host, database.name, database.username, database.password)


---------------------------------------------------- HELPERS -----------------------------------------------------------
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

function checkIfPhoneNumberAllreadyAssigned(phone_number)

    local executed_query = MySQL:executeQuery("SELECT phone_number FROM users WHERE phone_number = '@number'", { ['@number'] = phone_number })
    local result = MySQL:getResults(executed_query, { 'phone_number' })

    if (result[1] ~= nil) then
        return true
    end
    return false
end

function getPhoneRandomNumber()
    return math.random(10000000,99999999)
end

------------------------------------------------- CHECK/SET PHONE NUMBER -----------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function checkNumber(number)
    local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE phone_number = '@number' LIMIT 1", { ['@number'] = number })
    local result = MySQL:getResults(executed_query, { 'identifier','nom'})
    if result then
        for _, v in ipairs(result) do
            return v
        end

    else
        return false
    end
end

AddEventHandler('es:playerLoaded',function(source)

    local executed_query = MySQL:executeQuery("SELECT phone_number FROM users WHERE identifier = '@username'", { ['@username'] = getPlayerID(source) })
    local result = MySQL:getResults(executed_query, { 'phone_number' })
    if (result[1].phone_number == "0") then
        local phone_number = getPhoneRandomNumber()
        phone_number = "06"..tostring(phone_number)
        if not checkIfPhoneNumberAllreadyAssigned(phone_number) then
            MySQL:executeQuery(  "UPDATE users SET phone_number='@number' WHERE identifier = '@identifier'",
                { ['@number'] = phone_number, ['@identifier'] = getPlayerID(source) })
            TriggerEvent("es:getPlayerFromId", source, function(user)

                TriggerClientEvent('phone:getPhoneNumberOnLoaded',source, phone_number)
            end)
        end
    else
        TriggerEvent("es:getPlayerFromId", source, function(user)
            TriggerClientEvent('phone:getPhoneNumberOnLoaded', source, user.phoneNumber)
        end)
    end
end)

------------------------------------------- REPERTORY SERVER EVENTS ----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

----- SAVE CURRENT STEAM ID TO CLIENT -----
RegisterServerEvent('phone:getSteamId')
AddEventHandler('phone:getSteamId', function()
    TriggerClientEvent('phone:setSteamId', source, getPlayerID(source))
end)

RegisterServerEvent("phone:addNewNumero")
AddEventHandler("phone:addNewNumero", function(number)
    local player = getPlayerID(source)
    local contact =  checkNumber(number)
    if not contact then
        TriggerClientEvent("phone:notifs", source, "~o~Aucun contact trouvé")
    else
        if player == contact.identifier then
            TriggerClientEvent("phone:notifs", source, " ~r~ Vous ne pouvez pas ajoutez votre numéro ;)" )
            CancelEvent()
        end
        local executed_query = MySQL:executeQuery("SELECT * FROM user_phonelist WHERE owner_id = '@username' AND contact_id = '@id' ", { ['@username'] = player, ['@id'] = contact.identifier })
        local result = MySQL:getResults(executed_query, { 'contact_id' })


        if(result[1] == nil) then
            MySQL:executeQuery("INSERT INTO user_phonelist (`owner_id`, `contact_id`) VALUES ('@owner', '@contact')",
                { ['@owner'] = player, ['@contact'] = contact.identifier })
            TriggerClientEvent("phone:notifs", source, "~g~Numéro de ~y~".. contact.name .. " ~g~ajouté" )
            updateRepertory({source = source, player = player })
        else
            TriggerClientEvent("phone:notifs", source, " ~y~".. contact.name .. "~r~ existe déjà dans votre répertoire" )
        end
    end
end)

RegisterServerEvent("phone:checkContactServer")
AddEventHandler("phone:checkContactServer", function(identifier)
    local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@id'", { ['@id'] = identifier.identifier })
    local result = MySQL:getResults(executed_query, { 'identifier', 'phone_number', 'nom' })

    if result[1] ~= nil then
        for _, v in ipairs(result) do
            TriggerClientEvent("phone:notifs", source, "~o~".. v.nom .. " : ~s~" .. v.phone_number)
        end
    end
end)

function updateRepertory(player)
    numberslist = {}
    source = player.source
    local player = player.player
    local executed_query = MySQL:executeQuery("SELECT * FROM user_phonelist JOIN users ON `user_phonelist`.`contact_id` = `users`.`identifier` WHERE owner_id = '@username' ORDER BY nom ASC", { ['@username'] = player })
    local result = MySQL:getResults(executed_query, { 'identifier','nom', 'contact_id'}, "contact_id")
    if (result) then
        for _, v in ipairs(result) do
            t = { name= v.nom, identifier = v.identifier }
            table.insert(numberslist, v.identifier, t)
        end
    end
    TriggerClientEvent("phone:repertoryGetNumberListFromServer", source, numberslist)
end

local numberslist = {}
RegisterServerEvent("phone:repertoryGetNumberList")
AddEventHandler("phone:repertoryGetNumberList", function()
    numberslist = {}
    local player = getPlayerID(source)
    local executed_query = MySQL:executeQuery("SELECT * FROM user_phonelist JOIN users ON `user_phonelist`.`contact_id` = `users`.`identifier` WHERE owner_id = '@username' ORDER BY nom ASC", { ['@username'] = player })
    local result = MySQL:getResults(executed_query, { 'identifier','nom', 'prenom', 'contact_id'}, "contact_id")
    if (result) then
        for _, v in ipairs(result) do
            t = { name= v.nom..' '..v.prenom, identifier = v.identifier }
            table.insert(numberslist, v.identifier, t)
        end
    end
    TriggerClientEvent("phone:repertoryGetNumberListFromServer", source, numberslist)
end)

RegisterServerEvent('phone:deleteContact')
AddEventHandler('phone:deleteContact', function(contact)
    MySQL:executeQuery("DELETE FROM user_phonelist WHERE `owner_id` = '@owner' AND `contact_id`='@contact'", { ['@owner'] = getPlayerID(source), ['@contact'] = contact })
    TriggerClientEvent('phone:notifs', source, "~g~ Contact supprimé !" )
end)


----------------------------------------------- MESSAGERIE EVENTS ------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("phone:sendNewMsg")
AddEventHandler("phone:sendNewMsg", function(msg)
    local sender = nil
    msg = {
        owner_id = getPlayerID(source),
        receiver = msg.receiver,
        msg = msg.msg
    }
    MySQL:executeQuery("INSERT INTO user_message (`owner_id`, `receiver_id`, `msg`, `has_read`) VALUES ('@owner', '@receiver', '@msg', '@read')",
        { ['@owner'] = msg.owner_id, ['@receiver'] = msg.receiver, ['@msg'] = msg.msg, ['@read'] = 0 })
    TriggerClientEvent("phone:notifs", source, " ~g~ message envoyé" )
    TriggerEvent('es:getPlayerFromId', source, function(sender)
         local SENDER = sender
         TriggerEvent("es:getPlayers", function(users)
             for k , user in pairs(users) do
                 if user.identifier == msg.receiver and k ~= source then
                     TriggerClientEvent("phone:notifsNewMsg", k, "Nouveau message de ~y~" .. SENDER.nom ..' '..SENDER.prenom)
                 end
             end
         end)
    end)

end)

local messagelist = {}
RegisterServerEvent("phone:messageryGetOldMsg")
AddEventHandler("phone:messageryGetOldMsg", function()
    -- TriggerClientEvent("phone:displayMsg", source)
    messagelist = {}
    local player = getPlayerID(source)
    local executed_query = MySQL:executeQuery("SELECT * FROM user_message JOIN users ON `user_message`.`owner_id` = `users`.`identifier` WHERE receiver_id = '@user' AND receiver_deleted='0' ORDER BY date DESC", { ['@user'] = player })
    local result = MySQL:getResults(executed_query, { 'identifier', 'nom', 'msg', 'date', 'has_read', 'owner_id','receiver_id', 'prenom'})
    local counter = 0
    if (result) then
        local USERS = {}
        for _, val in ipairs(result) do
            message = {
                msg = val.msg,
                name = val.nom .. ' ' .. val.prenom,
                identifier = val.identifier,
                date = tostring(val.date),
                has_read = val.has_read,
                owner_id = val.owner_id,
                receiver_id = val.receiver_id
            }
            messagelist[_] = message
            if val.has_read == 0 then
                counter = counter +1
            end
        end
        TriggerClientEvent("phone:nbMsgUnreaded", source, ''..counter..'')
    end
    TriggerClientEvent("phone:messageryGetOldMsgFromServer", source, messagelist)
end)


RegisterServerEvent("phone:setMsgReaded")
AddEventHandler("phone:setMsgReaded", function(msg)
    MySQL:executeQuery("UPDATE user_message SET `has_read` = 1 WHERE `receiver_id` = '@receiver' AND `msg` = '@msg' AND `has_read` = '@read' ", { ['@receiver'] = getPlayerID(source), ['@msg'] = msg.msg, ['@read'] = msg.has_read })
end)

RegisterServerEvent('phone:deleteMsg')
AddEventHandler('phone:deleteMsg', function(msg)
    MySQL:executeQuery("DELETE FROM user_message WHERE  owner_id='@owner' AND receiver_id='@receiver' AND msg='@msg' AND has_read=1 AND receiver_deleted=0 LIMIT 1", { ['@owner'] = msg.owner, ['@receiver'] = msg.receiver, ['@msg'] =  msg.msg })
    TriggerClientEvent('phone:notifs', source, "~g~ Message supprimé !" )
end)


RegisterServerEvent('phone:deleteAllMsg')
AddEventHandler('phone:deleteAllMsg', function()
    MySQL:executeQuery("DELETE FROM user_message WHERE receiver_id='@receiver'", { ['@receiver'] = getPlayerID(source) })
    TriggerClientEvent('phone:notifs', source, "~g~ Messagerie vidée!" )
end)
----------------------------------------------- RESET MEMORY EVENTS ----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('phone:resetPhone')
AddEventHandler('phone:resetPhone', function()
    MySQL:executeQuery("DELETE FROM user_phonelist WHERE `owner_id` = '@id'", { ['@id'] = getPlayerID(source)})
    MySQL:executeQuery("DELETE FROM user_message WHERE `receiver_id` = '@receiver'", { ['@receiver'] = getPlayerID(source)})
    TriggerClientEvent('phone:notifs', source, "~g~Téléphone réinitialisé !")
    TriggerClientEvent("phone:repertoryGetNumberList", source)
    TriggerClientEvent("phone:messageryGetOldMsg", source)

end)
