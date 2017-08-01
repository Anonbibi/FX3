--====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================

local Menu = {}
local itemMenuGeneralHcdh = {}
local itemMenuChoixHcdhService = {}
local itemMenuChoixHcdhVehicle = {}

local UrgenceHcdhMenu = {['Title'] = 'Missions en cours',  ['SubMenu'] = {
    ['Title'] = 'Missions en cours', ['Items'] = {
        {['Title'] = 'Retour', ['ReturnBtn'] = true },
        {['Title'] = 'Fermer'},
}}}

function updateMenuHcdh(newUrgenceMenu)
    itemMenuGeneralHcdh.Items[1] = newUrgenceMenu
end

function openMenuHcdhGeneral() 
    Menu.item = itemMenuGeneralHcdh
    Menu.isOpen = true
    Menu.initMenu()
end

function MenuChoixHcdhVehicleCar()
    Menu.item = itemMenuChoixHcdhVehicleCar
    Menu.isOpen = true
    Menu.initMenu()
end

function MenuChoixHcdhVehicleHeli()
    Menu.item = itemMenuChoixHcdhVehicleHeli
    Menu.isOpen = true
    Menu.initMenu()
end

function MenuChoixHcdhService()
    Menu.item = itemMenuChoixHcdhService
    Menu.isOpen = true
    Menu.initMenu()
end


itemMenuGeneralHcdh = {
    ['Title'] = 'Hcdh',
    ['Items'] = {
         UrgenceHcdhMenu,
        --{['Title'] = 'Fouiller', ['Function'] = HCDH_Check},
        --{['Title'] = 'Saisir Argent Sale', ['Function'] = HCDH_Saisir_AS},
        --{['Title'] = 'Saisir Objets Illegaux', ['Function'] = HCDH_Saisir_ITEM},
        --{['Title'] = 'Saisir les armes Illégales', ['Function'] = HCDH_Saisir_NOACHAWEAPONS},
        --{['Title'] = 'Saisir les armes Illégales et confisquer les autres', ['Function'] = HCDH_Saisir_TEMPSWEAPONS},
        --{['Title'] = 'Rendre les armes confisquer', ['Function'] = HCDH_Rendre_WEAPONS},
        --{['Title'] = 'Saisir Toute les armes définitivement', ['Function'] = HCDH_Saisir_ALLWEAPONS},
        --{['Title'] = 'Menoter', ['Function'] = HCDH_Cuffed},
        --{['Title'] = 'Prison',  ['SubMenu'] = {
            -- ['Title'] = 'Prison', 
            -- ['Items'] = {
            --     {['Title'] = '1 Minute', ['Function'] = HCDH_PRISON_DATA, tarif = 60},
            --     {['Title'] = '15 Minutes', ['Function'] = HCDH_PRISON_DATA, tarif = 900},
            --     {['Title'] = '30 Minutes', ['Function'] = HCDH_PRISON_DATA, tarif = 1800},
            --     {['Title'] = '45 Minutes', ['Function'] = HCDH_PRISON_DATA, tarif = 2700},
            --     {['Title'] = '1 Heure', ['Function'] = HCDH_PRISON_DATA, tarif = 3600},
            --     {['Title'] = '1 Heure 30', ['Function'] = HCDH_PRISON_DATA, tarif = 5400},
            --     {['Title'] = '2 Heures', ['Function'] = HCDH_PRISON_DATA, tarif = 7200},
            --     {['Title'] = '3 Heures', ['Function'] = HCDH_PRISON_DATA, tarif = 10800},
            --     {['Title'] = '4 Heures', ['Function'] = HCDH_PRISON_DATA, tarif = 14400},
            -- }
        --}},
        --{['Title'] = 'Placer dans le véhicule', ['Function'] = HCDH_PutInVehicle},
        --{['Title'] = 'Sortir du véhicule', ['Function'] = HCDH_UnseatVehicle},
        --{['Title'] = 'Amendes',  ['SubMenu'] = {
      --       ['Title'] = 'Amendes', 
      --       ['Items'] = {
      --           {['Title'] = 'Code de la Route',  ['SubMenu'] = { 
      --               ['Title'] = 'Délits relatifs à la conduite', 
      --               ['Items'] = {
      --                   {['Title'] = 'Éclairage défectueux', ['Function'] = HCDH_FINE_DATA, tarif = 1000},
						-- {['Title'] = 'Stationnement interdit ou gênant', ['Function'] = HCDH_FINE_DATA, tarif = 2500},
						-- {['Title'] = 'Utilisation abusive du klaxon', ['Function'] = HCDH_FINE_DATA, tarif = 500},
						-- {['Title'] = 'Dégradation de bien public', ['Function'] = HCDH_FINE_DATA, tarif = 3000},
						-- {['Title'] = 'Conduite hors route', ['Function'] = HCDH_FINE_DATA, tarif = 5000},
						-- {['Title'] = 'Conduite dangereuse', ['Function'] = HCDH_FINE_DATA, tarif = 8000},
						-- {['Title'] = 'Conduite sans permis', ['Function'] = HCDH_FINE_DATA, tarif = 20000},
						-- {['Title'] = 'Absence de clignotant', ['Function'] = HCDH_FINE_DATA, tarif = 500},
						-- {['Title'] = 'Franchir une ligne continue', ['Function'] = HCDH_FINE_DATA, tarif = 2000},
						-- {['Title'] = 'Circulation à contre-sens', ['Function'] = HCDH_FINE_DATA, tarif = 3000},
						-- {['Title'] = 'Demi-tour non autorisé', ['Function'] = HCDH_FINE_DATA, tarif = 3000},
						-- {['Title'] = 'Non-respect des distances de sécurité', ['Function'] = HCDH_FINE_DATA, tarif = 1000},
						-- {['Title'] = 'Arrêt dangereux / interdit', ['Function'] = HCDH_FINE_DATA, tarif = 2000},
						-- {['Title'] = 'Refus de priorité', ['Function'] = HCDH_FINE_DATA, tarif = 1500},
						-- {['Title'] = 'Non-respect à un véhicule prioritaire', ['Function'] = HCDH_FINE_DATA, tarif = 2000},
						-- {['Title'] = 'Refus de STOP', ['Function'] = HCDH_FINE_DATA, tarif = 1500},
						-- {['Title'] = 'Refus de feu tricolore', ['Function'] = HCDH_FINE_DATA, tarif = 1500},
						-- {['Title'] = 'Dépassement dangereux', ['Function'] = HCDH_FINE_DATA, tarif = 1500},
						-- {['Title'] = 'Véhicule dégradé', ['Function'] = HCDH_FINE_DATA, tarif = 2000},
						-- {['Title'] = 'Ivresse au volant', ['Function'] = HCDH_FINE_DATA, tarif = 5000},
						-- {['Title'] = 'Non port du casque', ['Function'] = HCDH_FINE_DATA, tarif = 5000},
      --               }
      --           }},
      --           {['Title'] = 'Excès de vitesse',  ['SubMenu'] = { 
      --               ['Title'] = 'Excès de vitesse', 
      --               ['Items'] = {
      --                   {['Title'] = 'Excès < 10km/h', ['Function'] = HCDH_FINE_DATA, tarif = 500},
      --                   {['Title'] = 'Excès > 10km/h', ['Function'] = HCDH_FINE_DATA, tarif = 1000},
      --                   {['Title'] = 'Excès > 20km/h', ['Function'] = HCDH_FINE_DATA, tarif = 2000},
						-- {['Title'] = 'Excès > 50km/h', ['Function'] = HCDH_FINE_DATA, tarif = 7000},
      --               }
      --           }},
      --           {['Title'] = 'Délits relatifs à l ordre public',  ['SubMenu'] = { 
				  --   ['Title'] = 'Délits relatifs à l ordre public', 
      --               ['Items'] = {
      --                   {['Title'] = 'Insulte sur autrui', ['Function'] = HCDH_FINE_DATA, tarif = 1000},
      --                   {['Title'] = 'Trouble à l ordre public', ['Function'] = HCDH_FINE_DATA, tarif = 2000},
      --                   {['Title'] = 'Refus d optempérer', ['Function'] = HCDH_FINE_DATA, tarif = 8000},
						-- {['Title'] = 'Faux témoignage', ['Function'] = HCDH_FINE_DATA, tarif = 4000},
						-- {['Title'] = 'Tentative de vol', ['Function'] = HCDH_FINE_DATA, tarif = 10000},
						-- {['Title'] = 'Vol', ['Function'] = HCDH_FINE_DATA, tarif = 15000},
						-- {['Title'] = 'Vol de véhicule civil', ['Function'] = HCDH_FINE_DATA, tarif = 50000},
						-- {['Title'] = 'Vol de véhicule public', ['Function'] = HCDH_FINE_DATA, tarif = 75000},
						-- {['Title'] = 'Délit de fuite', ['Function'] = HCDH_FINE_DATA, tarif = 15000},
						-- {['Title'] = 'Entrave à enquête', ['Function'] = HCDH_FINE_DATA, tarif = 5000},
						-- {['Title'] = 'Menace ou/et intimidation', ['Function'] = HCDH_FINE_DATA, tarif = 5000},
						-- {['Title'] = 'Manifestation non déclarée', ['Function'] = HCDH_FINE_DATA, tarif = 3000},
						-- {['Title'] = 'Arme blanche sortie', ['Function'] = HCDH_FINE_DATA, tarif = 5000},
						-- {['Title'] = 'Arme léthale sortie', ['Function'] = HCDH_FINE_DATA, tarif = 7000},
						-- {['Title'] = 'Possède une arme sans permis', ['Function'] = HCDH_FINE_DATA, tarif = 8000},
						-- {['Title'] = 'Possède une arme illégale', ['Function'] = HCDH_FINE_DATA, tarif = 10000},
      --               }
      --           }},
		    --     {['Title'] = 'Crimes',  ['SubMenu'] = { 
				  --   ['Title'] = 'Crimes', 
      --               ['Items'] = {
      --                   {['Title'] = 'Tentative de corruption', ['Function'] = HCDH_FINE_DATA, tarif = 35000},
      --                   {['Title'] = 'Possessiion d argent sale', ['Function'] = HCDH_FINE_DATA, tarif = 30000},
						-- {['Title'] = 'Tentative de meurtre', ['Function'] = HCDH_FINE_DATA, tarif = 80000},
						-- {['Title'] = 'Homicide invonlontaire', ['Function'] = HCDH_FINE_DATA, tarif = 50000},
						-- {['Title'] = 'Homicide volontaire', ['Function'] = HCDH_FINE_DATA, tarif = 100000},
						-- {['Title'] = 'Kidnapping', ['Function'] = HCDH_FINE_DATA, tarif = 50000},
						-- {['Title'] = 'Vol à main armée', ['Function'] = HCDH_FINE_DATA, tarif = 45000},
						-- {['Title'] = 'Braquage', ['Function'] = HCDH_FINE_DATA, tarif = 50000},
						-- {['Title'] = 'Evasion de prison', ['Function'] = HCDH_FINE_DATA, tarif = 150000},					
      --               }
      --           }},
		    --     {['Title'] = 'Complicité',  ['SubMenu'] = { 
				  --   ['Title'] = 'Complicité', 
      --               ['Items'] = {
      --                   {['Title'] = 'Complicité de vol', ['Function'] = HCDH_FINE_DATA, tarif = 25000},
      --                   {['Title'] = 'Complicité de meurtre', ['Function'] = HCDH_FINE_DATA, tarif = 100000},	
						-- {['Title'] = 'Complicité d évasion', ['Function'] = HCDH_FINE_DATA, tarif = 90000},	
      --               }
      --           }},
		    --     {['Title'] = 'Stupéfiants',  ['SubMenu'] = { 
				  --   ['Title'] = 'Stupéfiants', 
      --               ['Items'] = {
      --                   {['Title'] = 'Possession de Cannabis >5gr', ['Function'] = HCDH_FINE_DATA, tarif = 10000},
      --                   {['Title'] = 'Récolte', ['Function'] = HCDH_FINE_DATA, tarif = 25000},	
						-- {['Title'] = 'Fabricant', ['Function'] = HCDH_FINE_DATA, tarif = 50000},
						-- {['Title'] = 'Dealer', ['Function'] = HCDH_FINE_DATA, tarif = 75000},			
      --               }
      --           }},
      --           { ['Title'] = 'Amende customisée', ['Function'] = HCDH_FINE_CUSTOM },
      --       }
        --}},
        {['Title'] = 'Crocheter', ['Function'] = HCDH_Crocheter},
        {['Title'] = 'Verifier la plaque', ['Function'] = HCDH_CheckPlate},
		--{['Title'] = 'Placer un Radar', ['Function'] = HCDH_radar},
		{['Title'] = 'Supprimer le Vehicule', ['Function'] = HCDH_deleteVehicle},
	 }
}

itemMenuChoixHcdhVehicleCar = {
    ['Title'] = 'Hcdh - Choix du véhicule',
    ['Items'] = {
        --{['Title'] = 'Voiture service 1', ['Function'] = HCDH_SpanwVehicleCar, type = 'Car', model = 'fbi'},
        --{['Title'] = 'Voiture service 2', ['Function'] = HCDH_SpanwVehicleCar, type = 'Car', model = 'fbi2'},
        --{['Title'] = 'Kuruma Blindé', ['Function'] = HCDH_SpanwVehicleCar, type = 'Car', model = 'kuruma2'},
        --{['Title'] = 'XLS Blindé', ['Function'] = HCDH_SpanwVehicleCar,  type = 'Car', model = 'xls2'},
        --{['Title'] = 'Baller Blindé', ['Function'] = HCDH_SpanwVehicleCar,  type = 'Car', model = 'baller6'},
        {['Title'] = 'Schafter Blindé', ['Function'] = HCDH_SpanwVehicleCar,  type = 'Car', model = 'schafter5'},
        --{['Title'] = 'Limousine', ['Function'] = HCDH_SpanwVehicleCar,  type = 'Car', model = 'stretch'},
    }
}

itemMenuChoixHcdhVehicleHeli = {
    ['Title'] = 'Hcdh - Choix du véhicule',
    ['Items'] = {
        {['Title'] = 'Helicoptère', ['Function'] = HCDH_invokeVehicle, type = 'Chopper', model = 'polmav'},
    }
}

itemMenuChoixHcdhService = {
    ['Title'] = 'Hcdh - Vest',
    ['Items'] = {
        {['Title'] = 'Prendre le service', ['Function'] = takeService},
        --{['Title'] = 'Prendre le service ( Investigation ) ', ['Function'] = takeServiceInvestigation},
        --{['Title'] = 'Mettre le gillet par balles', ['Function'] = equipeVest, type = 'Bulletproof jacket'},
        --{['Title'] = 'Retirer le giller par balles', ['Function'] = equipeVest, type = 'Take offbulletproof jacket'},
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
