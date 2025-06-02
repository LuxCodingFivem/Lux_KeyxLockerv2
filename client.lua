ESX = exports['es_extended']:getSharedObject()

_menuPool = NativeUI.CreatePool()

CreateThread(function()
    while true do
        Wait(1)
        if _menuPool:IsAnyMenuOpen() then
            _menuPool:ProcessMenus()
        else
            Wait(150) -- this small line
        end
     end
end)

RegisterCommand('CreateKeyLocker', function(source, args)
    ESX.TriggerServerCallback('Lux_KeyLockerv2:getGroup', function(group) 
        if group == 'admin' then 
            print('test')
        else
            ESX.ShowNotification(string.format(Translation[Config.Locale]['command_no_access']))
        end
    end)
end, false)