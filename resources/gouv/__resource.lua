resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

dependency 'essentialmode'

-- ui_page 'gui/ui.html'

files {
	--'gui/ui.html',
	--'gui/job-icon.png',
	--'gui/pricedown.ttf',
	
}

client_script {
	'gui/gui.lua',
	'gouv/gouv_client.lua',
    'gouv/gouv_client_vehicle.lua',
    'gouv/gouv_client_veset.lua',
    'gouv/gouv_client_notif.lua',
    'gouv/gouv_Menu.lua',
}

server_script {
	'../essentialmode/config.lua',
	'gouv/gouv_server.lua',
    'gouv/gouv_server_notif.lua',
}

export 'getIsInServiceAgent'

