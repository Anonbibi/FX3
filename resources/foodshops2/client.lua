local options = {
    x = 0.1,
    y = 0.2,
    width = 0.2,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "Magasin",
    menu_subtitle = "Categories",
    color_r = 255,
    color_g = 51,
    color_b = 102,
}

RegisterNetEvent("mp:firstspawn")
AddEventHandler("mp:firstspawn",function()
	Main()
	MainTequilala() -- Menu to draw
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
    options.menu_subtitle = "Selection des Articles"
    ClearMenu()
    Menu.addButton("Jambon Beurre (100 €)", "JambonBeurre", nil)
	Menu.addButton("Kebab (125 €)", "Kebab", nil)
	Menu.addButton("Cola (80 €)", "Cola", nil)
	Menu.addButton("Eau (65 €)", "Eau", nil)
	Menu.addButton("Limonade (70 €)", "Limonade", nil)
	Menu.addButton("Pomme (25 €)", "Pomme", nil)
	Menu.addButton("Orange (25 €)", "Orange", nil)
	Menu.addButton("Banane (25 €)", "Banane", nil)
end

function MainTequilala()
    options.menu_subtitle = "Selection une boisson"
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
local twentyfourseven_shops = {
	{ ['x'] = 1961.1140136719, ['y'] = 3741.4494628906, ['z'] = 32.34375 },
	{ ['x'] = 1392.4129638672, ['y'] = 3604.47265625, ['z'] = 34.980926513672 },
	{ ['x'] = 546.98962402344, ['y'] = 2670.3176269531, ['z'] = 42.156539916992 },
	{ ['x'] = 2556.2534179688, ['y'] = 382.876953125, ['z'] = 108.62294769287 },
	{ ['x'] = -1821.9542236328, ['y'] = 792.40191650391, ['z'] = 138.13920593262 },
	{ ['x'] = 128.1410369873, ['y'] = -1286.1120605469, ['z'] = 29.281036376953 },
	{ ['x'] = -1223.6690673828, ['y'] = -906.67517089844, ['z'] = 12.326356887817 },
	{ ['x'] = -708.19256591797, ['y'] = -914.65264892578, ['z'] = 19.215591430664 },
	{ ['x'] = 26.419162750244, ['y'] = -1347.5804443359, ['z'] = 29.497024536133 },
	{ ['x'] = 1135.67, ['y'] = -982.177, ['z'] = 46.4158 },
	{ ['x'] = -47.124, ['y'] = -1756.52, ['z'] = 29.421 },
	{ ['x'] = -1487.48, ['y'] = -378.918, ['z'] = 40.1634},
	{ ['x'] = 374.208, ['y'] = 328.134, ['z'] = 103.566 },
	{ ['x'] = 2676.99, ['y'] = 3281.37, ['z'] = 55.2412 },
	{ ['x'] = -2967.86, ['y'] = 391.037, ['z'] = 15.0433 },
}

local tequilala_shops = {
	{ ['x'] = -561.815, ['y'] = 288.11, ['z'] = 81.27 },
	{ ['x'] = -565.009, ['y'] = 288.257, ['z'] = 84.57 },
}


Citizen.CreateThread(function()
	for k,v in ipairs(twentyfourseven_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 52)
		SetBlipScale(blip, 0.7)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Magasin d'Alimentation")
		EndTextCommandSetBlipName(blip)
	end
end)

RegisterNetEvent("Vodka")
AddEventHandler("Vodka", function(amount)
    TriggerEvent("player:receiveItem", 101, 1)
    TriggerServerEvent("coffretequ:amendecoffre", amount)
	Menu.hidden = false  
end)

function Vodka()
    TriggerServerEvent("Alimentation10")
	Menu.hidden = false
end

RegisterNetEvent("Whisky")
AddEventHandler("Whisky", function(amount)
    TriggerEvent("player:receiveItem", 102, 1)
    TriggerServerEvent("coffretequ:amendecoffre", amount)
	Menu.hidden = false  
end)

function Whisky()
    TriggerServerEvent("Alimentation9")
	Menu.hidden = false
end

RegisterNetEvent("Rhum")
AddEventHandler("Rhum", function(amount)
    TriggerEvent("player:receiveItem", 103, 1)
    TriggerServerEvent("coffretequ:amendecoffre", amount)
	Menu.hidden = false  
end)

function Rhum()
    TriggerServerEvent("Alimentation11")
	Menu.hidden = false
end

RegisterNetEvent("TequiLaLa")
AddEventHandler("TequiLaLa", function(amount)
    TriggerEvent("player:receiveItem", 104, 1)
    TriggerServerEvent("coffretequ:amendecoffre", amount)
	Menu.hidden = false  
end)

function TequiLaLa()
    TriggerServerEvent("Alimentation12")
	Menu.hidden = false
end

RegisterNetEvent("VodkaBull")
AddEventHandler("VodkaBull", function(amount)
    TriggerEvent("player:receiveItem", 105, 1)
    TriggerServerEvent("coffretequ:amendecoffre", amount)
	Menu.hidden = false  
end)

function VodkaBull()
    TriggerServerEvent("Alimentation13")
	Menu.hidden = false
end

RegisterNetEvent("WhiskyCola")
AddEventHandler("VodkaBull", function(amount)
    TriggerEvent("player:receiveItem", 106, 1)
    TriggerServerEvent("coffretequ:amendecoffre", amount)
	Menu.hidden = false  
end)

function WhiskyCola()
    TriggerServerEvent("Alimentation14")
	Menu.hidden = false
end

RegisterNetEvent("RhumCola")
AddEventHandler("RhumCola", function(amount)
    TriggerEvent("player:receiveItem", 107, 1)
    TriggerServerEvent("coffretequ:amendecoffre", amount)
	Menu.hidden = false  
end)

function RhumCola()
    TriggerServerEvent("Alimentation15")
	Menu.hidden = false
end

RegisterNetEvent("TequilalaCola")
AddEventHandler("TequilalaCola", function(amount)
    TriggerEvent("player:receiveItem", 108, 1)
    TriggerServerEvent("coffretequ:amendecoffre", amount)
	Menu.hidden = false  
end)

function TequilalaCola()
    TriggerServerEvent("Alimentation16")
	Menu.hidden = false
end

RegisterNetEvent("TequilalaJuice")
AddEventHandler("TequilalaJuice", function(amount)
    TriggerEvent("player:receiveItem", 109, 1)
    TriggerServerEvent("coffretequ:amendecoffre", amount)
	Menu.hidden = false  
end)

function TequilalaJuice()
    TriggerServerEvent("Alimentation17")
	Menu.hidden = false
end

RegisterNetEvent("TequilalaCoffee")
AddEventHandler("TequilalaCoffee", function(amount)
    TriggerEvent("player:receiveItem", 110, 1)
    TriggerServerEvent("coffretequ:amendecoffre", amount)
	Menu.hidden = false  
end)

function TequilalaCoffee()
    TriggerServerEvent("Alimentation18")
	Menu.hidden = false
end

RegisterNetEvent("TequilalaTea")
AddEventHandler("TequilalaTea", function(amount)
    TriggerEvent("player:receiveItem", 111, 1)
    TriggerServerEvent("coffretequ:amendecoffre", amount)
	Menu.hidden = false  
end)

function TequilalaTea()
    TriggerServerEvent("Alimentation19")
	Menu.hidden = false
end

RegisterNetEvent("TequilalaLimo")
AddEventHandler("TequilalaLimo", function(amount)
    TriggerEvent("player:receiveItem", 112, 1)
    TriggerServerEvent("coffretequ:amendecoffre", amount)
	Menu.hidden = false  
end)

function TequilalaLimo()
    TriggerServerEvent("Alimentation20")
	Menu.hidden = false
end

RegisterNetEvent("JambonBeurre")
AddEventHandler("JambonBeurre", function(amount)
    TriggerEvent("player:receiveItem", 30, 1)
    TriggerServerEvent("coffregouv:amendecoffre", amount)
	Menu.hidden = false  
end)

function JambonBeurre()
    TriggerServerEvent("Alimentation1")
	Menu.hidden = false
end


RegisterNetEvent("Kebab")
AddEventHandler("Kebab", function(amount)
    TriggerEvent("player:receiveItem", 34, 1)
    TriggerServerEvent("coffregouv:amendecoffre", amount)
	Menu.hidden = false  
end)

function Kebab()
    TriggerServerEvent("Alimentation2")
	Menu.hidden = false
end


RegisterNetEvent("Cola")
AddEventHandler("Cola", function(amount)
    TriggerEvent("player:receiveItem", 35, 1)
    TriggerServerEvent("coffregouv:amendecoffre", amount)
	Menu.hidden = false  
end)

function Cola()
    TriggerServerEvent("Alimentation3")
	Menu.hidden = false
end


RegisterNetEvent("Eau")
AddEventHandler("Eau", function(amount)
    TriggerEvent("player:receiveItem", 6, 1)
    TriggerServerEvent("coffregouv:amendecoffre", amount)
	Menu.hidden = false  
end)

function Eau()
    TriggerServerEvent("Alimentation4")
	Menu.hidden = false
end


RegisterNetEvent("Limonade")
AddEventHandler("Limonade", function(amount)
    TriggerEvent("player:receiveItem", 36, 1)
    TriggerServerEvent("coffregouv:amendecoffre", amount)
	Menu.hidden = false  
end)

function Limonade()
    TriggerServerEvent("Alimentation5")
	Menu.hidden = false
end


RegisterNetEvent("Pomme")
AddEventHandler("Pomme", function(amount)
    TriggerEvent("player:receiveItem", 37, 1)
    TriggerServerEvent("coffregouv:amendecoffre", amount)
	Menu.hidden = false  
end)

function Pomme()
    TriggerServerEvent("Alimentation6")
	Menu.hidden = false
end


RegisterNetEvent("Orange")
AddEventHandler("Orange", function(amount)
    TriggerEvent("player:receiveItem", 39, 1)
    TriggerServerEvent("coffregouv:amendecoffre", amount)
	Menu.hidden = false  
end)

function Orange()
    TriggerServerEvent("Alimentation7")
	Menu.hidden = false
end


RegisterNetEvent("Banane")
AddEventHandler("Banane", function(amount)
    TriggerEvent("player:receiveItem", 40, 1)
    TriggerServerEvent("coffregouv:amendecoffre", amount)
	Menu.hidden = false  
end)

function Banane()
    TriggerServerEvent("Alimentation8")
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
		for k,v in ipairs(twentyfourseven_shops) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0,0, 0,0)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 3.0)then
					DisplayHelpText("Appuyer sur ~o~F ~w~pour ~o~accéder au SuperMarché.")
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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)

		for kk,vv in ipairs(tequilala_shops) do
			if(Vdist(vv.x, vv.y, vv.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(1, vv.x, vv.y, vv.z - 1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0,0, 0,0)
				if(Vdist(vv.x, vv.y, vv.z, pos.x, pos.y, pos.z) < 3.0)then
					DisplayHelpText("Appuyer sur ~o~F ~w~pour ~o~accéder au Bar.")
					if IsControlJustPressed(1, 23) then
                        MainTequilala()
                        Menu.hidden = not Menu.hidden
				    end
                  Menu.renderGUI(options)
                end
            end
		end
	end
end)
