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
            OpenCreateKeyLockerMenu()
        else
            ESX.ShowNotification(string.format(Translation[Config.Locale]['command_no_access']))
        end
    end)
end, false)

function OpenCreateKeyLockerMenu()
    _menuPool:CloseAllMenus()

    local PlayerPed = PlayerPedId()
    local PlayerCoords = GetEntityCoords(PlayerPed)

    local CreateKeyLockerMenu = NativeUI.CreateMenu(string.format(Translation[Config.Locale]['create_key_locker_menu_title']), '~b~')
    _menuPool:Add(CreateKeyLockerMenu)

    local CoordXItem = NativeUI.CreateItem('X:', '')
    CoordXItem:RightLabel(ESX.Math.Round(PlayerCoords.x, 2))
    CreateKeyLockerMenu:AddItem(CoordXItem)

    local CoordYItem = NativeUI.CreateItem('Y:', '')
    CoordYItem:RightLabel(ESX.Math.Round(PlayerCoords.y, 2))
    CreateKeyLockerMenu:AddItem(CoordYItem)

    local CoordZItem = NativeUI.CreateItem('Z:', '')
    CoordZItem:RightLabel(ESX.Math.Round(PlayerCoords.z, 2))
    CreateKeyLockerMenu:AddItem(CoordZItem)

    local CloseItem = NativeUI.CreateItem(string.format(Translation[Config.Locale]['close_item_title']), string.format(Translation[Config.Locale]['close_item_description']))
    CreateKeyLockerMenu:AddItem(CloseItem)
    
    CloseItem.Activated = function(sender, index)
        _menuPool:CloseAllMenus()
    end
    
    CreateKeyLockerMenu:Visible(true)
    _menuPool:RefreshIndex()
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end