local allowWanted = false

RegisterNetEvent("allowWanted")
AddEventHandler("allowWanted", function()
	if not allowWanted then
		allowWanted = true
                TriggerEvent("chatMessage", "", { 0, 0, 0 }, "Never Wanted: OFF!")
	else
		allowWanted = false
                TriggerEvent("chatMessage", "", { 0, 0, 0 }, "Never Wanted: ON!")
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not allowWanted then
                        SetPlayerWantedLevel(PlayerId(), 0, false)
                        SetPlayerWantedLevelNow(PlayerId(), false)
		end

		if allowWanted then
		end
	end
end)