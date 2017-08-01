require "resources/essentialmode/lib/MySQL"

MySQL:open("151.236.37.159", "gfav_n3m", "gfavn3m", "987654")


function idJob(player)
  local executed_query = MySQL:executeQuery("SELECT identifier, job_id, job_name FROM users LEFT JOIN jobs ON jobs.job_id = users.job WHERE users.identifier = '@identifier'", {['@identifier'] = player})
  local result = MySQL:getResults(executed_query, {'job_id'}, "identifier")
  return tostring(result[1].job_id)
end

function updateCoffreMeca(player, prixavant,prixtotal,prixajoute)
  MySQL:executeQuery("UPDATE coffremine SET `solde`='@prixtotal', identifier = '@identifier' , lasttransfert = '@prixajoute' WHERE solde = '@prixavant' AND id = '5' ",{['@prixtotal'] = prixtotal, ['@identifier'] = player ,['@prixajoute'] = prixajoute,['@prixavant'] = prixavant})

end

function GetSoldeMeca()
  local executed_query = MySQL:executeQuery("SELECT solde FROM coffremine WHERE id ='5'")
  local result = MySQL:getResults(executed_query, {'solde'})
  --return tostring(result[1].solde)
  return tostring(result[1].solde)
end

function GetCaMeca()
  local executed_query = MySQL:executeQuery("SELECT ca FROM coffremine WHERE id ='5'")
  local result = MySQL:getResults(executed_query, {'ca'})
  --return tostring(result[1].solde)
  return tostring(result[1].ca)
end

function GetSaleMeca()
  local executed_query = MySQL:executeQuery("SELECT sale FROM coffremine WHERE id ='5'")
  local result = MySQL:getResults(executed_query, {'sale'})
  --return tostring(result[1].solde)
  return tostring(result[1].sale)
end

function ajoutAmendeToCoffreMeca(solde,sale,ca)
  MySQL:executeQuery("UPDATE coffremine SET `solde`='@solde',ca='@ca',sale='@sale'  WHERE id = '5' ",{['@solde'] = solde, ['@ca'] = ca, ['@sale'] = sale})
end

function blanchimentMeca(solde,sale)
  MySQL:executeQuery("UPDATE coffremine SET `solde`='@solde' ,sale='@sale'  WHERE id = '5' ",{['@solde'] = solde, ['@sale'] = sale})
end

RegisterServerEvent('coffremeca:transform')
AddEventHandler('coffremeca:transform', function (amount)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local idjob = idJob(player)
 
 -- Here change id Job (allowed to withdraw/deposit )
    if(idjob == '35')then
      local amountblan = 0
      local amountblan = amount
      if user:dirty_money >= tonumber(amountblan) then
        local maxsale = 0
        local maxsale = GetSaleMeca()
        local solde = 0
        local solde = GetSoldeMeca()
        if tonumber(maxsale) >= tonumber(amountblan) then
          local restesale = 0
          local restesale = tonumber(maxsale) - tonumber(amountblan)
          local newsolde = 0
          local newsolde = tonumber(solde) + tonumber(amountblan)
          blanchimentMeca(tonumber(newsolde),tonumber(restesale))
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



RegisterServerEvent('coffremeca:amendecoffre')
AddEventHandler('coffremeca:amendecoffre', function(amount)
  local solde = 0
  local ca = 0
  local sale = 0
  local amountcoffre = 0
  local totalsolde = 0
  local totalca = 0
  local totalsale = 0
  local solde = GetSoldeMeca()
  local ca = GetCaMeca()
  local sale = GetSaleMeca()
  local amountcoffre = amount
  local totalsolde = amountcoffre + solde
  local totalca = amountcoffre + ca
  local totalsale = amountcoffre + sale
  ajoutAmendeToCoffreMeca(totalsolde,totalsale,totalca)
  TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez payer : "..amountcoffre.." ~g~€ au Mecano")
  
end)


RegisterServerEvent('coffremeca:getsolde')
AddEventHandler('coffremeca:getsolde',function()
TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = user.identifier
    local idjob = idJob(player)
 
 -- Here change id Job (allowed to withdraw/deposit )
    if(idjob == '35')then
      -- (idjob == '17'or idjob =='18')
      local datasolde = 0
      local dataca = 0
      local datasale = 0
      local datasolde = GetSoldeMeca()
      local dataca = GetCaMeca()
      local datasale = GetSaleMeca()
      print(datasolde)
      print(dataca)
      print(datasale)
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Coffre Garage Carreno", false, "Chiffre d'affaire total : "..dataca.."~g~€")
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Coffre Garage Carreno", false, "Solde restant : "..datasolde.."~g~€")
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Coffre Garage Carreno", false, "Argent Blanchissable : "..datasale.."~g~€")

    else
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas la permisison !")
    end
end)
end)

RegisterServerEvent('coffremeca:ajoutsolde')
AddEventHandler('coffremeca:ajoutsolde',function(ajout)
TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = user.identifier
    local idjob = idJob(player)
 
 -- Here change id Job (allowed to withdraw/deposit )
    if(idjob == '35')then
      -- (idjob == '17'or idjob =='18')
      local prixavant = 0
      local prixajoute = 0
      local prixtotal = 0
      local prixavant = GetSoldeMeca()
      local prixajoute = ajout
      local prixtotal = prixavant + prixajoute
     
      print(player)
      print(prixavant)
      print(prixajoute)
      print(prixtotal)

      if((user.money - prixajoute)>=0)then
     
        user:removeMoney((prixajoute))

        updateCoffreMeca(player,prixavant,prixtotal,prixajoute)
        TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez rajouter : "..prixajoute.." ~g~€")
      else
         TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas assez d'argent !")

      end
    else
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas la permisison !")
    end
end)
end)

RegisterServerEvent('coffremeca:retirersolde')
AddEventHandler('coffremeca:retirersolde',function(ajout)
TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local idjob = idJob(player)
 -- Here change id Job (allowed to withdraw/deposit )
     --(idjob == '23'or idjob =='18')
    if(idjob == '35')then

      local prixavant = 0
      local prixenleve = 0
      local prixtotal = 0
      local prixavant = GetSoldeMeca()
      local prixenleve = ajout
      local prixtotal = prixavant-prixenleve
     
      print(player)
      print(prixavant)
      print(prixenleve)
      print(prixtotal)
    

      if(prixtotal<-1)then
        TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Coffre vide !")
        
      else
        

        updateCoffreMeca(player,prixavant,prixtotal,prixenleve)
        user:addMoney((prixenleve))
        TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez enlever : "..prixenleve.." ~r~€")
      end
    else
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas la permisison !")
    end


end)
end)



