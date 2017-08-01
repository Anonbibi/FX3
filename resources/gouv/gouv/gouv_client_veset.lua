local vestgouv = {
	opened = false,
	title = "Agent Locker",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }, -- ???
	menu = {
		x = 0.11,
		y = 0.25,
		width = 0.2,
		height = 0.04,
		buttons = 10,  --Nombre de bouton
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Take your service", description = ""},
				{name = "Break your service", description = ""},
				{name = "Bulletproof jacket", description = ""},
				{name = "Take offbulletproof jacket", description = ""},
				{name = "High-visibility clothing", description = ""},
				{name = "Take off High-visibility clothing", description = ""},
			}
		},
	}
}



local hashSkin = GetHashKey("mp_m_freemode_01")
function giveUniforme()
	Citizen.CreateThread(function()
		TriggerServerEvent("gouv:setService",true)
		if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
			
			SetPedPropIndex(GetPlayerPed(-1), 1, 5, 0, 2)             --Lunette Soleil
			SetPedPropIndex(GetPlayerPed(-1), 2, 0, 0, 2)             --Ecouteur Bluetooh
			
			
		else

			SetPedPropIndex(GetPlayerPed(-1), 1, 11, 3, 2)           --Lunette Soleil
			SetPedPropIndex(GetPlayerPed(-1), 2, 0, 0, 2)            --Ecouteur Bluetooh
		
		end
		
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), 150, true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), 150, true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), 150, true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"), 150, true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 150, true, true)
		Citizen.Wait(500)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"), true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"), true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), true, true)
		
	end)
end

function removeUniforme()
	Citizen.CreateThread(function()
		TriggerServerEvent("gouv:setService",false)
		TriggerServerEvent("skin_customization:SpawnPlayer")
		SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 1, 2)  
		RemoveAllPedWeapons(GetPlayerPed(-1))
	end)
end

function takeService()
    ServiceOn()
    giveUniforme()
    drawNotification("Vous etes en Service")
end

function takeServiceInvestigation()
	ServiceOn()
	TriggerServerEvent("gouv:setService",true)--add by fox
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"), 150, true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 150, true, true)
		Citizen.Wait(500)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), true, true)
	drawNotification("Vous etes en Service")
end

function finishService()
    ServiceOff()
    removeUniforme()                                          
    drawNotification("Service Terminé")
end

RegisterNetEvent('gouv:finishService')
AddEventHandler('gouv:finishService', function()
	ServiceOff()
    removeUniforme()  
end)

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function equipeVest(data)
    local type = data.type
    if type == "Bulletproof jacket" then
        Citizen.CreateThread(function()
            if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
                SetPedComponentVariation(GetPlayerPed(-1), 9, 4, 1, 2)  --Bulletproof jacket
            else
                SetPedComponentVariation(GetPlayerPed(-1), 9, 6, 1, 2)
            end
        end)
    elseif type == "Take offbulletproof jacket" then
        Citizen.CreateThread(function()
            SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 1, 2)  --Remove Bulletproof jacket
        end)
    elseif type == "High-visibility clothing" then
        Citizen.CreateThread(function()
            if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
                SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 0, 2) --High-visibility clothing
            else
                SetPedComponentVariation(GetPlayerPed(-1), 8, 36, 0, 2)
            end
        end)
    elseif type == "Take off High-visibility clothing" then
        Citizen.CreateThread(function()
            if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
                SetPedComponentVariation(GetPlayerPed(-1), 8, 58, 0, 2) --Remove High-visibility clothing + Remet la ceinture
            else
                SetPedComponentVariation(GetPlayerPed(-1), 8, 35, 0, 2)
            end
        end)
    end
end