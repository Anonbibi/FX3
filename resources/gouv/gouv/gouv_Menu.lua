--====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================

local Menu = {}
local itemMenuGeneralGouv = {}
local itemMenuChoixGouvService = {}
local itemMenuChoixGouvVehicle = {}

local UrgenceGouvMenu = {['Title'] = 'Missions en cours',  ['SubMenu'] = {
    ['Title'] = 'Missions en cours', ['Items'] = {
        {['Title'] = 'Retour', ['ReturnBtn'] = true },
        {['Title'] = 'Fermer'},
}}}

function updateMenuGouv(newUrgenceMenu)
    itemMenuGeneralGouv.Items[1] = newUrgenceMenu
end

function openMenuGouvGeneral() 
    Menu.item = itemMenuGeneralGouv
    Menu.isOpen = true
    Menu.initMenu()
end

function MenuChoixGouvVehicleCar()
    Menu.item = itemMenuChoixGouvVehicleCar
    Menu.isOpen = true
    Menu.initMenu()
end

function MenuChoixGouvVehicleHeli()
    Menu.item = itemMenuChoixGouvVehicleHeli
    Menu.isOpen = true
    Menu.initMenu()
end

function MenuChoixGouvService()
    Menu.item = itemMenuChoixGouvService
    Menu.isOpen = true
    Menu.initMenu()
end


itemMenuGeneralGouv = {
    ['Title'] = 'Gouv',
    ['Items'] = {
         UrgenceGouvMenu,
        {['Title'] = 'Fouiller', ['Function'] = GOUV_Check},
        --{['Title'] = 'Saisir Argent Sale', ['Function'] = GOUV_Saisir_AS},
        --{['Title'] = 'Saisir Objets Illegaux', ['Function'] = GOUV_Saisir_ITEM},
        {['Title'] = 'Saisir les armes Illégales', ['Function'] = GOUV_Saisir_NOACHAWEAPONS},
        {['Title'] = 'Saisir les armes Illégales et confisquer les autres', ['Function'] = GOUV_Saisir_TEMPSWEAPONS},
        {['Title'] = 'Rendre les armes confisquer', ['Function'] = GOUV_Rendre_WEAPONS},
        {['Title'] = 'Saisir Toute les armes définitivement', ['Function'] = GOUV_Saisir_ALLWEAPONS},
        {['Title'] = 'Menoter', ['Function'] = GOUV_Cuffed},
        --{['Title'] = 'Prison',  ['SubMenu'] = {
            -- ['Title'] = 'Prison', 
            -- ['Items'] = {
            --     {['Title'] = '1 Minute', ['Function'] = GOUV_PRISON_DATA, tarif = 60},
            --     {['Title'] = '15 Minutes', ['Function'] = GOUV_PRISON_DATA, tarif = 900},
            --     {['Title'] = '30 Minutes', ['Function'] = GOUV_PRISON_DATA, tarif = 1800},
            --     {['Title'] = '45 Minutes', ['Function'] = GOUV_PRISON_DATA, tarif = 2700},
            --     {['Title'] = '1 Heure', ['Function'] = GOUV_PRISON_DATA, tarif = 3600},
            --     {['Title'] = '1 Heure 30', ['Function'] = GOUV_PRISON_DATA, tarif = 5400},
            --     {['Title'] = '2 Heures', ['Function'] = GOUV_PRISON_DATA, tarif = 7200},
            --     {['Title'] = '3 Heures', ['Function'] = GOUV_PRISON_DATA, tarif = 10800},
            --     {['Title'] = '4 Heures', ['Function'] = GOUV_PRISON_DATA, tarif = 14400},
            -- }
        --}},
        {['Title'] = 'Placer dans le véhicule', ['Function'] = GOUV_PutInVehicle},
        {['Title'] = 'Sortir du véhicule', ['Function'] = GOUV_UnseatVehicle},
        --{['Title'] = 'Amendes',  ['SubMenu'] = {
      --       ['Title'] = 'Amendes', 
      --       ['Items'] = {
      --           {['Title'] = 'Code de la Route',  ['SubMenu'] = { 
      --               ['Title'] = 'Délits relatifs à la conduite', 
      --               ['Items'] = {
      --                   {['Title'] = 'Éclairage défectueux', ['Function'] = GOUV_FINE_DATA, tarif = 1000},
						-- {['Title'] = 'Stationnement interdit ou gênant', ['Function'] = GOUV_FINE_DATA, tarif = 2500},
						-- {['Title'] = 'Utilisation abusive du klaxon', ['Function'] = GOUV_FINE_DATA, tarif = 500},
						-- {['Title'] = 'Dégradation de bien public', ['Function'] = GOUV_FINE_DATA, tarif = 3000},
						-- {['Title'] = 'Conduite hors route', ['Function'] = GOUV_FINE_DATA, tarif = 5000},
						-- {['Title'] = 'Conduite dangereuse', ['Function'] = GOUV_FINE_DATA, tarif = 8000},
						-- {['Title'] = 'Conduite sans permis', ['Function'] = GOUV_FINE_DATA, tarif = 20000},
						-- {['Title'] = 'Absence de clignotant', ['Function'] = GOUV_FINE_DATA, tarif = 500},
						-- {['Title'] = 'Franchir une ligne continue', ['Function'] = GOUV_FINE_DATA, tarif = 2000},
						-- {['Title'] = 'Circulation à contre-sens', ['Function'] = GOUV_FINE_DATA, tarif = 3000},
						-- {['Title'] = 'Demi-tour non autorisé', ['Function'] = GOUV_FINE_DATA, tarif = 3000},
						-- {['Title'] = 'Non-respect des distances de sécurité', ['Function'] = GOUV_FINE_DATA, tarif = 1000},
						-- {['Title'] = 'Arrêt dangereux / interdit', ['Function'] = GOUV_FINE_DATA, tarif = 2000},
						-- {['Title'] = 'Refus de priorité', ['Function'] = GOUV_FINE_DATA, tarif = 1500},
						-- {['Title'] = 'Non-respect à un véhicule prioritaire', ['Function'] = GOUV_FINE_DATA, tarif = 2000},
						-- {['Title'] = 'Refus de STOP', ['Function'] = GOUV_FINE_DATA, tarif = 1500},
						-- {['Title'] = 'Refus de feu tricolore', ['Function'] = GOUV_FINE_DATA, tarif = 1500},
						-- {['Title'] = 'Dépassement dangereux', ['Function'] = GOUV_FINE_DATA, tarif = 1500},
						-- {['Title'] = 'Véhicule dégradé', ['Function'] = GOUV_FINE_DATA, tarif = 2000},
						-- {['Title'] = 'Ivresse au volant', ['Function'] = GOUV_FINE_DATA, tarif = 5000},
						-- {['Title'] = 'Non port du casque', ['Function'] = GOUV_FINE_DATA, tarif = 5000},
      --               }
      --           }},
      --           {['Title'] = 'Excès de vitesse',  ['SubMenu'] = { 
      --               ['Title'] = 'Excès de vitesse', 
      --               ['Items'] = {
      --                   {['Title'] = 'Excès < 10km/h', ['Function'] = GOUV_FINE_DATA, tarif = 500},
      --                   {['Title'] = 'Excès > 10km/h', ['Function'] = GOUV_FINE_DATA, tarif = 1000},
      --                   {['Title'] = 'Excès > 20km/h', ['Function'] = GOUV_FINE_DATA, tarif = 2000},
						-- {['Title'] = 'Excès > 50km/h', ['Function'] = GOUV_FINE_DATA, tarif = 7000},
      --               }
      --           }},
      --           {['Title'] = 'Délits relatifs à l ordre public',  ['SubMenu'] = { 
				  --   ['Title'] = 'Délits relatifs à l ordre public', 
      --               ['Items'] = {
      --                   {['Title'] = 'Insulte sur autrui', ['Function'] = GOUV_FINE_DATA, tarif = 1000},
      --                   {['Title'] = 'Trouble à l ordre public', ['Function'] = GOUV_FINE_DATA, tarif = 2000},
      --                   {['Title'] = 'Refus d optempérer', ['Function'] = GOUV_FINE_DATA, tarif = 8000},
						-- {['Title'] = 'Faux témoignage', ['Function'] = GOUV_FINE_DATA, tarif = 4000},
						-- {['Title'] = 'Tentative de vol', ['Function'] = GOUV_FINE_DATA, tarif = 10000},
						-- {['Title'] = 'Vol', ['Function'] = GOUV_FINE_DATA, tarif = 15000},
						-- {['Title'] = 'Vol de véhicule civil', ['Function'] = GOUV_FINE_DATA, tarif = 50000},
						-- {['Title'] = 'Vol de véhicule public', ['Function'] = GOUV_FINE_DATA, tarif = 75000},
						-- {['Title'] = 'Délit de fuite', ['Function'] = GOUV_FINE_DATA, tarif = 15000},
						-- {['Title'] = 'Entrave à enquête', ['Function'] = GOUV_FINE_DATA, tarif = 5000},
						-- {['Title'] = 'Menace ou/et intimidation', ['Function'] = GOUV_FINE_DATA, tarif = 5000},
						-- {['Title'] = 'Manifestation non déclarée', ['Function'] = GOUV_FINE_DATA, tarif = 3000},
						-- {['Title'] = 'Arme blanche sortie', ['Function'] = GOUV_FINE_DATA, tarif = 5000},
						-- {['Title'] = 'Arme léthale sortie', ['Function'] = GOUV_FINE_DATA, tarif = 7000},
						-- {['Title'] = 'Possède une arme sans permis', ['Function'] = GOUV_FINE_DATA, tarif = 8000},
						-- {['Title'] = 'Possède une arme illégale', ['Function'] = GOUV_FINE_DATA, tarif = 10000},
      --               }
      --           }},
		    --     {['Title'] = 'Crimes',  ['SubMenu'] = { 
				  --   ['Title'] = 'Crimes', 
      --               ['Items'] = {
      --                   {['Title'] = 'Tentative de corruption', ['Function'] = GOUV_FINE_DATA, tarif = 35000},
      --                   {['Title'] = 'Possessiion d argent sale', ['Function'] = GOUV_FINE_DATA, tarif = 30000},
						-- {['Title'] = 'Tentative de meurtre', ['Function'] = GOUV_FINE_DATA, tarif = 80000},
						-- {['Title'] = 'Homicide invonlontaire', ['Function'] = GOUV_FINE_DATA, tarif = 50000},
						-- {['Title'] = 'Homicide volontaire', ['Function'] = GOUV_FINE_DATA, tarif = 100000},
						-- {['Title'] = 'Kidnapping', ['Function'] = GOUV_FINE_DATA, tarif = 50000},
						-- {['Title'] = 'Vol à main armée', ['Function'] = GOUV_FINE_DATA, tarif = 45000},
						-- {['Title'] = 'Braquage', ['Function'] = GOUV_FINE_DATA, tarif = 50000},
						-- {['Title'] = 'Evasion de prison', ['Function'] = GOUV_FINE_DATA, tarif = 150000},					
      --               }
      --           }},
		    --     {['Title'] = 'Complicité',  ['SubMenu'] = { 
				  --   ['Title'] = 'Complicité', 
      --               ['Items'] = {
      --                   {['Title'] = 'Complicité de vol', ['Function'] = GOUV_FINE_DATA, tarif = 25000},
      --                   {['Title'] = 'Complicité de meurtre', ['Function'] = GOUV_FINE_DATA, tarif = 100000},	
						-- {['Title'] = 'Complicité d évasion', ['Function'] = GOUV_FINE_DATA, tarif = 90000},	
      --               }
      --           }},
		    --     {['Title'] = 'Stupéfiants',  ['SubMenu'] = { 
				  --   ['Title'] = 'Stupéfiants', 
      --               ['Items'] = {
      --                   {['Title'] = 'Possession de Cannabis >5gr', ['Function'] = GOUV_FINE_DATA, tarif = 10000},
      --                   {['Title'] = 'Récolte', ['Function'] = GOUV_FINE_DATA, tarif = 25000},	
						-- {['Title'] = 'Fabricant', ['Function'] = GOUV_FINE_DATA, tarif = 50000},
						-- {['Title'] = 'Dealer', ['Function'] = GOUV_FINE_DATA, tarif = 75000},			
      --               }
      --           }},
      --           { ['Title'] = 'Amende customisée', ['Function'] = GOUV_FINE_CUSTOM },
      --       }
        --}},
        {['Title'] = 'Crocheter', ['Function'] = GOUV_Crocheter},
        {['Title'] = 'Verifier la plaque', ['Function'] = GOUV_CheckPlate},
		--{['Title'] = 'Placer un Radar', ['Function'] = GOUV_radar},
		{['Title'] = 'Supprimer le Vehicule', ['Function'] = GOUV_deleteVehicle},
	 }
}

itemMenuChoixGouvVehicleCar = {
    ['Title'] = 'Gouv - Choix du véhicule',
    ['Items'] = {
        {['Title'] = 'Voiture service 1', ['Function'] = GOUV_SpanwVehicleCar, type = 'Car', model = 'fbi'},
        {['Title'] = 'Voiture service 2', ['Function'] = GOUV_SpanwVehicleCar, type = 'Car', model = 'fbi2'},
        {['Title'] = 'Kuruma Blindé', ['Function'] = GOUV_SpanwVehicleCar, type = 'Car', model = 'kuruma2'},
        {['Title'] = 'XLS Blindé', ['Function'] = GOUV_SpanwVehicleCar,  type = 'Car', model = 'xls2'},
        {['Title'] = 'Baller Blindé', ['Function'] = GOUV_SpanwVehicleCar,  type = 'Car', model = 'baller6'},
        {['Title'] = 'Schafter Blindé', ['Function'] = GOUV_SpanwVehicleCar,  type = 'Car', model = 'schafter5'},
        {['Title'] = 'Limousine', ['Function'] = GOUV_SpanwVehicleCar,  type = 'Car', model = 'stretch'},
    }
}

itemMenuChoixGouvVehicleHeli = {
    ['Title'] = 'Gouv - Choix du véhicule',
    ['Items'] = {
        {['Title'] = 'Helicoptère', ['Function'] = GOUV_invokeVehicle, type = 'Chopper', model = 'polmav'},
    }
}

itemMenuChoixGouvService = {
    ['Title'] = 'Gouv - Vest',
    ['Items'] = {
        {['Title'] = 'Prendre le service', ['Function'] = takeService},
        {['Title'] = 'Prendre le service ( Investigation ) ', ['Function'] = takeServiceInvestigation},
        {['Title'] = 'Mettre le gillet par balles', ['Function'] = equipeVest, type = 'Bulletproof jacket'},
        {['Title'] = 'Retirer le giller par balles', ['Function'] = equipeVest, type = 'Take offbulletproof jacket'},
        {['Title'] = 'Quitter le service', ['Function'] = finishService},
    }
}

--====================================================================================
--  Option Menu
--====================================================================================
Menu.backgroundColor = { 52, 73, 94, 196 }
Menu.backgroundColorActive = {243, 156, 18, 255}
Menu.tileTextColor = {243, 156, 18, 255}
Menu.tileBackgroundColor = { 255,255,255, 255 }
Menu.textColor = { 255,255,255,255 }
Menu.textColorActive = { 255,255,255, 255 }

Menu.keyOpenMenu = 167 -- N+
Menu.keyUp = 172 -- PhoneUp
Menu.keyDown = 173 -- PhoneDown
Menu.keyLeft = 174 -- PhoneLeft || Not use next release Maybe 
Menu.keyRight =	175 -- PhoneRigth || Not use next release Maybe 
Menu.keySelect = 176 -- PhoneSelect
Menu.KeyCancel = 177 -- PhoneCancel
Menu.IgnoreNextKey = false
Menu.posX = 0.05
Menu.posY = 0.05

Menu.ItemWidth = 0.20
Menu.ItemHeight = 0.03

Menu.isOpen = false   -- /!\ Ne pas toucher
Menu.currentPos = {1} -- /!\ Ne pas toucher

--====================================================================================
--  Menu System
--====================================================================================

function Menu.drawRect(posX, posY, width, heigh, color)
    DrawRect(posX + width / 2, posY + heigh / 2, width, heigh, color[1], color[2], color[3], color[4])
end

function Menu.initText(textColor, font, scale)
    font = font or 0
    scale = scale or 0.35
    SetTextFont(font)
    SetTextScale(0.0,scale)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextEntry("STRING")
end

function Menu.draw() 
    -- Draw Rect
    local pos = 0
    local menu = Menu.getCurrentMenu()
    local selectValue = Menu.currentPos[#Menu.currentPos]
    local nbItem = #menu.Items
    -- draw background title & title
    Menu.drawRect(Menu.posX, Menu.posY , Menu.ItemWidth, Menu.ItemHeight * 2, Menu.tileBackgroundColor)    
    Menu.initText(Menu.tileTextColor, 4, 0.7)
    AddTextComponentString(menu.Title)
    DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY)

    -- draw bakcground items
    Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * 2, Menu.ItemWidth, Menu.ItemHeight + (nbItem-1)*Menu.ItemHeight, Menu.backgroundColor)
    -- draw all items
    for pos, value in pairs(menu.Items) do
        if pos == selectValue then
            Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * (1+pos), Menu.ItemWidth, Menu.ItemHeight, Menu.backgroundColorActive)
            Menu.initText(Menu.textColorActive)
        else
            Menu.initText(value.TextColor or Menu.textColor)
        end
        AddTextComponentString(value.Title)
        DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY + Menu.ItemHeight * (pos+1))
    end
    
end

function Menu.getCurrentMenu()
    local currentMenu = Menu.item
    for i=1, #Menu.currentPos - 1 do
        local val = Menu.currentPos[i]
        currentMenu = currentMenu.Items[val].SubMenu
    end
    return currentMenu
end

function Menu.initMenu()
    Menu.currentPos = {1}
    Menu.IgnoreNextKey = true 
end

function Menu.keyControl()
    if Menu.IgnoreNextKey == true then
        Menu.IgnoreNextKey = false 
        return
    end
    if IsControlJustPressed(1, Menu.keyDown) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = (Menu.currentPos[slcp] % size) + 1

    elseif IsControlJustPressed(1, Menu.keyUp) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = ((Menu.currentPos[slcp] - 2 + size) % size) + 1

    elseif IsControlJustPressed(1, Menu.KeyCancel) then 
        table.remove(Menu.currentPos)
        if #Menu.currentPos == 0 then
            Menu.isOpen = false 
        end

    elseif IsControlJustPressed(1, Menu.keySelect)  then
        local cSelect = Menu.currentPos[#Menu.currentPos]
        local cMenu = Menu.getCurrentMenu()
        if cMenu.Items[cSelect].SubMenu ~= nil then
            Menu.currentPos[#Menu.currentPos + 1] = 1
        else
            if cMenu.Items[cSelect].ReturnBtn == true then
                table.remove(Menu.currentPos)
                if #Menu.currentPos == 0 then
                    Menu.isOpen = false 
                end
            else
                if cMenu.Items[cSelect].Function ~= nil then
                    cMenu.Items[cSelect].Function(cMenu.Items[cSelect])
                end
                if cMenu.Items[cSelect].Event ~= nil then
                    TriggerEvent(cMenu.Items[cSelect].Event, cMenu.Items[cSelect])
                end
                if cMenu.Items[cSelect].Close == nil or cMenu.Items[cSelect].Close == true then
                    Menu.isOpen = false
                end
            end
        end
    end

end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        if IsControlJustPressed(1, Menu.keyOpenMenu) then
            Menu.isOpen = false
        end
        if Menu.isOpen then
            Menu.draw()
            Menu.keyControl()
        end
	end
end)
