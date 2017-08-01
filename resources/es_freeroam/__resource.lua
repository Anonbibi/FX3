-- resource_type 'gametype' { name = 'es_freeroam'}

-- description 'FiveM es_freeroam'

-- -- Manifest
-- resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- -- Requiring essentialmode
-- dependency 'essentialmode'

-- General
client_scripts {
  'client.lua',
  --'events/smoke.lua',
--  'events/fleecaJob.lua',
  --'player/map.lua',
  --'player/scoreboard.lua',
}

server_scripts {
  --'config.lua',
  --'server.lua',
  --'player/commands.lua',
}
--server_script '@mysql-async/lib/MySQL.lua'
