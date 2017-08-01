--[[Register]]--

RegisterNetEvent("gouvernementgarages:getVehicles")
RegisterNetEvent('gouvernementgarages:SpawnVehicle')
RegisterNetEvent('gouvernementgarages:StoreVehicle')




--[[Local/Global]]--

VEHIGOUV = {}
local gouvernementgarage_location = {-409.085, 1061.53, 322.841}
local inrangeofgouvernementgarage = false
local currentlocation = nil
local gouvernementgarage = {title = "gouvernementgarage", currentpos = nil, marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }}




function MenuGouvernementGarage()
    ped = GetPlayerPed(-1);
    MenuTitle = "GouvernementGarage"
    ClearMenu()
    Menu.addButton("Rentrer le véhicule","RentrerVehiculeGouvernement",nil)
    Menu.addButton("Sortir un véhicule","ListeVehiculeGouvernement",nil)
    Menu.addButton("Fermer","CloseMenu",nil) 
end

function RentrerVehiculeGouvernement()
	TriggerServerEvent('gouvernementgarages:CheckForVeh',source)
	CloseMenu()
end

function ListeVehiculeGouvernement()
    ped = GetPlayerPed(-1);
    MenuTitle = "Mes vehicules :"
    ClearMenu()
    for ind, value in pairs(VEHIGOUV) do
            Menu.addButton(tostring(value.vehicle_name) .. " : " .. tostring(value.vehicle_state), "OptionVehicleGouvernement", value.id)
    end    
    Menu.addButton("Retour","MenuGouvernementGarage",nil)
end

function OptionVehicleGouvernement(vehID)
	local vehID = vehID
    MenuTitle = "Options :"
    ClearMenu()
    Menu.addButton("Sortir", "SortirVehiculeGouvernement", vehID)
	--Menu.addButton("Supprimer", "SupprimerVehiculeGouvernement", vehID)
    Menu.addButton("Retour", "ListeVehiculeGouvernement", nil)
end

function SortirVehiculeGouvernement(vehID)
	local vehID = vehID
	TriggerServerEvent('gouvernementgarages:CheckForSpawnVeh', vehID)
	CloseMenu()
end

--[[
function SupprimerVehiculeGouvernement(vehID)
	local vehID = vehID
		TriggerServerEvent('gouvernementgarages:CheckForDelVeh', vehID)
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

function IsPlayerInRangeOfGouvernementGarage()
	return inrangeofgouvernementgarage
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
	local loc = gouvernementgarage_location
	pos = gouvernementgarage_location
	checkgouvernementgarage = 0
	while true do
		Wait(0)
		DrawMarker(1,gouvernementgarage_location[1],gouvernementgarage_location[2],gouvernementgarage_location[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
		if GetDistanceBetweenCoords(gouvernementgarage_location[1],gouvernementgarage_location[2],gouvernementgarage_location[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
			drawTxt('~g~E~s~ pour ouvrir le menu',0,1,0.5,0.8,0.6,255,255,255,255)		
			if IsControlJustPressed(1, 86) then
				MenuGouvernementGarage()
				Menu.hidden = not Menu.hidden
			end
			Menu.renderGUI()
		end
	end
end)





--[[Events]]--

AddEventHandler("gouvernementgarages:getVehicles", function(THEVEHIGOUV)
    VEHIGOUV = {}
    VEHIGOUV = THEVEHIGOUV
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("gouvernementgarages:CheckGouvernementGarageForVeh")
end)

AddEventHandler('gouvernementgarages:SpawnVehicle', function(vehicle, plate, state, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
	local car = GetHashKey(vehicle)
	local plate = plate
	local state = state
	local primarycolor = tonumber(primarycolor)
	local secondarycolor = tonumber(secondarycolor)
	local pearlescentcolor = tonumber(pearlescentcolor)
	local wheelcolor = tonumber(wheelcolor)
	Citizen.CreateThread(function()			
		Citizen.Wait(3000)
		local caisseo = GetClosestVehicle(-409.085, 1061.53, 322.841)
		if DoesEntityExist(caisseo) then
			drawNotification("La zone est encombrée") 
		else
			if state == "Sortit" then
				drawNotification("Ce véhicule n'est pas dans le garage de gouvernement")
			else
				local mods = {}
				for i = 0,24 do
					mods[i] = GetVehicleMod(veh,i)
				end					
				RequestModel(car)
				while not HasModelLoaded(car) do
				Citizen.Wait(0)
				end
				veh = CreateVehicle(car, -409.085, 1061.53, 322.841, 0.0, true, false)
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
				TriggerServerEvent('gouvernementgarages:SetVehOut', vehicle, plate)
   				TriggerServerEvent("gouvernementgarages:CheckGouvernementGarageForVeh")
			end
		end
	end)
end)

AddEventHandler('gouvernementgarages:StoreVehicle', function(vehicle, plate)
	local car = GetHashKey(vehicle)	
	local plate = plate
	Citizen.CreateThread(function()		
		Citizen.Wait(3000)
		local caissei = GetClosestVehicle(-409.085, 1061.53, 322.841, 3.000, 0, 70)
		SetEntityAsMissionEntity(caissei, true, true)		
		local platecaissei = GetVehicleNumberPlateText(caissei)
		if DoesEntityExist(caissei) then	
			if plate ~= platecaissei then					
				drawNotification("Ce n'est pas ton véhicule")
			else
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caissei))
				drawNotification("Véhicule rentré")
				TriggerServerEvent('gouvernementgarages:SetVehIn', plate)
				TriggerServerEvent("gouvernementgarages:CheckGouvernementGarageForVeh")
			end
		else
			drawNotification("Aucun véhicule présent")
		end   
	end)
end)


