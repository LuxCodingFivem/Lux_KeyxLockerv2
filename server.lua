ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('Lux_KeyLockerv2:getGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()

    cb(group)
end)