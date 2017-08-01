require "resources/essentialmode/lib/MySQL"
MySQL:open("151.236.37.159", "gfav_n3m", "gfavn3m", "987654")


function idJobShop(player)
  local executed_query = MySQL:executeQuery("SELECT identifier, job_id, job_name FROM users LEFT JOIN jobs ON jobs.job_id = users.job WHERE users.identifier = '@identifier'", {['@identifier'] = player})
  local result = MySQL:getResults(executed_query, {'job_id'}, "identifier")
  return tostring(result[1].job_id)
end

RegisterServerEvent("Alimentation1")
AddEventHandler("Alimentation1", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
	    if (tonumber(target.money) >= 100) then
			TriggerClientEvent("JambonBeurre", source, 100)
			target:removeMoney(100)
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "Vous avez acheter un~o~ Jambon Beurre\n")
		else
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "~r~Vous n'avez pas assez d'argent !\n")
		end
	end)
end)


RegisterServerEvent("Alimentation2")
AddEventHandler("Alimentation2", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)

	    if (tonumber(target.money) >= 125) then
			TriggerClientEvent("Kebab", source, 125)
			target:removeMoney(125)
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "Vous avez acheter un~o~ Kebab\n")
		else
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "~r~Vous n'avez pas assez d'argent !\n")
		end
	end)
end)


RegisterServerEvent("Alimentation3")
AddEventHandler("Alimentation3", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
	    if (tonumber(target.money) >= 80) then
			TriggerClientEvent("Cola", source, 80)
			target:removeMoney(80)
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "Vous avez acheter une~b~ Canette Cola\n")
		else
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "~r~Vous n'avez pas assez d'argent !\n")
		end
	end)
end)


RegisterServerEvent("Alimentation4")
AddEventHandler("Alimentation4", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
	    if (tonumber(target.money) >= 65) then
			TriggerClientEvent("Eau", source, 65)
			target:removeMoney(65)
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "Vous avez acheter une~b~ Bouteille Eau\n")
		else
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "~r~Vous n'avez pas assez d'argent !\n")
		end
	end)
end)


RegisterServerEvent("Alimentation5")
AddEventHandler("Alimentation5", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
	    if (tonumber(target.money) >= 70) then
			TriggerClientEvent("Limonade", source ,70)
			target:removeMoney(70)
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "Vous avez acheter une~g~ Canette Limonade\n")
		else
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "~r~Vous n'avez pas assez d'argent !\n")
		end
	end)
end)


RegisterServerEvent("Alimentation6")
AddEventHandler("Alimentation6", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
	    if (tonumber(target.money) >= 25) then
			TriggerClientEvent("Pomme", source ,25)
			target:removeMoney(25)
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "Vous avez acheter une~o~ Pomme\n")
		else
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "~r~Vous n'avez pas assez d'argent !\n")
		end
	end)
end)


RegisterServerEvent("Alimentation7")
AddEventHandler("Alimentation7", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
	    if (tonumber(target.money) >= 25) then
			TriggerClientEvent("Orange", source ,25)
			target:removeMoney(25)
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "Vous avez acheter une~o~ Orange\n")
		else
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "~r~Vous n'avez pas assez d'argent !\n")
		end
	end)
end)


RegisterServerEvent("Alimentation8")
AddEventHandler("Alimentation8", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
	    if (tonumber(target.money) >= 25) then
			TriggerClientEvent("Banane", source ,25)
			target:removeMoney(25)
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "Vous avez acheter une~o~ Banane\n")
		else
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "~r~Vous n'avez pas assez d'argent !\n")
		end
	end)
end)


RegisterServerEvent("Alimentation9")
AddEventHandler("Alimentation9", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local player = target.identifier
    	local idjob = idJobShop(player)

    	if(idjob == '34')then
    		TriggerClientEvent("Whisky", source, 0)
    		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez récupéré une~r~ Bouteille de Whisky\n")
	    	
		else
			if (tonumber(target.money) >= 350) then
				TriggerClientEvent("Whisky", source, 350)
				target:removeMoney(350)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de Whisky\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		end
	end)
end)

RegisterServerEvent("Alimentation10")
AddEventHandler("Alimentation10", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local player = target.identifier
    	local idjob = idJobShop(player)

    	if(idjob == '34')then
    		TriggerClientEvent("Vodka", source, 0)
    		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez récupéré une~r~ Bouteille de Vodka\n")
	    	
		else

	    	if (tonumber(target.money) >= 350) then
				TriggerClientEvent("Vodka", source, 350)
				target:removeMoney(350)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de Vodka\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		end
	end)
end)

RegisterServerEvent("Alimentation11")
AddEventHandler("Alimentation11", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)

		local player = target.identifier
    	local idjob = idJobShop(player)

    	if(idjob == '34')then
    		TriggerClientEvent("Rhum", source, 0)
    		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez récupéré une~r~ Bouteille de Rhum\n")
	    	
		else
	    	if (tonumber(target.money) >= 350) then
				TriggerClientEvent("Rhum", source, 350)
				target:removeMoney(350)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de Rhum\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		end
	end)
end)

RegisterServerEvent("Alimentation12")
AddEventHandler("Alimentation12", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)

		local player = target.identifier
    	local idjob = idJobShop(player)

    	if(idjob == '34')then
    		TriggerClientEvent("TequiLaLa", source, 0)
    		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez récupéré une~r~ Bouteille de TequiLaLa\n")
	    	
		else

	    	if (tonumber(target.money) >= 500) then
				TriggerClientEvent("TequiLaLa", source, 500)
				target:removeMoney(500)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de TequiLaLa\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		end
	end)
end)

RegisterServerEvent("Alimentation13")
AddEventHandler("Alimentation13", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local player = target.identifier
    	local idjob = idJobShop(player)

    	if(idjob == '34')then
    		TriggerClientEvent("VodkaBull", source, 0)
    		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez récupéré une~r~ Bouteille de VodkaBull\n")
	    	
		else

	    	if (tonumber(target.money) >= 400) then
				TriggerClientEvent("VodkaBull", source, 400)
				target:removeMoney(400)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de VodkaBull\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
	end)
end)

RegisterServerEvent("Alimentation14")
AddEventHandler("Alimentation14", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local player = target.identifier
    	local idjob = idJobShop(player)

    	if(idjob == '34')then
    		TriggerClientEvent("WhiskyCola", source, 0)
    		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez récupéré une~r~ Bouteille de WhiskyCola\n")
	    	
		else
	    	if (tonumber(target.money) >= 400) then
				TriggerClientEvent("WhiskyCola", source, 400)
				target:removeMoney(400)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de WhiskyCola\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		end
	end)
end)

RegisterServerEvent("Alimentation15")
AddEventHandler("Alimentation15", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local player = target.identifier
    	local idjob = idJobShop(player)

    	if(idjob == '34')then
    		TriggerClientEvent("RhumCola", source, 0)
    		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez récupéré une~r~ Bouteille de RhumCola\n")
	    	
		else
	    	if (tonumber(target.money) >= 400) then
				TriggerClientEvent("RhumCola", source, 400)
				target:removeMoney(400)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de RhumCola\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		end
	end)
end)

RegisterServerEvent("Alimentation16")
AddEventHandler("Alimentation16", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local player = target.identifier
    	local idjob = idJobShop(player)

    	if(idjob == '34')then
    		TriggerClientEvent("TequilalaCola", source, 0)
    		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez récupéré une~r~ Bouteille de TequilalaCola\n")
	    	
		else
	    	if (tonumber(target.money) >= 90) then
				TriggerClientEvent("TequilalaCola", source, 90)
				target:removeMoney(90)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de TequilalaCola\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		end
	end)
end)

RegisterServerEvent("Alimentation17")
AddEventHandler("Alimentation17", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local player = target.identifier
    	local idjob = idJobShop(player)

    	if(idjob == '34')then
    		TriggerClientEvent("TequilalaJuice", source, 0)
    		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez récupéré une~r~ Bouteille de TequilalaJuice\n")
	    	
		else
	    	if (tonumber(target.money) >= 90) then
				TriggerClientEvent("TequilalaJuice", source, 90)
				target:removeMoney(90)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de TequilalaJuice\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		end
	end)
end)

RegisterServerEvent("Alimentation18")
AddEventHandler("Alimentation18", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local player = target.identifier
    	local idjob = idJobShop(player)

    	if(idjob == '34')then
    		TriggerClientEvent("TequilalaCoffee", source, 0)
    		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez récupéré une~r~ Bouteille de TequilalaCoffee\n")
	    	
		else
	    	if (tonumber(target.money) >= 90) then
				TriggerClientEvent("TequilalaCoffee", source, 90)
				target:removeMoney(90)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de TequilalaCoffee\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		end
	end)
end)

RegisterServerEvent("Alimentation19")
AddEventHandler("Alimentation19", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local player = target.identifier
    	local idjob = idJobShop(player)

    	if(idjob == '34')then
    		TriggerClientEvent("TequilalaTea", source, 0)
    		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez récupéré une~r~ Bouteille de TequilalaTea\n")
	    	
		else
	   		if (tonumber(target.money) >= 90) then
				TriggerClientEvent("TequilalaTea", source, 90)
				target:removeMoney(90)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de TequilalaTea\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		end
	end)
end)

RegisterServerEvent("Alimentation20")
AddEventHandler("Alimentation20", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		local player = target.identifier
    	local idjob = idJobShop(player)

    	if(idjob == '34')then
    		TriggerClientEvent("TequilalaLimo", source, 0)
    		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez récupéré une~r~ Bouteille de TequilalaLimo\n")
	    	
		else

	    	if (tonumber(target.money) >= 90) then
				TriggerClientEvent("TequilalaLimo", source, 90)
				target:removeMoney(90)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de TequilalaLimo\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		end
	end)
end)