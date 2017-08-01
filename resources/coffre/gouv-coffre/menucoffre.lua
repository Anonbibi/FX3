-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------MENU COFFRE-------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
local menugouv = {
  opened = false,
  title = "Banque Gouvernement",
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
        --{name = "Blanchir de l argent sale", description = ''},
      }
    },
  }
}
-------------------------------------------------
----------------CONFIG SELECTION----------------
-------------------------------------------------
function ButtonSelectedgouv(button)
  local ped = GetPlayerPed(-1)
  local this = menugouv.currentmenu
  local btn = button.name
  if this == "main" then
    if btn == "Gestion" then
      OpenMenugouv('Gestion')
    elseif btn == "Fermer" then
      CloseMenugouv()
    end
  elseif this == "Gestion" then
    if btn == "Voir solde" then
      VoirSoldeGouv()
    elseif btn == "Ajouter un montant" then
      AjouterSoldeGouv()
    elseif btn == "Retirer un montant" then
      RetirerSoldeGouv()
    elseif btn == "Blanchir de l argent sale" then
      BlanchirArgentSaleGouv()
    end
  end
end



-------------------------------------------------
----------------FONCTION COFFRE------------------
-------------------------------------------------

function BlanchirArgentSaleGouv()
  DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
        
    end
    if (GetOnscreenKeyboardResult()) then
      --if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
        TriggerServerEvent('coffregouv:transform',result)
        --end


    end
  
end

function AjouterSoldeGouv()
  DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
        
    end
    if (GetOnscreenKeyboardResult()) then
      --if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
        TriggerServerEvent('coffregouv:ajoutsolde',result)
        --end


    end
  
end

function RetirerSoldeGouv()
  DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
        
    end
    if (GetOnscreenKeyboardResult()) then
      --if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
        TriggerServerEvent('coffregouv:retirersolde',result)
        --end


    end
  
end

function VoirSoldeGouv()

  TriggerServerEvent('coffregouv:getsolde')
end


------------------------------------------------
----------------CONFIG OPEN MENU-----------------
-------------------------------------------------
function OpenMenugouv(menu)
  menugouv.lastmenu = menugouv.currentmenu
  if menu == "Gestion" then
    menugouv.lastmenu = "main"
  end
  menugouv.menu.from = 1
  menugouv.menu.to = 10
  menugouv.selectedbutton = 0
  menugouv.currentmenu = menu
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
local menu = menugouv.menu
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
  local menu = menugouv.menu
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
  local menu = menugouv.menu
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
  local menu = menugouv.menu
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
function BackMenugouv()
  if backlock then
    return
  end
  backlock = true
  if menugouv.currentmenu == "main" then
    CloseMenugouv()
  elseif menugouv.currentmenu == "Gestion"  then
    OpenMenugouv(menugouv.lastmenu)
  else
    OpenMenugouv(menugouv.lastmenu)
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
function OpengouvMenu()
  menugouv.currentmenu = "main"
  menugouv.opened = true
  menugouv.selectedbutton = 0
end
-------------------------------------------------
----------------FONCTION CLOSE-------------------
-------------------------------------------------
function CloseMenugouv()
    menugouv.opened = false
    menugouv.menu.from = 1
    menugouv.menu.to = 10
end
-------------------------------------------------
----------------FONCTION OPEN MENU---------------
-------------------------------------------------
local backlock = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustPressed(1,166) and menugouv.opened == true then
        CloseMenugouv()
    end
    if menugouv.opened then
      local ped = LocalPed()
      local menu = menugouv.menu[menugouv.currentmenu]
      drawTxt(menugouv.title,1,1,menugouv.menu.x,menugouv.menu.y,1.0, 255,255,255,255)
      drawMenuTitle(menu.title, menugouv.menu.x,menugouv.menu.y + 0.08)
      drawTxt(menugouv.selectedbutton.."/"..tablelength(menu.buttons),0,0,menugouv.menu.x + menugouv.menu.width/2 - 0.0385,menugouv.menu.y + 0.067,0.4, 255,255,255,255)
      local y = menugouv.menu.y + 0.12
      buttoncount = tablelength(menu.buttons)
      local selected = false

      for i,button in pairs(menu.buttons) do
        if i >= menugouv.menu.from and i <= menugouv.menu.to then

          if i == menugouv.selectedbutton then
            selected = true
          else
            selected = false
          end
          drawMenuButton(button,menugouv.menu.x,y,selected)
          if button.distance ~= nil then
            drawMenuRight(button.distance.."m",menugouv.menu.x,y,selected)
          end
          y = y + 0.04
          if selected and IsControlJustPressed(1,201) then
            ButtonSelectedgouv(button)
          end
        end
      end
    end
    if menugouv.opened then
      if IsControlJustPressed(1,202) then
        BackMenugouv()
      end
      if IsControlJustReleased(1,202) then
        backlock = false
      end
      if IsControlJustPressed(1,188) then
        if menugouv.selectedbutton > 1 then
          menugouv.selectedbutton = menugouv.selectedbutton -1
          if buttoncount > 10 and menugouv.selectedbutton < menugouv.menu.from then
            menugouv.menu.from = menugouv.menu.from -1
            menugouv.menu.to = menugouv.menu.to - 1
          end
        end
      end
      if IsControlJustPressed(1,187)then
        if menugouv.selectedbutton < buttoncount then
          menugouv.selectedbutton = menugouv.selectedbutton +1
          if buttoncount > 10 and menugouv.selectedbutton > menugouv.menu.to then
            menugouv.menu.to = menugouv.menu.to + 1
            menugouv.menu.from = menugouv.menu.from + 1
          end
        end
      end
    end

  end
end)