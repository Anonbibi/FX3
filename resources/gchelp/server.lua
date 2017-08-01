--====================================================================================
-- #Author: Jonathan D @ Gannon
--
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================


--====================================================================================
--  Help
--====================================================================================
TriggerEvent('es:addCommand', 'help', function(source, args, user)
    TriggerClientEvent('gc:openHelp', source, 'help')
end)

TriggerEvent('es:addCommand', 'rules', function(source, args, user)
    TriggerClientEvent('gc:openHelp', source, 'rules')
end)
