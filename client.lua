-- Configuration
local Config = {
    afkTime = 300,              -- Time in seconds before a player is considered AFK (5 minutes)
    notificationInterval = 5,   -- Interval in seconds between AFK notifications
    warningNotification = true, -- Show a warning notification before being considered AFK
    warningTime = 30,           -- Seconds before AFK when to show warning
    inputControl = true,        -- Also controls player input, not just position
    debugMode = false           -- Debug mode to test the script
}

local isAFK = false
local lastActivity = 0
local lastPosition = vector3(0, 0, 0)
local lastHeading = 0
local lastInput = 0

-- Function to check if player is active
local function checkActivity()
    local playerPed = PlayerPedId()
    if not playerPed or not DoesEntityExist(playerPed) then return false end
    
    local active = false
    local currentPosition = GetEntityCoords(playerPed, true)
    local currentHeading = GetEntityHeading(playerPed)
    
    if #(currentPosition - lastPosition) > 0.5 or math.abs(currentHeading - lastHeading) > 1.0 then
        active = true
    end
    
    if Config.inputControl then
        if IsControlPressed(0, 32) or IsControlPressed(0, 33) or -- W, S
           IsControlPressed(0, 34) or IsControlPressed(0, 35) or -- A, D
           IsControlPressed(0, 24) or IsControlPressed(0, 25) then -- Attack, Aim
            active = true
        end
    end
    
    lastPosition = currentPosition
    lastHeading = currentHeading
    
    return active
end

-- Function to show AFK notification
local function showAFKNotification()
    ExecuteCommand("me ~r~Player AFK~r~")
    
    -- Display AFK notification using lib.notify
    lib.notify({
        id = 'ardenhub_afk',
        title = 'AFK SYSTEM',
        description = 'You are currently in AFK mode',
        type = 'error',
        duration = 5000,
        position = 'top-right',
        icon = 'user-clock',
        iconColor = '#ff0000'
    })
    
    if Config.debugMode then
        print("[AFK System] AFK notification sent")
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        
        local playerPed = PlayerPedId()
        if playerPed and DoesEntityExist(playerPed) then
            local active = checkActivity()
            
            if active then
               
                lastActivity = GetGameTimer()
                
                if isAFK then
                    isAFK = false
                    if Config.debugMode then
                        print("[AFK System] No longer AFK")
                    end
                end
            else
                local timePassed = (GetGameTimer() - lastActivity) / 1000
                
                if Config.warningNotification and not isAFK and timePassed >= (Config.afkTime - Config.warningTime) then
                    -- Show warning notification using lib.notify
                    lib.notify({
                        id = 'ardenhub_afk_warning',
                        title = 'AFK SYSTEM',
                        description = 'You will be considered AFK in ' .. math.ceil(Config.afkTime - timePassed) .. ' seconds!',
                        type = 'warning',
                        duration = 4000,
                        position = 'top-right',
                        icon = 'triangle-exclamation',
                        iconColor = '#ffcc00'
                    })
                end
                
                if timePassed >= Config.afkTime then
                    if not isAFK then
                        isAFK = true
                        showAFKNotification()
                        if Config.debugMode then
                            print("[AFK System] Player now AFK")
                        end
                    else
                        if (timePassed % Config.notificationInterval) < 1 then
                            showAFKNotification()
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    lastActivity = GetGameTimer()
    local playerPed = PlayerPedId()
    if playerPed then
        lastPosition = GetEntityCoords(playerPed, true)
        lastHeading = GetEntityHeading(playerPed)
    end
    
    if Config.debugMode then
        print("[AFK System] Initialized - AFK Time: " .. Config.afkTime .. "s")
    end
end)