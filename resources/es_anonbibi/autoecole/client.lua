--[[Register]]--

RegisterNetEvent("autoecolegarages:getVehicles")
RegisterNetEvent('autoecolegarages:SpawnVehicle')
RegisterNetEvent('autoecolegarages:StoreVehicle')
RegisterNetEvent('autoecolegarages:SelVehicle')



--[[Local/Global]]--

VEHICLESAUTOEC = {}
local autoecolegarage_location = {470.131, 74.6438, 76.461}
local inrangeofautoecolegarage = false
local currentlocation = nil
local autoecolegarage = {title = "autoecolegarage", currentpos = nil, marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }}



--[[Functions]]--

function MenuAutoecoleGarage()
    ped = GetPlayerPed(-1);
    MenuTitle = "AutoecoleGarage"
    ClearMenu()
    Menu.addButton("Rentrer le véhicule","RentrerVehiculeAutoec",nil)
    Menu.addButton("Sortir un véhicule","ListeVehiculeAutoec",nil)
    Menu.addButton("Fermer","CloseMenu",nil) 
end

function RentrerVehiculeAutoec()
	TriggerServerEvent('autoecolegarages:CheckForVeh',source)
	CloseMenu()
end

function ListeVehiculeAutoec()
    ped = GetPlayerPed(-1);
    MenuTitle = "Mes vehicules :"
    ClearMenu()
    for ind, value in pairs(VEHICLESAUTOEC) do
            Menu.addButton(tostring(value.vehicle_name) .. " : " .. tostring(value.vehicle_state), "OptionVehicleAutoec", value.id)
    end    
    Menu.addButton("Retour","MenuAutoecoleGarage",nil)
end

function OptionVehicleAutoec(vehID)
	local vehID = vehID
    MenuTitle = "Options :"
    ClearMenu()
    Menu.addButton("Sortir", "SortirVehiculeAutoec", vehID)
	--Menu.addButton("Supprimer", "SupprimerVehiculeAutoec", vehID)
    Menu.addButton("Retour", "ListeVehiculeAutoec", nil)
end

function SortirVehiculeAutoec(vehID)
	local vehID = vehID
	TriggerServerEvent('autoecolegarages:CheckForSpawnVeh', vehID)
	CloseMenu()
end

--[[
function SupprimerVehiculeAutoec(vehID)
	local vehID = vehID
		TriggerServerEvent('autoecolegarages:CheckForDelVeh', vehID)
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

function IsPlayerInRangeOfAutoecoleGarage()
	return inrangeofautoecolegarage
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
	local loc = autoecolegarage_location
	pos = autoecolegarage_location
	checkautoecolegarage = 0
	while true do
		Wait(0)
		DrawMarker(1,autoecolegarage_location[1],autoecolegarage_location[2],autoecolegarage_location[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
		if GetDistanceBetweenCoords(autoecolegarage_location[1],autoecolegarage_location[2],autoecolegarage_location[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
			drawTxt('~g~E~s~ pour ouvrir le menu',0,1,0.5,0.8,0.6,255,255,255,255)		
			if IsControlJustPressed(1, 86) then
				MenuAutoecoleGarage()
				Menu.hidden = not Menu.hidden
			end
			Menu.renderGUI()
		end
	end
end)





--[[Events]]--

AddEventHandler("autoecolegarages:getVehicles", function(THEVEHICLESAUTOEC)
    VEHICLESAUTOEC = {}
    VEHICLESAUTOEC = THEVEHICLESAUTOEC
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("autoecolegarages:CheckAutoecoleGarageForVeh")
end)

AddEventHandler('autoecolegarages:SpawnVehicle', function(vehicle, plate, state, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
	local car = GetHashKey(vehicle)
	local plate = plate
	local state = state
	local primarycolor = tonumber(primarycolor)
	local secondarycolor = tonumber(secondarycolor)
	local pearlescentcolor = tonumber(pearlescentcolor)
	local wheelcolor = tonumber(wheelcolor)
	Citizen.CreateThread(function()			
		Citizen.Wait(3000)
		local caisseo = GetClosestVehicle(470.131, 74.6438, 76.461, 3.000, 0, 70)
		if DoesEntityExist(caisseo) then
			drawNotification("La zone est encombrée") 
		else
			if state == "Sortit" then
				drawNotification("Ce véhicule n'est pas dans le garage de autoecole")
			else
				local mods = {}
				for i = 0,24 do
					mods[i] = GetVehicleMod(veh,i)
				end					
				RequestModel(car)
				while not HasModelLoaded(car) do
				Citizen.Wait(0)
				end
				veh = CreateVehicle(car, 470.131, 74.6438, 76.461, 0.0, true, false)
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
				TriggerServerEvent('autoecolegarages:SetVehOut', vehicle, plate)
   				TriggerServerEvent("autoecolegarages:CheckAutoecoleGarageForVeh")
			end
		end
	end)
end)

AddEventHandler('autoecolegarages:StoreVehicle', function(vehicle, plate)
	local car = GetHashKey(vehicle)	
	local plate = plate
	Citizen.CreateThread(function()		
		Citizen.Wait(3000)
		local caissei = GetClosestVehicle(470.131, 74.6438, 76.461, 3.000, 0, 70)
		SetEntityAsMissionEntity(caissei, true, true)		
		local platecaissei = GetVehicleNumberPlateText(caissei)
		if DoesEntityExist(caissei) then	
			if plate ~= platecaissei then					
				drawNotification("Ce n'est pas ton véhicule")
			else
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caissei))
				drawNotification("Véhicule rentré")
				TriggerServerEvent('autoecolegarages:SetVehIn', plate)
				TriggerServerEvent("autoecolegarages:CheckAutoecoleGarageForVeh")
			end
		else
			drawNotification("Aucun véhicule présent")
		end   
	end)
end)


