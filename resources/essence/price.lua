fuel = math.random(1.25, 1.55) -- Fuel Cost, this could be made to randomise between 1.05 and 1.30 or something like that

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

RegisterServerEvent('frfuel:fuelAdded')
AddEventHandler('frfuel:fuelAdded', function(amount)

local cost = round(fuel * amount)

TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Le prix de l'essence est de $" .. fuel)

TriggerEvent('es:getPlayerFromId', source, function(user)
local curplayer = user.identifier
local wallet = user.money
local new_wallet = wallet - cost
--TriggerClientEvent('chatMessage', source, "SYSTEM", {255,0,0}, "DEBUG: " .. wallet .. " - " .. cost .. " = " .. new_wallet .. " :DEBUG")

    TriggerEvent("es:setPlayerDataId", curplayer, "money", new_wallet, function(response, success)
        user:removeMoney(cost)
        TriggerClientEvent('es:activateMoney', source, new_wallet)
            if(success)then
                TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "votre plein est de " .. round(amount) .. " litres d'essence")
                TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Le plein vous a coûté $" .. round(cost))
                --if (new_wallet <= 0)then
                --    TriggerClientEvent('chatMessage', -1, "911", {255, 0, 0}, GetPlayerName(source) .." n'a pas payé sont plein d'essence , il est recherché par la police")
                --    SetPlayerWantedLevel(source,  1,  false)
                --end
            end
        end)
    end)
end)