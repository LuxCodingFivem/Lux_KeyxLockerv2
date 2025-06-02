fx_version 'cerulean'
games { 'gta5' }

author 'Luxcoding'
version '2.0.0'

lua54 'yes'

shared_scripts {
	'@NativeUILua_Reloaded/src/NativeUIReloaded.lua',
}

escrow_ignore {
    'config.lua',
    'client.lua',
    'server.lua'
}

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server.lua'
}