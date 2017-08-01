dependency 'vdk_inventory'

server_scripts {
	'../essentialmode/config.lua',
	-- 'config.lua',
	'server.lua'
}

client_script {
	'vdkrec.lua'
}

server_script '@mysql-async/lib/MySQL.lua'
