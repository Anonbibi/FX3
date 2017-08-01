--====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================





--===================================================================================================================================================--
--                Build Menu -- playAmination = joue l'aniamtion une fois et playAminationLoop pour jouer l'animation en boucle.                     -- 
-- site des emotes = http://docs.ragepluginhook.net/html/62951c37-a440-478c-b389-c471230ddfc5.htm#amb@code_human_wander_idles_cop@male@staticSection --
--===================================================================================================================================================--
local KeyOpenJobsMenu = 166 -- F5
local currentJobs = ''
local hasMenuJob = false
local nameJobPolice = ''
RegisterNetEvent('metiers:updateJob')
AddEventHandler('metiers:updateJob', function(nameJob)
    if hasMenuJob then
        table.remove(Menu.item.Items, 1)
    end
    hasMenuJob = false

    if nameJob == 'Policier' or
       nameJob == '[LSPD] Recrue' or
       nameJob == '[LSPD] Brigadier' or
       nameJob == '[LSPD] Brigadier-Chef' or
       nameJob == '[LSPD] Sergent' or
       nameJob == '[LSPD] Sergent-Chef' or
       nameJob == '[LSPD] Lieutenant' or
       nameJob == '[LSPD] Lieutenant-Chef' or
       nameJob == '[LSPD] Capitaine' or
       nameJob == '[LSPD] Commandant' then

       nameJobPolice = 'Policier'

       table.insert(Menu.item.Items, 1, {['Title'] = 'Menu ' .. nameJobPolice, ['Function'] = openMenuJobs } )
       hasMenuJob = true
       --Citizen.Trace('-----------------------')
    end
    if nameJob == '[GOUV] Agent' then

       nameJobGouv = 'Agent'

       table.insert(Menu.item.Items, 1, {['Title'] = 'Menu ' .. nameJobGouv, ['Function'] = openMenuJobs } )
       hasMenuJob = true
       --Citizen.Trace('-----------------------')
    end

    if nameJob == '[HCDH] Representent' then

       nameJobHcdh = 'Representent'

       table.insert(Menu.item.Items, 1, {['Title'] = 'Menu ' .. nameJobHcdh, ['Function'] = openMenuJobs } )
       hasMenuJob = true
       --Citizen.Trace('-----------------------')
    end

    if nameJob == '[BOSS] Garage Carreno' then

       nameJobMeca = 'Mecano'

       table.insert(Menu.item.Items, 1, {['Title'] = 'Menu ' .. nameJobMeca, ['Function'] = openMenuJobs } )
       hasMenuJob = true
       --Citizen.Trace('-----------------------')
    end

    if nameJob == '[BOSS] Eco Taxi' then

       nameJobTaxi = 'Taxi'

       table.insert(Menu.item.Items, 1, {['Title'] = 'Menu ' .. nameJobTaxi, ['Function'] = openMenuJobs } )
       hasMenuJob = true
       --Citizen.Trace('-----------------------')
    end

    if nameJob == 'Ambulancier' or 
       nameJob == 'Taxi' or 
       nameJob == 'Mecano' then
       table.insert(Menu.item.Items, 1, {['Title'] = 'Menu ' .. nameJob, ['Function'] = openMenuJobs } )
       hasMenuJob = true
       --Citizen.Trace('-----------------------')
    end
    if nameJob == 'Policier' or
       nameJob == '[LSPD] Recrue' or
       nameJob == '[LSPD] Brigadier' or
       nameJob == '[LSPD] Brigadier-Chef' or
       nameJob == '[LSPD] Sergent' or
       nameJob == '[LSPD] Sergent-Chef' or
       nameJob == '[LSPD] Lieutenant' or
       nameJob == '[LSPD] Lieutenant-Chef' or
       nameJob == '[LSPD] Capitaine' or       
       nameJob == '[LSPD] Commandant' then
       currentJobs = 'police'

    elseif nameJob == '[GOUV] Agent' then
        currentJobs = 'gouv'

    elseif nameJob == '[HCDH] Representent' then
        currentJobs = 'hcdh'

    elseif nameJob == '[GOUV] President' then
        currentJobs = 'president'

    elseif nameJob == '[BOSS] Metal co' then
        currentJobs = 'metalco'

    elseif nameJob == '[BOSS] LBDL' then
        currentJobs = 'lbdl'

    elseif nameJob == '[BOSS] TequiLaLa' then
        currentJobs = 'barman'

    elseif nameJob == '[BOSS] Garage Carreno' then
        currentJobs = 'mecano'

    elseif nameJob == '[BOSS] Eco Taxi' then
        currentJobs = 'taxi'

    elseif nameJob == 'Chomeur' or
       nameJob == 'Fermier' or
       nameJob == 'Bucheron' or
       nameJob == 'Mineur' or
       nameJob == 'Pecheur' or
       nameJob == 'Docker' or
       nameJob == 'Brasseur' or
       nameJob == 'Vigneron' or
       nameJob == 'Livreur' or   
       nameJob == 'Mecano' or
       nameJob == 'Taxi' or  
       nameJob == 'Ambulancier' then
        currentJobs = string.lower(nameJob)
    end
end)


function openMenuJobs()
    TriggerEvent(currentJobs .. ':openMenu')
end

Menu = {}
Menu.item = {
    ['Title'] = 'Interactions',
    ['Items'] = {
        {['Title'] = 'Personnel', ['SubMenu'] = {
            ['Title'] = 'Menu',
                ['Items'] = {
                    { ['Title'] = 'Regarder sa carte d\'identité', ['Event'] = 'gcl:openMeIdentity'},
                    { ['Title'] = 'Montrer carte d\'identité', ['Event'] = 'gcl:showItentity'},
                }
            }
        },
        {['Title'] = 'Telephone' , ['Event'] = 'phone:toggleMenu'},
        {['Title'] = 'Emote', ['SubMenu'] = {
            ['Title'] = 'Menu',
            ['Items'] = {
                { ['Title'] = 'Bras tendu', ['Function'] = playAminationLoop, ['dictionaries'] = "nm@hands", ['clip'] = 'flail' },
                { ['Title'] = 'Saluer', ['SubMenu'] = {
                    ['Title'] = 'Animations - Saluer',
                    ['Items'] = {
                        { ['Title'] = "Serrer la main", Function = playAmination ,  dictionaries = "mp_common", clip = 'givetake1_a'},
                        { ['Title'] = "Dire bonjour",   Function = playAmination ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_hello" },
                        { ['Title'] = "Tappes moi en 5", Function = playAmination , dictionaries = "mp_ped_interaction", clip = "highfive_guy_a" },
                        { ['Title'] = "Salut militaire", Function = playAmination , dictionaries = "mp_player_int_uppersalute", clip = "mp_player_int_salute" },
                    }
                }},
                { ['Title'] = 'Humeur', ['SubMenu'] = {
                    ['Title'] = 'Animations - Humeur',
                    ['Items'] = {
                        { ['Title'] = "Applaudir", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_CHEERING"},
                        { ['Title'] = "Branleur", Function = playAmination ,  dictionaries = "mp_player_int_upperwank", clip = "mp_player_int_wank_01" },
                        { ['Title'] = "Dammed ", Function = playAmination ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_damn" },
                        { ['Title'] = "Calme toi ", Function = playAmination ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_easy_now" },
                        { ['Title'] = "No way", Function = playAmination ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_no_way" },
                        { ['Title'] = "Doigt d'honneur", Function = playAmination ,  dictionaries = "mp_player_int_upperfinger", clip = "mp_player_int_finger_01_enter" },
                        { ['Title'] = 'Faire un doigt', ['Function'] = playAmination, ['dictionaries'] = "mp_player_intfinger", ['clip'] = 'mp_player_int_finger' },
                        { ['Title'] = "Balle dans la tête", Function = playAmination ,  dictionaries = "mp_suicide", clip = "pistol" },
                        { ['Title'] = "Super", Function = playAmination ,  dictionaries = "mp_action", clip = "thanks_male_06" },
                        { ['Title'] = "Enlacer", Function = playAmination ,  dictionaries = "mp_ped_interaction", clip = "kisses_guy_a" },
                        { ['Title'] = 'Mains en l\'air', ['Function'] = playAmination, ['dictionaries'] = "missminuteman_1ig_2", ['clip'] = 'handsup_base' },
                        { ['Title'] = 'Signe de la main', ['Function'] = playAmination, ['dictionaries'] = "friends@frj@ig_1", ['clip'] = 'wave_e' },
                    }
                }},
                { ['Title'] = 'Sportives', ['SubMenu'] = {
                    ['Title'] = 'Animations - Sportives',
                    ['Items'] = {
                        { ['Title'] = "Faire du Yoga", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_YOGA"},
                        { ['Title'] = "Jogging", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_JOG_STANDING"},
                        { ['Title'] = "Faire des pompes", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_PUSH_UPS"},
                    }
                }},
                { ['Title'] = 'Festives', ['SubMenu'] = {
                    ['Title'] = 'Animations - Festives',
                    ['Items'] = {
                        { ['Title'] = "Boire une biere", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_DRINKING"},
                        { ['Title'] = "Pres du feu", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_STAND_FIRE"},
                        { ['Title'] = "Jouer de la musique", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_MUSICIAN"},
                    }
                }},
                { ['Title'] = 'Prendre une pose', ['SubMenu'] = {
                    ['Title'] = 'Animations - Pose',
                    ['Items'] = {
                        { ['Title'] = 'Accouder au comptoir', ['Function'] = playEmote, ['EmoteName'] = 'PROP_HUMAN_BUM_SHOPPING_CART' },
                        { ['Title'] = 'Assis au sol', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_PICNIC' },
                        { ['Title'] = 'Sur le ventre', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_SUNBATHE' },
                        { ['Title'] = 'Sur le dos', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_SUNBATHE_BACK' },
                    }
                }},
                { ['Title'] = 'Autres', ['SubMenu'] = {
                    ['Title'] = 'Animations - Autres',
                    ['Items'] = {
                        { ['Title'] = 'Oui', ['Function'] = playAmination, ['dictionaries'] = "gestures@m@standing@casual", ['clip'] = 'gesture_pleased' }, 
                        { ['Title'] = 'Non', ['Function'] = playAmination, ['dictionaries'] = "gestures@m@standing@casual", ['clip'] = 'gesture_head_no' },
                        { ['Title'] = "Crocheter", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_WELDING"},
                        { ['Title'] = "Prendre des notes", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_CLIPBOARD"},
                        { ['Title'] = "S\'assoir", Function = playEmote, ['EmoteName'] = "PROP_HUMAN_SEAT_CHAIR"},
                        { ['Title'] = "Fumer une clope", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_SMOKING"},
                        { ['Title'] = "Réparer le moteur",   Function = playAmination ,  dictionaries = "amb@world_human_vehicle_mechanic@male@idle_a", clip = "WORLD_HUMAN_VEHICLE_MECHANIC" },
                        { ['Title'] = "Se gratter les couilles", Function = playAmination , dictionaries = "mp_player_int_uppergrab_crotch", clip = "mp_player_int_grab_crotch" },
                        { ['Title'] = "Rock and Roll", Function = playAmination , dictionaries = "mp_player_int_upperrock", clip = "mp_player_int_rock" },
                        { ['Title'] = 'Selfie', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_TOURIST_MOBILE' },
                        { ['Title'] = 'Portable', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_STAND_MOBILE' },
                    }
                }},
                { ['Title'] = 'Metier', ['SubMenu'] = {
                    ['Title'] = 'Animations Metier',
                    ['Items'] = {
                        { ['Title'] = 'Marteau piqueur', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_CONST_DRILL' }, -- mineur
                        { ['Title'] = 'Pose de la police', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_COP_IDLES' }, -- Police
                        { ['Title'] = 'Circulation', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_CAR_PARK_ATTENDANT' }, -- police
                        { ['Title'] = 'Souffleur', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_GARDENER_LEAF_BLOWER' }, -- Jardinier
                        { ['Title'] = 'Planter', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_GARDENER_PLANT' }, -- Jardinier
                        { ['Title'] = 'Pêcher', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_STAND_FISHING' }, -- P?cheur
                        { ['Title'] = 'Soudure', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_WELDING' }, -- soudeur / crochetage
                        { ['Title'] = 'Examiner corp 1', ['Function'] = playEmote, ['EmoteName'] = 'CODE_HUMAN_MEDIC_KNEEL' }, -- Pour medecin et ambulancier
                        { ['Title'] = 'Examiner corp 2', ['Function'] = playEmote, ['EmoteName'] = 'CODE_HUMAN_MEDIC_TEND_TO_DEAD' }, -- Pour medecin et ambulancier
                        { ['Title'] = 'Verbaliser', ['Function'] = playEmote, ['EmoteName'] = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH' }, -- Verbaliser
                        { ['Title'] = 'Jumelle', ['Function'] = playEmote, ['EmoteName']  = 'WORLD_HUMAN_BINOCULARS' }, -- policier/chasseur
                    }
                }},
            },
        }},
        --{ ['Title'] = 'Faire Pipi', ['Event'] = 'gabs:enviepipi'},
        { ['Title'] = 'Enlever / Mettre chapeau', ['Event'] = 'accessories_switcher:toggleHat',['Close'] = false},
        { ['Title'] = 'Enlever / mettre Lunettes', ['Event'] = 'accessories_switcher:toggleGlasses',['Close'] = false},
        { ['Title'] = 'Annuler Animation', ['Event'] = 'gc:clearAmination'},
        { ['Title'] = 'Se suicider / Respawn', ['Event'] = 'ambulancier:selfRespawn'},
    }
}
--====================================================================================
--  Option Menu
--====================================================================================
Menu.backgroundColor = { 52, 73, 94, 196 }
Menu.backgroundColorActive = { 22, 160, 134, 255 }
Menu.tileTextColor = { 22, 160, 134, 255 }
Menu.tileBackgroundColor = { 255,255,255, 255 }
Menu.textColor = { 255,255,255,255 }
Menu.textColorActive = { 255,255,255, 255 }

Menu.keyOpenMenu = 167 -- F3    
Menu.keyUp = 172 -- PhoneUp
Menu.keyDown = 173 -- PhoneDown
Menu.keyLeft = 174 -- PhoneLeft || Not use next release Maybe 
Menu.keyRight = 175 -- PhoneRigth || Not use next release Maybe 
Menu.keySelect = 176 -- PhoneSelect
Menu.KeyCancel = 177 -- PhoneCancel

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
            Menu.initText(Menu.textColor)
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
    for i,v in ipairs(Menu.item.Items)do
            if( v['Title'] == 'Ambulancier')then
                table.remove(Menu.item.Items,i)
                
            end
    end
    TriggerEvent("ambulancier:menu")
    Menu.currentPos = {1}
    
end

function Menu.keyControl()
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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustPressed(1, Menu.keyOpenMenu) then
            Menu.initMenu()
            Menu.isOpen = not Menu.isOpen
        end
        if Menu.isOpen then
            Menu.draw()
            Menu.keyControl()
        end
        if IsControlJustPressed(1, KeyOpenJobsMenu) then
            openMenuJobs()
        end
    end
end)