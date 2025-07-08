fx_version 'cerulean'
game 'gta5'

author 'Deandre Lindsey'
description 'PvE Cartel Raid System with Assassins, Helicopter Chases, Cooldowns'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

files {
    'locales/*.json',
    'html/*'
}

ui_page 'html/index.html'
