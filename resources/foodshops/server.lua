require "resources/essentialmode/lib/MySQL"
MySQL:open("151.236.37.159", "gfav_n3m", "gfavn3m", "987654")


RegisterServerEvent("Alimentation1")
AddEventHandler("Alimentation1", function()
	TriggerEvent("es:getPlayerFromId", source, function(target)
	    if (tonumber(target.money) >= 100) then
		TriggerClientEvent("JambonBeurre", source)
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
		TriggerClientEvent("Kebab", source)
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
		TriggerClientEvent("Cola", source)
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
		TriggerClientEvent("Eau", source)
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
		TriggerClientEvent("Limonade", source)
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
		TriggerClientEvent("Pomme", source)
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
		TriggerClientEvent("Orange", source)
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
		TriggerClientEvent("Banane", source)
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
	    if (tonumber(target.money) >= 65) then
		TriggerClientEvent("Eau", source)
		target:removeMoney(65)
		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "Vous avez acheter une~r~ Bouteille Whisky\n")
		else
		TriggerClientEvent("es_freeroam:notify", source, "CHAR_PLANESITE", 1, "Eco Marché", false, "~r~Vous n'avez pas assez d'argent !\n")
		end
	end)
end)

