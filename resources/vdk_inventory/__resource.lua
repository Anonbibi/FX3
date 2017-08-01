server_scripts {
	'server.lua'
}
client_script {
	'vdkinv.lua',
	'GUI.lua',
	'anims.lua'
}

export 'getQuantity'
export 'notFull'

server_script '@mysql-async/lib/MySQL.lua'