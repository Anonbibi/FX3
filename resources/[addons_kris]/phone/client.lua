--
-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 17/05/2017
-- Time: 16:50
-- To change this template use File | Settings | File Templates.
--

--------------------------------------------------- VARS MENU ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

local options = {
    x = 0.12,
    y = 0.2,
    width = 0.22,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = 'Téléphone',
    menu_subtitle = 'Actions',
    color_r = 192,
    color_g = 57,
    color_b = 43,
}

--------------------------------------------------- VARS PHONE ---------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

local openKey = 168
local current_steam_id = ''
local phone_number = ''

NUMBERS_LIST = {}
OLDS_MSG = {}

------------------------------------------------- FUNCTIONS HELPERS ----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function drawTxt(options)
    SetTextFont(options.font)
    SetTextProportional(0)
    SetTextScale(options.scale, options.scale)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(0)
    SetTextEntry('STRING')
    AddTextComponentString(options.text)
    DrawRect(options.xBox,options.y,options.width,options.height,0,0,0,150)
    DrawText(options.x - options.width/2 + 0.005, options.y - options.height/2 + 0.0028)
end
function DisplayHelpText(str)
    SetTextComponentFormat('STRING')
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
function notifs(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString( msg )
    DrawNotification(false, false)
end

--------------------------------------------------- NUI CALLBACKS ------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('phone:unreaded')
AddEventHandler('phone:unreaded', function()
    SendNUIMessage({unreaded = true})
end)
RegisterNetEvent('phone:nbMsgUnreaded')
AddEventHandler('phone:nbMsgUnreaded', function(counter)
    SendNUIMessage({nbMsgUnreaded = counter})
end)

--------------------------------------------------- LISTENER MENU ------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    TriggerServerEvent('phone:getSteamId')
    TriggerServerEvent('phone:repertoryGetNumberList')
    TriggerServerEvent('phone:messageryGetOldMsg')
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, openKey) then
            TriggerEvent('phone:toggleMenu')
        end
        Menu.renderGUI(options)
    end
end)

RegisterNetEvent('phone:setSteamId')
AddEventHandler('phone:setSteamId', function(steam_id)
   current_steam_id = steam_id
end)

RegisterNetEvent('phone:getPhoneNumberOnLoaded')
AddEventHandler('phone:getPhoneNumberOnLoaded', function(number)
    Citizen.Trace(number)
    phone_number = number
end)

RegisterNetEvent('phone:toggleMenu')
AddEventHandler('phone:toggleMenu', function()
    phoneMenu() -- Menu to draw
	Menu.hidden = not Menu.hidden -- Hide/Show the menu
end)

RegisterNetEvent("phone:repertoryGetNumberListFromServer")
AddEventHandler("phone:repertoryGetNumberListFromServer", function(NUMBERSLIST)
    NUMBERS_LIST = {}
    NUMBERS_LIST = NUMBERSLIST
end)

RegisterNetEvent("phone:messageryGetOldMsgFromServer")
AddEventHandler("phone:messageryGetOldMsgFromServer", function(OLDSMSG)
    OLDS_MSG = {}
    OLDS_MSG = OLDSMSG
end)

RegisterNetEvent('phone:notifsNewMsg')
AddEventHandler('phone:notifsNewMsg', function(notif)
    SendNUIMessage({unreaded = true})
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
    notifs( notif )
end)

RegisterNetEvent('phone:readMsg')
AddEventHandler('phone:readMsg', function(msg)
    SendNUIMessage({read = true, by = msg.by, msg = msg.msg})
end)

RegisterNetEvent('phone:deleteUnreaded')
AddEventHandler('phone:deleteUnreaded', function(msg)
    SendNUIMessage({deleteUnreaded = true})
end)

RegisterNetEvent('phone:closeMsg')
AddEventHandler('phone:closeMsg', function()
    SendNUIMessage({closeRead = true})
end)

RegisterNetEvent("phone:notifs")
AddEventHandler("phone:notifs", function(msg)
    notifs(msg)
end)

--------------------------------------------------- BASE MENU ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function phoneMenu()
    TriggerServerEvent("phone:repertoryGetNumberList")
    TriggerServerEvent("phone:messageryGetOldMsg")
    options.menu_subtitle = phone_number
    ClearMenu()
    if not IsEntityDead(GetPlayerPed(-1)) then
        Menu.addButton("Repertoire", "repertoryMenu", nil)
        Menu.addButton("Messagerie", "messageryMenu", nil)
    end
    Menu.addButton("Services public", "publicMenu", nil)
    if not IsEntityDead(GetPlayerPed(-1)) then
        Menu.addButton("Vider la mémoire", "cleanMemoryMenu", nil)
    end
    Menu.addButton("Ranger le téléphone", "closePhone", nil)
end

function closePhone()
    Menu.hidden = not Menu.hidden
end
------------------------------------------------ REPERTORY MENU --------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

------- REPERTORY MENU -----------
function repertoryMenu()
    options.menu_subtitle = "Repertoire"
    ClearMenu()
    Menu.addButton("Ajouter un numéro", "newNumero", nil )
    Menu.addButton('Retour', 'phoneMenu', nil )
    for ind, value in pairs(NUMBERS_LIST) do
        Menu.addButton(value.name, "repertoryContact", value.identifier)
    end
    Menu.addButton("Retour", "phoneMenu", nil )
end

------- ADD NUMBER ------------
function newNumero()
    DisplayOnscreenKeyboard(2, "FMMC_KEY_TIP8", '', '', '', '', '', 11)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        TriggerServerEvent("phone:addNewNumero", result)
        phoneMenu()
    end
end

------- CONTACT MENU ----------
function repertoryContact(contact)
    options.menu_subtitle = 'Repertoire'
    ClearMenu()
    Menu.addButton('Afficher le numéro', 'checkContact', contact )
    Menu.addButton('Envoyer un message', 'writeMsg', contact )
    Menu.addButton('Supprimer', 'deleteContact', contact )
    Menu.addButton('Retour', 'repertoryMenu', nil )

end

---- CONTACT MENU ACTIONS -----
function checkContact(contact)
    TriggerServerEvent("phone:checkContactServer", {identifier = contact})
end

function writeMsg(receiver)
    DisplayOnscreenKeyboard(2, "FMMC_KEY_TIP8", "(250 characters max)", "", "", "", "", 250)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        local msg = {
            receiver = receiver,
            msg = result
        }
        TriggerServerEvent("phone:sendNewMsg", msg)
        phoneMenu()
    end
end

function deleteContact(contact)
    TriggerServerEvent("phone:deleteContact", contact)
    phoneMenu()
end

------------------------------------------------ MESSAGERY MENU --------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

------- MESSAGERY MENU --------
function messageryMenu()
    options.menu_subtitle = "Messagerie"
    ClearMenu()
    Menu.addButton("Retour", "phoneMenu", nil )
    for ind, value in pairs(OLDS_MSG) do
        local n = ""
        if value.has_read == 0 then
            n = " - ~r~Non lu"
        end
        Menu.addButton(value.name .. " " .. n, "msgMenu", {msg = value.msg, name = value.name, date= value.date, has_read = value.has_read, receiver_id = value.receiver_id, owner_id = value.owner_id})
    end
    Menu.addButton("Supprimer tout", "deleteAll", nil )
    Menu.addButton("Retour", "phoneMenu", nil )
end

------- ONE MESSAGE MENU --------
function msgMenu(msg)

    TriggerServerEvent("phone:messageryGetOldMsg")
    options.menu_subtitle = "Message de "..msg.name
    ClearMenu()
    Citizen.Trace(json.encode(msg))

    Menu.addButton("Lire", "readMsg", {msg = msg.msg, name = msg.name, date= msg.date, has_read = msg.has_read, receiver_id = msg.receiver_id})
    Menu.addButton("Répondre", "respondTo", msg.owner_id)
    Menu.addButton("Supprimer", "deleteMsg", {msg = msg.msg, name = msg.name, date= msg.date, has_read = msg.has_read, receiver_id = msg.receiver_id, owner_id = msg.owner_id})
    Menu.addButton("Retour", "messageryMenu", nil )
end

------- MESSAGE ACTIONS --------
function readMsg(msg)
    TriggerEvent('phone:readMsg', {by = msg.name, msg = msg.msg})
    options.menu_subtitle = "Message de "..msg.name
    ClearMenu()
    if msg.has_read == 0 then
        TriggerServerEvent("phone:setMsgReaded", msg)
        TriggerEvent('phone:setReaded')
        SendNUIMessage({read = true})
    end
    Menu.addButton("Fermer", "closeMsg", nil)
end

function closeMsg()
    TriggerEvent('phone:closeMsg')
    phoneMenu()
end

function respondTo(contact)
    DisplayOnscreenKeyboard(2, "FMMC_KEY_TIP8", "(250 characters max)", "", "", "", "", 250)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        local msg = {
            receiver = contact,
            msg = result
        }
        TriggerServerEvent("phone:sendNewMsg", msg)
        phoneMenu()
    end
end

function deleteMsg(msg)

    local delmsg = {
        owner = msg.owner_id,
        receiver = msg.receiver_id,
        msg = msg.msg
    }
    TriggerEvent('phone:deleteUnreaded')
    TriggerServerEvent("phone:deleteMsg", delmsg)
    phoneMenu()
end

function deleteAll()
    options.menu_subtitle = "Supprimer tout"
    ClearMenu()
    Menu.addButton("Oui", "deleteAllAction", nil)
    Menu.addButton("Non", "messageryMenu", nil )
end

function deleteAllAction()
    TriggerServerEvent('phone:deleteAllMsg')
    phoneMenu()
end

------------------------------------------------ PUBLIC CALLS MENU -----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--------- PUBLIC CALLS MENU ------
function publicMenu()
    options.menu_subtitle = "Services public"
    ClearMenu()
    Menu.addButton("Police", "callPolice", nil)
    Menu.addButton("Médecins", "callMedics", nil)
    Menu.addButton("Dépanneur", "callTroubleshooters", nil)
    Menu.addButton("Taxi", "callTaxis", nil)
    Menu.addButton("Gouvernement", "callGouv", nil)
    Menu.addButton("HCDH", "callHcdh", nil)
    Menu.addButton("Retour", "phoneMenu", nil )
end

---------- HCDH CALL EVENT -----
function callHcdh()
    options.menu_subtitle = "Appel HCDH"
    ClearMenu()
    Menu.addButton("Nouveau joueur", "callHcdhAction", {fn= "hcdh:callHcdh", type = 'new'})
    Menu.addButton("Demande de rendez-vous", "callHcdhAction", {fn= "hcdh:callHcdh", type = 'rdv'})
    Menu.addButton("Raison personnalisée", "callHcdhAction", {fn= "hcdh:callHcdhCustom", type = nil})
    Menu.addButton("Annuler mon appel", "callHcdhAction", {fn= "hcdh:cancelCall", type = nil})
    Menu.addButton("Retour", "phoneMenu", nil )
end

function callHcdhAction(arg)
    TriggerEvent(arg.fn, {type = arg.type})
    publicMenu()
end

---------- GOUV CALL EVENT -----
function callGouv()
    options.menu_subtitle = "Appel Gouvernement"
    ClearMenu()
    Menu.addButton("Demande de rendez-vous", "callGouvAction", {fn= "gouv:callGouv", type = 'rdv'})
    Menu.addButton("Demande d'intervention", "callGouvAction", {fn= "gouv:callGouv", type = 'help'})
    Menu.addButton("Raison personnalisée", "callGouvAction", {fn= "gouv:callGouvCustom", type = nil})
    Menu.addButton("Annuler mon appel", "callGouvAction", {fn= "gouv:cancelCall", type = nil})
    Menu.addButton("Retour", "phoneMenu", nil )
end

function callGouvAction(arg)
    TriggerEvent(arg.fn, {type = arg.type})
    publicMenu()
end

---------- POLICE CALL EVENT -----
function callPolice()
    options.menu_subtitle = "Appel police"
    ClearMenu()
    Menu.addButton("Signaler un vol", "callPoliceAction", {fn= "police:callPolice", type = 'vole'})
    Menu.addButton("Signaler une aggression", "callPoliceAction", {fn= "police:callPolice", type = 'aggression'})
    Menu.addButton("Raison personnalisée", "callPoliceAction", {fn= "police:callPoliceCustom", type = nil})
    Menu.addButton("Annuler mon appel", "callPoliceAction", {fn= "police:cancelCall", type = nil})
    Menu.addButton("Retour", "phoneMenu", nil )
end

function callPoliceAction(arg)
    TriggerEvent(arg.fn, {type = arg.type})
    publicMenu()
end

---------- MEDICS CALL EVENT -----
function callMedics()
    options.menu_subtitle = "Medecins"
    ClearMenu()
    Menu.addButton("Appel Coma", "callMedicsAction", {type= 'Coma', fn='ambulancier:callAmbulancier'})
    Menu.addButton("Appel Ambulancier", "callMedicsAction", {type='Demande', fn='ambulancier:callAmbulancier'})
    Menu.addButton("Respawn", "callMedicsAction", {type=nil, fn='ambulancier:selfRespawn'})
    Menu.addButton("Annuler mon appel", "callMedicsAction", {type=nil, fn='ambulancier:cancelCall'})
    Menu.addButton("Retour", "phoneMenu", nil )
end

function callMedicsAction(arg)
    TriggerEvent(arg.fn, {type = arg.type})
    publicMenu()
end

----- TROUBLESHOOTERS CALL EVENT -----
function callTroubleshooters()
    options.menu_subtitle = "Depanneurs"
    ClearMenu()
    Menu.addButton("Moto", "callTroubleshootersAction", {type="moto", fn="mecano:callMecano"})
    Menu.addButton("Voiture", "callTroubleshootersAction", {type="voiture", fn="mecano:callMecano"})
    Menu.addButton("Camionnette", "callTroubleshootersAction", {type="camionnette", fn="mecano:callMecano"})
    Menu.addButton("Camion", "callTroubleshootersAction", {type="camion", fn="mecano:callMecano"})
    Menu.addButton("Annuler mon appel", "callTroubleshootersAction", {type=nil, fn="mecano:cancelCall"})
    Menu.addButton("Retour", "phoneMenu", nil )
end

function callTroubleshootersAction(arg)
    TriggerEvent(arg.fn, {type = arg.type})
    publicMenu()
end

----- TAXIS CALL EVENT -----
function callTaxis()
    options.menu_subtitle = "Taxis"
    ClearMenu()
    Menu.addButton("1 personne", "callTaxisAction", {type="1 personne", fn="taxi:callService"})
    Menu.addButton("2 personne", "callTaxisAction", {type="2 personne", fn="taxi:callService"})
    Menu.addButton("3 personne", "callTaxisAction", {type="3 personne", fn="taxi:callService"})
    Menu.addButton("Annuler mon appel", "callTaxisAction", {type=nil, fn="taxi:cancelCall"})
    Menu.addButton("Retour", "phoneMenu", nil )
end
function callTaxisAction(arg)
    TriggerEvent(arg.fn, {type = arg.type})
    publicMenu()
end

------------------------------------------------ RESET PHONE MENU ------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function cleanMemoryMenu()
    options.menu_subtitle = "Vider la memoire"
    ClearMenu()
    Menu.addButton("Oui", "cleanMemoryMenuAction", nil)
    Menu.addButton("Non", "phoneMenu", nil )
end

function cleanMemoryMenuAction()
    TriggerServerEvent('phone:resetPhone')
end
