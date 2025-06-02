ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('Lux_KeyLockerv2:getGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()

    cb(group)
end)

RegisterServerEvent('Lux_KeyLockerv2:SaveKeyLocker')
AddEventHandler('Lux_KeyLockerv2:SaveKeyLocker', function(data)
    MySQL.Async.fetchAll('SELECT COALESCE((SELECT MIN(t1.id + 1) FROM lux_keylocker t1 LEFT JOIN lux_keylocker t2 ON t1.id + 1 = t2.id WHERE t2.id IS NULL), 1) AS freie_id', {}, function(result)
        MySQL.Async.execute('INSERT INTO lux_keylocker (id, x, y, z, size, lable, password) VALUES (@id, @x, @y, @z, @size, @lable, @password)', {
            ['@id'] = result[1].freie_id,
            ['@x'] = data.x,
            ['@y'] = data.y,
            ['@z'] = data.z,
            ['@size'] = data.size or 0.5,
            ['@lable'] = data.label or '',
            ['@password'] = data.password or '',
        })
    end)


    -- for i=1, #data.items, 1 do 
    --     MySQL.Async.execute('INSERT INTO lux_keylocker_items (locker_id, item) VALUES (@locker_id, @item)', {
    --         ['@locker_id'] = last_insert_rowid(),
    --         ['@item'] = data.items[i],
    --     })
    -- end
end)