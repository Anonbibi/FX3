-- -- Configure the coordinates where the strippers should be placed.
-- local strippers = {
--   {type=5, hash=0x2970a494, x=112.159, y=-1287.326, z=28.459, a=265.902},
--   {type=5, hash=0x2970a494, x=108.440, y=-1289.298, z=28.859, a=338.700},
--   {type=5, hash=0x2970a494, x=108.181, y=-1304.807, z=28.769, a=186.893},
--   {type=5, hash=0x2970a494, x=118.125, y=-1283.357, z=28.277, a=124.466},
--   }

-- -- Configure the coordinates for the bartenders.
--   local bartenders = {
--     {type=5, hash=0x780c01bd, x=128.900, y=-1283.211, z=29.273, a=123.98},
--   }

-- -- Configure the coordinates for the bartenders.
-- local bouncers = {
--   {type=4, hash=0x9fd4292d, x=130.328, y=-1298.409, z=29.233, a=211.486},
--   {type=4, hash=0x9fd4292d, x=127.404, y=-1300.126, z=29.23, a=211.587},
--   {type=4, hash=0x9fd4292d, x=111.088, y=-1304.371, z=29.020, a=296.699},
-- }

-- local bartenders = {
--     {type=5, hash=0x780c01bd, x=128.900, y=-1283.211, z=29.273, a=123.98},
--   }

function LocalPed()
  return GetPlayerPed(-1)
end

function StartText()
  DrawMarker(1, -1171.42, -1572.72, 3.6636, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 2.0, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
  ShowInfo("Press ~INPUT_CONTEXT~ to buy a drink", 0)
end

Citizen.CreateThread(function()
  -- Load the ped modal (s_f_y_hooker_01)
  RequestModel(GetHashKey("s_f_y_hooker_01"))
  while not HasModelLoaded(GetHashKey("s_f_y_hooker_01")) do
    Wait(1)
  end

  -- Load the ped modal (mp_f_stripperlite)
  RequestModel(GetHashKey("mp_f_stripperlite"))
  while not HasModelLoaded(GetHashKey("mp_f_stripperlite")) do
    Wait(1)
  end

  -- Load the ped modal (s_m_m_bouncer_01)
  RequestModel(GetHashKey("s_m_m_bouncer_01"))
  while not HasModelLoaded(GetHashKey("s_m_m_bouncer_01")) do
    Wait(1)
  end

  -- Load the animation (testing)
  RequestAnimDict("mini@strip_club@idles@stripper")
  while not HasAnimDictLoaded("mini@strip_club@idles@stripper") do
    Wait(1)
  end

  -- Load the bouncer animation (testing)
  RequestAnimDict("mini@strip_club@idles@bouncer@base")
  while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
    Wait(1)
  end
    hotessmodel = 's_f_y_hooker_01'
    hotessmodelhash = GetHashKey(hotessmodel)
    hotess =  CreatePed(5, hotessmodelhash, -564.468, 279.542, 82.18, 0.0, false, true)
    SetBlockingOfNonTemporaryEvents(hotess, true)
    SetPedCombatAttributes(hotess, 46, true)
    SetPedFleeAttributes(hotess, 0, 0)
    SetPedRelationshipGroupHash(hotess, GetHashKey("CIVFEMALE"))

    -- Spawn the bartender to the coordinates
    bartendermodel1 = 's_f_y_barman_01'
    bartendermodelhash1 = GetHashKey(bartendermodel1)
    bartender1 =  CreatePed(5, bartendermodelhash1, -561.815, 288.11, 81.27, 0.0, false, true)
    SetBlockingOfNonTemporaryEvents(bartender1, true)
    SetPedCombatAttributes(bartender1, 46, true)
    SetPedFleeAttributes(bartender1, 0, 0)
    SetPedRelationshipGroupHash(bartender1, GetHashKey("CIVFEMALE"))

     -- Spawn the bartender to the coordinates
    bartendermodel2 = 's_f_y_barman_01'
    bartendermodelhash2 = GetHashKey(bartendermodel2)
    bartender2 =  CreatePed(5, bartendermodelhash2, -565.009, 288.257, 84.57, 0.0, false, true)
    SetBlockingOfNonTemporaryEvents(bartender2, true)
    SetPedCombatAttributes(bartender2, 46, true)
    SetPedFleeAttributes(bartender2, 0, 0)
    SetPedRelationshipGroupHash(bartender2, GetHashKey("CIVFEMALE"))

     -- Spawn the bartender to the coordinates
    djmodel = 'a_m_y_hipster_01'
    djmodelhash = GetHashKey(bartendermodel2)
    dj =  CreatePed(4, bartendermodelhash2, -565.009, 288.257, 84.57, 0.0, false, true)
    SetBlockingOfNonTemporaryEvents(bartender2, true)
    SetPedCombatAttributes(bartender2, 46, true)
    SetPedFleeAttributes(bartender2, 0, 0)
    SetPedRelationshipGroupHash(bartender2, GetHashKey("CIVMALE"))

end)




