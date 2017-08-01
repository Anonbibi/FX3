

-- Position de l icone et du marker dans le jeu
local xloc = 1201.31
local yloc = -3189.44
local zloc = 6.0280 - 1
local xlocinside = xloc - 13
local ylocinside = yloc + 15
local zlocinside = zloc + 0.2
local xlocoutside = xloc + 2
local ylocoutside = yloc + 12
local zlocoutside = zloc
local startmine_locations = {
	{entering = {xloc,yloc,zloc}, inside = {xlocinside,ylocinside,zlocinside, 120.1953}, outside = {xlocoutside,ylocoutside,zlocoutside,322.345}},
}



-- Distance de vue du marker
local distanceviewmarker = 15

-- reglage des touches
local controllkeyvalid = 201

-- Text action
local helpactiontext = 'Appuyez sur ENTREE pour avoir votre camion'


local startmine_blips ={}
local inrangeofstartmine = false
local currentlocation = nil

-- temps de farm
local timefarm = 600000

--
local blipsnum =  67
local blipstext = 'Dépot Miner'


local function LocalPed()
	return GetPlayerPed(-1)
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




local firstspawn = 0
	AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		
    			ShowStartmineBlips(true)
    		
		
		firstspawn = 1
	end
end)

function IsPlayerInRangeOfStartmine()
	return inrangeofstartmine
end

function ShowStartmineBlips(bool)
	if bool and #startmine_blips == 0 then
		for station,pos in pairs(startmine_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,blipsnum)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(blipstext)
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(startmine_blips, {blip = blip, pos = loc})
		end
		Citizen.CreateThread(function()
			while #startmine_blips > 0 do
				Citizen.Wait(0)
				local inrange = false
				for i,b in ipairs(startmine_blips) do
					if IsPlayerWantedLevelGreater(GetPlayerIndex(),0) == false and IsPedInAnyVehicle(LocalPed(), true) == false and  GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(LocalPed())) < distanceviewmarker then
						DrawMarker(1,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],0,0,0,0,0,0,6.001,6.001,1.001,0,155,255,200,0,0,0,0)
						drawTxt(helpactiontext,0,1,0.5,0.8,0.6,255,255,255,255)
						currentlocation = b
						inrange = true	
					end
				end
				inrangeofstartmine = inrange
				if IsControlJustPressed(1,controllkeyvalid)  and (inrangeofstartmine == true) then

					local myPed = GetPlayerPed(-1)
					local player = PlayerId()
					local vehicle = GetHashKey('tiptruck')

					RequestModel(vehicle)

					while not HasModelLoaded(vehicle) do
						Wait(1)
					end

					local plate = math.random(100, 900)
					local spawned_car = CreateVehicle(vehicle,xloc,yloc,zloc, math.random(), true, false)

					SetVehicleOnGroundProperly(spawned_car)
					SetVehicleNumberPlateText(spawned_car, "MINE")
					SetModelAsNoLongerNeeded(vehicle)
					Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
					Citizen.Wait(600000)
  				
				end
			end	
		end)
	elseif bool == false and #startmine_blips > 0 then
		for i,b in ipairs(startmine_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		startmine_blips = {}
	end
end


function LocalPed()
	return GetPlayerPed(-1)
end




