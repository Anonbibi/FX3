local options = {
    x = 0.1,
    y = 0.2,
    width = 0.2,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "Tequilala",
    menu_subtitle = "Categories",
    color_r = 255,
    color_g = 51,
    color_b = 102,
}

RegisterNetEvent("mp:firstspawn")
AddEventHandler("mp:firstspawn",function()
	Main() -- Menu to draw
    Menu.hidden = not Menu.hidden -- Hide/Show the menu
    Menu.renderGUI(options) -- Draw menu on each tick if Menu.hidden = false
end)

function changemodel(model)
	
	local modelhashed = GetHashKey(model)

	RequestModel(modelhashed)
	while not HasModelLoaded(modelhashed) do 
	    RequestModel(modelhashed)
	    Citizen.Wait(0)
	end

	SetPlayerModel(PlayerId(), modelhashed)
	local a = "" -- nil doesnt work
	SetPedRandomComponentVariation(GetPlayerPed(-1), true)
	SetModelAsNoLongerNeeded(modelhashed)
end

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function Main()
    options.menu_subtitle = "Selection des Boissons"
    ClearMenu()
    Menu.addButton("Vodka (350 €)", "Vodka", nil)
	Menu.addButton("Whisky (350 €)", "Whisky", nil)
	Menu.addButton("Rhum (350 €)", "Rhum", nil)
	Menu.addButton("Tequi-La-La (500 €)", "TequiLaLa", nil)
	Menu.addButton("Vodka-Bull (400 €)", "VodkaBull", nil)
	Menu.addButton("Whisky-Cola (400 €)", "WhiskyCola", nil)
	Menu.addButton("Rhum-Cola (400 €)", "RhumCola", nil)
	Menu.addButton("Tequi-Cola (90 €)", "TequilalaCola", nil)
	Menu.addButton("Tequi-Juice (90 €)", "TequilalaJuice", nil)
	Menu.addButton("Tequi-Coffee (90 €)", "TequilalaCoffee", nil)
	Menu.addButton("Tequi-Tea (90 €)", "TequilalaTea", nil)
	Menu.addButton("Tequi-Limo (90 €)", "TequilalaLimo", nil)
	--Menu.addButton("Whisky (500 €)", "Whisky", nil)
end

------------------------------
--FONCTIONS
-------------------------------
local tequilala_shops = {
	{ ['x'] = -561.815, ['y'] = 288.11, ['z'] = 81.27 },
	{ ['x'] = -565.009, ['y'] = 288.257, ['z'] = 84.57 },
}

Citizen.CreateThread(function()
	for k,v in ipairs(tequilala_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 52)
		SetBlipScale(blip, 0.7)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Tequilala Barman")
		EndTextCommandSetBlipName(blip)
	end
end)

RegisterNetEvent("Vodka")
AddEventHandler("Vodka", function()
    TriggerEvent("player:receiveItem", 101, 1)
	Menu.hidden = false  
end)

function Vodka()
    TriggerServerEvent("Tequilaladrink10")
	Menu.hidden = false
end

RegisterNetEvent("Whisky")
AddEventHandler("Whisky", function()
    TriggerEvent("player:receiveItem", 102, 1)
	Menu.hidden = false  
end)

function Whisky()
    TriggerServerEvent("Tequilaladrink9")
	Menu.hidden = false
end

RegisterNetEvent("Rhum")
AddEventHandler("Rhum", function()
    TriggerEvent("player:receiveItem", 103, 1)
	Menu.hidden = false  
end)

function Rhum()
    TriggerServerEvent("Tequilaladrink11")
	Menu.hidden = false
end

RegisterNetEvent("TequiLaLa")
AddEventHandler("TequiLaLa", function()
    TriggerEvent("player:receiveItem", 104, 1)
	Menu.hidden = false  
end)

function TequiLaLa()
    TriggerServerEvent("Tequilaladrink12")
	Menu.hidden = false
end

RegisterNetEvent("VodkaBull")
AddEventHandler("VodkaBull", function()
    TriggerEvent("player:receiveItem", 105, 1)
	Menu.hidden = false  
end)

function VodkaBull()
    TriggerServerEvent("Tequilaladrink13")
	Menu.hidden = false
end

RegisterNetEvent("WhiskyCola")
AddEventHandler("VodkaBull", function()
    TriggerEvent("player:receiveItem", 106, 1)
	Menu.hidden = false  
end)

function WhiskyCola()
    TriggerServerEvent("Tequilaladrink14")
	Menu.hidden = false
end

RegisterNetEvent("RhumCola")
AddEventHandler("RhumCola", function()
    TriggerEvent("player:receiveItem", 107, 1)
	Menu.hidden = false  
end)

function RhumCola()
    TriggerServerEvent("Tequilaladrink15")
	Menu.hidden = false
end

RegisterNetEvent("TequilalaCola")
AddEventHandler("TequilalaCola", function()
    TriggerEvent("player:receiveItem", 108, 1)
	Menu.hidden = false  
end)

function TequilalaCola()
    TriggerServerEvent("Tequilaladrink16")
	Menu.hidden = false
end

RegisterNetEvent("TequilalaJuice")
AddEventHandler("TequilalaJuice", function()
    TriggerEvent("player:receiveItem", 109, 1)
	Menu.hidden = false  
end)

function TequilalaJuice()
    TriggerServerEvent("Tequilaladrink17")
	Menu.hidden = false
end

RegisterNetEvent("TequilalaCoffee")
AddEventHandler("TequilalaCoffee", function()
    TriggerEvent("player:receiveItem", 110, 1)
	Menu.hidden = false  
end)

function TequilalaCoffee()
    TriggerServerEvent("Tequilaladrink18")
	Menu.hidden = false
end

RegisterNetEvent("TequilalaTea")
AddEventHandler("TequilalaTea", function()
    TriggerEvent("player:receiveItem", 111, 1)
	Menu.hidden = false  
end)

function TequilalaTea()
    TriggerServerEvent("Tequilaladrink19")
	Menu.hidden = false
end

RegisterNetEvent("TequilalaLimo")
AddEventHandler("TequilalaLimo", function()
    TriggerEvent("player:receiveItem", 112, 1)
	Menu.hidden = false  
end)

function TequilalaLimo()
    TriggerServerEvent("Tequilaladrink20")
	Menu.hidden = false
end


-------------------------
---INVENTAIRE
-------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Press F2 to open menu
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(tequilala_shops) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0,0, 0,0)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 2.0)then
					DisplayHelpText("Appuyer sur ~o~F ~w~pour ~o~accéder a la carte des boissons.")
					if IsControlJustPressed(1, 23) then
                        Main()
                        Menu.hidden = not Menu.hidden
				    end
                  Menu.renderGUI(options)
                end
            end
		end
	end
end)
