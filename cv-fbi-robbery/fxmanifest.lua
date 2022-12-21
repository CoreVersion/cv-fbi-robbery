fx_version 'adamant'

game 'gta5'
lua54 'yes'
author "royyalbertFZ#2275 and naor#7052"
version "2.0.0"
description "FBI Robbery Script Made By royyalbertFZ#2275 and naor#7052 For CoreVersion • Development"

client_scripts {
    '@PolyZone/client.lua',
    'client/client.lua',
    'client/main.lua'--WareHouse
}

server_scripts {
    'server/server.lua',
    'server/main.lua'--WareHouse
}

shared_scripts {
	'config.lua'
}

dependencies {
    'PolyZone',
    'qb-target'
}