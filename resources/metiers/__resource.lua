resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

dependency 'essentialmode'

ui_page 'gui/ui.html'

files {
	'gui/ui.html',
	'gui/job-icon.png',
	'gui/pricedown.ttf',
	"gui/chomeur.png",
	"gui/mineur.png",
	"gui/bucheron.png",
	"gui/fermier.png",
	"gui/pecheur.png",
	"gui/brasseur.png",
	"gui/vigneron.png",
	"gui/ambulancier.png",
	"gui/mecano.png",
	"gui/taxi.png",
	"gui/[LSPD] Sergent-Chef.png",
	"gui/[LSPD] Sergent.png",
	"gui/[LSPD] Recrue.png",
	"gui/[LSPD] Lieutenant-Chef.png",
	"gui/[LSPD] Lieutenant.png",
	"gui/[LSPD] Commandant.png",
	"gui/[LSPD] Capitaine.png",
	"gui/[LSPD] Brigadier-Chef.png",
	"gui/[LSPD] Brigadier.png",
	"gui/[$] Grand Bandit.png",
	"gui/[GOUV]_President.png",
	"gui/[GOUV]_Agent.png",
	"gui/[HCDH] Representente.png",
	"gui/[BOSS] Metal Co.png",
	
}

client_script {
	'gui/gui.lua',
	'poleemploi/metiers_config.lua',
	'chomeur/chomeur_config.lua',
	'fermier/fermier_config.lua',
	'bucheron/bucheron_config.lua',
	'mineur/mineur_config.lua',
	'pecheur/pecheur_config.lua',
	'vigneron/vigneron_config.lua',
	'brasseur/brasseur_config.lua',
	'police/police_client.lua',
    'police/police_client_vehicle.lua',
    'police/police_client_veset.lua',
    'police/police_client_notif.lua',
    'police/police_Menu.lua',
	'poleemploi/metiers_client.lua',
	'chomeur/chomeur_client.lua',
	'fermier/fermier_client.lua',
	'bucheron/bucheron_client.lua',
	'mineur/mineur_client.lua',
	'pecheur/pecheur_client.lua',
	'vigneron/vigneron_client.lua',
	'brasseur/brasseur_client.lua',
	'mecano/mecano_client.lua',
	'mecano/mecano_Menu.lua',
	--'gouv/gouv_client.lua',
    --'gouv/gouv_client_vehicle.lua',
    --'gouv/gouv_client_veset.lua',
    --'gouv/gouv_client_notif.lua',
    --'gouv/gouv_Menu.lua',
}

server_script {
	'../essentialmode/config.lua',
	'poleemploi/metiers_server.lua',
	'chomeur/chomeur_server.lua',
	'police/police_server.lua',
    'police/police_server_notif.lua',
	'fermier/fermier_server.lua',
	'bucheron/bucheron_server.lua',
	'mineur/mineur_server.lua',
	'pecheur/pecheur_server.lua',
	'vigneron/vigneron_config.lua',
	'vigneron/vigneron_server.lua',
	'brasseur/brasseur_config.lua',
	'brasseur/brasseur_server.lua',
	'mecano/mecano_server.lua',
	--'gouv/gouv_server.lua',
    --'gouv/gouv_server_notif.lua',
}

export 'getIsInService'
export 'getIsInServiceHdch'

