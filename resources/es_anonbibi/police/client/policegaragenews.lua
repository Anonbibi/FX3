--[[Register]]--

RegisterNetEvent("policegarages:getVehicles")
RegisterNetEvent('policegarages:SpawnVehicle')
RegisterNetEvent('policegarages:StoreVehicle')
RegisterNetEvent('policegarages:SelVehicle')



--[[Local/Global]]--

VEHICLESPOLICE = {}
local policegarage_location = {447.454,  -998.124, 24.7477}
local inrangeofpolicegarage = false
local currentlocation = nil
local policegarage = {title = "policegarage", currentpos = nil, marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }}



--[[Functions]]--

function MenuPoliceGarage()
    ped = GetPlayerPed(-1);
    MenuTitle = "PoliceGarage"
    ClearMenu()
    Menu.addButton("Rentrer le véhicule","RentrerVehiculePolic",nil)
    Menu.addButton("Sortir un véhicule","ListeVehiculePolic",nil)
    Menu.addButton("Fermer","CloseMenu",nil) 
end

function RentrerVehiculePolic()
	TriggerServerEvent('policegarages:CheckForVeh',source)
	CloseMenu()
end

function ListeVehiculePolic()
    ped = GetPlayerPed(-1);
    MenuTitle = "Mes vehicules :"
    ClearMenu()
    for ind, value in pairs(VEHICLESPOLICE) do
            Menu.addButton(tostring(value.vehicle_name) .. " : " .. tostring(value.vehicle_state), "OptionVehiclePolic", value.id)
    end    
    Menu.addButton("Retour","MenuPoliceGarage",nil)
end

function OptionVehiclePolic(vehID)
	local vehID = vehID
    MenuTitle = "Options :"
    ClearMenu()
    Menu.addButton("Sortir", "SortirVehiculePolic", vehID)
	--Menu.addButton("Supprimer", "SupprimerVehiculePolic", vehID)
    Menu.addButton("Retour", "ListeVehiculePolic", nil)
end

function SortirVehiculePolic(vehID)
	local vehID = vehID
	TriggerServerEvent('policegarages:CheckForSpawnVeh', vehID)
	CloseMenu()
end

--[[
function SupprimerVehiculePolic(vehID)
	local vehID = vehID
		TriggerServerEvent('policegarages:CheckForDelVeh', vehID)
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

function IsPlayerInRangeOfPoliceGarage()
	return inrangeofpolicegarage
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
	local loc = policegarage_location
	pos = policegarage_location
	checkpolicegarage = 0
	while true do
		Wait(0)
		DrawMarker(1,policegarage_location[1],policegarage_location[2],policegarage_location[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
		if GetDistanceBetweenCoords(policegarage_location[1],policegarage_location[2],policegarage_location[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
			drawTxt('~g~E~s~ pour ouvrir le menu',0,1,0.5,0.8,0.6,255,255,255,255)		
			if IsControlJustPressed(1, 86) then
				MenuPoliceGarage()
				Menu.hidden = not Menu.hidden
			end
			Menu.renderGUI()
		end
	end
end)





--[[Events]]--

AddEventHandler("policegarages:getVehicles", function(THEVEHICLESPOLICE)
    VEHICLESPOLICE = {}
    VEHICLESPOLICE = THEVEHICLESPOLICE
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("policegarages:CheckPoliceGarageForVeh")
end)

AddEventHandler('policegarages:SpawnVehicle', function(vehicle, plate, state, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
	local car = GetHashKey(vehicle)
	local plate = plate
	local state = state
	local primarycolor = tonumber(primarycolor)
	local secondarycolor = tonumber(secondarycolor)
	local pearlescentcolor = tonumber(pearlescentcolor)
	local wheelcolor = tonumber(wheelcolor)
	Citizen.CreateThread(function()			
		Citizen.Wait(3000)
		local caisseo = GetClosestVehicle(447.454,  -998.124, 24.7477, 3.000, 0, 70)
		if DoesEntityExist(caisseo) then
			drawNotification("La zone est encombrée") 
		else
			if state == "Sortit" then
				drawNotification("Ce véhicule n'est pas dans le police garage")
			else
				local mods = {}
				for i = 0,24 do
					mods[i] = GetVehicleMod(veh,i)
				end					
				RequestModel(car)
				while not HasModelLoaded(car) do
				Citizen.Wait(0)
				end
				veh = CreateVehicle(car, 447.454, -998.124, 24.7477, 0.0, true, false)
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
				TriggerServerEvent('policegarages:SetVehOut', vehicle, plate)
   				TriggerServerEvent("policegarages:CheckPoliceGarageForVeh")
			end
		end
	end)
end)

AddEventHandler('policegarages:StoreVehicle', function(vehicle, plate)
	local car = GetHashKey(vehicle)	
	local plate = plate
	Citizen.CreateThread(function()		
		Citizen.Wait(3000)
		local caissei = GetClosestVehicle(447.454,  -998.124, 24.7477, 3.000, 0, 70)
		SetEntityAsMissionEntity(caissei, true, true)		
		local platecaissei = GetVehicleNumberPlateText(caissei)
		if DoesEntityExist(caissei) then	
			if plate ~= platecaissei then					
				drawNotification("Ce n'est pas ton véhicule")
			else
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caissei))
				drawNotification("Véhicule rentré")
				TriggerServerEvent('policegarages:SetVehIn', plate)
				TriggerServerEvent("policegarages:CheckPoliceGarageForVeh")
			end
		else
			drawNotification("Aucun véhicule présent")
		end   
	end)
end)


