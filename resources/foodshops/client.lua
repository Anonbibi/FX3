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

RegisterNetEvent("JambonBeurre")
AddEventHandler("JambonBeurre", function()
    TriggerEvent("player:receiveItem", 30, 1)
	Menu.hidden = false  
end)

function JambonBeurre()
    TriggerServerEvent("Alimentation1")
	Menu.hidden = false
end


RegisterNetEvent("Kebab")
AddEventHandler("Kebab", function()
    TriggerEvent("player:receiveItem", 34, 1)
	Menu.hidden = false  
end)

function Kebab()
    TriggerServerEvent("Alimentation2")
	Menu.hidden = false
end


RegisterNetEvent("Cola")
AddEventHandler("Cola", function()
    TriggerEvent("player:receiveItem", 35, 1)
	Menu.hidden = false  
end)

function Cola()
    TriggerServerEvent("Alimentation3")
	Menu.hidden = false
end


RegisterNetEvent("Eau")
AddEventHandler("Eau", function()
    TriggerEvent("player:receiveItem", 6, 1)
	Menu.hidden = false  
end)

function Eau()
    TriggerServerEvent("Alimentation4")
	Menu.hidden = false
end


RegisterNetEvent("Limonade")
AddEventHandler("Limonade", function()
    TriggerEvent("player:receiveItem", 36, 1)
	Menu.hidden = false  
end)

function Limonade()
    TriggerServerEvent("Alimentation5")
	Menu.hidden = false
end


RegisterNetEvent("Pomme")
AddEventHandler("Pomme", function()
    TriggerEvent("player:receiveItem", 37, 1)
	Menu.hidden = false  
end)

function Pomme()
    TriggerServerEvent("Alimentation6")
	Menu.hidden = false
end


RegisterNetEvent("Orange")
AddEventHandler("Orange", function()
    TriggerEvent("player:receiveItem", 39, 1)
	Menu.hidden = false  
end)

function Orange()
    TriggerServerEvent("Alimentation7")
	Menu.hidden = false
end


RegisterNetEvent("Banane")
AddEventHandler("Banane", function()
    TriggerEvent("player:receiveItem", 40, 1)
	Menu.hidden = false  
end)

function Banane()
    TriggerServerEvent("Alimentation8")
	Menu.hidden = false
end


RegisterNetEvent("Whisky")
AddEventHandler("Whisky", function()
    TriggerEvent("player:receiveItem", 41, 1)
	Menu.hidden = false  
end)

function Whisky()
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
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 2.0)then
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
