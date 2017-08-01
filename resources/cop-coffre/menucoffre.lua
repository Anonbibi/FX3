-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------MENU COFFRE-------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
local menufbi = {
	opened = false,
	title = "Banque LSPD",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.11,
		y = 0.25,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "GESTION",
			name = "main",
			buttons = {
				{name = "Gestion", description = ""},
				{name = "Fermer", description = ""},
			}
		},
		["Gestion"] = {
			title = "GESTION",
			name = "Gestion",
			buttons = {
				{name = "Voir solde", description = ''},
				{name = "Ajouter un montant", description = ''},
				{name = "Retirer un montant", description = ''},
			}
		},
	}
}
-------------------------------------------------
----------------CONFIG SELECTION----------------
-------------------------------------------------
function ButtonSelectedfbi(button)
	local ped = GetPlayerPed(-1)
	local this = menufbi.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Gestion" then
			OpenMenufbi('Gestion')
		elseif btn == "Fermer" then
			CloseMenufbi()
		end
	elseif this == "Gestion" then
		if btn == "Voir solde" then
			VoirSolde()
		elseif btn == "Ajouter un montant" then
			AjouterSolde()
		elseif btn == "Retirer un montant" then
			RetirerSolde()
		end
	end
end



-------------------------------------------------
----------------FONCTION COFFRE------------------
-------------------------------------------------



function AjouterSolde()
	DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
        
    end
    if (GetOnscreenKeyboardResult()) then
    	--if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
       	TriggerServerEvent('coffrelspd:ajoutsolde',result)
       	--end


    end
	
end


function RetirerSolde()
	DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
        
    end
    if (GetOnscreenKeyboardResult()) then
    	--if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
       	TriggerServerEvent('coffrelspd:retirersolde',result)
       	--end


    end
	
end




function VoirSolde()

	TriggerServerEvent('coffrelspd:getsolde')
end






------------------------------------------------
----------------CONFIG OPEN MENU-----------------
-------------------------------------------------
function OpenMenufbi(menu)
	menufbi.lastmenu = menufbi.currentmenu
	if menu == "Gestion" then
		menufbi.lastmenu = "main"
	end
	menufbi.menu.from = 1
	menufbi.menu.to = 10
	menufbi.selectedbutton = 0
	menufbi.currentmenu = menu
end
-------------------------------------------------
------------------DRAW NOTIFY--------------------
-------------------------------------------------
function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
--------------------------------------
-------------DISPLAY HELP TEXT--------
--------------------------------------
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
-------------------------------------------------
------------------DRAW TITLE MENU----------------
-------------------------------------------------
function drawMenuTitle(txt,x,y)
local menu = menufbi.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end
-------------------------------------------------
------------------DRAW MENU BOUTON---------------
-------------------------------------------------
function drawMenuButton(button,x,y,selected)
	local menu = menufbi.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end
-------------------------------------------------
------------------DRAW MENU INFO-----------------
-------------------------------------------------
function drawMenuInfo(text)
	local menu = menufbi.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
	DrawText(0.365, 0.934)
end
-------------------------------------------------
----------------DRAW MENU DROIT------------------
-------------------------------------------------
function drawMenuRight(txt,x,y,selected)
	local menu = menufbi.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end
-------------------------------------------------
-------------------DRAW TEXT---------------------
-------------------------------------------------
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
-------------------------------------------------
----------------CONFIG BACK MENU-----------------
-------------------------------------------------
function BackMenufbi()
	if backlock then
		return
	end
	backlock = true
	if menufbi.currentmenu == "main" then
		CloseMenufbi()
	elseif menufbi.currentmenu == "Gestion"  then
		OpenMenufbi(menufbi.lastmenu)
	else
		OpenMenufbi(menufbi.lastmenu)
	end
end
-------------------------------------------------
---------------------FONCTION--------------------
-------------------------------------------------
function f(n)
return n + 0.0001
end

function LocalPed()
return GetPlayerPed(-1)
end

function try(f, catch_f)
local status, exception = pcall(f)
if not status then
catch_f(exception)
end
end
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end
-------------------------------------------------
----------------FONCTION OPEN--------------------
-------------------------------------------------
function OpenfbiMenu()
	menufbi.currentmenu = "main"
	menufbi.opened = true
	menufbi.selectedbutton = 0
end
-------------------------------------------------
----------------FONCTION CLOSE-------------------
-------------------------------------------------
function CloseMenufbi()
		menufbi.opened = false
		menufbi.menu.from = 1
		menufbi.menu.to = 10
end
-------------------------------------------------
----------------FONCTION OPEN MENU---------------
-------------------------------------------------
local backlock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,166) and menufbi.opened == true then
				CloseMenufbi()
		end
		if menufbi.opened then
			local ped = LocalPed()
			local menu = menufbi.menu[menufbi.currentmenu]
			drawTxt(menufbi.title,1,1,menufbi.menu.x,menufbi.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, menufbi.menu.x,menufbi.menu.y + 0.08)
			drawTxt(menufbi.selectedbutton.."/"..tablelength(menu.buttons),0,0,menufbi.menu.x + menufbi.menu.width/2 - 0.0385,menufbi.menu.y + 0.067,0.4, 255,255,255,255)
			local y = menufbi.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= menufbi.menu.from and i <= menufbi.menu.to then

					if i == menufbi.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,menufbi.menu.x,y,selected)
					if button.distance ~= nil then
						drawMenuRight(button.distance.."m",menufbi.menu.x,y,selected)
					end
					y = y + 0.04
					if selected and IsControlJustPressed(1,201) then
						ButtonSelectedfbi(button)
					end
				end
			end
		end
		if menufbi.opened then
			if IsControlJustPressed(1,202) then
				BackMenufbi()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if menufbi.selectedbutton > 1 then
					menufbi.selectedbutton = menufbi.selectedbutton -1
					if buttoncount > 10 and menufbi.selectedbutton < menufbi.menu.from then
						menufbi.menu.from = menufbi.menu.from -1
						menufbi.menu.to = menufbi.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if menufbi.selectedbutton < buttoncount then
					menufbi.selectedbutton = menufbi.selectedbutton +1
					if buttoncount > 10 and menufbi.selectedbutton > menufbi.menu.to then
						menufbi.menu.to = menufbi.menu.to + 1
						menufbi.menu.from = menufbi.menu.from + 1
					end
				end
			end
		end

	end
end)