
local ambulancierIsInService = false

local spawnAmbulancierVehicleChoix = {}
local KEY_E = 38
local KEY_UP = 96 -- N+
local KEY_DOWN = 97 -- N-
local KEY_CLOSE = 177
local ambulancier_nbMissionEnAttenteText = '-- Aucune Info --'
local ambulancier_BlipMecano = {}
local ambulancier_showHelp = false
local listMissionsAmbulancier = {}
local currentMissionAmbulancier = nil
local ambulance_call_accept = 0
local ambulance_nbAmbulanceInService = 0
local ambulance_nbAmbulanceDispo = 0

----
local ambulancier_blipsTemp
local ambulancier_markerBool = false
local existingVeh = nil

isAmbulancier = false

local TEXTAMBUL = {
    SpawnVehicleImpossible = '~R~ Impossible, aucune place disponible',
    InfoAmbulancierNoAppel = '~g~Aucun appel en attente',
    InfoAmbulancierNbAppel = '~w~ Appel en attente',
    NoPatientFound = '~b~ Aucun patient à proximité',
    CALL_INFO_NO_PERSONNEL = '~r~Aucun ambulancier en service',
    CALL_INFO_ALL_BUSY = '~o~Tous nos ambulancier sont occupés',
    CALL_INFO_WAIT = '~b~Votre appel est sur attente',
    CALL_INFO_OK = '~g~Un ambulancier va arriver',

    CALL_RECU = 'Confirmation\nVotre appel à été enregistré',
    CALL_ACCEPT = 'Votre appel a été accepté, un ambulancier est en route',
    CALL_CANCEL = 'L\'ambulancier vient d\'abandonner votre appel',
    CALL_FINI = 'Votre appel a été résolu',
    CALL_EN_COURS = 'Vous avez déjà une demande en cours ...',

    MISSION_NEW = 'Un nouveau patient a été signalé, il y été ajouté dans votre liste de mission',
    MISSION_ACCEPT = 'Mission acceptée, mettez vous en route',
    MISSION_ANNULE = 'Votre patient s\'est décommandé',
    MISSION_CONCURENCE = 'Vous étes plusieurs sur le coup',
    MISSION_INCONNU = 'Cette mission n\'est plus d\'actualité',
    MISSION_EN_COURS = 'Cette mission est déjà en cours de traitement'
    
}
-- restart depanneur
ambulancier_platesuffix="Ambul" --Suffix de la plaque d'imat
ambulancier_car = {
	x=1161.79223632813,  
	y=-1494.0009765625,
	z=34.0925659179688,
    h=0.0,
    OverPowered=15.0,
}
ambulancier_helico = {
	x= 1216.29809570313,  
	y=-1517.66320800781,
	z=33.9526176452637,
    h=0.0,
    OverPowered=1.0,
}

ambulancier_blips = {
	["Urgences"] = {
		id=61, 
		x=1155.26,
		y=-1520.82,
		z=34.01,
		distanceBetweenCoords=5,
		distanceMarker=5,
	},
	["Garage d\'entreprise"] = {
		id=50,
		x=1158.67456054688,  
		y=-1496.5673828125,
		z=33.7025659179688,
		distanceBetweenCoords=2,
		distanceMarker=2
	},
    ["Heliport"] = {
		id=43,
		x=1206.40002441406,  
		y=-1511.20886230469,
		z=34.0025659179688,
		distanceBetweenCoords=2,
		distanceMarker=2
	}
}

ambulancier_sortie={
	x=1151.279296875,
	y=-1529.92565917969,
	z=35.3715476989746
}


--====================================================================================
--  Gestion de prise et d'abandon de service
--====================================================================================
local function showBlipAmbulancier()
    for key, item in pairs(ambulancier_blips) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(key)
		EndTextCommandSetBlipName(item.blip)
	end
	ambulancier_blipsTemp = ambulancier_blips
end
local function removeBlipAmbulancier()
    ambulancier_markerBool = false
	for _, item in pairs(ambulancier_blips) do
			RemoveBlip(item.blip)
	end
end
local function drawHelpJobAmbulancier()
    local lines = {
        { text = '~o~Information Ambulancier', isTitle = true, isCenter = true},
        { text = '~g~Vous devez sauver les citoyens dans le coma', isCenter = true, addY = 0.04},
        { text = ' - Prenez votre service et récupérez votre véhicule dans un garage'},
        { text = ' - Lorsque qu\'un appel est lancé, prenez l\'appel et dirrigez vous pour lui sauver la vie'},
        { text = ' - Une fois sur place, analysez la situation et sauvez le si possible'},
        { text = ' - Prévenez le centre d\'appels que la mission est terminée'},
        { text = ' - Prenez ou attendez le prochain appel', addY = 0.04},
        { text = '~b~ Vos véhicules :', size = 0.4, addY = 0.04 },
        { text = '~g~L\'ambulance ~w~Rapide et maniable, permet d\'intervenir à courte et moyenne distance'},
        { text = '~g~L\'helicoptère ~w~Plus rapide pour les longue distances', addY = 0.04},
        { text = '~d~Si vous trouvez des problèmes, utilisez le forum pour nous les signaler', isCenter = true, addY = 0.06},
        { text = '~b~Merci & Bonne route', isCenter = true},
    }
    DrawRect(0.5, 0.5, 0.48, 0.5, 0,0,0, 225)
    local y = 0.31 - 0.025
    local defaultAddY = 0.025
    local addY = 0.025
    for _, line in pairs(lines) do 
        y = y + addY
        local caddY = defaultAddY
        local x = 0.275
        local defaultSize = 0.32
        local defaultFont = 8
        if line.isTitle == true then
            defaultFont = 1
            defaultSize = 0.8
            caddY = 0.06
        end
        SetTextFont(line.font or defaultFont)
        SetTextScale(0.0,line.size or defaultSize)
        SetTextCentre(line.isCenter == true)
        if line.isCenter == true then
            x = 0.5
        end
        SetTextDropShadow(0, 0, 0, 0, 0)
        SetTextEdge(0, 0, 0, 0, 0)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        AddTextComponentString(line.text)
        DrawText(x, y)
        addY = line.addY or caddY
    end
    SetTextComponentFormat("STRING")
    AddTextComponentString('~INPUT_CELLPHONE_CANCEL~ ~g~Ferme l\'aide')
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end

function Chat(t)
	TriggerEvent("chatMessage", 'AMBU', { 0, 255, 255}, "" .. tostring(t))
end

function spawnVehicule(pos, type)
    deleteVehicle()
    local vehi = GetClosestVehicle(pos.x, pos.y, pos.z, 2.0, 0, 70)
    if vehi == 0 then
        RequestModel(type)
        while not HasModelLoaded(type) do
            Wait(1)
        end
        local plate = math.random(100, 900)
        myVehiculeEntity = CreateVehicle(type, pos.x, pos.y, pos.z, pos.h , true, false)
		if type == "polmav" then
			SetVehicleLivery(myVehiculeEntity, 1)
		end


        SetVehicleNumberPlateText(myVehiculeEntity, "Ambul"..plate)
        SetVehicleEnginePowerMultiplier(myVehiculeEntity, pos.OverPowered)
        SetVehicleOnGroundProperly(myVehiculeEntity)

        local ObjectId = NetworkGetNetworkIdFromEntity(myVehiculeEntity)
        SetNetworkIdExistsOnAllMachines(ObjectId, true)
        
        local p = GetEntityCoords(myVehiculeEntity, 0)
        local h = GetEntityHeading(myVehiculeEntity)
        SetModelAsNoLongerNeeded(type)
        return
    end
    -- Citizen.Trace('impossible')
    notifIcon("CHAR_CALL911", 1, "Urgence", false, TEXTAMBUL.SpawnVehicleImpossible)
end
function invokeVehicle(data)
    if data.type == 1 then
        spawnVehicule(ambulancier_car, "ambulance")
    elseif data.type == 2 then
        spawnVehicule(ambulancier_helico, "polmav")
    elseif data.type == -1 then
        deleteVehicle()
    end
end
local function toogleServiceAmbulancier()
    ambulancierIsInService = not ambulancierIsInService
    Citizen.Trace("toogleServiceAmbulancier")
    if ambulancierIsInService then
        local hashSkin = GetHashKey("mp_m_freemode_01")
		Citizen.CreateThread(function()
		if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
			SetPedComponentVariation(GetPlayerPed(-1), 11, 13, 3, 2)
			SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)
			SetPedComponentVariation(GetPlayerPed(-1), 4, 9, 3, 2)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 92, 0, 2)
			SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2)
		else
			SetPedComponentVariation(GetPlayerPed(-1), 11, 9, 2, 2)
			SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)
			SetPedComponentVariation(GetPlayerPed(-1), 4, 3, 3, 2)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 98, 0, 2)
			SetPedComponentVariation(GetPlayerPed(-1), 6, 27, 0, 2)
		end
		end)
        TriggerServerEvent('ambulancier:takeService')
        TriggerServerEvent('ambulancier:requestMission')
        ambulancier_showHelp = true
    else
        -- Restaure Ped
        TriggerServerEvent('ambulancier:endService')
        TriggerServerEvent("skin_customization:SpawnPlayer")
    end 
end

local function gestionServiceAmbulancier()

    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), ambulancier_blips["Urgences"].x, ambulancier_blips["Urgences"].y, ambulancier_blips["Urgences"].z, true) <= ambulancier_blips["Urgences"].distanceMarker+5 then
        DrawMarker(1, ambulancier_blips["Urgences"].x, ambulancier_blips["Urgences"].y, ambulancier_blips["Urgences"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
        ClearPrints()
        SetTextEntry_2("STRING")
        if ambulancierIsInService then
            AddTextComponentString("Appuyez sur ~g~E~s~ pour quitter le ~b~service actif")
        else
            AddTextComponentString("Appuyez sur ~g~E~s~ pour rentrer en ~b~service actif")
        end
        DrawSubtitleTimed(2000, 1)
        if IsControlJustPressed(1, KEY_E) then
            toogleServiceAmbulancier()
        end
    end

    if ambulancierIsInService then
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), ambulancier_blips["Garage d\'entreprise"].x, ambulancier_blips["Garage d\'entreprise"].y, ambulancier_blips["Garage d\'entreprise"].z, true) <= ambulancier_blips["Garage d\'entreprise"].distanceMarker+5 then
            DrawMarker(1, ambulancier_blips["Garage d\'entreprise"].x, ambulancier_blips["Garage d\'entreprise"].y, ambulancier_blips["Garage d\'entreprise"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
            ClearPrints()
            SetTextEntry_2("STRING")
            AddTextComponentString("Appuyez sur ~g~E~s~ pour faire appairaitre/ranger votre ~b~vehicule")
            DrawSubtitleTimed(2000, 1)
            if IsControlJustPressed(1, KEY_E) then
                openMenuChoixVehicleAmbulancier()
            end
        end
         if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), ambulancier_blips["Heliport"].x, ambulancier_blips["Heliport"].y, ambulancier_blips["Heliport"].z, true) <= ambulancier_blips["Heliport"].distanceMarker+5 then
            DrawMarker(1, ambulancier_blips["Heliport"].x, ambulancier_blips["Heliport"].y, ambulancier_blips["Heliport"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
            ClearPrints()
            SetTextEntry_2("STRING")
            AddTextComponentString("Appuyez sur ~g~E~s~ pour faire appairaitre/ranger votre ~b~vehicule")
            DrawSubtitleTimed(2000, 1)
            if IsControlJustPressed(1, KEY_E) then
                openMenuChoixHelicoAmbulancier()
            end
        end
    end
end


--====================================================================================
-- Vehicule gestion
--====================================================================================
function notif(message)
	Citizen.CreateThread(function()
		Wait(10)
		SetNotificationTextEntry("STRING")
		AddTextComponentString(message)
		DrawNotification(false, false)
	end)
end
--restart metiers
function jobsSystemAmbulancier()

    if currentMissionAmbulancier == nil then
        return
    end
    RemoveBlip(ambulancier_blip_currentMission)
    local patientPed = GetPlayerPed(GetPlayerFromServerId(currentMissionAmbulancier.id));
     local posPatient = currentMissionAmbulancier.positionBackUp
    if patientPed ~= nil and patientPed~= 0 and patientPed ~= GetPlayerPed(-1) then
        posPatient = GetEntityCoords(patientPed)
    end
    
    ambulancier_blip_currentMission = AddBlipForCoord(posPatient.x, posPatient.y, posPatient.z)
	SetBlipAsShortRange(ambulancier_blip_currentMission, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Urgence")
	EndTextCommandSetBlipName(ambulancier_blip_currentMission)
    local mypos = GetEntityCoords(GetPlayerPed(-1))
    local dist = GetDistanceBetweenCoords(mypos,posPatient.x, posPatient.y, posPatient.z, false)
	if dist < 13.0 then
        DrawMarker(1,posPatient.x, posPatient.y, 0.0 , 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 350.0, 0, 155, 255, 64, 0, 0, 0, 0)
    end
    if dist < 3.0 then
        if tostring(currentMissionAmbulancier.type) == "Coma" then
            notif('Appuyez sur E pour réanimer le joueur')
            if (IsControlJustReleased(1, KEY_E)) then
                TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                Citizen.Wait(8000)
                ClearPedTasks(GetPlayerPed(-1));
                TriggerServerEvent('ambulancier:rescueHim', currentMissionAmbulancier.id)
                finishMissionAmbulancier()
                --break
            end
        elseif tostring(currentMissionAmbulancier.type) == "Demande" then
                finishMissionAmbulancier()
        end
    end
end

function startMissionAmbulancier(missions)
    currentMissionAmbulancier = missions
    local posPatient = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(currentMissionAmbulancier.id)))
    SetNewWaypoint(posPatient.x, posPatient.y)
    
end
function finishMissionAmbulancier()
    TriggerServerEvent('ambulancier:FinishMission', currentMissionAmbulancier.id)
    RemoveBlip(ambulancier_blip_currentMission)
    currentMissionAmbulancier = nil
end
--
function showInfoClientAmbulancier() 
    if ambulance_call_accept ~= 0 then

        local offsetX = 0.87
        local offsetY = 0.911
        DrawRect(offsetX, offsetY, 0.23, 0.035, 0, 0, 0, 215)

        SetTextFont(1)
        SetTextScale(0.0,0.5)
        SetTextCentre(true)
        SetTextDropShadow(0, 0, 0, 0, 0)
        SetTextEdge(0, 0, 0, 0, 0)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        if ambulance_call_accept == 1 then
            AddTextComponentString(TEXTAMBUL.CALL_INFO_OK)
        else 
            if ambulance_nbAmbulanceInService == 0 then
                AddTextComponentString(TEXTAMBUL.CALL_INFO_NO_PERSONNEL)
            elseif ambulance_nbAmbulanceDispo == 0 then
                AddTextComponentString(TEXTAMBUL.CALL_INFO_ALL_BUSY)
            else
                AddTextComponentString(TEXTAMBUL.CALL_INFO_WAIT)
            end
        end  
        DrawText(offsetX, offsetY - 0.015 )
    end
end

function showInfoJobsAmbulancier()
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
    AddTextComponentString('~o~Ambulancier Info')
    DrawText(offsetX, offsetY - 0.03)

    SetTextFont(1)
    SetTextScale(0.0,0.5)
    SetTextCentre(false)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")

    AddTextComponentString(ambulancier_nbMissionEnAttenteText)
    DrawText(offsetX - 0.065, offsetY -0.002)
end

function deleteVehicle()
    if myVehiculeEntity ~= nil then
        DeleteVehicle(myVehiculeEntity)
        myVehiculeEntity = nil
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        -- local mypos = GetEntityCoords(GetPlayerPed(-1))
        
        -- DrawMarker(1,mypos.x, mypos.y, 0.0 , 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 250.0, 0, 155, 255, 64, 0, 0, 0, 0)
 

        if isAmbulancier then
            gestionServiceAmbulancier()
            jobsSystemAmbulancier()
            if ambulancierIsInService then
                showInfoJobsAmbulancier()
            end
        end
        if ambulancier_showHelp == true then
            drawHelpJobAmbulancier()
            if IsControlJustPressed(0, KEY_CLOSE) then
                ambulancier_showHelp = false
            end
        end
        if ambulance_call_accept ~= 0 then
            showInfoClientAmbulancier()
        end
    end
end)

--
RegisterNetEvent('ambulancier:drawMarker')	
AddEventHandler('ambulancier:drawMarker', function (boolean)
	isAmbulancier = boolean
	ambulancierIsInService = false
    if isAmbulancier then
        showBlipAmbulancier()
    else
        removeBlipAmbulancier()
    end
end)
RegisterNetEvent('ambulancier:drawBlips')	
AddEventHandler('ambulancier:drawBlips', function ()
end)
RegisterNetEvent('ambulancier:marker')	
AddEventHandler('ambulancier:marker', function ()
end)

RegisterNetEvent('ambulancier:deleteBlips')
AddEventHandler('ambulancier:deleteBlips', function ()
    isAmbulancier = false
	TriggerServerEvent('ambulancier:endService')
    TriggerServerEvent("skin_customization:SpawnPlayer")
    removeBlipAmbulancier()
end)


--====
function acceptMissionAmbulancier(data) 
    local mission = data.mission 
    TriggerServerEvent('ambulancier:AcceptMission', mission.id)
end

function needAmbulance(type)
        local pos = GetEntityCoords(GetPlayerPed(-1))
        TriggerServerEvent('ambulancier:Call', type, {x = pos.x, y = pos.y, z = pos.z})
end

--====================================================================================
-- Serveur - Client Trigger
-- restart depanneur
--====================================================================================

function notifIcon(icon, type, sender, title, text)
	Citizen.CreateThread(function()
        Wait(1)

        
        SetNotificationTextEntry("STRING");
        if TEXTAMBUL[text] ~= nil then
            text = TEXTAMBUL[text]
        end
        AddTextComponentString(text);
        SetNotificationMessage(icon, icon, true, type, sender, title, text);
        DrawNotification(false, true);
	end)
end

RegisterNetEvent("ambulancier:PersonnelMessage")
AddEventHandler("ambulancier:PersonnelMessage",function(message)
    if ambulancierIsInService then
        notifIcon("CHAR_CALL911", 1, "Urgence Info", false, message)
    end
end)

RegisterNetEvent("ambulancier:ClientMessage")
AddEventHandler("ambulancier:ClientMessage",function(message)
    notifIcon("CHAR_CALL911", 1, "Urgence", false, message)
end)





function updateMenuMissionAmbulancier() 
    local items = {
        {['Title'] = 'Retour', ['ReturnBtn'] = true }
    }

    for _,m in pairs(listMissionsAmbulancier) do 
        -- Citizen.Trace('item mission')
        local item = {
            Title = 'Mission ' .. m.id ,
            mission = m,
            Function = acceptMissionAmbulancier
        }
        if #m.acceptBy ~= 0 then
            item.Title = item.Title .. ' (En cours)'
            item.TextColor = {39, 174, 96, 255}
        end
        table.insert(items, item)
    end
    if currentMissionAmbulancier ~= nil then
        table.insert(items, {['Title'] = 'Terminer la mission', ['Function'] = finishMissionAmbulancier})
    end

    table.insert(items, {['Title'] = 'Fermer'})

    menu = {['Title'] = 'Missions en cours',  ['SubMenu'] = {
        ['Title'] = 'Missions en cours', ['Items'] = items
    }}
    updateMenu(menu)
end


RegisterNetEvent('ambulancier:MissionAccept')
AddEventHandler('ambulancier:MissionAccept', function (mission)
    startMissionAmbulancier(mission)
end)

RegisterNetEvent('ambulancier:MissionChange')
AddEventHandler('ambulancier:MissionChange', function (missions)
    if not ambulancierIsInService then
        return
    end
    listMissionsAmbulancier = missions
    -- if currentMissionAmbulancier ~= nil then
         local nbMissionEnAttente = 0
    --     local find = false 
         for _,m in pairs(listMissionsAmbulancier) do
      --       if m.id == currentMissionAmbulancier.id then
      --           find = true
       --      end
             if #m.acceptBy == 0 then
               nbMissionEnAttente = nbMissionEnAttente + 1
             end
        end
        if nbMissionEnAttente == 0 then 
             ambulancier_nbMissionEnAttenteText = TEXTAMBUL.InfoAmbulancierNoAppel
         else
            ambulancier_nbMissionEnAttenteText = '~g~ ' .. nbMissionEnAttente .. ' ' .. TEXTAMBUL.InfoAmbulancierNbAppel
         end
    --     Citizen.Trace('ok')
    --     if not find then
    --         currentMissionAmbulancier = nil
    --         notifIcon("CHAR_CALL911", 1, "Mecano", false, TEXTAMBUL.MissionCancel)
    --         if currentBlip ~= nil then
    --             RemoveBlip(currentBlip)
    --         end
    --     end
    -- end
    updateMenuMissionAmbulancier()
end)


local function showMessageInformation(message, duree)
    duree = duree or 2000
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end

RegisterNetEvent('ambulancier:openMenu')
AddEventHandler('ambulancier:openMenu', function()
    if ambulancierIsInService then
        TriggerServerEvent('ambulancier:requestMission')
        openMenuGeneralAmbulancier()
    else
        showMessageInformation("~r~Vous devez être en service pour acceder au menu")
    end
end)

RegisterNetEvent('ambulancier:callAmbulancier')
AddEventHandler('ambulancier:callAmbulancier',function(data)
    needAmbulance(data.type)
end)

RegisterNetEvent('ambulancier:callStatus')
AddEventHandler('ambulancier:callStatus',function(status)
    ambulance_call_accept = status
end)

RegisterNetEvent('ambulancier:personnelChange')
AddEventHandler('ambulancier:personnelChange',function(nbPersonnel, nbDispo)
    --Citizen.Trace('nbPersonnel : ' .. nbPersonnel .. ' dispo' .. nbDispo)
    ambulance_nbAmbulanceInService = nbPersonnel
    ambulance_nbAmbulanceDispo = nbDispo
end)

RegisterNetEvent('ambulancier:cancelCall')
AddEventHandler('ambulancier:cancelCall',function(data)
    TriggerServerEvent('ambulancier:cancelCall')
end)


RegisterNetEvent('ambulancier:selfRespawn')
AddEventHandler('ambulancier:selfRespawn',
function()
    TriggerServerEvent('ambulancier:askSelfRespawn')
end)

function GetPlayers()
	local players = {}

	for i = 0, 31 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, i)
		end
	end

	return players
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end
RegisterNetEvent('ambulancier:HealMe')
AddEventHandler('ambulancier:HealMe',
function (idToHeal)
    if idToHeal == PlayerId() then
        SetEntityHealth(GetPlayerPed(-1), GetPedMaxHealth(GetPlayerPed(-1)))
    end
end)

RegisterNetEvent('ambulancier:Heal')
AddEventHandler('ambulancier:Heal',
function()
    Citizen.CreateThread(function()
        local closestPlayer, closestDistance = GetClosestPlayer()
        if closestDistance < 2.0 and closestDistance ~= -1 then
            TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
            Citizen.Wait(8000)
            ClearPedTasks(GetPlayerPed(-1));
            TriggerServerEvent('ambulancier:healHim',closestPlayer)
        else
            showMessageInformation(TEXTAMBUL.NoPatientFound)
        end
    end)
end)
--====================================================================================
-- ADD Blip for All Player
--====================================================================================

--Citizen.Trace("Mecano load")
TriggerServerEvent('ambulancier:requestPersonnel')