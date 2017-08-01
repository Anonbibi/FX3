resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

dependency 'essentialmode'


client_script {
	'gui/gui.lua',
	'hcdh/hcdh_client.lua',
    'hcdh/hcdh_client_vehicle.lua',
    'hcdh/hcdh_client_veset.lua',
    'hcdh/hcdh_client_notif.lua',
    'hcdh/hcdh_Menu.lua',
}

server_script {
	'../essentialmode/config.lua',
	'hcdh/hcdh_server.lua',
    'hcdh/hcdh_server_notif.lua',
}

export 'getIsInServiceHdch'

