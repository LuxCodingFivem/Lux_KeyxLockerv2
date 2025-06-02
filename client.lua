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
    local data = {}
    _menuPool:CloseAllMenus()

    local PlayerPed = PlayerPedId()
    local PlayerCoords = GetEntityCoords(PlayerPed)

    data.x = PlayerCoords.x
    data.y = PlayerCoords.y
    data.z = PlayerCoords.z

    local CreateKeyLockerMenu = NativeUI.CreateMenu(string.format(Translation[Config.Locale]['create_key_locker_menu_title']), '~b~')
    _menuPool:Add(CreateKeyLockerMenu)

    local CoordXItem = NativeUI.CreateItem(string.format(Translation[Config.Locale]['coord_x_item_title']), string.format(Translation[Config.Locale]['coord_x_item_description']))
    CoordXItem:RightLabel(ESX.Math.Round(PlayerCoords.x, 2))
    CreateKeyLockerMenu:AddItem(CoordXItem)

    local CoordYItem = NativeUI.CreateItem(string.format(Translation[Config.Locale]['coord_y_item_title']), string.format(Translation[Config.Locale]['coord_y_item_description']))
    CoordYItem:RightLabel(ESX.Math.Round(PlayerCoords.y, 2))
    CreateKeyLockerMenu:AddItem(CoordYItem)

    local CoordZItem = NativeUI.CreateItem(string.format(Translation[Config.Locale]['coord_z_item_title']), string.format(Translation[Config.Locale]['coord_z_item_description']))
    CoordZItem:RightLabel(ESX.Math.Round(PlayerCoords.z, 2))
    CreateKeyLockerMenu:AddItem(CoordZItem)

    local SizeItem = NativeUI.CreateItem(string.format(Translation[Config.Locale]['size_item_title']), string.format(Translation[Config.Locale]['size_item_description']))
    CreateKeyLockerMenu:AddItem(SizeItem)

    SizeItem.Activated = function(sender, index)
        local Input = exports['Lux_Input']:Input('number', string.format(Translation[Config.Locale]['input_size']))
        data.size = Input
        SizeItem:RightLabel(Input)
        _menuPool:RefreshIndex()
    end

    local AccessSubMenu = _menuPool:AddSubMenu(CreateKeyLockerMenu, string.format(Translation[Config.Locale]['access_submenu_title']), string.format(Translation[Config.Locale]['access_submenu_description']))
    local PasswordItem = NativeUI.CreateItem(string.format(Translation[Config.Locale]['password_item_title']), string.format(Translation[Config.Locale]['password_item_description']))
    AccessSubMenu.SubMenu:AddItem(PasswordItem)

    PasswordItem.Activated = function(sender, index)
        local Input = exports['Lux_Input']:Input('input', string.format(Translation[Config.Locale]['input_password']))
        data.password = Input
        PasswordItem:RightLabel(Input)
        _menuPool:RefreshIndex()
    end

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