fx_version 'cerulean'
games { 'gta5' }

author 'Esc Store'
description 'Esc-GuideBook'
version '1.0.0'
repository 'https://esc.tebex.io'

ui_page 'index.html'

shared_scripts {'config.lua'}

files {
'index.html',
'css/index.css',
'script/index.js',
'assets/*.png'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

lua54 'yes'
