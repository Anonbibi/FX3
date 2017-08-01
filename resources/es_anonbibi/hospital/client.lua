--[[Register]]--

RegisterNetEvent("hospitalgarages:getVehicles")
RegisterNetEvent('hospitalgarages:SpawnVehicle')
RegisterNetEvent('hospitalgarages:StoreVehicle')
RegisterNetEvent('hospitalgarages:SelVehicle')



--[[Local/Global]]--

VEHICLESHOSPI = {}
local hospitalgarage_location = {276.958, -1354.13, 30.9351}
local inrangeofhospitalgarage = false
local currentlocation = nil
local hospitalgarage = {title = "hospitalgarage", currentpos = nil, marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }}



--[[Functions]]--

function MenuHospitalGarage()
    ped = GetPlayerPed(-1);
    MenuTitle = "HospitalGarage"
    ClearMenu()
    Menu.addButton("Rentrer le véhicule","RentrerVehiculeHospi",nil)
    Menu.addButton("Sortir un véhicule","ListeVehiculeHospi",nil)
    Menu.addButton("Fermer","CloseMenu",nil) 
end

function RentrerVehiculeHospi()
	TriggerServerEvent('hospitalgarages:CheckForVeh',source)
	CloseMenu()
end

function ListeVehiculeHospi()
    ped = GetPlayerPed(-1);
    MenuTitle = "Mes vehicules :"
    ClearMenu()
    for ind, value in pairs(VEHICLESHOSPI) do
            Menu.addButton(tostring(value.vehicle_name) .. " : " .. tostring(value.vehicle_state), "OptionVehicleHospi", value.id)
    end    
    Menu.addButton("Retour","MenuHospitalGarage",nil)
end

function OptionVehicleHospi(vehID)
	local vehID = vehID
    MenuTitle = "Options :"
    ClearMenu()
    Menu.addButton("Sortir", "SortirVehiculeHospi", vehID)
	--Menu.addButton("Supprimer", "SupprimerVehiculeHospi", vehID)
    Menu.addButton("Retour", "ListeVehiculeHospi", nil)
end

function SortirVehiculeHospi(vehID)
	local vehID = vehID
	TriggerServerEvent('hospitalgarages:CheckForSpawnVeh', vehID)
	CloseMenu()
end

--[[
function SupprimerVehiculeHospi(vehID)
	local vehID = vehID
		TriggerServerEvent('hospitalgarages:CheckForDelVeh', vehID)
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

function IsPlayerInRangeOfHospitalGarage()
	return inrangeofhospitalgarage
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
	local loc = hospitalgarage_location
	pos = hospitalgarage_location
	checkhospitalgarage = 0
	while true do
		Wait(0)
		DrawMarker(1,hospitalgarage_location[1],hospitalgarage_location[2],hospitalgarage_location[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
		if GetDistanceBetweenCoords(hospitalgarage_location[1],hospitalgarage_location[2],hospitalgarage_location[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
			drawTxt('~g~E~s~ pour ouvrir le menu',0,1,0.5,0.8,0.6,255,255,255,255)		
			if IsControlJustPressed(1, 86) then
				MenuHospitalGarage()
				Menu.hidden = not Menu.hidden
			end
			Menu.renderGUI()
		end
	end
end)





--[[Events]]--

AddEventHandler("hospitalgarages:getVehicles", function(THEVEHICLESHOSPI)
    VEHICLESHOSPI = {}
    VEHICLESHOSPI = THEVEHICLESHOSPI
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("hospitalgarages:CheckHospitalGarageForVeh")
end)

AddEventHandler('hospitalgarages:SpawnVehicle', function(vehicle, plate, state, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
	local car = GetHashKey(vehicle)
	local plate = plate
	local state = state
	local primarycolor = tonumber(primarycolor)
	local secondarycolor = tonumber(secondarycolor)
	local pearlescentcolor = tonumber(pearlescentcolor)
	local wheelcolor = tonumber(wheelcolor)
	Citizen.CreateThread(function()			
		Citizen.Wait(3000)
		local caisseo = GetClosestVehicle(276.958, -1354.13, 30.8351, 3.000, 0, 70)
		if DoesEntityExist(caisseo) then
			drawNotification("La zone est encombrée") 
		else
			if state == "Sortit" then
				drawNotification("Ce véhicule n'est pas dans le garage de hospital")
			else
				local mods = {}
				for i = 0,24 do
					mods[i] = GetVehicleMod(veh,i)
				end					
				RequestModel(car)
				while not HasModelLoaded(car) do
				Citizen.Wait(0)
				end
				veh = CreateVehicle(car, 276.958, -1354.13, 30.8351, 0.0, true, false)
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
				TriggerServerEvent('hospitalgarages:SetVehOut', vehicle, plate)
   				TriggerServerEvent("hospitalgarages:CheckHospitalGarageForVeh")
			end
		end
	end)
end)

AddEventHandler('hospitalgarages:StoreVehicle', function(vehicle, plate)
	local car = GetHashKey(vehicle)	
	local plate = plate
	Citizen.CreateThread(function()		
		Citizen.Wait(3000)
		local caissei = GetClosestVehicle(276.958, -1354.13, 30.8351, 3.000, 0, 70)
		SetEntityAsMissionEntity(caissei, true, true)		
		local platecaissei = GetVehicleNumberPlateText(caissei)
		if DoesEntityExist(caissei) then	
			if plate ~= platecaissei then					
				drawNotification("Ce n'est pas ton véhicule")
			else
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caissei))
				drawNotification("Véhicule rentré")
				TriggerServerEvent('hospitalgarages:SetVehIn', plate)
				TriggerServerEvent("hospitalgarages:CheckHospitalGarageForVeh")
			end
		else
			drawNotification("Aucun véhicule présent")
		end   
	end)
end)


