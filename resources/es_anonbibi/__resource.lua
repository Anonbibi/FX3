-- Manifest
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Requiring essentialmode
dependency 'essentialmode'

client_script 'startmine.lua'
client_script 'startboulange.lua'
client_script 'startbucheron.lua'
client_script 'startvitrier.lua'
client_script 'startvigneron.lua'
client_script 'startfermier.lua'
--client_script 'police/client/GUI.lua'
--client_script 'police/client/policegaragenews.lua'

client_script 'cascade/client.lua'
client_script'cascade/GUI.lua'

client_script 'taxi/client.lua'
client_script'taxi/GUI.lua'

-- client_script 'gouvernement/client.lua'
-- client_script'gouvernement/GUI.lua'

-- client_script 'hospital/client.lua'
-- client_script'hospital/GUI.lua'

client_script 'depannage/client.lua'
client_script'autoecole/GUI.lua'

client_script 'autoecole/client.lua'
client_script'depannage/GUI.lua'

--server_script 'police/server/svpolicegaragenews.lua'

server_script 'cascade/server.lua'
server_script 'taxi/server.lua'
-- server_script 'hospital/server.lua'
server_script 'depannage/server.lua'
server_script 'autoecole/server.lua'

-- server_script 'gouvernement/server.lua'