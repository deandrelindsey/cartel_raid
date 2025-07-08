local QBCore = exports['qbx_core']:GetCoreObject()
local lastRaidTime = 0
local cooldownEnds = 0

local function inCooldown()
    return os.time() < cooldownEnds
end

RegisterServerEvent('cartel:attemptRaid')
AddEventHandler('cartel:attemptRaid', function()
    local src = source
    if inCooldown() then
        TriggerClientEvent('ox_lib:notify', src, {
            title = "Cartel",
            description = "Too soon. The cartel is on alert.",
            type = "error"
        })
        return
    end

    lastRaidTime = os.time()
    cooldownEnds = lastRaidTime + (3600 * math.random(Config.RaidCooldownHours.min, Config.RaidCooldownHours.max))

    if Config.AlertPolice then
        local coords = GetEntityCoords(GetPlayerPed(src))
        TriggerClientEvent('chat:addMessage', -1, {
            args = { "^1[911]", "Shots fired at cartel location near Sandy Shores!" }
        })
    end

    TriggerClientEvent('cartel:spawnGuards', src)
    Wait(5000)
    TriggerClientEvent('cartel:spawnCrates', src)
    Wait(15000)
    TriggerClientEvent('cartel:helicopterChase', src)
end)
