local holdingup = false
local store = ""
local secondsRemaining = 0

local stores = {
	["braquage_superette_san_andreas_avenue"] = {
		position = { ['x'] = -1220.89, ['y'] = -915.861, ['z'] = 10.826 },
		reward = math.random(1500, 3000),
		nameofstore = "SUPERETTE à SAN ANDREAS AVENUE (ROLS LIQUOR)",
		lastrobbed = 0
	},
	["braquage_superette_vespucci_boulvard"] = {
		position = { ['x'] = 1126.99, ['y'] = -980.134, ['z'] = 45.016 },
		reward = math.random(1500, 3000),
		nameofstore = "SUPERETTE à VESPUCCI BOULVARD (ROLS LIQUOR)",
		lastrobbed = 0
	},
	["braquage_superette_prosperity_street"] = {
		position = { ['x'] = -1478.93, ['y'] = -375.365, ['z'] = 38.663 },
		reward = math.random(1500, 3000),
		nameofstore = "SUPERETTE à PROSPERITY STREET (ROLS LIQUOR)",
		lastrobbed = 0
	},
	["braquage_superette_clinton_avenue"] = {
		position = { ['x'] = 380.29, ['y'] = 332.024, ['z'] = 103.056 },
		reward = math.random(1500, 3000),
		nameofstore = "SUPERETTE à CLINTON AVENUE (247 SUPER MARKET)",
		lastrobbed = 0
	}
}

function Chat(t)
	TriggerEvent("chatMessage", 'HOLDUP', { 0, 255, 255}, "" .. tostring(t))
end

RegisterNetEvent('es_holdup:currentlyrobbing')
AddEventHandler('es_holdup:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
	secondsRemaining = 180
end)

RegisterNetEvent('es_holdup:toofarlocal')
AddEventHandler('es_holdup:toofarlocal', function(robb)
	holdingup = false
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Braquage annulé, tu ne recevras rien !")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('es_holdup:notifycop2')
AddEventHandler('es_holdup:notifycop2', function(text)
	if exports.metiers:getIsInService() == true then 
		SetNotificationTextEntry('STRING')
		AddTextComponentString(text)
		DrawNotification(false, false)
		
	end
end)


RegisterNetEvent('es_holdup:robberycomplete')
AddEventHandler('es_holdup:robberycomplete', function(robb)
	holdingup = false
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Bravo ! tu as gagné: ^2" .. stores[store].reward)
	store = ""
	secondsRemaining = 0
	incircle = false
end)

Citizen.CreateThread(function()
	while true do
		if holdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(stores)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 437)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Braquage de Magasin")
		EndTextCommandSetBlipName(blip)
	end
end)
local incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
					
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText("~INPUT_CONTEXT~ pour cambrioler ~b~" .. v.nameofstore .. "~w~ la police va être prevenue!")
						end
						incircle = true
						if(IsControlJustReleased(1, 51))then
							if exports.metiers:getIsInService() == true then
								DisplayHelpText("Tu es policier tu ne peux pas cambrioler")
								TriggerEvent('chatMessage', "", {0, 255, 0}, "tu es policier tu ne peux pas cambrioler");
							else
								TriggerServerEvent('es_holdup:stestcop',k)
								
							end
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then

			drawTxt(0.66, 1.44, 1.0,1.0,0.4, "Cambriolage : ~r~" .. secondsRemaining .. "~w~ secondes restantes", 255, 255, 255, 255)
			
			local pos2 = stores[store].position
			DrawMarker(1, pos2.x, pos2.y, pos2.z - 1, 0, 0, 0, 0, 0, 0, 10.0, 10.0, 0.2, 1555, 0, 0,255, 0, 0, 0,0)

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 5)then
				TriggerServerEvent('es_holdup:toofar', store)
			end
		end
		Citizen.Wait(0)
	end
end)








function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end