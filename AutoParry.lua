local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")

-- Toggle state
_G.isToggled = _G.isToggled or false -- false is enabled, true is disabled

-- Function to toggle the script on or off
local function toggleScript(state)
    _G.isToggled = state
    print("Script toggled to:", state and "Enabled" or "Disabled")
end

-- Call this to toggle the script dynamically
toggleScript(not _G.isToggled)

-- Maximum allowed distance
local MAX_DISTANCE = 10

-- Load animation IDs from a separate loadstring link
local animationSet = {}
local animationsUrl = "https://raw.githubusercontent.com/yourrepository/Gatekeepinglol/refs/heads/main/AutoParryHelper.lua" -- Replace with your raw link

local success, animations = pcall(function()
    return loadstring(game:HttpGet(animationsUrl))()
end)

if success and animations then
    for _, id in ipairs(animations) do
        animationSet[id] = true
    end
else
    warn("Failed to load animations:", animations)
end

-- Function to check if an animation is monitored
local function isMonitoredAnimation(animationId)
    return animationSet[animationId] ~= nil
end

-- Local player and workspace character folder
local localPlayer = Players.LocalPlayer
local playerCharacters = workspace:WaitForChild("PlayerCharacters")

-- Cache local character and humanoid root part
local localCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local localHumanoidRootPart = localCharacter:WaitForChild("HumanoidRootPart")

-- Update local character and root part on respawn
localPlayer.CharacterAdded:Connect(function(character)
    localCharacter = character
    localHumanoidRootPart = character:WaitForChild("HumanoidRootPart")
    print("Local character updated on respawn")
end)

-- Monitor new players
Players.PlayerAdded:Connect(function(player)
    print("New player added:", player.Name)
end)

-- Optimize detection loop
RunService.Heartbeat:Connect(function()
    if not _G.isToggled then return end -- Exit if script is toggled off

    local closestPlayer = nil
    local closestDistance = MAX_DISTANCE

    local localPosition = localHumanoidRootPart.Position

    -- Find the closest player within the maximum distance
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            local character = playerCharacters:FindFirstChild(player.Name)
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local distance = (localPosition - humanoidRootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestPlayer = player
                        closestDistance = distance
                    end
                end
            end
        end
    end

    -- Monitor animations on the closest player within the maximum distance
    if closestPlayer then
        local closestCharacter = playerCharacters:FindFirstChild(closestPlayer.Name)
        local humanoid = closestCharacter and closestCharacter:FindFirstChildOfClass("Humanoid")
        local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
        if animator then
            for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                if isMonitoredAnimation(track.Animation.AnimationId) then
                    -- Check if the animation is within the first 500 milliseconds
                    if track.TimePosition <= 0.5 then
                        -- Simulate pressing "F" immediately
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, nil)

                        -- Debugging: Print the distance when "F" is pressed
                        print("Pressed F for player:", closestPlayer.Name, "Distance:", closestDistance)

                        -- Break out of the loop after detecting one animation
                        return
                    else
                        -- Debugging: Animation skipped due to exceeding time limit
                        print("Skipped animation for player:", closestPlayer.Name, "TimePosition:", track.TimePosition)
                    end
                end
            end
        end
    end
end)
