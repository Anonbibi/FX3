require "resources/essentialmode/lib/MySQL"

MySQL:open("151.236.37.159", "gfav_n3m", "gfavn3m", "987654")


function idJob(player)
  local executed_query = MySQL:executeQuery("SELECT identifier, job_id, job_name FROM users LEFT JOIN jobs ON jobs.job_id = users.job WHERE users.identifier = '@identifier'", {['@identifier'] = player})
  local result = MySQL:getResults(executed_query, {'job_id'}, "identifier")
  return tostring(result[1].job_id)
end

function updateCoffreMine(player, prixavant,prixtotal,prixajoute)
  MySQL:executeQuery("UPDATE coffremine SET `solde`='@prixtotal', identifier = '@identifier' , lasttransfert = '@prixajoute' WHERE solde = '@prixavant' AND id = '1' ",{['@prixtotal'] = prixtotal, ['@identifier'] = player ,['@prixajoute'] = prixajoute,['@prixavant'] = prixavant})

end

function GetSoldeMine()
  local executed_query = MySQL:executeQuery("SELECT solde FROM coffremine WHERE id ='1'")
  local result = MySQL:getResults(executed_query, {'solde'})
  --return tostring(result[1].solde)
  return tostring(result[1].solde)
end

function GetCaMine()
  local executed_query = MySQL:executeQuery("SELECT ca FROM coffremine WHERE id ='1'")
  local result = MySQL:getResults(executed_query, {'ca'})
  --return tostring(result[1].solde)
  return tostring(result[1].ca)
end

function GetSaleMine()
  local executed_query = MySQL:executeQuery("SELECT sale FROM coffremine WHERE id ='1'")
  local result = MySQL:getResults(executed_query, {'sale'})
  --return tostring(result[1].solde)
  return tostring(result[1].sale)
end

function ajoutAmendeToCoffreMine(solde,sale,ca)
  MySQL:executeQuery("UPDATE coffremine SET `solde`='@solde',ca='@ca',sale='@sale'  WHERE id = '1' ",{['@solde'] = solde, ['@ca'] = ca, ['@sale'] = sale})
end

function blanchimentMine(solde,sale)
  MySQL:executeQuery("UPDATE coffremine SET `solde`='@solde' ,sale='@sale'  WHERE id = '1' ",{['@solde'] = solde, ['@sale'] = sale})
end

RegisterServerEvent('coffremine:transform')
AddEventHandler('coffremine:transform', function (amount)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local idjob = idJob(player)
    local amountblan = 0
    local amountblan = amount
    if(idjob == '27')then
      if user:dirty_money >= tonumber(amountblan) then
        local maxsale = 0
        local maxsale = GetSaleMine()
        local solde = 0
        local solde = GetSoldeMine()
        if tonumber(maxsale) >= tonumber(amountblan) then
          local restesale = 0
          local restesale = tonumber(maxsale) - tonumber(amountblan)
          local newsolde = 0
          local newsolde = tonumber(solde) + tonumber(amountblan)
          blanchimentMine(tonumber(newsolde),tonumber(restesale))
          user:removeDirty_Money(tonumber(amountblan))
          TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez blanchi : "..amountblan.." ~g~€")
        
        else
          TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Trop d'argent sale à blanchir")
        end
      else
        TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous n'avez pas suffisament d'argent sale")
      end
    else
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas la permisison !")
    end
  end)
end)



RegisterServerEvent('coffremine:amendecoffre')
AddEventHandler('coffremine:amendecoffre', function(amount)
  local solde = 0
  local ca = 0
  local sale = 0
  local amountcoffre = 0
  local totalsolde = 0
  local totalca = 0
  local totalsale = 0
  local solde = GetSoldeMine()
  local ca = GetCaMine()
  local sale = GetSaleMine()
  local amountcoffre = amount
  local totalsolde = amountcoffre + solde
  local totalca = amountcoffre + ca
  local totalsale = amountcoffre + sale
  ajoutAmendeToCoffreMine(totalsolde,totalsale,totalca)
  TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez rajouter : "..amountcoffre.." ~g~€")
  
end)


RegisterServerEvent('coffremine:getsolde')
AddEventHandler('coffremine:getsolde',function()
TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = user.identifier
    local idjob = idJob(player)
 
 -- Here change id Job (allowed to withdraw/deposit )
    if(idjob == '27')then
      -- (idjob == '17'or idjob =='18')
      local datasolde = 0
      local dataca = 0
      local datasale = 0
      local datasolde = GetSoldeMine()
      local dataca = GetCaMine()
      local datasale = GetSaleMine()
      print(datasolde)
      print(dataca)
      print(datasale)
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Coffre Metal", false, "Chiffre d'affaire total : "..dataca.."~g~€")
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Coffre Metal", false, "Solde restant : "..datasolde.."~g~€")
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Coffre Metal", false, "Argent Blanchissable : "..datasale.."~g~€")

    else
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas la permisison !")
    end
end)
end)

RegisterServerEvent('coffremine:ajoutsolde')
AddEventHandler('coffremine:ajoutsolde',function(ajout)
TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = user.identifier
    local idjob = idJob(player)
 
 -- Here change id Job (allowed to withdraw/deposit )
    if(idjob =='27')then
      -- (idjob == '17'or idjob =='18')
      local prixavant = 0
      local prixajoute = 0
      local prixtotal = 0
      local prixavant = GetSoldeMine()
      local prixajoute = ajout
      local prixtotal = prixavant + prixajoute
     
      print(player)
      print(prixavant)
      print(prixajoute)
      print(prixtotal)

      if((user.money - prixajoute)>=0)then
     
        user:removeMoney((prixajoute))

        updateCoffreMine(player,prixavant,prixtotal,prixajoute)
        TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez rajouter : "..prixajoute.." ~g~€")
      else
         TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas assez d'argent !")

      end
    else
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas la permisison !")
    end
end)
end)

RegisterServerEvent('coffremine:retirersolde')
AddEventHandler('coffremine:retirersolde',function(ajout)
TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local idjob = idJob(player)
 -- Here change id Job (allowed to withdraw/deposit )
     --(idjob == '23'or idjob =='18')
    if(idjob == '27')then

      local prixavant = 0
      local prixenleve = 0
      local prixtotal = 0
      local prixavant = GetSoldeMine()
      local prixenleve = ajout
      local prixtotal = prixavant-prixenleve
     
      print(player)
      print(prixavant)
      print(prixenleve)
      print(prixtotal)
    

      if(prixtotal<-1)then
        TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Coffre vide !")
        
      else
        

        updateCoffreMine(player,prixavant,prixtotal,prixenleve)
        user:addMoney((prixenleve))
        TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez enlever : "..prixenleve.." ~r~€")
      end
    else
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas la permisison !")
    end


end)
end)



