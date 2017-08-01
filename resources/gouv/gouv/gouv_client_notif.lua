local KEY_E = 38
local KEY_CLOSE = 177
local GOUV_currentBlip = nil 
local GOUV_listMissions = {}
local GOUV_currentMissions = nil
local GOUV_nbMissionEnAttenteText = '-- Aucune Info --'
local GOUV_BlipMecano = {}
local GOUV_showHelp = false
local GOUV_CALL_ACCEPT_P = 0
local GOUV_nbMecanoisInService = 0
local GOUV_nbMecanoDispo = 0


-- local isAgent = false
-- local isAgentInService = false
-- local rank = "inconnu"
-- local checkpoints = {}
-- local existingVeh = nil
-- local handCuffed = false

-- isAgent = true -- famse
-- isisInService = false
-- blipsAgents = {}


local GOUV_TEXT = {
    PrendreService = '~INPUT_PICKUP~ Prendre son service d agent du gouvernement',
    QuitterService = '~INPUT_PICKUP~ Quitter son service d agent du gouvernement',
    SpawnVehicle = '~INPUT_PICKUP~ Recuprer son véhicule de ~b~service',
    SpawnVehicleImpossible = '~R~ Impossible, aucune place disponible',

    Blip = 'Mission en cours',


    MissionCancel = 'Votre mission en cours n\'est plus d\'actualité',
    MissionClientAccept = 'Un agent du gouvernement a prit votre appel',
    MissionClientCancel = 'Votre agent du gouvernement vous a abandonné',
    InfoGouvNoAppel = '~g~Aucun appel en attente',
    InfoGouvNbAppel = '~w~ Appel en attente',
    BlipMecanoService = 'Prise de service',
    BlipMecanoVehicle = 'Prise du véhicule de service',

    CALL_INFO_NO_PERSONNEL = '~r~Aucun agent en service',
    CALL_INFO_ALL_BUSY = '~o~Toutes nos unité sont occupés',
    CALL_INFO_WAIT = '~b~Votre appel est sur attente',
    CALL_INFO_OK = '~g~Une unité va arriver sur les lieux de l\'appel',

    CALL_RECU = 'Confirmation\nVotre appel a été enregistré',
    CALL_ACCEPT_P_P = 'Votre appel a été accepté, un Agent est en route',
    CALL_CANCEL = 'L agent vient d\'abandonner votre appel',
    CALL_FINI = 'Votre appel a été résolu',
    CALL_EN_COURS = 'Vous avez déjà une demande en cours ...',

    MISSION_NEW = 'Une nouvelle alerte a été signalée, elle a été ajoutée dans votre liste de missions',
    MISSION_ACCEPT = 'Mission acceptée, mettez vous en route',
    MISSION_ANNULE = 'Votre client s\'est décommandé',
    MISSION_CONCURENCE = 'Vous êtes plusieurs sur le coup',
    MISSION_INCONNU = 'Cette mission n\'est plus d\'actualité',
    MISSION_EN_COURS = 'Cette mission est déjà en cours de traitement'
    
}

--====================================================================================
--  Utils function
--====================================================================================
local function showMessageInformation(message, duree)
    duree = duree or 2000
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end
--====================================================================================
--  Gestion de prise et d'abandon de service
--====================================================================================


-- local function --onServiceChangeGouv()
--     if isAgentInService then
--         TriggerServerEvent('police:takeService')
--         TriggerServerEvent('police:requestMission')
--     else
--         -- Restaure Ped
--         TriggerServerEvent('police:endService')
--         TriggerServerEvent("skin_customization:SpawnPlayer")
--     end 
-- end


--====================================================================================
-- UserAction restart police
--====================================================================================

	RegisterNetEvent('gouv:fouille')
	AddEventHandler('gouv:fouille', function()
		if(isAgentInService) then
			t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 1) then
				TriggerServerEvent("gouv:targetFouille", GetPlayerServerId(t))
			else
				TriggerServerEvent("gouv:targetFouilleEmpty")
			end
		else
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous n'êtes pas en service !")
		end
	end)

	RegisterNetEvent('gouv:amende')
	AddEventHandler('gouv:amende', function(t, amount)
		if(isAgentInService) then
			TriggerServerEvent("gouv:amendeGranted", t, amount)
		else
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous n'êtes pas en service !")
		end
	end)

	RegisterNetEvent('gouv:cuff')
	AddEventHandler('gouv:cuff', function(t)
		if(isAgentInService) then
			t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 1) then
				TriggerServerEvent("gouv:cuffGranted", GetPlayerServerId(t))
			else
				TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Aucun joueur à portée !")
			end
		else
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous n'êtes pas en service !")
		end
	end)

	RegisterNetEvent('gouv:getArrested')
	AddEventHandler('gouv:getArrested', function()
		if (isAgent == false) then
			handCuffed = not handCuffed
			if (handCuffed) then
				TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous avez été menotté.")
				SetPedComponentVariation(GetPlayerPed(-1), 7, 41, 0 ,0)
			else
				TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Liberté ! Adieu merveilleuses menottes ...")
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0 ,0)
			end
		end
	end)

	RegisterNetEvent('gouv:payAmende')
	AddEventHandler('gouv:payAmende', function(amount)
		TriggerServerEvent('bank:withdrawAmende', amount)
        TriggerServerEvent("coffrelspd:amendecoffre", amount)
		TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous avez payé une amende de $"..amount..".")
	end)



	RegisterNetEvent('gouv:forceEnter')
	AddEventHandler('gouv:forceEnter', function(id)
		if(isAgentInService) then
			t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 1) then
				TriggerServerEvent("gouv:forceEnterAsk", GetPlayerServerId(t))
			else
				TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Aucun joueur menotté à portée !")
			end
		else
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous n'êtes pas en service !")
		end
	end)

--====================================================================================
-- Vehicule gestion
--====================================================================================

function GOUV_showInfoClient() 
    if GOUV_CALL_ACCEPT_P ~= 0 then

        local offsetX = 0.87
        local offsetY = 0.785
        DrawRect(offsetX, offsetY, 0.23, 0.035, 0, 0, 0, 215)

        SetTextFont(1)
        SetTextScale(0.0,0.5)
        SetTextCentre(true)
        SetTextDropShadow(0, 0, 0, 0, 0)
        SetTextEdge(0, 0, 0, 0, 0)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        if GOUV_CALL_ACCEPT_P == 1 then
            AddTextComponentString(GOUV_TEXT.CALL_INFO_OK)
        else 
            if GOUV_nbMecanoisInService == 0 then
                AddTextComponentString(GOUV_TEXT.CALL_INFO_NO_PERSONNEL)
            elseif GOUV_nbMecanoDispo == 0 then
                AddTextComponentString(GOUV_TEXT.CALL_INFO_ALL_BUSY)
            else
                AddTextComponentString(GOUV_TEXT.CALL_INFO_WAIT)
            end
        end  
        DrawText(offsetX, offsetY - 0.015 )
    end
end

function GOUV_showInfoJobs()
    local offsetX = 0.9
    local offsetY = 0.845
    DrawRect(offsetX, offsetY, 0.15, 0.07, 0, 0, 0, 215)

    SetTextFont(1)
    SetTextScale(0.0,0.5)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString('~o~Gouv Info')
    DrawText(offsetX, offsetY - 0.03)

    SetTextFont(1)
    SetTextScale(0.0,0.5)
    SetTextCentre(false)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")

    AddTextComponentString(GOUV_nbMissionEnAttenteText)
    DrawText(offsetX - 0.065, offsetY -0.002)
end



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isAgent then
            --gestionService()
            
            if isAgentInService then
				--TriggerServerEvent('police:setService', true)
                GOUV_showInfoJobs()	
			else
				--TriggerServerEvent('police:setService', false)
            end
        end

        if GOUV_CALL_ACCEPT_P ~= 0 then
            GOUV_showInfoClient()
        end
        -- Citizen.Trace('isAgent: ' .. (isAgent and 'True' or 'False'))
        -- POLICE_showInfoJobs()
    end
end)

--
RegisterNetEvent('gouv:drawMarker')	
AddEventHandler('gouv:drawMarker', function (boolean)
	isAgent = true
    Citizen.Trace('NOW AGENT')
    Citizen.Trace('NOW AGENT')
    Citizen.Trace('NOW AGENT')
end)
RegisterNetEvent('gouv:drawBlips')	
AddEventHandler('gouv:drawBlips', function ()

end)
RegisterNetEvent('gouv:marker')	
AddEventHandler('gouv:marker', function ()
end)

RegisterNetEvent('gouv:deleteBlips')
AddEventHandler('gouv:deleteBlips', function ()
    isAgent = false
	Citizen.Trace("NOMOREAGENT")
	TriggerServerEvent("gouv:removeAgent")
	TriggerEvent("gouv:finishService")
	
	RemoveAllPedWeapons(GetPlayerPed(-1), true)
end)

--====================================================================================
-- Call System
--====================================================================================

-- Notification
function notifIcon(icon, type, sender, title, text)
	Citizen.CreateThread(function()
        Wait(1)
        SetNotificationTextEntry("STRING");
        if GOUV_TEXT[text] ~= nil then
            text = GOUV_TEXT[text]
        end
        AddTextComponentString(text);
        SetNotificationMessage(icon, icon, true, type, sender, title, text);
        DrawNotification(false, true);
	end)
end

RegisterNetEvent("gouv:PersonnelMessage")
AddEventHandler("gouv:PersonnelMessage",function(message)
    if isAgentInService then
        notifIcon("CHAR_BLANK_ENTRY", 1, "Gouv Info", false, message)
    end
end)

RegisterNetEvent("gouv:ClientMessage")
AddEventHandler("gouv:ClientMessage",function(message)
    notifIcon("CHAR_BLANK_ENTRY", 1, "Gouv", false, message)
end)

-- 
function acceptMissionGouv(data) 
    local mission = data.mission 
    TriggerServerEvent('gouv:AcceptMission', mission.id)
end

function finishCurrentMissionGouv()
    TriggerServerEvent('gouv:FinishMission', GOUV_currentMissions.id)
    GOUV_currentMissions = nil
    if GOUV_currentBlip ~= nil then
        RemoveBlip(GOUV_currentBlip)
    end
end

function updateMenuMissionGouv() 
    local items = {{['Title'] = 'Retour', ['ReturnBtn'] = true }}
      for k,v in pairs(GOUV_listMissions) do
        Citizen.Trace('==>' .. k )
    end
    for _,m in pairs(GOUV_listMissions) do 
        local item = {
            Title = '' .. m.id .. ' - ' .. m.type,
            mission = m,
            Function = acceptMissionGouv
        }
        if #m.acceptBy ~= 0 then
            item.Title = item.Title .. ' (' .. #m.acceptBy ..' Unité)'
            item.TextColor = {39, 174, 96, 255}
        end
        table.insert(items, item)
        Citizen.Trace('add')
    end

    if GOUV_currentMissions ~= nil then
        table.insert(items, {['Title'] = 'Terminer la mission', ['Function'] = finishCurrentMissionGouv})
    end
    table.insert(items, {['Title'] = 'Fermer'})

    menu = {['Title'] = 'Missions en cours',  ['SubMenu'] = {
        ['Title'] = 'Missions en cours', ['Items'] = items
    }}
    updateMenuGouv(menu)
end

function callGouv(type)
    local myPed = GetPlayerPed(-1)
    local myCoord = GetEntityCoords(myPed)
    TriggerServerEvent('gouv:Call', myCoord.x, myCoord.y, myCoord.z, type)
end

RegisterNetEvent('gouv:MissionAccept')
AddEventHandler('gouv:MissionAccept', function (mission)
    GOUV_currentMissions = mission
    SetNewWaypoint(mission.pos[1], mission.pos[2])
    GOUV_currentBlip = AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
    SetBlipSprite(GOUV_currentBlip, 58)
    SetBlipColour(GOUV_currentBlip, 5)
    SetBlipAsShortRange(GOUV_currentBlip, true)
    --SetBlipFlashes(GOUV_currentBlip,1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(GOUV_TEXT.Blip)
	EndTextCommandSetBlipName(GOUV_currentBlip)
    SetBlipAsMissionCreatorBlip(GOUV_currentBlip, true)

end)

RegisterNetEvent('gouv:MissionCancel')
AddEventHandler('gouv:MissionCancel', function ()
    GOUV_currentMissions = nil
    if GOUV_currentBlip ~= nil then
        RemoveBlip(GOUV_currentBlip)
    end
end)

RegisterNetEvent('gouv:MissionChange')
AddEventHandler('gouv:MissionChange', function (missions)
    if not isAgentInService then
        return
    end 
    
    GOUV_listMissions = missions
    local nbMissionEnAttente = 0
    for _,m in pairs(GOUV_listMissions) do
        if #m.acceptBy == 0 then
            nbMissionEnAttente = nbMissionEnAttente + 1
        end
    end
    if nbMissionEnAttente == 0 then 
        GOUV_nbMissionEnAttenteText = GOUV_TEXT.InfoGouvNoAppel
    else
        GOUV_nbMissionEnAttenteText = '~g~ ' .. nbMissionEnAttente .. ' ' .. GOUV_TEXT.InfoGouvNbAppel
    end
  
    updateMenuMissionGouv()
end)

RegisterNetEvent('gouv:openMenu')
AddEventHandler('gouv:openMenu', function()
    if isAgentInService then
        TriggerServerEvent('gouv:requestMission')
        openMenuGouvGeneral()
    else
        showMessageInformation("~r~Vous devez être en service pour acceder au menu")
    end
end)

RegisterNetEvent('gouv:callGouv')
AddEventHandler('gouv:callGouv',function(data)
    callGouv(data.type)
end)

RegisterNetEvent('gouv:callGouvCustom')
AddEventHandler('gouv:callGouvCustom',function()
    local raison = openTextInput('','', 32)
    if raison ~= nil and raison ~= '' then 
        callGouv(raison)
    end
end)

RegisterNetEvent('gouv:callStatus')
AddEventHandler('gouv:callStatus',function(status)
    GOUV_CALL_ACCEPT_P = status
end)

RegisterNetEvent('gouv:personnelChange')
AddEventHandler('gouv:personnelChange',function(nbPersonnel, nbDispo)
    --Citizen.Trace('nbPersonnel : ' .. nbPersonnel .. ' dispo' .. nbDispo)
    GOUV_nbMecanoisInService = nbPersonnel
    GOUV_nbMecanoDispo = nbDispo
end)

RegisterNetEvent('gouv:cancelCall')
AddEventHandler('gouv:cancelCall',function(data)
    TriggerServerEvent('gouv:cancelCall')
end)

--====================================================================================
-- Initialisation
--====================================================================================


RegisterNetEvent('gouv:drawGetService')
AddEventHandler('gouv:drawGetService', function (source)
	isAgentInService = not isAgentInService
    --onServiceChangeGouv()
	Citizen.Trace("DRAWDRAW")
	TriggerServerEvent('gouv:setService', isAgentInService)
	if(existingVeh ~= nil) then
		SetEntityAsMissionEntity(existingVeh, true, true)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
		existingVeh = nil
	end
end)

RegisterNetEvent('gouv:getSkin')
AddEventHandler('gouv:getSkin', function (source)
    local playerPed = GetPlayerPed(-1)
    if (isAgent and isAgentInService) then
        SetPedComponentVariation(playerPed, 11, 55, 0, 2)  --Chemise Gouv
        SetPedComponentVariation(playerPed, 8, 58, 0, 2)   --Ceinture + matraque Gouv 
        SetPedComponentVariation(playerPed, 4, 35, 0, 2)   --Pantalon Gouv
        SetPedComponentVariation(playerPed, 6, 24, 0, 2)   -- Chaussure Gouv
        SetPedComponentVariation(playerPed, 10, 8, 0, 2)   --grade 0
        SetPedComponentVariation(playerPed, 3, 0, 0, 2)   -- under skin
        GiveWeaponToPed(playerPed, GetHashKey("WEAPON_NIGHTSTICK"), true, true)
        GiveWeaponToPed(playerPed, GetHashKey("WEAPON_PISTOL50"), 100, true, true)
        GiveWeaponToPed(playerPed, GetHashKey("WEAPON_STUNGUN"), true, true)
        GiveWeaponToPed(playerPed, GetHashKey("WEAPON_PUMPSHOTGUN"), 100, true, true)
    else
        TriggerServerEvent("skin_customization:SpawnPlayer")
        RemoveAllPedWeapons(GetPlayerPed(-1), true)
    end
end)

RegisterNetEvent('gouv:receiveIsAgent')
AddEventHandler('gouv:receiveIsAgent', function(result)
    if (result == "inconnu") then
        isAgent = false
        isAgentInService = false
        --onServiceChangeGouv()
    else
        isAgent = true
    end
end)

RegisterNetEvent('gouv:nowAgent')
AddEventHandler('gouv:nowAgent', function()
    isAgent = true
    isAgentInService = false
    --onServiceChangeGouv()
    TriggerServerEvent("metiers:jobs", 2)
end)

RegisterNetEvent('gouv:noLongerAgent')
AddEventHandler('gouv:noLongerAgent', function()
    isAgent = false
    isAgentInService = false
    --onServiceChangeGouv()
    TriggerServerEvent("metiers:jobs", 1)
    if(existingVeh ~= nil) then
        SetEntityAsMissionEntity(existingVeh, true, true)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
        existingVeh = nil
    end
end)

RegisterNetEvent('gouv:postAmendes')
RegisterNetEvent('gouv:postAmendes', function(data)
    
end)

RegisterNetEvent('gouv:postAmendesCustom')
RegisterNetEvent('gouv:postAmendesCustom', function(data)
    
end)

AddEventHandler("playerSpawned", function(source)
    TriggerServerEvent("gouv:checkIsAgent")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if (handCuffed == true) then
            RequestAnimDict('mp_arresting')
            SetPedComponentVariation(GetPlayerPed(-1), 7, 41, 0 ,0)

            while not HasAnimDictLoaded('mp_arresting') do
            Citizen.Wait(0)
            end
            
            local myPed = PlayerPedId()
            local animation = 'idle'
            local flags = 16

            TaskPlayAnim(myPed, 'mp_arresting', animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
        end
    end
end)

function openTextInput(title, defaultText, maxlength)
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", defaultText or "", "", "", "", maxlength or 180)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		return GetOnscreenKeyboardResult()
	end
	return nil
end

--====================================================================================
-- Action
--====================================================================================
function GOUV_Check()
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("gouv:targetCheckInventory", GetPlayerServerId(t))
	else
		TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
	end
end

function GOUV_Saisir_AS()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("gouv:targetSaisirDyrtiMoney", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
    end
end

function GOUV_Saisir_ITEM()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("gouv:targetSaisirIllegal", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
    end
end

function GOUV_Saisir_ALLWEAPONS()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        
        TriggerServerEvent("gouv:targetSaisirAllWeapon", GetPlayerServerId(t))
        RemoveAllPedWeapons(GetPlayerPed(t), true)
        
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
    end
end

function GOUV_Saisir_NOACHAWEAPONS()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        RemoveAllPedWeapons(GetPlayerPed(t), true)
        TriggerServerEvent("gouv:targetSaisirNoAchaWeapon", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
    end
end

function GOUV_Saisir_TEMPSWEAPONS()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        RemoveAllPedWeapons(GetPlayerPed(t), true)
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
    end
end

function GOUV_Rendre_WEAPONS()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("gouv:targetSaisirRendreWeapon", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
    end
end

function GOUV_Cuffed()
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("gouv:cuffGranted", GetPlayerServerId(t))
	else
		TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
	end
end

function GOUV_Crocheter()
	Citizen.CreateThread(function()
        Citizen.Trace('GOUV_Crocheter')
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        --GetClosestVehicle(x,y,z,distance dectection, 0 = tous les vehicules, Flag 70 = tous les veicules sauf police a tester https://pastebin.com/kghNFkRi)
        veh = GetClosestVehicle(plyCoords["x"], plyCoords["y"], plyCoords["z"], 5.001, 0, 70)
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)
        Citizen.Wait(20000)
        SetVehicleDoorsLocked(veh, 1)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        drawNotification("La voiture est ouverte.")
	end)
end

function GOUV_PutInVehicle()
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		local v = GetVehiclePedIsIn(GetPlayerPed(-1), true)
		TriggerServerEvent("gouv:forceEnterAsk", GetPlayerServerId(t), v)
	else
		TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "pas de joueur proche!")
	end
end

function GOUV_UnseatVehicle()
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("gouv:confirmUnseat", GetPlayerServerId(t))
	else
		TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "pas de joueur proche")
	end
end

function GOUV_CheckPlate()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
	if(DoesEntityExist(vehicleHandle)) then
		TriggerServerEvent("gouv:checkingPlate", GetVehicleNumberPlateText(vehicleHandle))
	else
		TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Pas de véhicule proche!")
	end
end

function GOUV_FINE_DATA(data)
    GOUV_Fines(data.tarif, data.Title)
end



-- function GOUV_PRISON_DATA(data)
--     t, distance = GetClosestPlayer()
--     if(distance ~= -1 and distance < 3) then
--         TriggerServerEvent("jail:teleportToJail", GetPlayerServerId(t), data.tarif)
--     else
--         TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Pas de joueur proche!")
--     end
-- end

function GOUV_FINE_CUSTOM()
    local r = openTextInput('','', 128)
    if r ~= nil and r ~= '' then
        local t = tonumber(openTextInput('','', 12))
        if t ~= nil and t > 0 then
            GOUV_Fines(t,r)
        end
    end
end

function GOUV_Fines(amount, reason)
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("gouv:finesGranted", GetPlayerServerId(t), amount, reason)
	else
		TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Pas de joueur proche!")
	end
end
--====================================================================================
-- Event 
--====================================================================================

RegisterNetEvent('gouv:payFines')
AddEventHandler('gouv:payFines', function(amount)
	TriggerServerEvent('bank:withdrawAmende', amount)
    TriggerServerEvent("coffrelspd:amendecoffre", amount)
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous avez payé $"..amount.." d'amende.")
end)

RegisterNetEvent('gouv:dropIllegalItem')
AddEventHandler('gouv:dropIllegalItem', function(id)
    TriggerEvent("player:looseItem", tonumber(id), exports.vdk_inventory:getQuantity(id))
end)

RegisterNetEvent('gouv:unseatme')
AddEventHandler('gouv:unseatme', function(t)
    local ped = GetPlayerPed(t)			
    ClearPedTasksImmediately(ped)
    plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
    local xnew = plyPos.x + 2
    local ynew = plyPos.y + 2
    
    SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

RegisterNetEvent('gouv:forcedEnteringVeh')
AddEventHandler('gouv:forcedEnteringVeh', function()
    if(handCuffed) then
        -- local pos = GetEntityCoords(GetPlayerPed(-1), 0)
        -- local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0, 3.0, 0.0)
        -- local rayHandle = Cast_3dRayPointToPoint(pos.x, pos.y, pos.z-1, entityWorld.x, entityWorld.y, entityWorld.z,5, 10, player, 0)
        -- local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
        local ped = GetPlayerPed(-1)
        local coordFrom =GetOffsetFromEntityInWorldCoords( ped, 0.0, 0.0, 0.0 )
        local coordTo = GetOffsetFromEntityInWorldCoords( ped, 0.0, 3.0, -0.8 )
        local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
        local _, _, _, _, vehicleHandle = GetRaycastResult( rayHandle )
        if vehicleHandle ~= nil then
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 2)
            TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Dans La voiture")
        end
    end
end)

RegisterNetEvent('gouv:resultAllAgentsInService')
AddEventHandler('gouv:resultAllAgentsInService', function(array)
	allServiceAgents = array
	enableAgentBlips()
end)

function enableAgentBlips()

	-- for k, existingBlip in pairs(blipsAgents) do
        -- RemoveBlip(existingBlip)
    -- end
	-- blipsAgents = {}
	
	-- local localIdAgents = {}
	-- for id = 0, 64 do
		-- if(NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
			-- for i,c in pairs(allServiceAgents) do
				-- if(i == GetPlayerServerId(id)) then
					-- localIdAgents[id] = c
					-- break
				-- end
			-- end
		-- end
	-- end
	
	-- for id, c in pairs(localIdAgents) do
		-- local ped = GetPlayerPed(id)
		-- local blip = GetBlipFromEntity(ped)
		
		-- if not DoesBlipExist( blip ) then

			-- blip = AddBlipForEntity( ped )
			-- SetBlipSprite( blip, 1 )
			-- Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			-- HideNumberOnBlip( blip )
			-- SetBlipNameToPlayerName( blip, id )
			
			-- SetBlipScale( blip,  0.85 )
			-- SetBlipAlpha( blip, 255 )
			
			-- table.insert(blipsAgents, blip)
		-- else
			
			-- blipSprite = GetBlipSprite( blip )
			
			-- HideNumberOnBlip( blip )
			-- if blipSprite ~= 1 then
				-- SetBlipSprite( blip, 1 )
				-- Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			-- end
			
			-- Citizen.Trace("Name : "..GetPlayerName(id))
			-- SetBlipNameToPlayerName( blip, id )
			-- SetBlipScale( blip,  0.85 )
			-- SetBlipAlpha( blip, 255 )
			
			-- table.insert(blipsAgents, blip)
		-- end
	-- end
end

--====================================================================================
-- Initialisation
--====================================================================================


TriggerServerEvent('gouv:requestPersonnel')
--TriggerServerEvent("police:checkIsAgent")

-- Register a network event 
RegisterNetEvent( 'deleteVehicle' )

-- The distance to check in front of the player for a vehicle
-- Distance is in GTA units, which are quite big  
local distanceToCheck = 5.0

-- Add an event handler for the deleteVehicle event. 
-- Gets called when a user types in /dv in chat (see server.lua)
function GOUV_deleteVehicle()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )
        -- log( "Player is at:\nX: " .. pos.x .. " Y: " .. pos.y .. " Z: " .. pos.z )
        -- log( "Found vehicle?: " .. tostring( DoesEntityExist( vehicle ) ) )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                ShowNotification( "Vehicule supprime." )
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )
            else 
                ShowNotification( "Mettez-vous à la place conducteur" )
            end 
        else
            local playerPos = GetEntityCoords( ped, 1 )
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( playerPos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                -- log( "Distance between ped and vehicle: " .. tostring( GetDistanceBetween( ped, vehicle ) ) )
                ShowNotification( "Vehicle deleted." )
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )
            else 
                ShowNotification( "Rapprochez-vous d'un vehicule" )
            end 
        end 
    end 
end

-- Delete car function borrowed frtom Mr.Scammer's model blacklist, thanks to him!
function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

-- Gets a vehicle in a certain direction
-- Credit to Konijima
function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

-- Shows a notification on the player's screen 
function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlPressed(1, 323) then --Start holding X
			if IsPedInAnyVehicle(LocalPed(), true) == false then
				TaskHandsUp(GetPlayerPed(-1), 1000, -1, -1, true) -- Perform animation.
			end
		end
		if IsControlPressed(1, 29) then --Start holding B
			if IsPedInAnyVehicle(LocalPed(), true) == false then
				TaskToggleDuck(GetPlayerPed(-1), 1000, -1, -1, true) -- Perform animation.
				RequestAnimDict( 'gestures@f@standing@casual' )
				while not HasAnimDictLoaded('gestures@f@standing@casual') do
					Citizen.Wait(0)
				end
				if HasAnimDictLoaded('gestures@f@standing@casual') then
					TaskPlayAnim( GetPlayerPed(-1), 'gestures@f@standing@casual', 'gesture_point' ,8.0, -8.0, -1, 0, 0, false, false, false )
				end
			end
		end
		
	end
end)
