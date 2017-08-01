--
-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 22/05/2017
-- Time: 07:59
-- To change this template use File | Settings | File Templates.

ui_page 'html/ui.html'
files {
    'html/ui.html',
    'html/pricedown.ttf',
    'html/vhighlander.ttf',
    'html/cursor.png',
    'html/styles.css',
    'html/scripts.js',
    'html/debounce.min.js'
}

client_script "client.lua"
server_script "server.lua"
server_script '@mysql-async/lib/MySQL.lua'

