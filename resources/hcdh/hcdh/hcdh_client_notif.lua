local KEY_E = 38
local KEY_CLOSE = 177
local HCDH_currentBlip = nil 
local HCDH_listMissions = {}
local HCDH_currentMissions = nil
local HCDH_nbMissionEnAttenteText = '-- Aucune Info --'
local HCDH_BlipMecano = {}
local HCDH_showHelp = false
local HCDH_CALL_ACCEPT_P = 0
local HCDH_nbMecanoisInService = 0
local HCDH_nbMecanoDispo = 0


-- local isMembre = false
-- local isMembreInService = false
-- local rank = "inconnu"
-- local checkpoints = {}
-- local existingVeh = nil
-- local handCuffed = false

-- isMembre = true -- famse
-- isisInService = false
-- blipsMembres = {}


local HCDH_TEXT = {
    PrendreService = '~INPUT_PICKUP~ Prendre son service de membre de la HCDH',
    QuitterService = '~INPUT_PICKUP~ Quitter son service de membre de la HCDH',
    SpawnVehicle = '~INPUT_PICKUP~ Recuprer son véhicule de ~b~service',
    SpawnVehicleImpossible = '~R~ Impossible, aucune place disponible',

    Blip = 'Mission en cours',


    MissionCancel = 'Votre mission en cours n\'est plus d\'actualité',
    MissionClientAccept = 'Un membre de la HCDH a prit votre appel',
    MissionClientCancel = 'Votre membre de la HCDH vous a abandonné',
    InfoHcdhNoAppel = '~g~Aucun appel en attente',
    InfoHcdhNbAppel = '~w~ Appel en attente',
    BlipMecanoService = 'Prise de service',
    BlipMecanoVehicle = 'Prise du véhicule de service',

    CALL_INFO_NO_PERSONNEL = '~r~Aucun membre de la HCDH en service',
    CALL_INFO_ALL_BUSY = '~o~Toutes nos unité sont occupés',
    CALL_INFO_WAIT = '~b~Votre appel est sur attente',
    CALL_INFO_OK = '~g~Une unité va arriver sur les lieux de l\'appel',

    CALL_RECU = 'Confirmation\nVotre appel a été enregistré',
    CALL_ACCEPT_P_P = 'Votre appel a été accepté, un Membre HCDH est en route',
    CALL_CANCEL = 'Le membre de la HCDH vient d\'abandonner votre appel',
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


-- local function --onServiceChangeHcdh()
--     if isMembreInService then
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

	RegisterNetEvent('hcdh:fouille')
	AddEventHandler('hcdh:fouille', function()
		if(isMembreInService) then
			t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 1) then
				TriggerServerEvent("hcdh:targetFouille", GetPlayerServerId(t))
			else
				TriggerServerEvent("hcdh:targetFouilleEmpty")
			end
		else
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous n'êtes pas en service !")
		end
	end)

	RegisterNetEvent('hcdh:amende')
	AddEventHandler('hcdh:amende', function(t, amount)
		if(isMembreInService) then
			TriggerServerEvent("hcdh:amendeGranted", t, amount)
		else
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous n'êtes pas en service !")
		end
	end)

	RegisterNetEvent('hcdh:cuff')
	AddEventHandler('hcdh:cuff', function(t)
		if(isMembreInService) then
			t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 1) then
				TriggerServerEvent("hcdh:cuffGranted", GetPlayerServerId(t))
			else
				TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Aucun joueur à portée !")
			end
		else
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous n'êtes pas en service !")
		end
	end)

	RegisterNetEvent('hcdh:getArrested')
	AddEventHandler('hcdh:getArrested', function()
		if (isMembre == false) then
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

	RegisterNetEvent('hcdh:payAmende')
	AddEventHandler('hcdh:payAmende', function(amount)
		TriggerServerEvent('bank:withdrawAmende', amount)
        TriggerServerEvent("coffrelspd:amendecoffre", amount)
		TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous avez payé une amende de $"..amount..".")
	end)



	RegisterNetEvent('hcdh:forceEnter')
	AddEventHandler('hcdh:forceEnter', function(id)
		if(isMembreInService) then
			t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 1) then
				TriggerServerEvent("hcdh:forceEnterAsk", GetPlayerServerId(t))
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

function HCDH_showInfoClient() 
    if HCDH_CALL_ACCEPT_P ~= 0 then

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
        if HCDH_CALL_ACCEPT_P == 1 then
            AddTextComponentString(HCDH_TEXT.CALL_INFO_OK)
        else 
            if HCDH_nbMecanoisInService == 0 then
                AddTextComponentString(HCDH_TEXT.CALL_INFO_NO_PERSONNEL)
            elseif HCDH_nbMecanoDispo == 0 then
                AddTextComponentString(HCDH_TEXT.CALL_INFO_ALL_BUSY)
            else
                AddTextComponentString(HCDH_TEXT.CALL_INFO_WAIT)
            end
        end  
        DrawText(offsetX, offsetY - 0.015 )
    end
end

function HCDH_showInfoJobs()
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
    AddTextComponentString('~o~Hcdh Info')
    DrawText(offsetX, offsetY - 0.03)

    SetTextFont(1)
    SetTextScale(0.0,0.5)
    SetTextCentre(false)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")

    AddTextComponentString(HCDH_nbMissionEnAttenteText)
    DrawText(offsetX - 0.065, offsetY -0.002)
end



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isMembre then
            --gestionService()
            
            if isMembreInService then
				--TriggerServerEvent('police:setService', true)
                HCDH_showInfoJobs()	
			else
				--TriggerServerEvent('police:setService', false)
            end
        end

        if HCDH_CALL_ACCEPT_P ~= 0 then
            HCDH_showInfoClient()
        end
        -- Citizen.Trace('isMembre: ' .. (isMembre and 'True' or 'False'))
        -- POLICE_showInfoJobs()
    end
end)

--
RegisterNetEvent('hcdh:drawMarker')	
AddEventHandler('hcdh:drawMarker', function (boolean)
	isMembre = true
    Citizen.Trace('NOW AGENT')
    Citizen.Trace('NOW AGENT')
    Citizen.Trace('NOW AGENT')
end)
RegisterNetEvent('hcdh:drawBlips')	
AddEventHandler('hcdh:drawBlips', function ()

end)
RegisterNetEvent('hcdh:marker')	
AddEventHandler('hcdh:marker', function ()
end)

RegisterNetEvent('hcdh:deleteBlips')
AddEventHandler('hcdh:deleteBlips', function ()
    isMembre = false
	Citizen.Trace("NOMOREAGENT")
	TriggerServerEvent("hcdh:removeMembre")
	TriggerEvent("hcdh:finishService")
	
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
        if HCDH_TEXT[text] ~= nil then
            text = HCDH_TEXT[text]
        end
        AddTextComponentString(text);
        SetNotificationMessage(icon, icon, true, type, sender, title, text);
        DrawNotification(false, true);
	end)
end

RegisterNetEvent("hcdh:PersonnelMessage")
AddEventHandler("hcdh:PersonnelMessage",function(message)
    if isMembreInService then
        notifIcon("CHAR_BLANK_ENTRY", 1, "Hcdh Info", false, message)
    end
end)

RegisterNetEvent("hcdh:ClientMessage")
AddEventHandler("hcdh:ClientMessage",function(message)
    notifIcon("CHAR_BLANK_ENTRY", 1, "Hcdh", false, message)
end)

-- 
function acceptMissionHcdh(data) 
    local mission = data.mission 
    TriggerServerEvent('hcdh:AcceptMission', mission.id)
end

function finishCurrentMissionHcdh()
    TriggerServerEvent('hcdh:FinishMission', HCDH_currentMissions.id)
    HCDH_currentMissions = nil
    if HCDH_currentBlip ~= nil then
        RemoveBlip(HCDH_currentBlip)
    end
end

function updateMenuMissionHcdh() 
    local items = {{['Title'] = 'Retour', ['ReturnBtn'] = true }}
      for k,v in pairs(HCDH_listMissions) do
        Citizen.Trace('==>' .. k )
    end
    for _,m in pairs(HCDH_listMissions) do 
        local item = {
            Title = '' .. m.id .. ' - ' .. m.type,
            mission = m,
            Function = acceptMissionHcdh
        }
        if #m.acceptBy ~= 0 then
            item.Title = item.Title .. ' (' .. #m.acceptBy ..' Unité)'
            item.TextColor = {39, 174, 96, 255}
        end
        table.insert(items, item)
        Citizen.Trace('add')
    end

    if HCDH_currentMissions ~= nil then
        table.insert(items, {['Title'] = 'Terminer la mission', ['Function'] = finishCurrentMissionHcdh})
    end
    table.insert(items, {['Title'] = 'Fermer'})

    menu = {['Title'] = 'Missions en cours',  ['SubMenu'] = {
        ['Title'] = 'Missions en cours', ['Items'] = items
    }}
    updateMenuHcdh(menu)
end

function callHcdh(type)
    local myPed = GetPlayerPed(-1)
    local myCoord = GetEntityCoords(myPed)
    TriggerServerEvent('hcdh:Call', myCoord.x, myCoord.y, myCoord.z, type)
end

RegisterNetEvent('hcdh:MissionAccept')
AddEventHandler('hcdh:MissionAccept', function (mission)
    HCDH_currentMissions = mission
    SetNewWaypoint(mission.pos[1], mission.pos[2])
    HCDH_currentBlip = AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
    SetBlipSprite(HCDH_currentBlip, 58)
    SetBlipColour(HCDH_currentBlip, 5)
    SetBlipAsShortRange(HCDH_currentBlip, true)
    --SetBlipFlashes(HCDH_currentBlip,1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(HCDH_TEXT.Blip)
	EndTextCommandSetBlipName(HCDH_currentBlip)
    SetBlipAsMissionCreatorBlip(HCDH_currentBlip, true)

end)

RegisterNetEvent('hcdh:MissionCancel')
AddEventHandler('hcdh:MissionCancel', function ()
    HCDH_currentMissions = nil
    if HCDH_currentBlip ~= nil then
        RemoveBlip(HCDH_currentBlip)
    end
end)

RegisterNetEvent('hcdh:MissionChange')
AddEventHandler('hcdh:MissionChange', function (missions)
    if not isMembreInService then
        return
    end 
    
    HCDH_listMissions = missions
    local nbMissionEnAttente = 0
    for _,m in pairs(HCDH_listMissions) do
        if #m.acceptBy == 0 then
            nbMissionEnAttente = nbMissionEnAttente + 1
        end
    end
    if nbMissionEnAttente == 0 then 
        HCDH_nbMissionEnAttenteText = HCDH_TEXT.InfoHcdhNoAppel
    else
        HCDH_nbMissionEnAttenteText = '~g~ ' .. nbMissionEnAttente .. ' ' .. HCDH_TEXT.InfoHcdhNbAppel
    end
  
    updateMenuMissionHcdh()
end)

RegisterNetEvent('hcdh:openMenu')
AddEventHandler('hcdh:openMenu', function()
    if isMembreInService then
        TriggerServerEvent('hcdh:requestMission')
        openMenuHcdhGeneral()
    else
        showMessageInformation("~r~Vous devez être en service pour acceder au menu")
    end
end)

RegisterNetEvent('hcdh:callHcdh')
AddEventHandler('hcdh:callHcdh',function(data)
    callHcdh(data.type)
end)

RegisterNetEvent('hcdh:callHcdhCustom')
AddEventHandler('hcdh:callHcdhCustom',function()
    local raison = openTextInput('','', 32)
    if raison ~= nil and raison ~= '' then 
        callHcdh(raison)
    end
end)

RegisterNetEvent('hcdh:callStatus')
AddEventHandler('hcdh:callStatus',function(status)
    HCDH_CALL_ACCEPT_P = status
end)

RegisterNetEvent('hcdh:personnelChange')
AddEventHandler('hcdh:personnelChange',function(nbPersonnel, nbDispo)
    --Citizen.Trace('nbPersonnel : ' .. nbPersonnel .. ' dispo' .. nbDispo)
    HCDH_nbMecanoisInService = nbPersonnel
    HCDH_nbMecanoDispo = nbDispo
end)

RegisterNetEvent('hcdh:cancelCall')
AddEventHandler('hcdh:cancelCall',function(data)
    TriggerServerEvent('hcdh:cancelCall')
end)

--====================================================================================
-- Initialisation
--====================================================================================


RegisterNetEvent('hcdh:drawGetService')
AddEventHandler('hcdh:drawGetService', function (source)
	isMembreInService = not isMembreInService
    --onServiceChangeHcdh()
	Citizen.Trace("DRAWDRAW")
	TriggerServerEvent('hcdh:setService', isMembreInService)
	if(existingVeh ~= nil) then
		SetEntityAsMissionEntity(existingVeh, true, true)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
		existingVeh = nil
	end
end)

RegisterNetEvent('hcdh:getSkin')
AddEventHandler('hcdh:getSkin', function (source)
    local playerPed = GetPlayerPed(-1)
    if (isMembre and isMembreInService) then
        SetPedComponentVariation(playerPed, 11, 55, 0, 2)  --Chemise Hcdh
        SetPedComponentVariation(playerPed, 8, 58, 0, 2)   --Ceinture + matraque Hcdh 
        SetPedComponentVariation(playerPed, 4, 35, 0, 2)   --Pantalon Hcdh
        SetPedComponentVariation(playerPed, 6, 24, 0, 2)   -- Chaussure Hcdh
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

RegisterNetEvent('hcdh:receiveIsMembre')
AddEventHandler('hcdh:receiveIsMembre', function(result)
    if (result == "inconnu") then
        isMembre = false
        isMembreInService = false
        --onServiceChangeHcdh()
    else
        isMembre = true
    end
end)

RegisterNetEvent('hcdh:nowMembre')
AddEventHandler('hcdh:nowMembre', function()
    isMembre = true
    isMembreInService = false
    --onServiceChangeHcdh()
    TriggerServerEvent("metiers:jobs", 2)
end)

RegisterNetEvent('hcdh:noLongerMembre')
AddEventHandler('hcdh:noLongerMembre', function()
    isMembre = false
    isMembreInService = false
    --onServiceChangeHcdh()
    TriggerServerEvent("metiers:jobs", 1)
    if(existingVeh ~= nil) then
        SetEntityAsMissionEntity(existingVeh, true, true)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
        existingVeh = nil
    end
end)

RegisterNetEvent('hcdh:postAmendes')
RegisterNetEvent('hcdh:postAmendes', function(data)
    
end)

RegisterNetEvent('hcdh:postAmendesCustom')
RegisterNetEvent('hcdh:postAmendesCustom', function(data)
    
end)

AddEventHandler("playerSpawned", function(source)
    TriggerServerEvent("hcdh:checkIsMembre")
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
function HCDH_Check()
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("hcdh:targetCheckInventory", GetPlayerServerId(t))
	else
		TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
	end
end

function HCDH_Saisir_AS()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("hcdh:targetSaisirDyrtiMoney", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
    end
end

function HCDH_Saisir_ITEM()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("hcdh:targetSaisirIllegal", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
    end
end

function HCDH_Saisir_ALLWEAPONS()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        
        TriggerServerEvent("hcdh:targetSaisirAllWeapon", GetPlayerServerId(t))
        RemoveAllPedWeapons(GetPlayerPed(t), true)
        
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
    end
end

function HCDH_Saisir_NOACHAWEAPONS()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        RemoveAllPedWeapons(GetPlayerPed(t), true)
        TriggerServerEvent("hcdh:targetSaisirNoAchaWeapon", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
    end
end

function HCDH_Saisir_TEMPSWEAPONS()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        RemoveAllPedWeapons(GetPlayerPed(t), true)
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
    end
end

function HCDH_Rendre_WEAPONS()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("hcdh:targetSaisirRendreWeapon", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
    end
end

function HCDH_Cuffed()
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("hcdh:cuffGranted", GetPlayerServerId(t))
	else
		TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "pas de joueur proche!")
	end
end

function HCDH_Crocheter()
	Citizen.CreateThread(function()
        Citizen.Trace('HCDH_Crocheter')
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

function HCDH_PutInVehicle()
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		local v = GetVehiclePedIsIn(GetPlayerPed(-1), true)
		TriggerServerEvent("hcdh:forceEnterAsk", GetPlayerServerId(t), v)
	else
		TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "pas de joueur proche!")
	end
end

function HCDH_UnseatVehicle()
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("hcdh:confirmUnseat", GetPlayerServerId(t))
	else
		TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "pas de joueur proche")
	end
end

function HCDH_CheckPlate()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
	if(DoesEntityExist(vehicleHandle)) then
		TriggerServerEvent("hcdh:checkingPlate", GetVehicleNumberPlateText(vehicleHandle))
	else
		TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Pas de véhicule proche!")
	end
end

function HCDH_FINE_DATA(data)
    HCDH_Fines(data.tarif, data.Title)
end



-- function HCDH_PRISON_DATA(data)
--     t, distance = GetClosestPlayer()
--     if(distance ~= -1 and distance < 3) then
--         TriggerServerEvent("jail:teleportToJail", GetPlayerServerId(t), data.tarif)
--     else
--         TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Pas de joueur proche!")
--     end
-- end

function HCDH_FINE_CUSTOM()
    local r = openTextInput('','', 128)
    if r ~= nil and r ~= '' then
        local t = tonumber(openTextInput('','', 12))
        if t ~= nil and t > 0 then
            HCDH_Fines(t,r)
        end
    end
end

function HCDH_Fines(amount, reason)
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("hcdh:finesGranted", GetPlayerServerId(t), amount, reason)
	else
		TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Pas de joueur proche!")
	end
end
--====================================================================================
-- Event 
--====================================================================================

RegisterNetEvent('hcdh:payFines')
AddEventHandler('hcdh:payFines', function(amount)
	TriggerServerEvent('bank:withdrawAmende', amount)
    TriggerServerEvent("coffrelspd:amendecoffre", amount)
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous avez payé $"..amount.." d'amende.")
end)

RegisterNetEvent('hcdh:dropIllegalItem')
AddEventHandler('hcdh:dropIllegalItem', function(id)
    TriggerEvent("player:looseItem", tonumber(id), exports.vdk_inventory:getQuantity(id))
end)

RegisterNetEvent('hcdh:unseatme')
AddEventHandler('hcdh:unseatme', function(t)
    local ped = GetPlayerPed(t)			
    ClearPedTasksImmediately(ped)
    plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
    local xnew = plyPos.x + 2
    local ynew = plyPos.y + 2
    
    SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

RegisterNetEvent('hcdh:forcedEnteringVeh')
AddEventHandler('hcdh:forcedEnteringVeh', function()
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

RegisterNetEvent('hcdh:resultAllMembresInService')
AddEventHandler('hcdh:resultAllMembresInService', function(array)
	allServiceMembres = array
	enableMembreBlips()
end)

function enableMembreBlips()

	-- for k, existingBlip in pairs(blipsMembres) do
        -- RemoveBlip(existingBlip)
    -- end
	-- blipsMembres = {}
	
	-- local localIdMembres = {}
	-- for id = 0, 64 do
		-- if(NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
			-- for i,c in pairs(allServiceMembres) do
				-- if(i == GetPlayerServerId(id)) then
					-- localIdMembres[id] = c
					-- break
				-- end
			-- end
		-- end
	-- end
	
	-- for id, c in pairs(localIdMembres) do
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
			
			-- table.insert(blipsMembres, blip)
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
			
			-- table.insert(blipsMembres, blip)
		-- end
	-- end
end

--====================================================================================
-- Initialisation
--====================================================================================


TriggerServerEvent('hcdh:requestPersonnel')
--TriggerServerEvent("police:checkIsMembre")

-- Register a network event 
RegisterNetEvent( 'deleteVehicle' )

-- The distance to check in front of the player for a vehicle
-- Distance is in GTA units, which are quite big  
local distanceToCheck = 5.0

-- Add an event handler for the deleteVehicle event. 
-- Gets called when a user types in /dv in chat (see server.lua)
function HCDH_deleteVehicle()
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
