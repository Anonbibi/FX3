function closures_gouv_server()
    local listMissions = {}
    local listPersonnelActive = {}
    local acceptMulti = true
    local preFixEventName = 'gouv'

    local CALL_INFO_WAIT = 2 
    local CALL_INFO_OK = 1
    local CALL_INFO_NONE = 0

    -- Notifyle changement de status des missions
    function GOUV_notifyMissionChange(target)
        target = target or -1
        TriggerClientEvent(preFixEventName .. ':MissionChange', target, listMissions)
    end

    function GOUV_notifyMissionCancel(source)
        TriggerClientEvent(preFixEventName .. ':MissionCancel', source)
    end

    -- Notify le changement de status des missions
    function GOUV_notifyPersonnelChange(target)
        target = target or -1
        TriggerClientEvent(preFixEventName .. ':personnelChange', target,  GOUV_getNbPerosnnelActive(), GOUV_getNbPerosnnelDispo())
     end

    -- Notify un message a tout les personnels
    function GOUV_notifyAllPersonnel(MESS)
        TriggerClientEvent(preFixEventName .. ':PersonnelMessage', -1, MESS)
    end

    -- Notify un message un personnel
    function GOUV_notifyPersonnel(source, MESS)
        TriggerClientEvent(preFixEventName .. ':PersonnelMessage', source, MESS)
    end

    -- Notify un message un client
    function GOUV_notifyClient(source, MESS)
        TriggerClientEvent(preFixEventName .. ':ClientMessage', source, MESS)
    end

    -- Not use || Notify a message a tout le monde
    function GOUV_notifyAllClient(MESS)
        TriggerClientEvent(preFixEventName .. ':ClientMessage', -1 , MESS)
    end

    -- Notify call status change
    function GOUV_notifyCallStatus(source, status)
        TriggerClientEvent(preFixEventName .. ':callStatus', source, status)
    end

    function GOUV_addMission(source, position, type)
        local sMission = listMissions[source]
        if sMission == nil then
            listMissions[source] = {
                id = source,
                pos = position,
                acceptBy = {},
                type = type
            }

            GOUV_notifyClient(source, 'CALL_RECU')
            GOUV_notifyCallStatus(source, CALL_INFO_WAIT)
            GOUV_notifyAllPersonnel('MISSION_NEW')
            GOUV_notifyMissionChange()
        else -- Missions deja en cours
            GOUV_notifyClient(source, 'CALL_EN_COURS')
        end
    end

    function GOUV_closeMission(source, missionId)
        if listMissions[missionId] ~= nil then
            for _, v in pairs(listMissions[missionId].acceptBy) do 
                if v ~= source then
                    GOUV_notifyPersonnel(v, 'MISSION_ANNULE')
                    notifyMissionCancel(v)
                end
                GOUV_setInactivePersonnel(v)
            end
            listMissions[missionId] = nil
            GOUV_notifyClient(missionId, 'CALL_FINI')
            GOUV_notifyCallStatus(missionId, CALL_INFO_NONE)
            GOUV_notifyMissionChange()
            GOUV_notifyPersonnelChange()
        end
    end

    function GOUV_personelAcceptMission(source, missionId)
        local sMission = listMissions[missionId]
        if sMission == nil then
            GOUV_notifyPersonnel(source,'MISSION_INCONNU')
        elseif #sMission.acceptBy ~= 0  and not acceptMulti then 
            GOUV_notifyPersonnel(source, 'MISSION_EN_COURS')
        else
            GOUV_removePersonel(source)
            if #sMission.acceptBy >= 1 then
                if sMission.acceptBy[1] ~= source then
                    for _, m in pairs(sMission.acceptBy) do
                        GOUV_notifyPersonnel(m, 'MISSION_CONCURENCE')
                    end
                    table.insert(sMission.acceptBy, source)
                end
            else
                table.insert(sMission.acceptBy, source)
                GOUV_notifyClient(sMission.id, 'CALL_ACCEPT_P')
                GOUV_notifyPersonnel(source, 'MISSION_ACCEPT')
            end
            TriggerClientEvent(preFixEventName .. ':MissionAccept', source, sMission)
            GOUV_notifyCallStatus(missionId, CALL_INFO_OK)
            GOUV_setActivePersonnel(source)
            GOUV_notifyMissionChange()
            GOUV_notifyPersonnelChange()
        end
    end

    function GOUV_removePersonel(personnelId)
        for _, mission in pairs(listMissions) do 
            for k, v in pairs(mission.acceptBy) do 
                if v == personnelId then
                    table.remove(mission.acceptBy, k)
                    if #mission.acceptBy == 0 then
                        GOUV_notifyClient(mission.id, 'CALL_CANCEL')
                        TriggerClientEvent(preFixEventName .. ':callStatus', mission.id, 2)
                        GOUV_notifyCallStatus(mission.id, CALL_INFO_WAIT)
                        GOUV_notifyAllPersonnel('MISSION_NEW')
                    end
                    break
                end
            end
        end
        GOUV_removePersonelService(personnelId)
        GOUV_notifyPersonnelChange()
    end

    function GOUV_removeClient(clientId)
        if listMissions[clientId] ~= nil then
            for _, v in pairs(listMissions[clientId].acceptBy) do 
                GOUV_notifyPersonnel(v, 'MISSION_ANNULE')
                notifyMissionCancel(v)
                GOUV_setInactivePersonnel(v)
            end
            listMissions[clientId] = nil
            GOUV_notifyCallStatus(clientId, CALL_INFO_NONE)
            GOUV_notifyMissionChange()
            GOUV_notifyPersonnelChange()
        end
    end


    --=========================================================================
    --  Gestion des personnels en service & activité
    --=========================================================================

    function GOUV_addPersonelService(source)
        listPersonnelActive[source] = false
    end
    
    function GOUV_removePersonelService(source)
        listPersonnelActive[source] = nil
    end

    function GOUV_setActivePersonnel(source)
        listPersonnelActive[source] = true
        
    end

    function GOUV_setInactivePersonnel(source)
        listPersonnelActive[source] = false
    end

    function GOUV_getNbPerosnnelActive()
        local dispo = 0
        for _, v in pairs(listPersonnelActive) do 
            dispo = dispo + 1
        end
        return dispo
    end

    function GOUV_getNbPerosnnelDispo()
        local dispo = 0
        for _, v in pairs(listPersonnelActive) do 
            if v == false then
                dispo = dispo + 1
            end
        end
        return dispo
    end

    function GOUV_getNbPerosnnelBusy()
        local dispo = 0
        for _, v in pairs(listPersonnelActive) do 
            if v == true then
                dispo = dispo + 1
            end
        end
        return dispo
    end


    RegisterServerEvent(preFixEventName .. ':takeService')
    AddEventHandler(preFixEventName .. ':takeService', function ()
        GOUV_addPersonelService(source)
        GOUV_notifyPersonnelChange()
    end)

    RegisterServerEvent(preFixEventName .. ':breakService')
    AddEventHandler(preFixEventName .. ':breakService', function ()
        GOUV_removePersonel(source)
        GOUV_removePersonelService(source)
    end)

    RegisterServerEvent(preFixEventName .. ':requestMission')
    AddEventHandler(preFixEventName .. ':requestMission', function ()
        GOUV_notifyMissionChange(source)
    end)

    RegisterServerEvent(preFixEventName .. ':requestPersonnel')
    AddEventHandler(preFixEventName .. ':requestPersonnel', function ()
        GOUV_notifyPersonnelChange(source)
    end)

    RegisterServerEvent(preFixEventName .. ':Call')
    AddEventHandler(preFixEventName .. ':Call', function (posX,posY,posZ,type)
        GOUV_addMission(source, {posX, posY, posZ}, type)
    end)

    RegisterServerEvent(preFixEventName .. ':CallCancel')
    AddEventHandler(preFixEventName .. ':CallCancel', function ()
        GOUV_removeClient(source)
    end)

    RegisterServerEvent(preFixEventName .. ':AcceptMission')
    AddEventHandler(preFixEventName .. ':AcceptMission', function (id)
        GOUV_personelAcceptMission(source, id)
    end)

    RegisterServerEvent(preFixEventName .. ':FinishMission')
    AddEventHandler(preFixEventName .. ':FinishMission', function (id)
        GOUV_closeMission(source, id)
    end)

    RegisterServerEvent(preFixEventName .. ':cancelCall')
    AddEventHandler(preFixEventName .. ':cancelCall', function ()
        GOUV_removeClient(source)
    end)

    AddEventHandler('playerDropped', function()
        GOUV_removePersonel(source)
        GOUV_removeClient(source)
    end)


end

closures_gouv_server()
