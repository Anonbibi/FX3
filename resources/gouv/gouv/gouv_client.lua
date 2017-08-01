isAgent = false
isAgentInService = false
local rank = "inconnu"
local checkpoints = {}
local existingVeh = nil
local handCuffed = false
local isHandCuffed = false -- Don't touch!
local isAlreadyDead = false
local allServiceAgents = {}
local blipsAgents = {}
Citizen.Trace('agenci')
local takingService = {
  --{x=850.156677246094, y=-1283.92004394531, z=28.0047378540039},
  {x=-423.31, y=1072.45, z=327.191}
  --{x=-450.063201904297, y=6016.5751953125, z=31.7163734436035}
}

local stationGarage = {
	{x=-420.305, y=1062.18, z=323.242}
}

AddEventHandler("playerSpawned", function()
	TriggerServerEvent("gouv:checkIsAgent")
end)

RegisterNetEvent('gouv:receiveIsAgent')
AddEventHandler('gouv:receiveIsAgent', function(result)
	Citizen.Trace('isAgentisAgentisAgentisAgentisAgentisAgentisAgent')
	if(result == "inconnu") then
		isAgent = false
	else
		isAgent = true
		rank = result
	end
end)

RegisterNetEvent('gouv:nowAgent')
AddEventHandler('gouv:nowAgent', function()
	isAgent = true
end)

RegisterNetEvent('gouv:noLongerAgent')
AddEventHandler('gouv:noLongerAgent', function()
	isAgent = false
	isAgentInService = false
	
	local playerPed = GetPlayerPed(-1)
						
	TriggerServerEvent("skin_customization:SpawnPlayer")
	SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 1, 2)
	RemoveAllPedWeapons(playerPed)
	
	if(existingVeh ~= nil) then
		SetEntityAsMissionEntity(existingVeh, true, true)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
		existingVeh = nil
	end
	
	ServiceOff()
end)

-- RegisterNetEvent('police:getArrested')
-- AddEventHandler('police:getArrested', function()
-- 	if(isAgent == false) then
-- 		handCuffed = not handCuffed
-- 		if(handCuffed) then
-- 			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "vous êtes menoté")
-- 		else
-- 			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "LIBRE !")
-- 		end
-- 	end
-- end)

RegisterNetEvent('gouv:getArrested')
AddEventHandler('gouv:getArrested', function()
	if(isAgent == false) then
		handCuffed = not handCuffed
		if(handCuffed) then
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "vous êtes menoté")
			isHandCuffed = true -- jail addon
		else
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "LIBRE !")
			isHandCuffed = false -- jail addon
		end
	end
end)


-- Jail addon end

-- RegisterNetEvent('police:payFines')
-- AddEventHandler('police:payFines', function(amount, reason)
	-- --TriggerServerEvent('bank:withdrawAmende', amount)
	-- TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "You paid a $"..amount.." fine for" .. reason )
-- end)

RegisterNetEvent('gouv:dropIllegalItem')
AddEventHandler('gouv:dropIllegalItem', function(id)
	TriggerEvent("player:looseItem", tonumber(id), exports.vdk_inventory:getQuantity(id))
end)


RegisterNetEvent('gouv:unseatme')
AddEventHandler('gouv:unseatme', function(t)
	local ped = GetPlayerPed(t)        
	ClearPedTasksImmediately(ped)
	plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	local xnew = plyPos.x+2
	local ynew = plyPos.y+2
   
	SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

RegisterNetEvent('gouv:forcedEnteringVeh')
AddEventHandler('gouv:forcedEnteringVeh', function(veh)
	if(handCuffed) then
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
		local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 1)
		end
	end
end)

RegisterNetEvent('gouv:resultAllAgentsInService')
AddEventHandler('gouv:resultAllAgentsInService', function(array)
	allServiceAgents = array
	enableAgentBlips()
end)

function enableAgentBlips()

	for k, existingBlip in pairs(blipsAgents) do
        RemoveBlip(existingBlip)
    end
	blipsAgents = {}
	
	local localIdAgents = {}
	for id = 0, 64 do
		if(NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
			for i,c in pairs(allServiceAgents) do
				if(i == GetPlayerServerId(id)) then
					localIdAgents[id] = c
					break
				end
			end
		end
	end
	
	for id, c in pairs(localIdAgents) do
		local ped = GetPlayerPed(id)
		local blip = GetBlipFromEntity(ped)
		
		if not DoesBlipExist( blip ) then

			blip = AddBlipForEntity( ped )
			SetBlipSprite( blip, 1 )
			Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			HideNumberOnBlip( blip )
			SetBlipNameToPlayerName( blip, id )
			
			SetBlipScale( blip,  0.85 )
			SetBlipAlpha( blip, 255 )
			
			table.insert(blipsAgents, blip)
		else
			
			blipSprite = GetBlipSprite( blip )
			
			HideNumberOnBlip( blip )
			if blipSprite ~= 1 then
				SetBlipSprite( blip, 1 )
				Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			end
			
			Citizen.Trace("Name : "..GetPlayerName(id))
			SetBlipNameToPlayerName( blip, id )
			SetBlipScale( blip,  0.85 )
			SetBlipAlpha( blip, 255 )
			
			table.insert(blipsAgents, blip)
		end
	end
end

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

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function getIsInServiceAgent()
	return isAgentInService
end

function isNearTakeService()
	for i = 1, #takingService do
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(takingService[i].x, takingService[i].y, takingService[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, takingService[i].x, takingService[i].y, takingService[i].z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 155, 255, 200, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

function isNearStationGarage()
	for i = 1, #stationGarage do
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(stationGarage[i].x, stationGarage[i].y, stationGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, stationGarage[i].x, stationGarage[i].y, stationGarage[i].z-1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 0, 155, 255, 200, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

function ServiceOn()
	isAgentInService = true
	--TriggerServerEvent("jobssystem:jobs", 2)
	TriggerServerEvent("gouv:takeService")
end

function ServiceOff()
	isAgentInService = false
	--TriggerServerEvent("jobssystem:jobs", 7)
	TriggerServerEvent("gouv:breakService")
	allServiceAgents = {}
	
	for k, existingBlip in pairs(blipsAgents) do
        RemoveBlip(existingBlip)
    end
	blipsAgents = {}
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isAgent) then
			if(isNearTakeService()) then
			
				DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le vestiaire',0,1,0.5,0.8,0.6,255,255,255,255) -- ~g~E~s~
				if IsControlJustPressed(1,51) then
					--OpenMenuVest()
					MenuChoixGouvService()
				end
			end
			-- if(isAgentInService) then
				-- if IsControlJustPressed(1,166) then 
					-- OpenGouvMenu()
				-- end
			-- end
			
			if(isAgentInService) then
				if(isNearStationGarage()) then
					if(gouvvehicle ~= nil) then --existingVeh
						DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ranger votre vehicule',0,1,0.5,0.8,0.6,255,255,255,255)
					else
						DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage de gouv',0,1,0.5,0.8,0.6,255,255,255,255)
					end
					
					if IsControlJustPressed(1,51) then
						if(gouvvehicle ~= nil) then
							SetEntityAsMissionEntity(gouvvehicle, true, true)
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(gouvvehicle))
							gouvvehicle = nil
						else
							--OpenVeh()
							MenuChoixGouvVehicleCar()
						end
					end
				end
				
				
			end
		else
			if (handCuffed == true) then
			  RequestAnimDict('mp_arresting')

			  while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(0)
			  end

			  local myPed = PlayerPedId()
			  local animation = 'idle'
			  local flags = 16

			  TaskPlayAnim(myPed, 'mp_arresting', animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
			end
		end
    end
end)
---------------------------------------------------------------------------------------
-------------------------------SPAWN HELI AND CHECK DEATH------------------------------
---------------------------------------------------------------------------------------
local alreadyDead = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isAgent) then
			if(isAgentInService) then
			
				-- if(IsPlayerDead(PlayerId())) then
					-- if(alreadyDead == false) then
						-- ServiceOff()
						-- alreadyDead = true
					-- end
				-- else
					-- alreadyDead = false
				-- end
			
				DrawMarker(1,-460.467,1140.55,325.304,0,0,0,0,0,0,2.0,2.0,2.0,0,155,255,200,0,0,0,0)
			
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -460.467,1140.55,325.304, true ) < 5 then
					if(existingVeh ~= nil) then
						DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ranger votre helicoptère',0,1,0.5,0.8,0.6,255,255,255,255)
					else
						DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour prendre vote helicoptère',0,1,0.5,0.8,0.6,255,255,255,255)
					end
					
					if IsControlJustPressed(1,51)  then
						if(existingVeh ~= nil) then
							SetEntityAsMissionEntity(existingVeh, true, true)
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
							existingVeh = nil
						else
							local car = GetHashKey("volatus")
							local ply = GetPlayerPed(-1)
							local plyCoords = GetEntityCoords(ply, 0)
							
							RequestModel(car)
							while not HasModelLoaded(car) do
									Citizen.Wait(0)
							end
							
							existingVeh = CreateVehicle(car, plyCoords["x"], plyCoords["y"], plyCoords["z"], 90.0, true, false)
							SetVehicleLivery(existingVeh, 0)
							local id = NetworkGetNetworkIdFromEntity(existingVeh)
							SetNetworkIdCanMigrate(id, true)
							TaskWarpPedIntoVehicle(ply, existingVeh, -1)
						end
					end
				end
			end
		end
    end
end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(3000)
-- 			if not(isAgentInService) then
-- 				local ply = GetPlayerPed(-1)
-- 				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_PUMPSHOTGUN"))
-- 				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_ASSAULTRIFLE"))
-- 				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SNIPERRIFLE"))
-- 				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_PISTOL50"))
-- 				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_PISTOL"))
-- 				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SMG"))
-- 				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_MICROSMG"))
-- 				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_CARBINERIFLE"))
-- 				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SPECIALCARBINE"))
-- 				RemoveWeaponFromPed(ply, GetHashKey("WEAPON_COMBATPISTOL"))
-- 			end
-- 	end
-- end)

