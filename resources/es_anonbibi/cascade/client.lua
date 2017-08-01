--[[Register]]--

RegisterNetEvent("cascadegarages:getVehicles")
RegisterNetEvent('cascadegarages:SpawnVehicle')
RegisterNetEvent('cascadegarages:StoreVehicle')
RegisterNetEvent('cascadegarages:SelVehicle')



--[[Local/Global]]--

VEHICLESCASCADE = {}
local cascadegarage_location = {935.98, -91.1905, 77.9512}
local inrangeofcascadegarage = false
local currentlocation = nil
local cascadegarage = {title = "cascadegarage", currentpos = nil, marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }}



--[[Functions]]--

function MenuCascadeGarage()
    ped = GetPlayerPed(-1);
    MenuTitle = "CascadeGarage"
    ClearMenu()
    Menu.addButton("Rentrer le véhicule","RentrerVehiculeCasca",nil)
    Menu.addButton("Sortir un véhicule","ListeVehiculeCasca",nil)
    Menu.addButton("Fermer","CloseMenu",nil) 
end

function RentrerVehiculeCasca()
	TriggerServerEvent('cascadegarages:CheckForVeh',source)
	CloseMenu()
end

function ListeVehiculeCasca()
    ped = GetPlayerPed(-1);
    MenuTitle = "Mes vehicules :"
    ClearMenu()
    for ind, value in pairs(VEHICLESCASCADE) do
            Menu.addButton(tostring(value.vehicle_name) .. " : " .. tostring(value.vehicle_state), "OptionVehicleCasca", value.id)
    end    
    Menu.addButton("Retour","MenuCascadeGarage",nil)
end

function OptionVehicleCasca(vehID)
	local vehID = vehID
    MenuTitle = "Options :"
    ClearMenu()
    Menu.addButton("Sortir", "SortirVehiculeCasca", vehID)
	--Menu.addButton("Supprimer", "SupprimerVehiculeCasca", vehID)
    Menu.addButton("Retour", "ListeVehiculeCasca", nil)
end

function SortirVehiculeCasca(vehID)
	local vehID = vehID
	TriggerServerEvent('cascadegarages:CheckForSpawnVeh', vehID)
	CloseMenu()
end

--[[
function SupprimerVehiculeCasca(vehID)
	local vehID = vehID
		TriggerServerEvent('cascadegarages:CheckForDelVeh', vehID)
    Menu.addButton("Fermer","CloseMenu",nil) 
end
]]--

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function CloseMenu()
    Menu.hidden = true
end

function LocalPed()
	return GetPlayerPed(-1)
end

function IsPlayerInRangeOfCascadeGarage()
	return inrangeofcascadegarage
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
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



--[[Citizen]]--

Citizen.CreateThread(function()
	local loc = cascadegarage_location
	pos = cascadegarage_location
	checkcascadegarage = 0
	while true do
		Wait(0)
		DrawMarker(1,cascadegarage_location[1],cascadegarage_location[2],cascadegarage_location[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
		if GetDistanceBetweenCoords(cascadegarage_location[1],cascadegarage_location[2],cascadegarage_location[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
			drawTxt('~g~E~s~ pour ouvrir le menu',0,1,0.5,0.8,0.6,255,255,255,255)		
			if IsControlJustPressed(1, 86) then
				MenuCascadeGarage()
				Menu.hidden = not Menu.hidden
			end
			Menu.renderGUI()
		end
	end
end)





--[[Events]]--

AddEventHandler("cascadegarages:getVehicles", function(THEVEHICLESCASCADE)
    VEHICLESCASCADE = {}
    VEHICLESCASCADE = THEVEHICLESCASCADE
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("cascadegarages:CheckCascadeGarageForVeh")
end)

AddEventHandler('cascadegarages:SpawnVehicle', function(vehicle, plate, state, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
	local car = GetHashKey(vehicle)
	local plate = plate
	local state = state
	local primarycolor = tonumber(primarycolor)
	local secondarycolor = tonumber(secondarycolor)
	local pearlescentcolor = tonumber(pearlescentcolor)
	local wheelcolor = tonumber(wheelcolor)
	Citizen.CreateThread(function()			
		Citizen.Wait(3000)
		local caisseo = GetClosestVehicle(935.98, -91.1905, 79.0512, 3.000, 0, 70)
		if DoesEntityExist(caisseo) then
			drawNotification("La zone est encombrée") 
		else
			if state == "Sortit" then
				drawNotification("Ce véhicule n'est pas dans le cascadegarage")
			else
				local mods = {}
				for i = 0,24 do
					mods[i] = GetVehicleMod(veh,i)
				end					
				RequestModel(car)
				while not HasModelLoaded(car) do
				Citizen.Wait(0)
				end
				veh = CreateVehicle(car, 935.98, -91.1905, 79.0512, 0.0, true, false)
				for i,mod in pairs(mods) do
					SetVehicleModKit(personalvehicle,0)
					SetVehicleMod(personalvehicle,i,mod)
				end
				SetVehicleNumberPlateText(veh, plate)
				SetVehicleOnGroundProperly(veh)
				SetVehicleHasBeenOwnedByPlayer(veh,true)
				local id = NetworkGetNetworkIdFromEntity(veh)
				SetNetworkIdCanMigrate(id, true)
				SetVehicleColours(veh, primarycolor, secondarycolor)
				SetVehicleExtraColours(veh, pearlescentcolor, wheelcolor)
				SetEntityInvincible(veh, false) 
				drawNotification("Véhicule sorti")				
				TriggerServerEvent('cascadegarages:SetVehOut', vehicle, plate)
   				TriggerServerEvent("cascadegarages:CheckCascadeGarageForVeh")
			end
		end
	end)
end)

AddEventHandler('cascadegarages:StoreVehicle', function(vehicle, plate)
	local car = GetHashKey(vehicle)	
	local plate = plate
	Citizen.CreateThread(function()		
		Citizen.Wait(3000)
		local caissei = GetClosestVehicle(935.98, -91.1905, 79.0512, 3.000, 0, 70)
		SetEntityAsMissionEntity(caissei, true, true)		
		local platecaissei = GetVehicleNumberPlateText(caissei)
		if DoesEntityExist(caissei) then	
			if plate ~= platecaissei then					
				drawNotification("Ce n'est pas ton véhicule")
			else
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caissei))
				drawNotification("Véhicule rentré")
				TriggerServerEvent('cascadegarages:SetVehIn', plate)
				TriggerServerEvent("cascadegarages:CheckCascadeGarageForVeh")
			end
		else
			drawNotification("Aucun véhicule présent")
		end   
	end)
end)


