--=============================================================================
--  Jonathan D @ Gannon
--=============================================================================

-- General
client_scripts {
  'utils.lua',
  'weeds/weed_common.lua',
  'weeds/weed_client.lua',

  'meth/meth_client.lua',
}

server_scripts {
  'weeds/weed_common.lua',
  'weeds/weed_server.lua'
}

dependency 'vdk_inventory'