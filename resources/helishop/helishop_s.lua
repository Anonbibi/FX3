require "resources/essentialmode/lib/MySQL"
MySQL:open(database.host, database.name, database.username, database.password)

RegisterServerEvent('helishop:CheckMoneyForHeli')
RegisterServerEvent('helishop:BuyForHeli')


AddEventHandler('helishop:CheckMoneyForHeli', function(name, heli, price)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (tonumber(user.money) >= tonumber(price)) then
      local player = user.identifier
      local heli = heli
      local name = name
      user:removeMoney((price))
      TriggerClientEvent('helishop:FinishMoneyCheckForHeli',source, name, heli, price)
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Redbull donne des ailes!\n")
    else
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Fonds insuffisants!\n")
    end
  end)
end)

AddEventHandler('helishop:BuyForHeli', function(name, heli, price, plate, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
  TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = user.identifier
    local name = name
    local price = price
    local heli = heli
    local plate = plate
    local state = "Sortit"
    local primarycolor = primarycolor
    local secondarycolor = secondarycolor
    local pearlescentcolor = pearlescentcolor
    local wheelcolor = wheelcolor
    local executed_query = MySQL:executeQuery("INSERT INTO user_heli (`identifier`, `heli_name`, `heli_model`, `heli_price`, `heli_plate`, `heli_state`, `heli_colorprimary`, `heli_colorsecondary`, `heli_pearlescentcolor`, `heli_wheelcolor`) VALUES ('@username', '@name', '@heli', '@price', '@plate', '@state', '@primarycolor', '@secondarycolor', '@pearlescentcolor', '@wheelcolor')",
    {['@username'] = player, ['@name'] = name, ['@heli'] = heli, ['@price'] = price, ['@plate'] = plate, ['@state'] = state, ['@primarycolor'] = primarycolor, ['@secondarycolor'] = secondarycolor, ['@pearlescentcolor'] = pearlescentcolor, ['@wheelcolor'] = wheelcolor})
  end)
end)
