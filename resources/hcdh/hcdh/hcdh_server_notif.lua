function closures_hcdh_server()
    local listMissions = {}
    local listPersonnelActive = {}
    local acceptMulti = true
    local preFixEventName = 'hcdh'

    local CALL_INFO_WAIT = 2 
    local CALL_INFO_OK = 1
    local CALL_INFO_NONE = 0

    -- Notifyle changement de status des missions
    function HCDH_notifyMissionChange(target)
        target = target or -1
        TriggerClientEvent(preFixEventName .. ':MissionChange', target, listMissions)
    end

    function HCDH_notifyMissionCancel(source)
        TriggerClientEvent(preFixEventName .. ':MissionCancel', source)
    end

    -- Notify le changement de status des missions
    function HCDH_notifyPersonnelChange(target)
        target = target or -1
        TriggerClientEvent(preFixEventName .. ':personnelChange', target,  HCDH_getNbPerosnnelActive(), HCDH_getNbPerosnnelDispo())
     end

    -- Notify un message a tout les personnels
    function HCDH_notifyAllPersonnel(MESS)
        TriggerClientEvent(preFixEventName .. ':PersonnelMessage', -1, MESS)
    end

    -- Notify un message un personnel
    function HCDH_notifyPersonnel(source, MESS)
        TriggerClientEvent(preFixEventName .. ':PersonnelMessage', source, MESS)
    end

    -- Notify un message un client
    function HCDH_notifyClient(source, MESS)
        TriggerClientEvent(preFixEventName .. ':ClientMessage', source, MESS)
    end

    -- Not use || Notify a message a tout le monde
    function HCDH_notifyAllClient(MESS)
        TriggerClientEvent(preFixEventName .. ':ClientMessage', -1 , MESS)
    end

    -- Notify call status change
    function HCDH_notifyCallStatus(source, status)
        TriggerClientEvent(preFixEventName .. ':callStatus', source, status)
    end

    function HCDH_addMission(source, position, type)
        local sMission = listMissions[source]
        if sMission == nil then
            listMissions[source] = {
                id = source,
                pos = position,
                acceptBy = {},
                type = type
            }

            HCDH_notifyClient(source, 'CALL_RECU')
            HCDH_notifyCallStatus(source, CALL_INFO_WAIT)
            HCDH_notifyAllPersonnel('MISSION_NEW')
            HCDH_notifyMissionChange()
        else -- Missions deja en cours
            HCDH_notifyClient(source, 'CALL_EN_COURS')
        end
    end

    function HCDH_closeMission(source, missionId)
        if listMissions[missionId] ~= nil then
            for _, v in pairs(listMissions[missionId].acceptBy) do 
                if v ~= source then
                    HCDH_notifyPersonnel(v, 'MISSION_ANNULE')
                    notifyMissionCancel(v)
                end
                HCDH_setInactivePersonnel(v)
            end
            listMissions[missionId] = nil
            HCDH_notifyClient(missionId, 'CALL_FINI')
            HCDH_notifyCallStatus(missionId, CALL_INFO_NONE)
            HCDH_notifyMissionChange()
            HCDH_notifyPersonnelChange()
        end
    end

    function HCDH_personelAcceptMission(source, missionId)
        local sMission = listMissions[missionId]
        if sMission == nil then
            HCDH_notifyPersonnel(source,'MISSION_INCONNU')
        elseif #sMission.acceptBy ~= 0  and not acceptMulti then 
            HCDH_notifyPersonnel(source, 'MISSION_EN_COURS')
        else
            HCDH_removePersonel(source)
            if #sMission.acceptBy >= 1 then
                if sMission.acceptBy[1] ~= source then
                    for _, m in pairs(sMission.acceptBy) do
                        HCDH_notifyPersonnel(m, 'MISSION_CONCURENCE')
                    end
                    table.insert(sMission.acceptBy, source)
                end
            else
                table.insert(sMission.acceptBy, source)
                HCDH_notifyClient(sMission.id, 'CALL_ACCEPT_P')
                HCDH_notifyPersonnel(source, 'MISSION_ACCEPT')
            end
            TriggerClientEvent(preFixEventName .. ':MissionAccept', source, sMission)
            HCDH_notifyCallStatus(missionId, CALL_INFO_OK)
            HCDH_setActivePersonnel(source)
            HCDH_notifyMissionChange()
            HCDH_notifyPersonnelChange()
        end
    end

    function HCDH_removePersonel(personnelId)
        for _, mission in pairs(listMissions) do 
            for k, v in pairs(mission.acceptBy) do 
                if v == personnelId then
                    table.remove(mission.acceptBy, k)
                    if #mission.acceptBy == 0 then
                        HCDH_notifyClient(mission.id, 'CALL_CANCEL')
                        TriggerClientEvent(preFixEventName .. ':callStatus', mission.id, 2)
                        HCDH_notifyCallStatus(mission.id, CALL_INFO_WAIT)
                        HCDH_notifyAllPersonnel('MISSION_NEW')
                    end
                    break
                end
            end
        end
        HCDH_removePersonelService(personnelId)
        HCDH_notifyPersonnelChange()
    end

    function HCDH_removeClient(clientId)
        if listMissions[clientId] ~= nil then
            for _, v in pairs(listMissions[clientId].acceptBy) do 
                HCDH_notifyPersonnel(v, 'MISSION_ANNULE')
                notifyMissionCancel(v)
                HCDH_setInactivePersonnel(v)
            end
            listMissions[clientId] = nil
            HCDH_notifyCallStatus(clientId, CALL_INFO_NONE)
            HCDH_notifyMissionChange()
            HCDH_notifyPersonnelChange()
        end
    end


    --=========================================================================
    --  Gestion des personnels en service & activité
    --=========================================================================

    function HCDH_addPersonelService(source)
        listPersonnelActive[source] = false
    end
    
    function HCDH_removePersonelService(source)
        listPersonnelActive[source] = nil
    end

    function HCDH_setActivePersonnel(source)
        listPersonnelActive[source] = true
        
    end

    function HCDH_setInactivePersonnel(source)
        listPersonnelActive[source] = false
    end

    function HCDH_getNbPerosnnelActive()
        local dispo = 0
        for _, v in pairs(listPersonnelActive) do 
            dispo = dispo + 1
        end
        return dispo
    end

    function HCDH_getNbPerosnnelDispo()
        local dispo = 0
        for _, v in pairs(listPersonnelActive) do 
            if v == false then
                dispo = dispo + 1
            end
        end
        return dispo
    end

    function HCDH_getNbPerosnnelBusy()
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
        HCDH_addPersonelService(source)
        HCDH_notifyPersonnelChange()
    end)

    RegisterServerEvent(preFixEventName .. ':breakService')
    AddEventHandler(preFixEventName .. ':breakService', function ()
        HCDH_removePersonel(source)
        HCDH_removePersonelService(source)
    end)

    RegisterServerEvent(preFixEventName .. ':requestMission')
    AddEventHandler(preFixEventName .. ':requestMission', function ()
        HCDH_notifyMissionChange(source)
    end)

    RegisterServerEvent(preFixEventName .. ':requestPersonnel')
    AddEventHandler(preFixEventName .. ':requestPersonnel', function ()
        HCDH_notifyPersonnelChange(source)
    end)

    RegisterServerEvent(preFixEventName .. ':Call')
    AddEventHandler(preFixEventName .. ':Call', function (posX,posY,posZ,type)
        HCDH_addMission(source, {posX, posY, posZ}, type)
    end)

    RegisterServerEvent(preFixEventName .. ':CallCancel')
    AddEventHandler(preFixEventName .. ':CallCancel', function ()
        HCDH_removeClient(source)
    end)

    RegisterServerEvent(preFixEventName .. ':AcceptMission')
    AddEventHandler(preFixEventName .. ':AcceptMission', function (id)
        HCDH_personelAcceptMission(source, id)
    end)

    RegisterServerEvent(preFixEventName .. ':FinishMission')
    AddEventHandler(preFixEventName .. ':FinishMission', function (id)
        HCDH_closeMission(source, id)
    end)

    RegisterServerEvent(preFixEventName .. ':cancelCall')
    AddEventHandler(preFixEventName .. ':cancelCall', function ()
        HCDH_removeClient(source)
    end)

    AddEventHandler('playerDropped', function()
        HCDH_removePersonel(source)
        HCDH_removeClient(source)
    end)


end

closures_hcdh_server()
