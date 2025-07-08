local raidActive = false
local lastRaid = 0

CreateThread(function()
    while true do
        Wait(2000)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local dist = #(coords - Config.CartelZone.center)

        if dist < Config.CartelZone.radius and not raidActive then
            TriggerServerEvent('cartel:attemptRaid')
            Wait(10000)
        end
    end
end)

RegisterNetEvent('cartel:spawnGuards', function()
    raidActive = true
    local spawnLoc = Config.CartelZone.center
    for i = 1, 5 do
        local model = Config.GuardModels[math.random(#Config.GuardModels)]
        RequestModel(model) while not HasModelLoaded(model) do Wait(10) end
        local ped = CreatePed(4, model, spawnLoc.x + i*2, spawnLoc.y, spawnLoc.z, 0.0, true, false)
        GiveWeaponToPed(ped, `weapon_assaultrifle`, 100, true, true)
        SetPedRelationshipGroupHash(ped, `HATES_PLAYER`)
        TaskCombatPed(ped, PlayerPedId(), 0, 16)
    end
    TriggerEvent('ox_lib:notify', { title = 'Cartel Territory', description = 'You’ve triggered a raid!', type = 'error' })
end)

RegisterNetEvent('cartel:spawnCrates', function()
    local model = `prop_box_ammo03a`
    RequestModel(model) while not HasModelLoaded(model) do Wait(10) end
    for i = 1, 3 do
        local crate = CreateObject(model, Config.CartelZone.center.x + i * 2.0, Config.CartelZone.center.y, Config.CartelZone.center.z, true, true, true)
        FreezeEntityPosition(crate, true)
    end
end)

RegisterNetEvent('cartel:helicopterChase', function()
    local heli = CreateVehicle(`polmav`, GetEntityCoords(PlayerPedId()) + vector3(0, 0, 60), 0.0, true, false)
    TaskHeliMission(heli, heli, 0, PlayerPedId(), 0.0, 0.0, 0.0, 6, 10.0, -1.0, -1.0, 10, 10)
    Wait(30000)
    DeleteEntity(heli)
end)
