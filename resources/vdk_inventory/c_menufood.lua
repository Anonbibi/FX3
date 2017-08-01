-- [Id] = calories, water, needs
menus = {
	[22] = {
		calories=15,
		water=0,
		needs=-3,
		drunk=0
	},
	[30] = {
		calories=25,
		water=0,
		needs=-5,
		drunk=0
	},
	[25] = {
		calories=0,
		water=15,
		needs=-8,
		drunk=1
	},
	[26] = {
		calories=6,
		water=3,
		needs=-2,
		drunk=0
	},
	[27] = {
		calories=0,
		water=35,
		needs=-8,
		drunk=1
	},
	[6] = {
		calories=0,
		water=20,
		needs=-4,
		drunk=0
	}	
}

function Chat(t)
	TriggerEvent("chatMessage", 'TRUCKER', { 0, 255, 255}, "" .. tostring(t))
end

RegisterNetEvent("item:drunk")
AddEventHandler("item:drunk", function(item)
		--Chat(menus[item].drunk)
		if menus[item].drunk == 1 then
		  Citizen.Wait(500)
          --ClearPedTasksImmediately(GetPlayerPed(-1))
          SetTimecycleModifier("spectator5")
          SetPedMotionBlur(GetPlayerPed(-1), true)
          SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", true)
          SetPedIsDrunk(GetPlayerPed(-1), true)
          Citizen.Wait(30000)
          ClearTimecycleModifier()
          ResetScenarioTypesEnabled()
          ResetPedMovementClipset(GetPlayerPed(-1), 0)
          SetPedIsDrunk(GetPlayerPed(-1), false)
          SetPedMotionBlur(GetPlayerPed(-1), false)
		  -- Stop the mini mission
          --Citizen.Trace("Going back to reality\n")
        end
end)

Citizen.CreateThread(function()
    while true do
       Wait(0)

       RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
           while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
            Citizen.Wait(0)
           end
    end
end)
