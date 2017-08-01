require "resources/essentialmode/lib/MySQL"
MySQL:open("151.236.37.159", "gfav_n3m", "gfavn3m", "987654")


RegisterServerEvent("Tequilaladrink9")
AddEventHandler("Tequilaladrink9", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		
			if (tonumber(target.money) >= 350) then
				TriggerClientEvent("Whisky", source, 350)
				target:removeMoney(350)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de Whisky\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		
	end)
end)

RegisterServerEvent("Tequilaladrink10")
AddEventHandler("Tequilaladrink10", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		

	    	if (tonumber(target.money) >= 350) then
				TriggerClientEvent("Vodka", source, 350)
				target:removeMoney(350)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de Vodka\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		
	end)
end)

RegisterServerEvent("Tequilaladrink11")
AddEventHandler("Tequilaladrink11", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)

		
	    	if (tonumber(target.money) >= 350) then
				TriggerClientEvent("Rhum", source, 350)
				target:removeMoney(350)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de Rhum\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		
	end)
end)

RegisterServerEvent("Tequilaladrink12")
AddEventHandler("Tequilaladrink12", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
	
	    	if (tonumber(target.money) >= 500) then
				TriggerClientEvent("TequiLaLa", source, 500)
				target:removeMoney(500)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de TequiLaLa\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		
	end)
end)

RegisterServerEvent("Tequilaladrink13")
AddEventHandler("Tequilaladrink13", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		
	    	if (tonumber(target.money) >= 400) then
				TriggerClientEvent("VodkaBull", source, 400)
				target:removeMoney(400)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de VodkaBull\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
	end)
end)

RegisterServerEvent("Tequilaladrink14")
AddEventHandler("Tequilaladrink14", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		
	    	if (tonumber(target.money) >= 400) then
				TriggerClientEvent("WhiskyCola", source, 400)
				target:removeMoney(400)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de WhiskyCola\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		
	end)
end)

RegisterServerEvent("Tequilaladrink15")
AddEventHandler("Tequilaladrink15", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		
	    	if (tonumber(target.money) >= 400) then
				TriggerClientEvent("RhumCola", source, 400)
				target:removeMoney(400)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de RhumCola\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		
	end)
end)

RegisterServerEvent("Tequilaladrink16")
AddEventHandler("Tequilaladrink16", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
	    	if (tonumber(target.money) >= 90) then
				TriggerClientEvent("TequilalaCola", source, 90)
				target:removeMoney(90)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de TequilalaCola\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		
	end)
end)

RegisterServerEvent("Tequilaladrink17")
AddEventHandler("Tequilaladrink17", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		
	    	if (tonumber(target.money) >= 90) then
				TriggerClientEvent("TequilalaJuice", source, 90)
				target:removeMoney(90)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de TequilalaJuice\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		
	end)
end)

RegisterServerEvent("Tequilaladrink18")
AddEventHandler("Tequilaladrink18", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
		
	    	if (tonumber(target.money) >= 90) then
				TriggerClientEvent("TequilalaCoffee", source, 90)
				target:removeMoney(90)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de TequilalaCoffee\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		
	end)
end)

RegisterServerEvent("Tequilaladrink19")
AddEventHandler("Tequilaladrink19", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
	   		if (tonumber(target.money) >= 90) then
				TriggerClientEvent("TequilalaTea", source, 90)
				target:removeMoney(90)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de TequilalaTea\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
		
	end)
end)

RegisterServerEvent("Tequilaladrink20")
AddEventHandler("Tequilaladrink20", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
    		
	    	if (tonumber(target.money) >= 90) then
				TriggerClientEvent("TequilalaLimo", source, 90)
				target:removeMoney(90)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "Vous avez acheter une~r~ Bouteille de TequilalaLimo\n")
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Tequilala", false, "~r~Vous n'avez pas assez d'argent !\n")
			end
	end)
end)




