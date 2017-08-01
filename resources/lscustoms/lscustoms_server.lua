local tbl = {
[1] = {locked = false},
[2] = {locked = false},
[3] = {locked = false},
[4] = {locked = false}
}
RegisterServerEvent('lockGarage')
AddEventHandler('lockGarage', function(b,garage)
	tbl[tonumber(garage)].locked = b
	TriggerClientEvent('lockGarage',-1,tbl)
	print(json.encode(tbl))
end)
RegisterServerEvent('getGarageInfo')
AddEventHandler('getGarageInfo', function()
TriggerClientEvent('lockGarage',-1,tbl)
print(json.encode(tbl))
end)



RegisterServerEvent('CheckMoneyForLscustom')
AddEventHandler('CheckMoneyForLscustom', function(price)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local price = tonumber(price)
        
      if (tonumber(user.money) >= tonumber(price)) then
        user:removeMoney((price))
        TriggerClientEvent('FinishMoneyCheckLscustom', source, name, vehicle, price)
        TriggerClientEvent("es_freeroam:notify", source, "CHAR_LS_CUSTOMS", 1, "LS Customs", false,  "L'Atelier à modifier votre véhicule pour la somme de ~g~".. price .." €")
      else
          TriggerClientEvent("es_freeroam:notify", source, "CHAR_LS_CUSTOMS", 1, "LS Customs", false, "La Maison n'accorde pas de Pret, il vous manque ~g~".. price .." €")
      end 
    
  end)
end)




-- AddEventHandler('CheckMoneyForCustom', function(vehicle, price, mode_type, mode_value)
--   TriggerEvent('es:getPlayerFromId', source, function(user)
--     local player = user.identifier
--     local vehicle = vehicle
--     local mode_type = mode_type
--     local mode_value = mode_value
    
--     local price = tonumber(price)

    
--       if (tonumber(user.money) >= tonumber(price)) then
--         user:removeMoney((price))
--         local executed_query = MySQL:executeQuery("UPDATE user_vehicle SET vehicle_state='@state' WHERE vehicle_plate = '@plate' AND vehicle_model = '@vehicle'",
--       {['@username'] = player, ['@vehicle'] = vehicle, ['@state'] = state, ['@plate'] = plate})
--         TriggerClientEvent('FinishMoneyCheckForVeh', source, name, vehicle, price)
--         TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Modification du véhicule éffectué!\n")
--       else
--           TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Fonds insuffisants!\n")
--       end 
    
--   end)
-- end)