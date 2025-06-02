ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('Lux_KeyLockerv2:getGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()

    cb(group)
end)

RegisterServerEvent('Lux_KeyLockerv2:SaveKeyLocker')
AddEventHandler('Lux_KeyLockerv2:SaveKeyLocker', function(data)
    MySQL.Async.fetchAll('SELECT COALESCE((SELECT MIN(t1.keylocker_id + 1) FROM lux_keylocker t1 LEFT JOIN lux_keylocker t2 ON t1.keylocker_id + 1 = t2.keylocker_id WHERE t2.keylocker_id IS NULL), 1) AS freie_id', {}, function(result)
        MySQL.Async.execute('INSERT INTO lux_keylocker (keylocker_id, x, y, z, size, lable, password) VALUES (@keylocker_id, @x, @y, @z, @size, @lable, @password)', {
            ['@keylocker_id'] = result[1].freie_id,
            ['@x'] = data.x,
            ['@y'] = data.y,
            ['@z'] = data.z,
            ['@size'] = data.size or 0.5,
            ['@lable'] = data.label or '',
            ['@password'] = data.password or '',
        })

        if (#data.items > 0) then 
            for i=1, #data.items, 1 do 
                MySQL.Async.execute('INSERT INTO lux_keylocker_items (keylocker_id, item) VALUES (@keylocker_id, @item)', {
                    ['@keylocker_id'] = result[1].freie_id,
                    ['@item'] = data.items[i],
                })
            end
        end
    end)
end)