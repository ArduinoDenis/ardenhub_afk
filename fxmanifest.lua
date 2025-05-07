fx_version 'cerulean'
games { 'gta5' }
author 'arduinodenis.it'
description 'AFK System'
version '1.0.0'

dependency 'ox_lib'

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client.lua'
}