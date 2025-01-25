local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Current player
local localPlayer = Players.LocalPlayer
local playerCharacters = workspace:WaitForChild("PlayerCharacters")

-- Maximum allowed distance
local MAX_DISTANCE = 12

-- Toggle variable
_G.AutoParryEnabled = not _G.AutoParryEnabled -- Toggles between true and false each time the script is executed

-- Function to check if an animation is monitored
local animationSet = {} -- Animation set for lookup
local function isMonitoredAnimation(animationId)
    return animationSet[animationId] ~= nil
end

-- Add animation IDs to the animation set (Example: Add them programmatically or replace with your list)
for _, id in ipairs({
    -- Add your animation IDs here
      "rbxassetid://13458932087",
"rbxassetid://13458929077",
"rbxassetid://13458927861",
"rbxassetid://11696678844",
"rbxassetid://11696676120",
"rbxassetid://11696668442",
"rbxassetid://13487576270",
"rbxassetid://13487573091",
"rbxassetid://13487566685",
"rbxassetid://13499406618",
"rbxassetid://13499414413",
"rbxassetid://13499420642",
"rbxassetid://13458987024",
"rbxassetid://13458986160",
"rbxassetid://13458984551",
"rbxassetid://7533335921",
"rbxassetid://7533334962",
"rbxassetid://7533333743",
"rbxassetid://13488192017",
"rbxassetid://13488184383",
"rbxassetid://13488180372",
"rbxassetid://13459032381",
"rbxassetid://13459030184",
"rbxassetid://17050543918",
"rbxassetid://17050528632",
"rbxassetid://17050507041",
"rbxassetid://13513196385",
"rbxassetid://13513189886",
"rbxassetid://13513183910",
"rbxassetid://13453459729",
"rbxassetid://13453458401",
"rbxassetid://13460352630",
"rbxassetid://13460348445",
"rbxassetid://13460344260",
"rbxassetid://13458917637",
"rbxassetid://13458917033",
"rbxassetid://13458915980",
"rbxassetid://12157712325",
"rbxassetid://12157706721",
"rbxassetid://12157718032",
"rbxassetid://13454796982",
"rbxassetid://13454799116",
"rbxassetid://13454795171",
"rbxassetid://70831581241159",
"rbxassetid://104177904133176",
"rbxassetid://73703056374129",
"rbxassetid://13458958014",
"rbxassetid://13458956015",
"rbxassetid://13458954358",
"rbxassetid://17797807299",
"rbxassetid://17797657098",
"rbxassetid://17797748395",
"rbxassetid://13454387127",
"rbxassetid://13454380936",
"rbxassetid://13454374590",
"rbxassetid://17073860782",
"rbxassetid://17073851029",
"rbxassetid://17073840215",
"rbxassetid://11403403549",
"rbxassetid://11403400425",
"rbxassetid://11403397524",
"rbxassetid://11775624187",
"rbxassetid://11775622157",
"rbxassetid://11775620193",
"rbxassetid://13470952920",
"rbxassetid://13470948534",
"rbxassetid://13470946444",
"rbxassetid://13458905710",
"rbxassetid://13458904664",
"rbxassetid://13458903399",
"rbxassetid://13321538279",
"rbxassetid://13321539329",
"rbxassetid://13321535163",
"rbxassetid://13513291103",
"rbxassetid://13513287193",
"rbxassetid://13513283385",
"rbxassetid://13458945372",
"rbxassetid://13458943622",
"rbxassetid://13458941967",
"rbxassetid://13458877566",
"rbxassetid://13458875688",
"rbxassetid://13458873611",
"rbxassetid://13460385836",
"rbxassetid://13460380982",
"rbxassetid://13460377688",
"rbxassetid://13003340033",
"rbxassetid://13003341371",
"rbxassetid://13003338759",
"rbxassetid://13336412445",
"rbxassetid://13336411199",
"rbxassetid://13336409397",
"rbxassetid://6145041133",
"rbxassetid://6145038858",
"rbxassetid://6145039913",
"rbxassetid://13321348239",
"rbxassetid://13321347601",
"rbxassetid://13321346498",
"rbxassetid://13320513403",
"rbxassetid://13320511216",
"rbxassetid://13320509148",
"rbxassetid://11775632454",
"rbxassetid://11775634053",
"rbxassetid://11775630445",
"rbxassetid://13619253502",
"rbxassetid://13569811288",
"rbxassetid://13569806250",
"rbxassetid://12230746617",
"rbxassetid://12230754372",
"rbxassetid://12230750343",
"rbxassetid://11887610246",
"rbxassetid://11887607414",
"rbxassetid://11887604782",
"rbxassetid://6145119463",
"rbxassetid://6145118595",
"rbxassetid://6145117792",
"rbxassetid://13513221659",
"rbxassetid://13513227506",
"rbxassetid://13513218511",
"rbxassetid://13458971856",
"rbxassetid://13458969831",
"rbxassetid://13458968242",
"rbxassetid://6243326071",
"rbxassetid://6243325311",
"rbxassetid://6243323055",
"rbxassetid://13458807233",
"rbxassetid://13458807962",
"rbxassetid://13458806185",
"rbxassetid://13458836125",
"rbxassetid://13458834726",
"rbxassetid://13458832975",
"rbxassetid://13470927161",
"rbxassetid://13470923980",
"rbxassetid://13470921937",
"rbxassetid://13487460506",
"rbxassetid://13487453851",
"rbxassetid://13487449439",
"rbxassetid://13487411398",
"rbxassetid://13487407224",
"rbxassetid://13487403935",
"rbxassetid://13470833773",
"rbxassetid://13470830351",
"rbxassetid://13470827948",
"rbxassetid://13321474310",
"rbxassetid://13321472973",
"rbxassetid://13321471163",
"rbxassetid://13459007522",
"rbxassetid://13459005621",
"rbxassetid://13458998076",
"rbxassetid://7076137002",
"rbxassetid://7048081494",
"rbxassetid://7047913825",
"rbxassetid://13460455087",
"rbxassetid://13460450869",
"rbxassetid://13460447042",
"rbxassetid://9130662282",
"rbxassetid://9130659525",
"rbxassetid://9130656296",
"rbxassetid://13458760595",
"rbxassetid://13458759834",
"rbxassetid://13458758128",
"rbxassetid://14244781831",
"rbxassetid://14244770808",
"rbxassetid://14244766305",
"rbxassetid://13459077658",
"rbxassetid://13459076963",
"rbxassetid://13459075973",
"rbxassetid://13003600953",
"rbxassetid://13003602239",
"rbxassetid://13003603038",
"rbxassetid://14256334579",
"rbxassetid://14256325381",
"rbxassetid://14256317131",
"rbxassetid://15730143498",
"rbxassetid://15730136689",
"rbxassetid://15730133423",
"rbxassetid://13487493921",
"rbxassetid://13487490965",
"rbxassetid://13487487824",
"rbxassetid://13487633049",
"rbxassetid://13487613209",
"rbxassetid://13487607421",
"rbxassetid://13459091355",
"rbxassetid://13459089457",
"rbxassetid://13459087816",
"rbxassetid://11983619415",
"rbxassetid://11983614935",
"rbxassetid://11983609900",
"rbxassetid://13459065484",
"rbxassetid://13459063516",
"rbxassetid://13459060491",
"rbxassetid://13488271888",
"rbxassetid://13488269825",
"rbxassetid://13488266396",
"rbxassetid://13513260663",
"rbxassetid://13513248209",
"rbxassetid://13513253387",
"rbxassetid://13003389005",
"rbxassetid://13003387788",
"rbxassetid://13003386922",
"rbxassetid://13487697556",
"rbxassetid://13487694424",
"rbxassetid://13487690720",
"rbxassetid://13533166537",
"rbxassetid://13533169839",
"rbxassetid://13533161386",
"rbxassetid://13454108126",
"rbxassetid://13454094816",
"rbxassetid://13454086975",
"rbxassetid://14355215212",
"rbxassetid://14355196750",
"rbxassetid://14355186302",
"rbxassetid://13458893031",
"rbxassetid://13458891308",
"rbxassetid://13458888941",
"rbxassetid://13454928567",
"rbxassetid://13454924779",
"rbxassetid://13454921078",
"rbxassetid://12655102507",
"rbxassetid://12655101767",
"rbxassetid://12655101012",
"rbxassetid://14325955952",
"rbxassetid://14325935633",
"rbxassetid://14325929070",
"rbxassetid://13453348698",
"rbxassetid://13453347164",
"rbxassetid://13453344903",
"rbxassetid://13487539167",
"rbxassetid://13487532262",
"rbxassetid://13487525905",
"rbxassetid://13458776313",
"rbxassetid://13458774680",
"rbxassetid://13458771089",
"rbxassetid://10583004808",
"rbxassetid://70680139769880",
"rbxassetid://99526389273578",
"rbxassetid://105334413583215",
"rbxassetid://17636763405",
"rbxassetid://17636761482",
"rbxassetid://17636759328",
"rbxassetid://13458741435",
"rbxassetid://13458739683",
"rbxassetid://13458738217",
"rbxassetid://13458795865",
"rbxassetid://13458794213",
"rbxassetid://13458792827",
"rbxassetid://13470796649",
"rbxassetid://13470794805",
"rbxassetid://13470791717",
"rbxassetid://6133494118",
"rbxassetid://6133492666",
"rbxassetid://6133492098",
"rbxassetid://13453380525",
"rbxassetid://13453379194",
"rbxassetid://13453378028",
"rbxassetid://8799319983",
"rbxassetid://8799318064",
"rbxassetid://8799315678",
"rbxassetid://13458822610",
"rbxassetid://13458821366",
"rbxassetid://13458819950",
"rbxassetid://13453526234",
"rbxassetid://13453523825",
"rbxassetid://13453522871",
"rbxassetid://13003374745",
"rbxassetid://13003373241",
"rbxassetid://13003371543",
"rbxassetid://85188454028607",
"rbxassetid://136654287774707",
"rbxassetid://92314770647182"
}) do
    animationSet[id] = true
end

-- Optimize delay in detecting animations and pressing "F"
local connection
local function startAutoParry()
    connection = RunService.Heartbeat:Connect(function()
        if not _G.AutoParryEnabled then
            if connection then connection:Disconnect() end
            return
        end

        local closestPlayer = nil
        local closestDistance = math.huge

        -- Get the position of the local player
        local localCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local localHumanoidRootPart = localCharacter:FindFirstChild("HumanoidRootPart")
        if not localHumanoidRootPart then return end
        local localPosition = localHumanoidRootPart.Position

        -- Find the closest player within the maximum distance
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

        -- Monitor animations on the closest player within the maximum distance
        if closestPlayer then
            local closestCharacter = playerCharacters:FindFirstChild(closestPlayer.Name)
            local humanoid = closestCharacter and closestCharacter:FindFirstChildOfClass("Humanoid")
            local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
            if animator then
                for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                    if isMonitoredAnimation(track.Animation.AnimationId) then
                        -- Simulate pressing "F"
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, nil)

                        -- Debugging: Print the distance when "F" is pressed
                        print("Pressed F for player:", closestPlayer.Name, "Distance:", closestDistance)

                        break
                    end
                end
            end
        end
    end)
end

-- Start or stop the script based on the toggle
if _G.AutoParryEnabled then
    print("AutoParry Enabled")
    startAutoParry()
else
    print("AutoParry Disabled")
    if connection then connection:Disconnect() end
end
