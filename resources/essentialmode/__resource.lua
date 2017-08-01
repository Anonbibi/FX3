-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --

-- Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'EssentialMode by Kanersps.'

ui_page 'ui.html'

-- Server
server_scripts { 
	'server/util.lua',
	'server/main.lua',
	'server/classes/player.lua',
	--'server/classes/groups.lua', Pas compatible (metatables)
	'server/player/login.lua',
	'@mysql-async/lib/MySQL.lua'
}

-- Client
client_scripts {
	'client/main.lua'
}

-- NUI Files
files {
	'ui.html',
	'pdown.ttf'
}

server_exports {
	'getPlayerFromId',
	'addAdminCommand',
	'addCommand',
	'addGroupCommand'
}