-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsSessionStarted() then
			TriggerServerEvent('es:firstJoinProper')
			TriggerEvent('es:allowedToSpawn')
			return
		end
	end
end)

local loaded = false
local cashy = 0
local oldPos

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local pos = GetEntityCoords(GetPlayerPed(-1))

		if(oldPos ~= pos)then
			TriggerServerEvent('es:updatePositions', pos.x, pos.y, pos.z)

			if(loaded)then
				SendNUIMessage({
					setmoney = true,
					money = cashy
				})

				loaded = false
			end
			oldPos = pos
		end
	end
end)

local myDecorators = {}
local paramTpToSpawn = false
local spawnCoords = {}

RegisterNetEvent("es:setPlayerDecorator")
AddEventHandler("es:setPlayerDecorator", function(key, value, doNow)
	myDecorators[key] = value
	DecorRegister(key, 3)

	if(doNow)then
		DecorSetInt(GetPlayerPed(-1), key, value)
	end
end)


local firstSpawn = true
AddEventHandler("playerSpawned", function()
	for k,v in pairs(myDecorators)do
		DecorSetInt(GetPlayerPed(-1), k, v)
	end

	TriggerServerEvent('playerSpawn')
	
	if(paramTpToSpawn)then
		SetEntityCoords(GetPlayerPed(-1),tonumber(spawnCoords.x),tonumber(spawnCoords.y),tonumber(spawnCoords.z),1,0,0,1)
  		SetEntityHeading(GetPlayerPed(-1), 0.00)
  	end
end)

RegisterNetEvent('es:setMoneyIcon')
AddEventHandler('es:setMoneyIcon', function(i)
	SendNUIMessage({
		seticon = true,
		icon = i
	})
end)

RegisterNetEvent('es:setSpawnCoords_c')
AddEventHandler('es:setSpawnCoords_c', function(coords)
	spawnCoords = coords
	paramTpToSpawn = true
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	SendNUIMessage({
		setmoney = true,
		money = e
	})
end)

RegisterNetEvent('es:activateDirtyMoney')
AddEventHandler('es:activateDirtyMoney', function(e, bool)
	if(bool)then
		SendNUIMessage({
			setdirtymoney = true,
			dmoney = e
		})
	else
		SendNUIMessage({
			setdirtymoney = false
		})
	end
end)

RegisterNetEvent('es:activateBankMoney')
AddEventHandler('es:activateBankMoney', function(e, bool)
	if(bool)then
		SendNUIMessage({
			setbankmoney = true,
			bmoney = e
		})
	else
		SendNUIMessage({
			setbankmoney = false
		})
	end
end)

RegisterNetEvent("es:addedMoney")
AddEventHandler("es:addedMoney", function(m)
	SendNUIMessage({
		addcash = true,
		money = m
	})
end)

RegisterNetEvent("es:removedMoney")
AddEventHandler("es:removedMoney", function(m)
	SendNUIMessage({
		removecash = true,
		money = m
	})
end)

RegisterNetEvent("es:setMoneyDisplay")
AddEventHandler("es:setMoneyDisplay", function(val)
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			if not IsPauseMenuActive() then
				SendNUIMessage({
					setDisplay = true,
					display = val
				})
			end
		end
	end)
end)

RegisterNetEvent("es:enablePvp")
AddEventHandler("es:enablePvp", function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			for i = 0,32 do
				if NetworkIsPlayerConnected(i) then
					if NetworkIsPlayerConnected(i) and GetPlayerPed(i) ~= nil then
						SetCanAttackFriendly(GetPlayerPed(i), true, true)
						NetworkSetFriendlyFireOption(true)
					end
				end
			end
		end
	end)
end)