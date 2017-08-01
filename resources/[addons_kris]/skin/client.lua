--
-- MENU FOR CUSTOMIZE PLAYER SKIN
-- CREATOR: Jean-Christophe Pires
-- Date: 13/05/2017
--

------------------------------------------------- INIT VARS ------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--------- CREATE SKIN OBJECT ---------
SkinChooser =  {}
SkinChooser.__index = SkinChooser
function SkinChooser:create()
    -- our new object
    local self = {}
    -- make Account handle lookup
    setmetatable(self,SkinChooser)
    self.name           = nil
    self.model          = nil
    self.age            = nil
    self.head           = nil
    self.body_color     = nil
    self.hair           = nil
    self.hair_color     = nil
    self.beard          = nil
    self.beard_color    = nil
    self.eyebrows            = nil
    self.eyebrows_color      = nil
    return self
end

--------------- VARS -----------------
local current_skin = SkinChooser:create()

-------------- OUTFITS ---------------
OUTFIST_LIST = {}
local current_step = 0
------------ MENU OPTIONS ------------
local options = {
    x = 0.12,
    y = 0.15,
    width = 0.22,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "Personnalisation",
    menu_subtitle = "Bienvenue",
    color_r = 192,
    color_g = 57,
    color_b = 43,
}

------------------------------------------------ MAIN MENU -------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-------- MAIN MENU -------
function MainMenu()
    ClearMenu()
    Menu.addButton("Creez votre perso", "modelMenu", nil, nil)
end

------------------------------------------------ MODEL (SEXE) ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-------- MODEL MENU -------
function modelMenu()
    options.menu_subtitle = "Choix du sexe"
    ClearMenu()
    Menu.addButton("Homme", "skinMenuEnter", 'mp_m_freemode_01', 'skinMenu')
    Menu.addButton("Femme", "skinMenuEnter", 'mp_f_freemode_01', 'skinMenu')
end
function skinMenu(skin)
    RequestModel(skin)
    while not HasModelLoaded(skin) do
        RequestModel(skin)
        Wait(0)
    end
    SetPlayerModel(PlayerId(), skin)
    SetModelAsNoLongerNeeded(skin)
    -- SetPedHeadBlendData(playerPed, 0, 0, skin, 0, 0, skin, 1.0, 1.0, 1.0, true)
    SetPedDefaultComponentVariation(GetPlayerPed(-1))
    SetPedComponentVariation(GetPlayerPed(-1), 2, 0, 0, 0)

end

function skinMenuEnter(skin)
    current_skin.model = skin
    current_step = 1
    TriggerServerEvent('skin:getOutfits', current_skin.model)
    shapeMenu()
end

-------------------------------------------------- HEAD ----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--------- SHAPE ------------
function shapeMenu()
    options.menu_subtitle = "Forme du visage"
    ClearMenu()
    Menu.addButton("Retour", "modelMenu", nil, nil)
    if current_skin.model == 'mp_f_freemode_01' then
        Menu.addButton("Visage n°1", "setShapeEnter", 21, "setShape")
        Menu.addButton("Visage n°2", "setShapeEnter", 22, "setShape")
        Menu.addButton("Visage n°3", "setShapeEnter", 23, "setShape")
        Menu.addButton("Visage n°4", "setShapeEnter", 24, "setShape")
        Menu.addButton("Visage n°5", "setShapeEnter", 25, "setShape")
        Menu.addButton("Visage n°6", "setShapeEnter", 26, "setShape")
        Menu.addButton("Visage n°7", "setShapeEnter", 27, "setShape")
        Menu.addButton("Visage n°8", "setShapeEnter", 28, "setShape")
        Menu.addButton("Visage n°9", "setShapeEnter", 29, "setShape")
        Menu.addButton("Visage n°11", "setShapeEnter", 31, "setShape")
        Menu.addButton("Visage n°12", "setShapeEnter", 32, "setShape")
        Menu.addButton("Visage n°13", "setShapeEnter", 33, "setShape")
        Menu.addButton("Visage n°14", "setShapeEnter", 34, "setShape")
        Menu.addButton("Visage n°15", "setShapeEnter", 35, "setShape")
        Menu.addButton("Visage n°16", "setShapeEnter", 36, "setShape")
        Menu.addButton("Visage n°17", "setShapeEnter", 37, "setShape")
        Menu.addButton("Visage n°18", "setShapeEnter", 38, "setShape")
        Menu.addButton("Visage n°19", "setShapeEnter", 39, "setShape")
        Menu.addButton("Visage n°20", "setShapeEnter", 40, "setShape")
        Menu.addButton("Visage n°21", "setShapeEnter", 41, "setShape")
        Menu.addButton("Visage n°22", "setShapeEnter", 45, "setShape")
    else
        Menu.addButton("Visage n°1", "setShapeEnter", 0, "setShape")
        Menu.addButton("Visage n°2", "setShapeEnter", 1, "setShape")
        Menu.addButton("Visage n°3", "setShapeEnter", 2, "setShape")
        Menu.addButton("Visage n°4", "setShapeEnter", 3, "setShape")
        Menu.addButton("Visage n°5", "setShapeEnter", 4, "setShape")
        Menu.addButton("Visage n°6", "setShapeEnter", 5, "setShape")
        Menu.addButton("Visage n°7", "setShapeEnter", 6, "setShape")
        Menu.addButton("Visage n°8", "setShapeEnter", 7, "setShape")
        Menu.addButton("Visage n°9", "setShapeEnter", 8, "setShape")
        Menu.addButton("Visage n°10", "setShapeEnter", 9, "setShape")
        Menu.addButton("Visage n°11", "setShapeEnter", 10, "setShape")
        Menu.addButton("Visage n°12", "setShapeEnter", 11, "setShape")
        Menu.addButton("Visage n°13", "setShapeEnter", 12, "setShape")
        Menu.addButton("Visage n°14", "setShapeEnter", 13, "setShape")
        Menu.addButton("Visage n°15", "setShapeEnter", 14, "setShape")
        Menu.addButton("Visage n°16", "setShapeEnter", 15, "setShape")
        Menu.addButton("Visage n°17", "setShapeEnter", 16, "setShape")
        Menu.addButton("Visage n°18", "setShapeEnter", 17, "setShape")
        Menu.addButton("Visage n°19", "setShapeEnter", 18, "setShape")
        Menu.addButton("Visage n°20", "setShapeEnter", 19, "setShape")
        Menu.addButton("Visage n°21", "setShapeEnter", 20, "setShape")
        Menu.addButton("Visage n°22", "setShapeEnter", 42, "setShape")
        Menu.addButton("Visage n°23", "setShapeEnter", 43, "setShape")
        Menu.addButton("Visage n°24", "setShapeEnter", 44, "setShape")
    end
    Menu.addButton("Retour", "modelMenu", nil, nil)

end
function setShape(skin)
    SetPedHeadBlendData(GetPlayerPed(-1), skin, skin, skin, 0, 0, 0, 1.0, 1.0, 1.0, true)
    SetPedComponentVariation(GetPlayerPed(-1), 0, skin, 0, 0)

end
function setShapeEnter(skin)
    current_skin.head = skin
    current_step = 2
    bodyColor()
end

------- BODY COLOR ----------
function bodyColor()
    options.menu_subtitle = "Couleur de la peau"
    ClearMenu()
    Menu.addButton("Retour", "shapeMenu", nil, nil)
    Menu.addButton("Couleur n°1", "setBodyColorEnter", 21, "setBodyColor")
    Menu.addButton("Couleur n°2", "setBodyColorEnter", 22, "setBodyColor")
    Menu.addButton("Couleur n°3", "setBodyColorEnter", 23, "setBodyColor")
    Menu.addButton("Couleur n°4", "setBodyColorEnter", 24, "setBodyColor")
    Menu.addButton("Couleur n°5", "setBodyColorEnter", 25, "setBodyColor")
    Menu.addButton("Couleur n°6", "setBodyColorEnter", 26, "setBodyColor")
    Menu.addButton("Couleur n°7", "setBodyColorEnter", 27, "setBodyColor")
    Menu.addButton("Couleur n°8", "setBodyColorEnter", 28, "setBodyColor")
    Menu.addButton("Couleur n°9", "setBodyColorEnter", 29, "setBodyColor")
    Menu.addButton("Couleur n°11", "setBodyColorEnter", 31, "setBodyColor")
    Menu.addButton("Couleur n°12", "setBodyColorEnter", 32, "setBodyColor")
    Menu.addButton("Couleur n°13", "setBodyColorEnter", 33, "setBodyColor")
    Menu.addButton("Couleur n°14", "setBodyColorEnter", 34, "setBodyColor")
    Menu.addButton("Couleur n°15", "setBodyColorEnter", 35, "setBodyColor")
    Menu.addButton("Couleur n°16", "setBodyColorEnter", 36, "setBodyColor")
    Menu.addButton("Couleur n°17", "setBodyColorEnter", 37, "setBodyColor")
    Menu.addButton("Couleur n°18", "setBodyColorEnter", 38, "setBodyColor")
    Menu.addButton("Couleur n°19", "setBodyColorEnter", 39, "setBodyColor")
    Menu.addButton("Couleur n°20", "setBodyColorEnter", 40, "setBodyColor")
    Menu.addButton("Couleur n°21", "setBodyColorEnter", 41, "setBodyColor")
    Menu.addButton("Couleur n°22", "setBodyColorEnter", 45, "setBodyColor")
    Menu.addButton("Retour", "shapeMenu", nil, nil)

end
function setBodyColor(skin)
    SetPedHeadBlendData(GetPlayerPed(-1), current_skin.head, current_skin.head, current_skin.head, skin, skin, skin, 1.0, 1.0, 1.0, true)
    SetPedComponentVariation(GetPlayerPed(-1), 0, skin, 0, 0)
end
function setBodyColorEnter(skin)
    current_skin.body_color = skin
    current_step = 3
    eyebrowsMenu()
end

-------------------------------------------------- eyebrows -----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function eyebrowsMenu()
    options.menu_subtitle = "Formes des sourcils"
    ClearMenu()
    Menu.addButton("Retour", "bodyColor", nil, nil)
    for i = 0, GetNumHeadOverlayValues(1) do
        Menu.addButton("Forme n°"..i, "eyebrowsSelectorMenuEnter", i, "eyebrowsSelectorMenu")
    end
    Menu.addButton("Retour", "bodyColor", nil, nil)
end

function eyebrowsSelectorMenu(id)
    SetPedHeadOverlay(GetPlayerPed(-1),  2,  id,  0.9)
end

function eyebrowsSelectorMenuEnter(id)
    current_skin.eyebrows = id
    current_step = 4
    eyebrowsColorMenu()
end

function eyebrowsColorMenu()
    options.menu_subtitle = "Couleur des sourcils"
    ClearMenu()
    Menu.addButton("Retour", "eyebrowsMenu", nil)
    for i = 0, GetNumHairColors() do
        Menu.addButton("Couleur n°"..i, "eyebrowsColorSelectorMenuEnter", i, "eyebrowsColorSelectorMenu")
    end
    Menu.addButton("Retour", "eyebrowsMenu", nil, nil)
end

function eyebrowsColorSelectorMenu(id)
    SetPedHeadOverlay(GetPlayerPed(-1),  2,  current_skin.eyebrows,  0.9)        -- Beard Color
    SetPedHeadOverlayColor(GetPlayerPed(-1),  2, 1, id, 0)  -- Beard
end

function eyebrowsColorSelectorMenuEnter(id)
    current_skin.eyebrows_color = id
    hairSelectorMenu()
end

------------------------------------------------------- HAIR  ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

------------ HAIRCUT ---------
function hairSelectorMenu()
    options.menu_subtitle = "Coupe de cheveux"
    ClearMenu()
    Menu.addButton("Retour", "eyebrowsColorMenu", nil)
    for i = 0, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 2) -1 do
        Menu.addButton("Coupe n°"..i, "hairSelectorSwitcherEnter", i, "hairSelectorSwitcher")
    end
    Menu.addButton("Retour", "eyebrowsColorMenu", nil)
end
function hairSelectorSwitcher(id)
    SetPedComponentVariation(GetPlayerPed(-1), 2, id, 0, 0)
end
function hairSelectorSwitcherEnter(id)
    current_skin.hair = id
    current_step = 6
    hairColorVariationSelectorMenu()
end

----------- HAIR COLOR ----------
function hairColorVariationSelectorMenu()
    options.menu_subtitle = "Couleur des cheveux"
    ClearMenu()
    Menu.addButton("Retour", "hairSelectorMenu", nil)
    for i = 0,  GetNumHairColors() do

        Menu.addButton("Couleur n°"..i, "hairColorVariationSelectorSwitcherEnter", i, "hairColorVariationSelectorSwitcher")
    end
    Menu.addButton("Retour", "hairSelectorMenu", nil)
end
function hairColorVariationSelectorSwitcher(id)
    SetPedHairColor(GetPlayerPed(-1), id,4)
end
function hairColorVariationSelectorSwitcherEnter(id)
    current_skin.hair_color = id
    current_step = 7
    if current_skin.model == 'mp_m_freemode_01' then
        beardCutMenu()
    else
        outfitMenu()
    end
end


--------------------------------------------------- BEARD --------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

---------- CUT -----------
function beardCutMenu()
    options.menu_subtitle = "Barbe"
    ClearMenu()
    Menu.addButton("Retour", "hairColorVariationSelectorMenu", nil)
    for i = 0, GetNumHeadOverlayValues(1) do
        Menu.addButton("barbe n°"..i, "beardSelectorCutMenuEnter", i, "beardSelectorCutMenu")
    end
    Menu.addButton("Retour", "hairColorVariationSelectorMenu", nil)
end
function beardColorMenu()
    options.menu_subtitle = "Couleur de la barbe"
    ClearMenu()
    Menu.addButton("Retour", "beardCutMenu", nil)
    for i = 0, GetNumHairColors() do
        Menu.addButton("Couleur n°"..i, "beardSelectorColorMenuEnter", i, "beardSelectorColorMenu")
    end
    Menu.addButton("Retour", "beardCutMenu", nil)
end

------- BEARD COLOR -------
function beardSelectorCutMenu(id)
    SetPedHeadOverlay(GetPlayerPed(-1),  1,  id,  0.9)
    SetPedHeadOverlayColor(GetPlayerPed(-1),  1,  1,  1, 1)
end

function beardSelectorCutMenuEnter(id)
    current_skin.beard = id
    current_step = 8
    beardColorMenu()
end

function beardSelectorColorMenu(id)
    SetPedHeadOverlay(GetPlayerPed(-1),  1,  current_skin.beard ,  (current_skin.beard  / 10) + 0.0)  -- Beard
    SetPedHeadOverlayColor(GetPlayerPed(-1),  1,  1,  id, id)
end

function beardSelectorColorMenuEnter(id)
    current_skin.beard_color = id
    current_step = 9
    outfitMenu()
end

------------------------------------------------------ OUTFIT ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function outfitMenu()
    options.menu_subtitle = "Selection d'une tenue"
    ClearMenu()
    Menu.addButton("Retour", "hairColorVariationSelectorMenu", nil)
    for b , outfit in ipairs(OUTFIST_LIST) do
        Menu.addButton(outfit.name, "outfitSelectorEnter", outfit, "outfitSelector")
    end
    Menu.addButton("Retour", "hairColorVariationSelectorMenu", nil)
end
function outfitSelector(outfit)
    SetPedComponentVariation( GetPlayerPed(-1), 8, outfit.tshirt, outfit.tshirt_txt, 0 )
    SetPedComponentVariation( GetPlayerPed(-1), 4, outfit.pant, outfit.pant_txt, 0 )
    SetPedComponentVariation( GetPlayerPed(-1), 11, outfit.jacket, outfit.jacket_txt, 0 )
    SetPedComponentVariation( GetPlayerPed(-1), 6, outfit.shoe, outfit.shoe_txt, 0 )
    SetPedComponentVariation( GetPlayerPed(-1), 3, outfit.arm, outfit.arm_txt, 0 )
    SetPedComponentVariation( GetPlayerPed(-1), 3, outfit.arm, outfit.arm_txt, 0 )
    if outfit.mask ~= 0 then
        SetPedComponentVariation(GetPlayerPed(-1), 1, outfit.mask, outfit.mask_txt, 0)
    end
    if outfit.glasses ~= 0 then
        SetPedPropIndex(GetPlayerPed(-1), 1, outfit.glasses,outfit.glasses_txt, 0)
    end
    if outfit.hat ~= 0 then
        SetPedPropIndex(GetPlayerPed(-1), 0, outfit.hat,outfit.hat_txt, 0)
    end
end
function outfitSelectorEnter(outfit)
    current_skin.outfit_id = outfit.id
    current_step = 10
    saveMenu()
end

------------------------------------------------------- SAVE -----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function saveMenu()
    Menu.hidden = not Menu.hidden
    freeze(false)
    Citizen.Trace(json.encode(current_skin))
    TriggerServerEvent('skin:saveOutfitForNewPlayer', current_skin)
end

----------------------------------------------------- HELPERS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function freeze(freeze)
    local player = PlayerId()
    local ped = GetPlayerPed(-1)
    if not freeze then
        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end
        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    else
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)
    end
end

----------------------------------------------------- LISTENERS --------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- Spawn override
AddEventHandler('onClientMapStart', function()
    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
    exports.spawnmanager:setAutoSpawnCallback(function()
        TriggerServerEvent('skin:getPlayerModel')
    end)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('skin:openSkinCreator')
AddEventHandler("skin:openSkinCreator", function()
    MainMenu() -- Menu to draw

    --freeze(true)
    Menu.hidden = not Menu.hidden -- Hide/Show the menu
end)

RegisterNetEvent('skin:setOutfitList')
AddEventHandler('skin:setOutfitList', function(outfits)
    OUTFIST_LIST = {}
    OUTFIST_LIST = outfits
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        Menu.renderGUI(options) -- Draw menu on each tick if Menu.hidden = false
    end
end)

------------------------------------------------------ END -------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

local hospital = {
    x = -451.149,
    y= -341.954,
    z = 34.5017,
    name = "Hôpital",
    sprite = 61,
    color = 4,
    scale = 0.9
}
local airport = {
    x = -1041.56,
    y= -2744.44,
    z = 21.3594,
    name = "Aéroport National",
    sprite = 90,
    color = 73,
    scale = 0.9
}

-- Spawn override
AddEventHandler('onClientMapStart', function()
    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
    exports.spawnmanager:setAutoSpawnCallback(function()
        TriggerServerEvent('skin:getPlayerModel')
    end)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
        end
    end)
end)

local firstSpawn = true
AddEventHandler("playerSpawned", function()
    exports.spawnmanager:setAutoSpawn(false)
    SetPedDefaultComponentVariation(GetPlayerPed(-1))
    if firstSpawn then
        TriggerServerEvent('skin:firstSpawn')
        firstSpawn = false
    else
        TriggerServerEvent('skin:loadSkinAndPosition')
    end
end)

RegisterNetEvent('skin:getPlayerModelFromDb')
AddEventHandler('skin:getPlayerModelFromDb', function(model)
    exports.spawnmanager:spawnPlayer({x = hospital.x, y = hospital.y, z = hospital.z, model = model})
end)

RegisterNetEvent("skin:setPlayerSkin")
AddEventHandler("skin:setPlayerSkin", function(skin)
    setPlayerSkin(skin)
end)

RegisterNetEvent("skin:setPlayerOutfit")
AddEventHandler("skin:setPlayerOutfit", function(outfit)
    setPlayerOutfit(outfit)
end)

RegisterNetEvent("skin:setPlayerProps")
AddEventHandler("skin:setPlayerProps", function(prop)
    setPlayerProps(prop)
end)

function setPlayerSkin(skin)
    local playerPed = GetPlayerPed(-1)
    if skin then
        local hashSkin = GetHashKey("mp_m_freemode_01")
        if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
            SetPedHeadBlendData(playerPed, skin.head, skin.head, skin.head, skin.body_color, skin.body_color, skin.body_color, 1.0, 1.0, 1.0, true)
            SetPedComponentVariation(playerPed, 0, skin.head, 0, 0)
            SetPedComponentVariation(playerPed, 2, skin.hair, 0, 0)
            SetPedHairColor(playerPed, skin.hair_color,4)
            SetPedHeadOverlay(playerPed,  1,  skin.beard ,  1.0)
            SetPedHeadOverlayColor(playerPed,  1,  1,  skin.beard_color, 1.0)
            if skin.eyebrows ~= 0 then
                SetPedHeadOverlay(playerPed,  2,  skin.eyebrows, 1.0)
                SetPedHeadOverlayColor(playerPed,  2, 1, skin.eyebrows_color, 1.0)
            else
                SetPedHeadOverlay(playerPed,  2,  -1, 0)
            end
            if skin.makeup ~= 0 then
                SetPedHeadOverlay(playerPed,  4, skin.makeup , (skin.makeup_opacity / 10 +0.0))
            else
                SetPedHeadOverlay(playerPed,  4, -1 , 0)
            end
            if skin.lipstick ~= 0 then
                SetPedHeadOverlay(playerPed,  8,  skin.lipstick, 1.0)
                SetPedHeadOverlayColor(playerPed,  8,  1,  skin.lipstick_color, 1.0)
            else
                SetPedHeadOverlay(playerPed,  8,  -1, 0)
            end
            if skin.percing == 0 then
                ClearPedProp(GetPlayerPed(-1),2)
            else
                SetPedPropIndex(playerPed, 2, skin.percing,skin.percing_txt, 0)
            end
        else
            SetPedHeadBlendData(playerPed, skin.head, skin.head, skin.head, skin.body_color, skin.body_color, skin.body_color, 1.0, 1.0, 1.0, true)
            SetPedComponentVariation(playerPed, 0, skin.head, 0, 0)
            SetPedComponentVariation(playerPed, 2, skin.hair, 0, 0)
            SetPedHairColor(playerPed, skin.hair_color,4)
            if skin.eyebrows ~= 0 then
                SetPedHeadOverlay(playerPed,  2,  skin.eyebrows, 1.0)
                SetPedHeadOverlayColor(playerPed,  2, 1, skin.eyebrows_color, 1.0)
            else
                SetPedHeadOverlay(playerPed,  2,  -1, 0)
            end
            if skin.makeup ~= 0 then
                SetPedHeadOverlay(playerPed,  4, skin.makeup , (skin.makeup_opacity / 10 +0.0))
            else
                SetPedHeadOverlay(playerPed,  4, -1 , 0)
            end
            if skin.lipstick ~= 0 then
                SetPedHeadOverlay(playerPed,  8,  skin.lipstick, 1.0)
                SetPedHeadOverlayColor(playerPed,  8,  1,  skin.lipstick_color, 1.0)
            else
                SetPedHeadOverlay(playerPed,  8,  -1, 0)
            end
            if skin.percing == 0 then
                ClearPedProp(GetPlayerPed(-1),2)
            else
                SetPedPropIndex(playerPed, 2, skin.percing,skin.percing_txt, 0)
            end
        end
    end
end

function setPlayerOutfit(outfit)
    local playerPed = GetPlayerPed(-1)
    if outfit then

        SetPedComponentVariation(playerPed, 3, outfit.arm, outfit.arm_txt, 0)
        -- set tshirt
        SetPedComponentVariation(playerPed, 8, outfit.tshirt, outfit.tshirt_txt, 0)
        -- set jacket
        SetPedComponentVariation(playerPed, 11, outfit.jacket, outfit.jacket_txt, 0)
        -- set pants
        SetPedComponentVariation(playerPed, 4, outfit.pant, outfit.pant_txt, 0)
        -- set shoes
        SetPedComponentVariation(playerPed, 6, outfit.shoe, outfit.shoe_txt, 0)
        if outfit.mask ~= 0 then
            SetPedComponentVariation(playerPed, 1, outfit.mask, outfit.mask_txt, 0)
        end
        if outfit.glasses ~= 0 then
            SetPedPropIndex(playerPed, 1, outfit.glasses,outfit.glasses_txt, 0)
        else
            ClearPedProp(GetPlayerPed(-1),1)
        end
        if outfit.hat ~= 0 then
            SetPedPropIndex(playerPed, 0, outfit.hat,outfit.hat_txt, 0)
        else
            ClearPedProp(GetPlayerPed(-1),0)
        end
    end
end

function setPlayerProps(prop)
    local playerPed = GetPlayerPed(-1)
    if prop then
        print('---------------------')
        print(json.encode(prop))
        if prop.category == 'glasses' then
            ClearPedProp(GetPlayerPed(-1),1)
            SetPedPropIndex(playerPed, 1, prop.item_id,prop.prop_txt, 0)
        end
        if prop.category == 'hat' then
            ClearPedProp(GetPlayerPed(-1),0)
            SetPedPropIndex(playerPed, 0, prop.item_id,prop.prop_txt, 0)
        end
    end

end
