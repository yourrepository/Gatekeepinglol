RunService.Heartbeat:Connect(function()
    local closestPlayer = nil
    local closestDistance = math.huge

    local localCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local localHumanoidRootPart = localCharacter:FindFirstChild("HumanoidRootPart")
    if not localHumanoidRootPart then return end
    local localPosition = localHumanoidRootPart.Position


    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            local character = playerCharacters:FindFirstChild(player.Name)
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local distance = (localPosition - humanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= MAX_DISTANCE then
                    closestPlayer = player
                    closestDistance = distance
                end
            end
        end
    end


    if closestPlayer then
        local closestCharacter = playerCharacters:FindFirstChild(closestPlayer.Name)
        local humanoid = closestCharacter and closestCharacter:FindFirstChildOfClass("Humanoid")
        local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
        local closestHumanoidRootPart = closestCharacter and closestCharacter:FindFirstChild("HumanoidRootPart")

        if animator and closestHumanoidRootPart then
      
            local directionToLocalPlayer = (localPosition - closestHumanoidRootPart.Position).Unit
            local facingDirection = closestHumanoidRootPart.CFrame.LookVector

            local dotProduct = directionToLocalPlayer:Dot(facingDirection)
            local isLookingAtYou = dotProduct > 0.7

            if isLookingAtYou then
                for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                    if isMonitoredAnimation(track.Animation.AnimationId) then
    
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, nil)
                        
                    
                        print("Pressed F for player:", closestPlayer.Name, "Distance:", closestDistance)
                        
                        break
                    end
                end
            else
                print("Player", closestPlayer.Name, "is not looking at you.")
            end
        end
    end
end)
