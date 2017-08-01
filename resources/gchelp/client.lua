--====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================

-- restart gchelp

--====================================================================================
--  Config
--====================================================================================
KeyClose = 177 -- PhoneCancel




--====================================================================================
--  User Event
--====================================================================================
RegisterNetEvent("gc:openHelp")
AddEventHandler("gc:openHelp", function(typeHelp)
  openGui(typeHelp)
end)


--====================================================================================
--  Gestion UI
--====================================================================================
function openGui(typeHelp)
Citizen.Trace('openGui: ' .. typeHelp)
  SendNUIMessage({method = 'openGui', typeHelp = typeHelp})
  menuIsOpen = 1
end

function closeGui()
  SendNUIMessage({method = 'closeGui'})
  menuIsOpen = 0
end

--====================================================================================
--  Thread
--====================================================================================
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if menuIsOpen ~= 0 and IsControlJustPressed(1, KeyClose) then
        closeGui()
    end
  end
end)