local isHolding = false

RegisterCommand('+flashlights', function()
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if GetPedInVehicleSeat(vehicle, -1) == playerPed and not isHolding then
            if IsControlPressed(0, 21) or IsDisabledControlPressed(0, 21) then
                local _, _, highbeamsOn = GetVehicleLightsState(vehicle)
                local targetState = not (highbeamsOn == 1)

                isHolding = true

                CreateThread(function()
                    while isHolding do
                        SetVehicleFullbeam(vehicle, targetState)
                        Wait(0)
                    end
                    SetVehicleFullbeam(vehicle, not targetState)
                end)
            end
        end
    end
end, false)

RegisterCommand('-flashlights', function()
    isHolding = false
end, false)

RegisterKeyMapping('+flashlights', Config.defautKeyName, 'keyboard', Config.defautKey)
