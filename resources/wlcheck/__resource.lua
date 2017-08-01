--[[---------------------------------------------------------------------------------
||                                                                                  ||
||                      WHITELIST CHECKING SCRIPT - GTA5 - FiveM                    ||
||                                   Author = Shedow                                ||
||                            Created for N3MTV community                           ||
||                                                                                  ||
----------------------------------------------------------------------------------]]--

server_script {
	'../essentialmode/config.lua',
	'wlcheck_server.lua',
}
			  		  
client_script {
	'wlcheck_client.lua',
}
			  
dependency 'essentialmode'