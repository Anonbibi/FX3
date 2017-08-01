local myVehiculeEntity = nil
local otherVehicle = nil
local inService = false
local alarmValue = 0
local alarmVehicle = 0
local alarmDelay = 500
local ShowLineGrueHelp = true
local VehicleModelKeyTowTruck = GetHashKey('towtruck')
local VehicleModelKeyFlatBed = GetHashKey('flatbed')
local spawnVehicleChoix = {}
local KEY_E = 38
local KEY_UP = 96 -- N+
local KEY_DOWN = 97 -- N-
local KEY_CLOSE = 177
local currentBlip = nil 
local listMissions = {}
local currentMissions = nil
local myCallMission = nil 
local mecano_nbMissionEnAttenteText = '-- Aucune Info --'
local mecano_BlipMecano = {}
local mecano_showHelp = false
local mecano_call_accept = 0
local mecano_nbMecanoInService = 0
local mecano_nbMecanoDispo = 0

isMecano = false

local TEXT = {
    PrendreService = '~INPUT_PICKUP~ Prendre son service de mécano',
    QuitterService = '~INPUT_PICKUP~ Quitter son service de mécano',
    SpawnVehicle = '~INPUT_PICKUP~ Recuprer son véhicule de ~b~service',
    SpawnVehicleImpossible = '~R~ Impossible, aucune place disponible',
    PasVehicule = "~r~Placez vous devant un véhicule",
    CapotFerme = '~o~Ouvrez le capot du véhicule pour ne pas passer pour un guignol...',
    VehiculeOK = '~g~Aucun problème',
    VehiculeReparable = '~o~Le véhicule est endommagé, mais il est réparable sur place',
    VehiculeKO = "~r~Véhicule HS, il doit être rapatrié dans un garage pour réparation",
    VehiculeReparationRapideOk = "~g~Le véhicule a subit une réparation d'apoint",
    VehiculeReparationRapideKo = "~r~Le véhicule ne peut etre réparé sur place",
    VehiculeReparationGarage = "~r~Ce type de réparation ne peut être fait ici",
    VehiculeReparationOk = '~g~Le véhicule est comme neuf',
    VehiculeDeverrouilleOk = '~g~Le véhicule est ouvert pour tous',
    VehiculeDeverrouilleKo = '~o~Quelque chose ne se passe pas comme prévu...',
    InfoGrue = '~g~E~s~ attache/Detache le véhicule\n~g~N+~s~ monter la grue\n~g~N-~s~ pour baisser la grue',
    InfoRemoqueAttach = '~g~E~s~ Attacher le véhicule',
    InfoRemoqueDettach = '~g~E~s~ Détacher le véhicule',
    InfoRemoqueNo = 'Aucun véhicule à porté',
    Blip = 'Mission en cours',
    BlipGarage = "Mécano",
    MissionCancel = 'Votre mission en cours n\'est plus d\'actualité',
    MissionClientAccept = 'Un mécano a prit votre appel',
    MissionClientCancel = 'Votre mécano vous a abandonné',
    InfoMecanoNoAppel = '~g~Aucun appel en attente',
    InfoMecanoNbAppel = '~w~ Appel en attente',
    BlipMecanoService = 'Prise de service',
    BlipMecanoVehicle = 'Prise du véhicule de service',

    CALL_INFO_NO_PERSONNEL = '~r~Aucun mécano en service',
    CALL_INFO_ALL_BUSY = '~o~Tous nos mécano sont occupés',
    CALL_INFO_WAIT = '~b~Votre appel est sur attente',
    CALL_INFO_OK = '~g~Un mécano va arriver sur les lieux de l\'appel',

    CALL_RECU = 'Confirmation\nVotre appel a été enregistré',
    CALL_ACCEPT = 'Votre appel a été accepté, un mécano est en route',
    CALL_CANCEL = 'Le mécano vient d\'abandonner votre appel',
    CALL_FINI = 'Votre appel a été résolu',
    CALL_EN_COURS = 'Vous avez déjà une demande en cours ...',

    MISSION_NEW = 'Un nouvel accident a été signalé, il a été ajouté dans votre liste de mission',
    MISSION_ACCEPT = 'Mission acceptée, mettez vous en route',
    MISSION_ANNULE = 'Votre client s\'est décommandé',
    MISSION_CONCURENCE = 'Vous étes plusieurs sur le coup',
    MISSION_INCONNU = 'Cette mission n\'est plus d\'actualité',
    MISSION_EN_COURS = 'Cette mission est déjà en cours de traitement'
    
}
-- restart depanneur
local coords = {
    {
        ['PriseDeService'] = {x = -225.249, y = -1320.48, z = 30.29},
        ['ArenaRepair'] = {x = -205.535,  y = -1315.11,  z = 30.29, r = 50.0},
        ['SpawnVehicleAction'] = { x = -196.6, y = -1294.82, z = 30.796},
        ['SpawnVehicle'] = {
            {x = -184.061, y = -1290.59, z = 30.796, h = 311.7820, type = VehicleModelKeyTowTruck},
            {x = -184.061, y = -1290.59, z = 30.796, h = 311.7820, type = VehicleModelKeyTowTruck},
            {x = -184.061, y = -1290.59, z = 30.796, h = 311.7820, type = VehicleModelKeyFlatBed},
        },
    },
    {
        ['PriseDeService'] = {x = 2004.3656, y = 3790.5842, z = 32.1809},
        ['ArenaRepair'] = {x = 2006.354,  y = 3798.739,  z = 32.1808, r = 15.0},
        ['SpawnVehicleAction'] = { x = 1997.1357, y = 3779.9375, z = 32.1809},
        ['SpawnVehicle'] = {
            {x = 1983.1662, y = 3784.6511, z = 32.1463, h = 29.7412, type = VehicleModelKeyTowTruck},
            {x = 1979.5776, y = 3782.8300, z = 32.1465, h = 29.2248, type = VehicleModelKeyTowTruck},
            {x = 1977.0086, y = 3780.3515, z = 32.2697, h = 29.2043, type = VehicleModelKeyFlatBed},
        },
    },
    {
        ['PriseDeService'] = {x = 99.1272, y = 6620.6496, z = 32.4359},
        ['ArenaRepair'] = {x = 130.16,  y = 6609.85,  z = 31.84, r = 25.0},
        ['SpawnVehicleAction'] = { x = 108.0850, y = 6614.4726, z = 31.9555},
        ['SpawnVehicle'] = {
            {x = 109.5908, y = 6607.0776, z = 31.8156, h = 316.8023, type = VehicleModelKeyTowTruck},
            {x = 112.7592, y = 6603.8974, z = 31.8990, h = 314.7157, type = VehicleModelKeyTowTruck},
            {x = 119.9472, y = 6599.2880, z = 32.06, h = 270.60, type = VehicleModelKeyFlatBed},
        },
    },
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

local function SetTimeout(delay, func)
    Citizen.CreateThread(function()
        Citizen.Wait(delay)
        func()
    end)
end

local function setVehicleDoor(vehicle, open)
    open = open or 1
    if open == 1 then 
        SetVehicleDoorOpen(vehicle, 4, 0, 0)
        SetVehicleDoorOpen(vehicle, 0, 0, 0)
        SetVehicleDoorOpen(vehicle, 1, 0, 0)
        SetVehicleDoorOpen(vehicle, 2, 0, 0)
        SetVehicleDoorOpen(vehicle, 3, 0, 0)
        SetVehicleDoorOpen(vehicle, 5, 0, 0)
        SetVehicleDoorOpen(vehicle, 6, 0, 0)
        SetVehicleDoorOpen(vehicle, 7, 0, 0)
    else
        SetVehicleDoorShut(vehicle, 0, 0)
        SetVehicleDoorShut(vehicle, 1, 0)
        SetVehicleDoorShut(vehicle, 2, 0)
        SetVehicleDoorShut(vehicle, 3, 0)
        SetVehicleDoorShut(vehicle, 4, 0)
        SetVehicleDoorShut(vehicle, 5, 0)
        SetVehicleDoorShut(vehicle, 6, 0)
        SetVehicleDoorShut(vehicle, 7, 0)
    end
end

local function alarmState()
    if alarmVehicle ~= 0 and alarmValue ~= 0 then
        alarmValue = alarmValue - 1
        local state = alarmValue % 2
        setVehicleDoor(alarmVehicle, state)
        SetVehicleLights(vehicle, 1 + state)
        -- Citizen.Trace('... ' .. state)
        if alarmValue == 0 then 
            alarmVehicle = 0
            StartVehicleAlarm(alarmVehicle)
            SetVehicleSiren(vehicle, 0)
        else
            SetTimeout(alarmDelay, alarmState)
        end
    end
end

local function startAlarm(vehicle)
    if alarmVehicle == 0 then
        alarmVehicle = vehicle
        alarmValue = 20
        SetVehicleAlarm(alarmVehicle, 1)
        StartVehicleAlarm(alarmVehicle)
        StartVehicleHorn(alarmVehicle, 5000, 0 , 0)
        SetVehicleSiren(vehicle, 1)
        SetTimeout(alarmDelay, function()
            alarmState()
        end)
    end
end

local function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

local function GetVehicleLookByPlayer(ped, dist)
    local playerPos =GetOffsetFromEntityInWorldCoords( ped, 0.0, 0.0, 0.0 )
    local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, dist, -0.8 )
    return GetVehicleInDirection( playerPos, inFrontOfPlayer )
end

--====================================================================================
--  Gestion de prise et d'abandon de service
--====================================================================================
local function showBlipMecano()
    for _ , c in pairs(coords) do
        local currentBlip = AddBlipForCoord(c.PriseDeService.x, c.PriseDeService.y, c.PriseDeService.z)
        SetBlipSprite(currentBlip, 17)
        SetBlipColour(currentBlip, 25)
        SetBlipAsShortRange(currentBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(TEXT.BlipMecanoService)
        EndTextCommandSetBlipName(currentBlip)
        SetBlipAsMissionCreatorBlip(currentBlip, true)
        table.insert(mecano_BlipMecano, currentBlip)

        local currentBlip2 = AddBlipForCoord(c.SpawnVehicleAction.x, c.SpawnVehicleAction.y, c.SpawnVehicleAction.z)
        SetBlipSprite(currentBlip2, 18)
        SetBlipColour(currentBlip2, 64)
        SetBlipAsShortRange(currentBlip2, true)
        --SetBlipFlashes(currentBlip,1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(TEXT.BlipMecanoVehicle)
        EndTextCommandSetBlipName(currentBlip2)
        SetBlipAsMissionCreatorBlip(currentBlip2, true)
        table.insert(mecano_BlipMecano, currentBlip2)
    end
end
local function removeBlipMecano()
    for _ , c in pairs(mecano_BlipMecano) do
        RemoveBlip(c)
    end
    mecano_BlipMecano = {}
end
local function drawHelpJobM()
    local lines = {
        { text = '~o~Information Mécano', isTitle = true, isCenter = true},
        { text = '~g~Vous devez aider les citoyens à résoudre leurs problèmes de véhicules', isCenter = true, addY = 0.04},
        { text = ' - Prenez votre service et récupérez votre véhicule dans un garage'},
        { text = ' - Lorsque qu\'un appel est lancé, prenez l\'appel et dirrigez vers le client'},
        { text = ' - Une fois sur place, analysez la situation et faite une réparation sur place si possible'},
        { text = ' - Si cela est impossible, transportez le véhicule jusqu\'au garage le plus proche, pour une'},
        { text = '    réparation complète'},
        { text = ' - Facturez le client et rendez lui ses clefs'},
        { text = ' - Prévenez le centre d\'appels que la mission est terminée'},
        { text = ' - Prenez ou attendez le prochain appel', addY = 0.04},
        { text = '~b~ Vos compétences :', size = 0.4, addY = 0.04 },
        { text = '~g~Réparation rapide: ~w~Remet le moteur en marche, mais les dégâts de carrosserie sont'},
        { text = '    toujours présents'},
        
        { text = '~g~Réparation complète: ~w~Seulement réalisable en garage, remet à neuf un véhicule'},
        { text = '~g~Déverrouiller le véhicule: ~w~Débloque les portes du véhicule'},
        { text = '~b~ Vos véhicules :', size = 0.4, addY = 0.04 },
        { text = '~g~Le towtrunk ~w~Rapide et maniable, permet de transporter les voitures grâce à une grue'},
        { text = '~g~Le flatbed ~w~Plus impossant, il permet de transporter tous types de véhicules', addY = 0.04},
        { text = '~b~ Astuces :', size = 0.4, addY = 0.04 },
        { text = '~g~Afficher / Cacher aide : ~w~Affiche ou cache la ligne d\'aide derrière votre véhicule qui signale'},
        { text = '   le bon placement du véhicule à charger', addY = 0.04},
        { text = '~c~Si vous ne pouvez pas charger le véhicule sur le flatbed ou que le cable saute pour le'},
        { text = '~c~towtrunk, déverrouillez le véhicule'},
        { text = '~c~Si le cable s\'attache de l\'autre coté du véhicule, détachez et réattachez le', addY = 0.06},
        { text = '~d~Si vous trouvez des problèmes, utilisez le forum pour nous les signaler', isCenter = true, addY = 0.06},
        { text = '~b~Merci & Bonne route', isCenter = true},
    }
    DrawRect(0.5, 0.5, 0.48, 0.9, 0,0,0, 225)
    local y = 0.06 - 0.025
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
    --SetTextComponentFormat("STRING")
    --AddTextComponentString('~INPUT_CELLPHONE_CANCEL~ ~g~Ferme l\'aide')
    --DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end

function spawnDepanneuse(coords, type)
    deleteVehicle()
    for _, pos in pairs(coords) do 
        if pos.type == type then
            local vehi = GetClosestVehicle(pos.x, pos.y, pos.z, 2.0, 0, 70)
            -- Citizen.Trace('vehi : ' .. vehi)
            if vehi == 0 then
                RequestModel(type)
                while not HasModelLoaded(type) do
                    Wait(1)
                end
                myVehiculeEntity = CreateVehicle(type, pos.x, pos.y, pos.z, pos.h , true, false)
                SetVehicleNumberPlateText(myVehiculeEntity, "Depa001")
                local ObjectId = NetworkGetNetworkIdFromEntity(myVehiculeEntity)
                SetNetworkIdExistsOnAllMachines(ObjectId, true)
                
                local p = GetEntityCoords(myVehiculeEntity, 0)
                local h = GetEntityHeading(myVehiculeEntity)
                --showMessageInformation('Pos: ' .. p.x .. ' ' .. p.y .. ' ' .. p.z .. ' ' .. h)
                return
            end
        end
    end
    -- Citizen.Trace('impossible')
    notifIcon("CHAR_BLANK_ENTRY", 1, "Mecano", false, TEXT.SpawnVehicleImpossible)
    -- local myPed = GetPlayerPed(-1)
    -- local player = PlayerId()
    -- RequestModel(VehicleModelKeyTowTruck)
    -- while not HasModelLoaded(VehicleModelKeyTowTruck) do
    --     Wait(1)
    -- end
    
    -- local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
    -- myVehiculeEntity = CreateVehicle(VehicleModelKeyTowTruck, coords.x, coords.y, coords.z, 0 , true, false)
    -- DecorSetInt(myVehiculeEntity, 'VehicleDepa', 1)
    -- SetVehicleNumberPlateText(myVehiculeEntity, "Depa001")
    -- local ObjectId = NetworkGetNetworkIdFromEntity(myVehiculeEntity)
	-- SetNetworkIdExistsOnAllMachines(ObjectId, true)
end
function invokeVehicle(data)
    if data.type == 1 then
        spawnDepanneuse(spawnVehicleChoix, VehicleModelKeyTowTruck)
    elseif data.type == 2 then
        spawnDepanneuse(spawnVehicleChoix, VehicleModelKeyFlatBed)
    end
end
local function toogleService()
    inService = not inService
    if inService then
        local myPed = GetPlayerPed(-1)
        GiveWeaponToPed(myPed, 'WEAPON_HAMMER', 0, 0, 0)
        GiveWeaponToPed(myPed, 'WEAPON_CROWBAR', 0, 0, 0)
        GiveWeaponToPed(myPed, 'WEAPON_FLASHLIGHT', 0, 0, 0)
        GiveWeaponToPed(myPed, 'WEAPON_PETROLCAN', 1000, 0, 0)
        GiveWeaponToPed(myPed, 'WEAPON_FIREEXTINGUISHER', 1000, 0, 0)
        -- A Configurer
		local hashSkin = GetHashKey("mp_m_freemode_01")
		Citizen.CreateThread(function()
		if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
			SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2) -- TORSO
			SetPedComponentVariation(GetPlayerPed(-1), 11, 43, 0, 2) -- TORSO2
			SetPedComponentVariation(GetPlayerPed(-1), 4, 41, 0, 2) -- LEGS
			SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2) -- FEET
			SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) -- ACCESSORIE
		else
			SetPedComponentVariation(GetPlayerPed(-1), 3, 25, 0, 2) -- TORSO
			SetPedComponentVariation(GetPlayerPed(-1), 11, 1, 0, 2) -- TORSO2
			SetPedComponentVariation(GetPlayerPed(-1), 4, 4, 8, 2) -- LEGS
			SetPedComponentVariation(GetPlayerPed(-1), 6, 4, 0, 2) -- FEET
			SetPedComponentVariation(GetPlayerPed(-1), 8, 20, 1, 2) -- ACCESSORIE
		end
		end)
        TriggerServerEvent('mecano:takeService')
        TriggerServerEvent('mecano:requestMission')
        mecano_showHelp = true
    else
        -- Restaure Ped
        TriggerServerEvent('mecano:endService')
        TriggerServerEvent("skin_customization:SpawnPlayer")
    end 
end

local function gestionService()
    local myPed = GetPlayerPed(-1)
    local myPos = GetEntityCoords(myPed)
    for _, coordData in pairs(coords) do 
        local pos = coordData.PriseDeService
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, myPos.x, myPos.y, myPos.z, false)
        if dist <= 20 then
            DrawMarker(1, pos.x, pos.y, pos.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0, 0, 255, 200, 0, 0, 0, 0)
        end
        if dist <= 1 then 
            if inService then
                --showMessageInformation(TEXT.QuitterService, 60)
                SetTextComponentFormat("STRING")
                AddTextComponentString(TEXT.QuitterService)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            else
                SetTextComponentFormat("STRING")
                AddTextComponentString(TEXT.PrendreService)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                --showMessageInformation(TEXT.PrendreService, 60)
            end
            if IsControlJustPressed(0, KEY_E) then
                toogleService()
            end
        end

        if inService then 
            local pos = coordData.SpawnVehicleAction
            local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, myPos.x, myPos.y, myPos.z, false)
            if dist <= 20 then
                DrawMarker(1, pos.x, pos.y, pos.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0, 128, 0, 200, 0, 0, 0, 0)
            end
            if dist <= 1 then 
                -- showMessageInformation(TEXT.SpawnVehicle, 60)
                SetTextComponentFormat("STRING")
                AddTextComponentString(TEXT.SpawnVehicle)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                if IsControlJustPressed(0, KEY_E) then
                    spawnVehicleChoix = coordData.SpawnVehicle
                    openMenuChoixVehicle()
                end

            end

            local posArenaRepair = coordData.ArenaRepair
            local dist2 = GetDistanceBetweenCoords(posArenaRepair.x, posArenaRepair.y, posArenaRepair.z, myPos.x, myPos.y, myPos.z, false)
            if dist2 <= 60 then
                DrawMarker(1, posArenaRepair.x, posArenaRepair.y, posArenaRepair.z - 1.0, 0, 0, 0, 0, 0, 0, posArenaRepair.r, posArenaRepair.r, 1.0, 128, 0, 255, 128, 0, 0, 0, 0)
            end

        end
    end
end

--====================================================================================
-- Dommage Véhicule  restart depanneur
--====================================================================================

local function CustomVehicleDommage()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(myPed, 0)
    if vehicle ~= 0 then 
        local engineHealth = GetVehicleEngineHealth(vehicle)
        local vehicleHealth = GetEntityHealth(vehicle)
        local petrolTankeHealth = GetVehiclePetrolTankHealth(vehicle)
        local vehicleHealth2 = GetVehicleBodyHealth_2(vehicle)

        -- local t2 = (2100 - engineHealth - petrolTankeHealth - vehicleHealth2)
        -- ClearPrints()
        -- SetTextEntry_2("STRING")
        -- AddTextComponentString('~r~' .. math.floor(engineHealth) .. ' ~g~ ' .. vehicleHealth .. ' ~b~ ' .. math.floor(petrolTankeHealth) .. '\n~y~' .. vehicleHealth2 .. '\n~o~' .. t2)
        -- DrawSubtitleTimed(200, 1)

        if engineHealth <= 100 then
            SetVehicleEngineTorqueMultiplier(vehicle,0.25)
        end
        if vehicleHealth <= 0 or 
           (engineHealth <= 900 and engineHealth > 101) or 
           petrolTankeHealth <= 900  or
           vehicleHealth - 2000 + engineHealth + petrolTankeHealth <= 0 then   
            SetVehicleEngineHealth(vehicle, -1.0)
            SetVehicleBodyHealth(0.0)
            SetVehicleUndriveable(vehicle, true)
        elseif (2100 - engineHealth - petrolTankeHealth - vehicleHealth2) >= 65 and engineHealth > 100 then
            SetVehicleDoorOpen(vehicle, 4, 0, 0)
            SetVehicleBodyHealth(vehicle, vehicleHealth + 2000 - engineHealth - petrolTankeHealth)
            SetVehicleEngineHealth(vehicle, 100.0)
        end
       
        -- local total = engineHealth + vehicleHealth + petrolTankeHealth
        -- if engineHealth >= 998 and petrolTankeHealth >= 998 then
        --     SetEntityHealth(vehicle, 1000)
        --     vehicleHealth = 1000
        -- end
        -- local bodyHealth = vehicleHealth
        
        -- local t = (2000-engineHealth-petrolTankeHealth) + ((1000-vehicleHealth)/25)
        -- local t = GetVehicleDeformationAtPos(vehicle,1.21, 6.15, 0.3)
        -- t = (t.x * t.x + t.y * t.y + t.z * t.z) * 1000
        -- local t = GetVehicleBodyHealth_2(vehicle)
        -- if total <= 2850 then
        --     SetVehicleDoorOpen(vehicle, 4, 0, 0)
        -- end
        -- if total < 2800 and engineHealth >= 1 then
        --     if vehicleHealth + petrolTankeHealth < 1800 or vehicleHealth < 750 then
        --         SetVehicleEngineHealth(vehicle, -1.0)
        --         SetVehicleEngineOn(vehicle, 0, 0, 0)
        --         SetVehicleBodyHealth(vehicle, vehicleHealth * 0.1 )
        --         SetVehicleUndriveable(vehicle, true)
        --     else
        --         SetVehicleEngineHealth(vehicle, 0.0)
        --         SetVehicleEngineOn(vehicle, 0, 0, 0)
        --         SetVehicleUndriveable(vehicle, true)
        --     end
        -- end
        --[[ Debug Show Dommage 
        local t = math.floor(GetVehicleBodyHealth_2(vehicle))
        local t2 = 2100 - engineHealth - petrolTankeHealth - t
        ClearPrints()
        SetTextEntry_2("STRING")
        AddTextComponentString('~r~' .. math.floor(engineHealth) .. ' ~g~ ' .. vehicleHealth .. ' ~b~ ' .. math.floor(petrolTankeHealth) .. '\n~y~' .. t .. '\n~o~' .. t2)
        DrawSubtitleTimed(200, 1)
        --]]
    end
end

--====================================================================================
-- UserAction restart depanneur
--====================================================================================

function getStatusVehicle()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    local p = GetEntityCoords(vehicle, 0)
    local h = GetEntityHeading(vehicle)
    -- Citizen.Trace('Pos: ' .. p.x .. ' ' .. p.y .. ' ' .. p.z .. ' ' .. h)
    if vehicle ~= 0 then 
        -- local capotOpen = GetVehicleDoorAngleRatio(vehicle, 4) > 0.5
        -- if not capotOpen then 
        --     showMessageInformation(TEXT.CapotFerme)
        -- else
            local scenario = 'PROP_HUMAN_BUM_SHOPPING_CART'
            local pos = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 0.2, 0.0)
        
            --TaskStartScenarioAtPosition(myPed, scenario, pos.x, pos.y, pos.z, 0.0, 8000, 1, 0)
            TaskStartScenarioInPlace(myPed, scenario, 8000, 1)
            Citizen.Wait(8000)
            ClearPedTasks(myPed)
            local vehicleHealth = GetVehicleEngineHealth(vehicle)
            if vehicleHealth > 900 then
                showMessageInformation(TEXT.VehiculeOK,8000)
            elseif vehicleHealth >= 150 then
                showMessageInformation(TEXT.VehiculeReparable,8000)
            else
                showMessageInformation(TEXT.VehiculeKO,8000)
            end
        -- end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end

function repareVehicle()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    if vehicle ~= 0 then 
        -- local capotOpen = GetVehicleDoorAngleRatio(vehicle, 4) > 0.5
        -- if not capotOpen then 
        --     showMessageInformation(TEXT.CapotFerme)
        -- else
            local scenario = 'WORLD_HUMAN_VEHICLE_MECHANIC'
            local pos = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 0.02, 0.0)
            local h = GetEntityHeading(myPed)
            TaskStartScenarioAtPosition(myPed, scenario, pos.x, pos.y, pos.z, h + 180 , 8000, 1, 0)
            --TaskStartScenarioAtPosition(myPed, scenario,8000,1)
            Citizen.Wait(8000)
            ClearPedTasks(myPed)
            local vehicleHealth = GetEntityHealth(vehicle)
            if vehicleHealth >= 0 then
                SetVehicleEngineHealth(vehicle, 960.0)
                SetVehicleEngineOn(vehicle, 0, 0, 0)
                SetVehicleUndriveable(vehicle, false)
                SetVehicleEngineTorqueMultiplier(vehicle, 1.0)
                showMessageInformation(TEXT.VehiculeReparationRapideOk)
            else
                showMessageInformation(TEXT.VehiculeReparationRapideKo)
            end
        -- end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end

function fullRepareVehcile()
    local myPed = GetPlayerPed(-1)
    local myPos = GetEntityCoords(myPed)
    local inArena = false
    for _, coordData in pairs(coords) do
        local pos = coordData.ArenaRepair
        -- Citizen.Trace('pos ' .. pos.x .. ' ' .. pos.y .. ' ' .. pos.z .. '    ' .. GetDistanceBetweenCoords(pos.x, pos.y, pos.y, myPos.x, myPos.y, myPos.z, false))
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.y, myPos.x, myPos.y, myPos.z, false) <= coordData.ArenaRepair.r then
            inArena = true
            break
        end
    end
    if not inArena then
         showMessageInformation(TEXT.VehiculeReparationGarage)
        return
    end
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    if vehicle ~= 0 then 
        local scenario = 'WORLD_HUMAN_VEHICLE_MECHANIC'
        local pos = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 0.02, 0.0)
        local h = GetEntityHeading(myPed)
        TaskStartScenarioAtPosition(myPed, scenario, pos.x, pos.y, pos.z, h + 180 , 8000, 1, 0)
        local value = GetVehicleBodyHealth(vehicle)
        
        while( value < 999.9 ) do
            value = GetVehicleBodyHealth(vehicle)
            SetVehicleBodyHealth(vehicle, value + 1.0)
            showMessageInformation('Réparation en cours ~b~' .. math.floor(value) .. '/1000')
            Citizen.Wait(125)     
        end
        Citizen.Wait(250)
        ClearPedTasks(myPed)
        SetVehicleBodyHealth(vehicle, 1000.0)
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetEntityHealth(vehicle,1000)
        SetVehiclePetrolTankHealth(vehicle,1000.0)
        SetVehicleEngineOn(vehicle, 0, 0, 0)
        SetVehicleBodyHealth(vehicle, 1000.0)
        SetVehicleFixed(vehicle)
        SetVehicleEngineTorqueMultiplier(vehicle,1.0)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        showMessageInformation(TEXT.VehiculeReparationOk)
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end
-- restart depanneur
function openVehicleDoorData(data)
    local myPed = GetPlayerPed(-1)
    local myCoord = GetEntityCoords(myPed)
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    if vehicle ~= 0 then
        local porte = data.Porte or -1 
        if porte == -1 then 
            SetVehicleDoorOpen(vehicle, 0, 0, 0)
            SetVehicleDoorOpen(vehicle, 1, 0, 0)
            SetVehicleDoorOpen(vehicle, 2, 0, 0)
            SetVehicleDoorOpen(vehicle, 3, 0, 0)
            SetVehicleDoorOpen(vehicle, 4, 0, 0)
            SetVehicleDoorOpen(vehicle, 5, 0, 0)
            SetVehicleDoorOpen(vehicle, 6, 0, 0)
            SetVehicleDoorOpen(vehicle, 7, 0, 0)
        else
            SetVehicleDoorOpen(vehicle, porte, 0, 0)
        end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end

function closeVehicleDoorData(data)
    local myPed = GetPlayerPed(-1)
    local myCoord = GetEntityCoords(myPed)
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    if vehicle ~= 0 then
        local porte = data.Porte or -1 
        if porte == -1 then 
            SetVehicleDoorShut(vehicle, 0, 0)
            SetVehicleDoorShut(vehicle, 1, 0)
            SetVehicleDoorShut(vehicle, 2, 0)
            SetVehicleDoorShut(vehicle, 3, 0)
            SetVehicleDoorShut(vehicle, 4, 0)
            SetVehicleDoorShut(vehicle, 5, 0)
            SetVehicleDoorShut(vehicle, 6, 0)
            SetVehicleDoorShut(vehicle, 7, 0)
        else
            SetVehicleDoorShut(vehicle, porte, 0, 0)
        end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end

function unlockVehiculeForAll()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    if vehicle ~= 0 then 
        if math.random() > -0.25 then
            TaskWarpPedIntoVehicle(myPed, vehicle, -1)
            SetVehicleDoorsLocked(vehicle, 1)
            showMessageInformation(TEXT.VehiculeDeverrouilleOk)
        else   
            startAlarm(vehicle)
            showMessageInformation(TEXT.VehiculeDeverrouilleKo) 
        end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end

--====================================================================================
-- Vehicule gestion
--====================================================================================

--restart metiers
function jobsSystem()
    if inService == false then
        return 
    end
    
    local myPed = GetPlayerPed(-1)
    local myCoord = GetEntityCoords(myPed)
    local currentVehicle = GetVehiclePedIsIn(myPed, 0)

    if currentVehicle == 0 then -- a pied
        local towtruck = GetClosestVehicle(myCoord.x, myCoord.y, myCoord.z, 10.0, VehicleModelKeyTowTruck, 70)
        if towtruck ~= 0 then
            local coords = GetOffsetFromEntityInWorldCoords(towtruck, -1.5, -3.2, 0)
            local dist = GetDistanceBetweenCoords(myCoord.x, myCoord.y, myCoord.z, coords.x, coords.y, coords.z, true)
            if dist < 10 then
                DrawMarker(1, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)
            end
            if dist < 1.5 then 
                -- showMessageInformation(TEXT.InfoGrue)
                SetTextComponentFormat("STRING")
                AddTextComponentString(TEXT.InfoGrue)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                local c1 = GetOffsetFromEntityInWorldCoords(towtruck, 0.0, -4.3, 1.8)
                local c2 = GetOffsetFromEntityInWorldCoords(towtruck, 0.0, -4.3, -1.2)
                local vehicleAttach = GetEntityAttachedToTowTruck(towtruck)
                local vehicleGrap = GetVehicleInDirection(c1,c2)
                if ShowLineGrueHelp == true then 
                    if vehicleAttach ~= 0 then 
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 255, 0, 255)
                    elseif vehicleGrap ~= 0 then
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 0, 255, 255)
                    else
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 255, 0, 0, 255)
                    end
                end
                if IsControlJustPressed(1, KEY_UP) then
                    -- Citizen.Trace('up')
                    Citizen.InvokeNative(0xFE54B92A344583CA, towtruck, 1.0)
                elseif IsControlJustPressed(1, KEY_DOWN) then
                    -- Citizen.Trace('down')
                    Citizen.InvokeNative(0xFE54B92A344583CA, towtruck, 0.0)
                elseif IsControlJustPressed(1, KEY_E) then
                    -- Citizen.Trace('attack')
                    if vehicleAttach ~= 0 then
                        DetachVehicleFromTowTruck(towtruck, vehicleAttach)
                    elseif vehicleGrap ~= 0 then
                        AttachVehicleToTowTruck(towtruck, vehicleGrap, true, 0.0,0.0,0.0)
                    end
                end
            end
 
        else
            local flatbed= GetClosestVehicle(myCoord.x, myCoord.y, myCoord.z, 10.0, VehicleModelKeyFlatBed, 70)
            if flatbed ~= 0 then
                local coords = GetOffsetFromEntityInWorldCoords(flatbed, -1.5, -5.2, 0)
                local dist = GetDistanceBetweenCoords(myCoord.x, myCoord.y, myCoord.z, coords.x, coords.y, coords.z, true)
                if dist < 10 then
                    DrawMarker(1, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)
                end
                if dist < 1.5 then 

                    -- local c1 = GetOffsetFromEntityInWorldCoords(flatbed, -1.0, -1.4, 1.2)
                    -- local c2 = GetOffsetFromEntityInWorldCoords(flatbed, 1.0, -1.4, 1.2)

                    local c1 = GetOffsetFromEntityInWorldCoords(flatbed, -2.0, -1.2, 1.2)
                    local c2 = GetOffsetFromEntityInWorldCoords(flatbed, 2.0, -1.2, 1.2)
                    -- DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 255, 0, 255)
                    local cvg = GetVehicleInDirection(c1,c2)
                    --local cvg = GetEntityAttachedTo(flatbed)
                    -- restart depanneur
                    if cvg ~= 0 and GetEntityAttachedTo(cvg) == flatbed then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(TEXT.InfoRemoqueDettach)
                        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                        if IsControlJustPressed(1, KEY_E) then
                            DetachEntity(cvg, true,true)
                            local c = GetOffsetFromEntityInWorldCoords(flatbed, 0.0, -10.0, 0)
                            SetEntityCoords(cvg,c.x, c.y, c.z)
                            SetVehicleOnGroundProperly(cvg)
                        end
                    else
                        local c1 = GetOffsetFromEntityInWorldCoords(flatbed, 0.0, -7.3, 1.8)
                        local c2 = GetOffsetFromEntityInWorldCoords(flatbed, 0.0, -7.3, -1.2)
                        local vehicleGrap = GetVehicleInDirection(c1,c2)
                        if ShowLineGrueHelp == true then 
                            if vehicleGrap ~= 0 then 
                                DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 255, 0, 255)
                            else
                                DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 255, 0, 0, 255)
                            end
                        end
                        
                        if vehicleGrap ~= 0 then 
                            SetTextComponentFormat("STRING")
                            AddTextComponentString(TEXT.InfoRemoqueAttach)
                            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                            if IsControlJustPressed(1, KEY_E) then
                                Citizen.InvokeNative(0x870DDFD5A4A796E4,vehicleGrap)
                                AttachEntityToEntity(vehicleGrap, flatbed, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, true, false, 20, true)
                            end
                        else 
                            SetTextComponentFormat("STRING")
                            AddTextComponentString(TEXT.InfoRemoqueNo)
                            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                            if IsControlJustPressed(1, KEY_E) then
                                DetachEntity(flatbed, true,true)
                            end
                        end
                    end
                end
            end
        end
    else
        if ShowLineGrueHelp == true then 
            local inTowtruck = IsVehicleModel(currentVehicle, VehicleModelKeyTowTruck)
            if inTowtruck then
                local c1 = GetOffsetFromEntityInWorldCoords(currentVehicle, 0.0, -4.3, 1.8)
                local c2 = GetOffsetFromEntityInWorldCoords(currentVehicle, 0.0, -4.3, -0.8)
                local vehicle = GetVehicleInDirection(c1,c2)
                if vehicle ~= 0 then
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 0, 255, 255)
                else
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 255, 0, 0, 255)
                end
            else 
                local inFlatBed = IsVehicleModel(currentVehicle, VehicleModelKeyFlatBed)
                if inFlatBed then
                    local c1 = GetOffsetFromEntityInWorldCoords(currentVehicle, 0.0, -7.3, 1.8)
                    local c2 = GetOffsetFromEntityInWorldCoords(currentVehicle, 0.0, -7.3, -1.2)
                    local vehicleGrap = GetVehicleInDirection(c1,c2)
                    if vehicleGrap ~= 0 then 
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 255, 0, 255)
                    else
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 255, 0, 0, 255)
                    end
                end
            end
        end
    end
end
function showInfoClient() 
    if mecano_call_accept ~= 0 then

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
        if mecano_call_accept == 1 then
            AddTextComponentString(TEXT.CALL_INFO_OK)
        else 
            if mecano_nbMecanoInService == 0 then
                AddTextComponentString(TEXT.CALL_INFO_NO_PERSONNEL)
            elseif mecano_nbMecanoDispo == 0 then
                AddTextComponentString(TEXT.CALL_INFO_ALL_BUSY)
            else
                AddTextComponentString(TEXT.CALL_INFO_WAIT)
            end
        end  
        DrawText(offsetX, offsetY - 0.015 )
    end
end

function showInfoJobs()
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
    AddTextComponentString('~o~Mecano Info')
    DrawText(offsetX, offsetY - 0.03)

    SetTextFont(1)
    SetTextScale(0.0,0.5)
    SetTextCentre(false)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")

    AddTextComponentString(mecano_nbMissionEnAttenteText)
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
       --CustomVehicleDommage()
        if isMecano then
            gestionService()
            jobsSystem()
            if inService then
                showInfoJobs()
            end
        end
        if mecano_showHelp == true then
            drawHelpJobM()
            if IsControlJustPressed(0, KEY_CLOSE) then
                mecano_showHelp = false
            end
        end
        if mecano_call_accept ~= 0 then
            showInfoClient()
        end
    end
end)

--

RegisterNetEvent('meca:ismecaok')   
AddEventHandler('meca:ismecaok', function ()
    isMecano = true
end)

RegisterNetEvent('mecano:drawMarker')	
AddEventHandler('mecano:drawMarker', function (boolean)
	isMecano = boolean
    if isMecano then
        showBlipMecano()
    else
        removeBlipMecano()
    end
end)
RegisterNetEvent('mecano:drawBlips')	
AddEventHandler('mecano:drawBlips', function ()
end)
RegisterNetEvent('mecano:marker')	
AddEventHandler('mecano:marker', function ()
end)

RegisterNetEvent('mecano:deleteBlips')
AddEventHandler('mecano:deleteBlips', function ()
    isMecano = false
    removeBlipMecano()
end)

--====================================================================================
-- Serveur - Client Trigger
-- restart depanneur
--====================================================================================

function notifIcon(icon, type, sender, title, text)
	Citizen.CreateThread(function()
        Wait(1)
        SetNotificationTextEntry("STRING");
        if TEXT[text] ~= nil then
            text = TEXT[text]
        end
        AddTextComponentString(text);
        SetNotificationMessage(icon, icon, true, type, sender, title, text);
        DrawNotification(false, true);
	end)
end

RegisterNetEvent("mecano:PersonnelMessage")
AddEventHandler("mecano:PersonnelMessage",function(message)
    if inService then
        notifIcon("CHAR_BLANK_ENTRY", 1, "Mecano Info", false, message)
    end
end)

RegisterNetEvent("mecano:ClientMessage")
AddEventHandler("mecano:ClientMessage",function(message)
    notifIcon("CHAR_BLANK_ENTRY", 1, "Mecano", false, message)
end)


--=== restart depanneur
function acceptMission(data) 
    local mission = data.mission 

    -- currentMissions = mission
    TriggerServerEvent('mecano:AcceptMission', mission.id)
    -- SetNewWaypoint(mission.pos[1], mission.pos[2])
    -- currentBlip= AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
    -- SetBlipSprite(currentBlip, 446)
    -- SetBlipColour(currentBlip, 5)
    -- SetBlipAsShortRange(currentBlip, true)
    -- --SetBlipFlashes(currentBlip,1)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString(TEXT.Blip)
	-- EndTextCommandSetBlipName(currentBlip)
    -- SetBlipAsMissionCreatorBlip(currentBlip, true)
end

function finishCurrentMission()
    -- Citizen.Trace(currentMissions.id)
    TriggerServerEvent('mecano:FinishMission', currentMissions.id)
    currentMissions = nil
    if currentBlip ~= nil then
        RemoveBlip(currentBlip)
    end
end

function updateMenuMission() 
    local items = {{['Title'] = 'Retour', ['ReturnBtn'] = true }}
    for _,m in pairs(listMissions) do 
        -- Citizen.Trace('item mission')
        local item = {
            Title = 'Mission ' .. m.id .. ' [' .. m.type .. ']',
            mission = m,
            Function = acceptMission
        }
        if #m.acceptBy ~= 0 then
            item.Title = item.Title .. ' (En cours)'
            item.TextColor = {39, 174, 96, 255}
        end
        table.insert(items, item)
    end
    if currentMissions ~= nil then
        table.insert(items, {['Title'] = 'Terminer la mission', ['Function'] = finishCurrentMission})
    end
    table.insert(items, {['Title'] = 'Fermer'})

    menu = {['Title'] = 'Missions en cours',  ['SubMenu'] = {
        ['Title'] = 'Missions en cours', ['Items'] = items
    }}
    updateMenu(menu)
end

RegisterNetEvent('mecano:MissionAccept')
AddEventHandler('mecano:MissionAccept', function (mission)
    currentMissions = mission
    SetNewWaypoint(mission.pos[1], mission.pos[2])
    currentBlip= AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
    SetBlipSprite(currentBlip, 446)
    SetBlipColour(currentBlip, 5)
    SetBlipAsShortRange(currentBlip, true)
    --SetBlipFlashes(currentBlip,1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(TEXT.Blip)
	EndTextCommandSetBlipName(currentBlip)
    SetBlipAsMissionCreatorBlip(currentBlip, true)

end)


RegisterNetEvent('mecano:MissionCancel')
AddEventHandler('mecano:MissionCancel', function ()
    currentMissions = nil
    if currentBlip ~= nil then
        RemoveBlip(currentBlip)
    end
end)

RegisterNetEvent('mecano:MissionChange')
AddEventHandler('mecano:MissionChange', function (missions)
    if not inService then
        return
    end
    listMissions = missions
    -- if currentMissions ~= nil then
         local nbMissionEnAttente = 0
    --     local find = false 
         for _,m in pairs(listMissions) do
      --       if m.id == currentMissions.id then
      --           find = true
       --      end
             if #m.acceptBy == 0 then
               nbMissionEnAttente = nbMissionEnAttente + 1
             end
        end
        if nbMissionEnAttente == 0 then 
             mecano_nbMissionEnAttenteText = TEXT.InfoMecanoNoAppel
         else
            mecano_nbMissionEnAttenteText = '~g~ ' .. nbMissionEnAttente .. ' ' .. TEXT.InfoMecanoNbAppel
         end
    --     Citizen.Trace('ok')
    --     if not find then
    --         currentMissions = nil
    --         notifIcon("CHAR_BLANK_ENTRY", 1, "Mecano", false, TEXT.MissionCancel)
    --         if currentBlip ~= nil then
    --             RemoveBlip(currentBlip)
    --         end
    --     end
    -- end
    updateMenuMission()
end)


function needMecano(type)
    local myPed = GetPlayerPed(-1)
    local myCoord = GetEntityCoords(myPed)
    TriggerServerEvent('mecano:Call', myCoord.x, myCoord.y, myCoord.z, type)
end

function toogleHelperLine()
    ShowLineGrueHelp = not ShowLineGrueHelp
end

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

function MECANO_wash()
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
end

function MECANO_CheckPlate()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
    if(DoesEntityExist(vehicleHandle)) then
        TriggerServerEvent("police:checkingPlate", GetVehicleNumberPlateText(vehicleHandle))
    else
        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Pas de véhicule proche!")
    end
end

function MECANO_FINE_DATA(data)
    POLICE_Fines(data.tarif, data.Title)
end

function MECANO_FINE_CUSTOM()
    local r = openTextInput('','', 128)
    if r ~= nil and r ~= '' then
        local t = tonumber(openTextInput('','', 12))
        if t ~= nil and t > 0 then
            MECANO_Fines(t,r)
        end
    end
end

function MECANO_Fines(amount, reason)
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("mecano:finesGranted", GetPlayerServerId(t), amount, reason)
    else
        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Pas de joueur proche!")
    end
end

RegisterNetEvent('mecano:payFines')
AddEventHandler('mecano:payFines', function(amount)
    
    TriggerServerEvent("coffremeca:amendecoffre", amount)
    TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Vous avez payé la facture de $"..amount.." € du mecano.")
    TriggerServerEvent('bank:withdrawAmende', amount)
end)

RegisterNetEvent('mecano:openMenu')
AddEventHandler('mecano:openMenu', function()
    -- Citizen.Trace('open menu mecano')
    if inService then
        TriggerServerEvent('mecano:requestMission')
        openMenuGeneral()
    else
        showMessageInformation("~r~Vous devez etre en service pour acceder au menu")
    end
end)

RegisterNetEvent('mecano:callMecano')
AddEventHandler('mecano:callMecano',function(data)
    needMecano(data.type)
end)

RegisterNetEvent('mecano:callStatus')
AddEventHandler('mecano:callStatus',function(status)
    mecano_call_accept = status
end)

RegisterNetEvent('mecano:personnelChange')
AddEventHandler('mecano:personnelChange',function(nbPersonnel, nbDispo)
    mecano_nbMecanoInService = nbPersonnel
    mecano_nbMecanoDispo = nbDispo
end)

RegisterNetEvent('mecano:cancelCall')
AddEventHandler('mecano:cancelCall',function(data)
    TriggerServerEvent('mecano:cancelCall')
end)

--====================================================================================
-- ADD Blip for All Player
--====================================================================================
-- Delay sinon sa ne s'affiche pas
SetTimeout(2500, function() 
    for _, c in pairs(coords) do 
        local currentBlip = AddBlipForCoord(c.ArenaRepair.x, c.ArenaRepair.y, c.ArenaRepair.z)
        SetBlipSprite(currentBlip, 446)
        SetBlipAsShortRange(currentBlip, true)
        SetBlipColour(currentBlip, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(TEXT.BlipGarage)
        EndTextCommandSetBlipName(currentBlip)
        SetBlipAsMissionCreatorBlip(currentBlip, true)
    end
    
end)
--Citizen.Trace("Mecano load")
TriggerServerEvent('mecano:requestPersonnel')

-- Register a network event 
RegisterNetEvent( 'deleteVehicle' )

-- The distance to check in front of the player for a vehicle
-- Distance is in GTA units, which are quite big  
local distanceToCheck = 5.0

-- Add an event handler for the deleteVehicle event. 
-- Gets called when a user types in /dv in chat (see server.lua)
function MECANO_deleteVehicle()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )
        -- log( "Player is at:\nX: " .. pos.x .. " Y: " .. pos.y .. " Z: " .. pos.z )
        -- log( "Found vehicle?: " .. tostring( DoesEntityExist( vehicle ) ) )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                ShowNotification( "Vehicle supprimé." )
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )
            else 
                ShowNotification( "Vous devez être sur le siège conducteur!" )
            end 
        else
            local playerPos = GetEntityCoords( ped, 1 )
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( playerPos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                -- log( "Distance between ped and vehicle: " .. tostring( GetDistanceBetween( ped, vehicle ) ) )
                ShowNotification( "Vehicle supprimé." )
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )
            else 
                ShowNotification( "Vous devez être proche d'un véhicule pour le suppimer." )
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


-- isMecano = true
-- toogleService()


-- ----[[ DEBUG
-- local myPed = GetPlayerPed(-1)
-- local myCoord = GetEntityCoords(myPed)
-- -- toogleService()
-- Citizen.Trace('Pos init: ' .. myCoord.x .. ', ' .. myCoord.y .. ', ' .. myCoord.z)

-- local l = math.floor(math.random() * #coords) + 1 
-- -- Citizen.Trace('Tp at ' .. l )
-- local pos = coords[l].SpawnVehicleAction
-- --SetEntityCoords(myPed, pos.x, pos.y, pos.z)

-- --]]
-- toogleService()
-- isMecano = true
-- local myPed = GetPlayerPed(-1)
-- local myCoord = GetEntityCoords(myPed)
-- local any = nil
-- AddRope(
-- myCoord.x, myCoord.y, myCoord.z, 
-- 0.0, 0.0, 0.0,
-- 5.0, 1, 4.5, 5.5, 
-- 0,0,0,
-- 0,0,0,Citizen.ReturnResultAnyway())

-- local my= GetPlayerPed(-1)
-- local vi = GetVehicleLookByPlayer(my, 3.0)
-- if vi ~= nil then
--     local myCoord = GetEntityCoords(vi)
--     local h = GetEntityHeading(vi)
--     Citizen.Trace('Car init: ' .. myCoord.x .. ', ' .. myCoord.y .. ', ' .. myCoord.z ..  ', h :  ' .. h)
-- end

-- Citizen.CreateThread(function()
--     while true do 
--     Citizen.Wait(1)
--     local ped = GetPlayerPed(-1)
--            local playerPos = GetEntityCoords( ped, 1 )
--            local p = GetOffsetFromEntityInWorldCoords( ped, 0.0, 0.0, 0.0 )
--         local p1 = GetOffsetFromEntityInWorldCoords( ped, 0.0, 3.0, -0.8)
--         DrawLine(p.x, p.y, p.z, p1.x, p1.y, p1.z, 255,0,0,255)
--     end
-- end)