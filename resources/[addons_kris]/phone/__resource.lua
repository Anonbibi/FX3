--
-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 17/05/2017
-- Time: 16:50
-- To change this template use File | Settings | File Templates.
--


ui_page 'ui/ui.html'
files {
    'ui/ui.html',
    'ui/animate.css',
    'ui/pdown.ttf',
    'ui/voice_of_the_highlander.ttf'
}

server_scripts {
    '../../essentialmode/config.lua',
    'server.lua'
}
client_script {
    'GUI.lua',
    'client.lua',
}
