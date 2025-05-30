local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local OWNER_ID = 8567813665
local SCRIPT_USERS = {} -- Table to track script users

-- Track script users
local function trackScriptUser(player)
    SCRIPT_USERS[player.UserId] = true
end

-- Check if player is using the script
local function isScriptUser(player)
    return SCRIPT_USERS[player.UserId] or false
end

-- Show owner notification (only to script users)
local function showOwnerNotification(owner)
    if Players.LocalPlayer.UserId == OWNER_ID then return end
    
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size48
    local content, isReady = Players:GetUserThumbnailAsync(OWNER_ID, thumbType, thumbSize)

    StarterGui:SetCore("SendNotification", {
        Title = "Owner " .. owner.Name .. " joined!",
        Text = "Chaos Script activated",
        Duration = 5,
        Icon = content
    })
    
    -- Play sound
    wait(0.5)
    local Sound = Instance.new("Sound",game:GetService("SoundService"))
    Sound.SoundId = "rbxassetid://7545764969"
    Sound:Play()
end

-- Track local player as script user
trackScriptUser(Players.LocalPlayer)

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChaosScriptGUI"
ScreenGui.Parent = game.CoreGui

-- Improved button design
local function createButton(parent, name, positionY, text, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = parent
    btn.BackgroundColor3 = color
    btn.Position = UDim2.new(0.05, 0, positionY, 0)
    btn.Size = UDim2.new(0.9, 0, 0.12, 0)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextScaled = true
    btn.TextWrapped = true
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    -- Hover animation
    btn.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(
            math.floor(color.R * 255 + 30),
            math.floor(color.G * 255 + 30),
            math.floor(color.B * 255 + 30)
        )}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
    
    return btn
end

-- Create menu frame
local function createMenuFrame(name, sizeX, sizeY)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.BackgroundColor3 = Color3.fromRGB(15,15,20)
    frame.Position = UDim2.new(0.3,0,0.2,0)
    frame.Size = UDim2.new(0,sizeX,0,sizeY)
    frame.Visible = false
    frame.Active = true
    frame.Draggable = true
    frame.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.BackgroundColor3 = Color3.fromRGB(30,30,40)
    title.Size = UDim2.new(1,0,0,50)
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Color3.new(1,1,1)
    title.TextScaled = true
    title.TextWrapped = true
    title.Parent = frame
    
    local cornerTitle = Instance.new("UICorner")
    cornerTitle.CornerRadius = UDim.new(0, 12)
    cornerTitle.Parent = title
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "Close"
    closeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    closeBtn.Position = UDim2.new(1,-50,0,0)
    closeBtn.Size = UDim2.new(0,50,0,50)
    closeBtn.Font = Enum.Font.GothamBlack
    closeBtn.Text = "✖"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.TextScaled = true
    closeBtn.Parent = frame
    
    local cornerClose = Instance.new("UICorner")
    cornerClose.CornerRadius = UDim.new(0, 12)
    cornerClose.Parent = closeBtn
    
    return frame, title, closeBtn
end

-- Create Users menu (owner only)
local function createUsersMenu()
    local usersMenu, usersTitle, usersCloseBtn = createMenuFrame("UsersMenu", 350, 400)
    usersTitle.Text = "👥 Script Users"
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Parent = usersMenu
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.Size = UDim2.new(0.9, 0, 0.8, 0)
    scrollFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.ScrollBarThickness = 5
    
    local userListLayout = Instance.new("UIListLayout")
    userListLayout.Parent = scrollFrame
    userListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    userListLayout.Padding = UDim.new(0, 5)
    
    local function updateUserList()
        -- Clear existing entries
        for _, child in ipairs(scrollFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        -- Get all players and filter script users
        local players = Players:GetPlayers()
        local scriptUsers = {}
        
        for _, player in ipairs(players) do
            if isScriptUser(player) or player.UserId == OWNER_ID then
                table.insert(scriptUsers, player)
            end
        end
        
        -- Create entries for each script user
        for i, player in ipairs(scriptUsers) do
            local userFrame = Instance.new("Frame")
            userFrame.Parent = scrollFrame
            userFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            userFrame.Size = UDim2.new(1, 0, 0, 60)
            userFrame.LayoutOrder = i
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = userFrame
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Parent = userFrame
            nameLabel.BackgroundTransparency = 1
            nameLabel.Size = UDim2.new(0.7, 0, 0.4, 0)
            nameLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextColor3 = Color3.new(1, 1, 1)
            nameLabel.TextScaled = true
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Text = player.Name
            
            local userIdLabel = Instance.new("TextLabel")
            userIdLabel.Parent = userFrame
            userIdLabel.BackgroundTransparency = 1
            userIdLabel.Size = UDim2.new(0.7, 0, 0.3, 0)
            userIdLabel.Position = UDim2.new(0.1, 0, 0.5, 0)
            userIdLabel.Font = Enum.Font.Gotham
            userIdLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
            userIdLabel.TextScaled = true
            userIdLabel.TextXAlignment = Enum.TextXAlignment.Left
            userIdLabel.Text = "ID: " .. player.UserId
            
            -- Copy button
            local copyBtn = Instance.new("TextButton")
            copyBtn.Parent = userFrame
            copyBtn.Size = UDim2.new(0.2, 0, 0.4, 0)
            copyBtn.Position = UDim2.new(0.75, 0, 0.1, 0)
            copyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
            copyBtn.TextColor3 = Color3.new(1, 1, 1)
            copyBtn.Font = Enum.Font.Gotham
            copyBtn.Text = "Copy"
            copyBtn.TextScaled = true
            
            local cornerCopy = Instance.new("UICorner")
            cornerCopy.CornerRadius = UDim.new(0, 8)
            cornerCopy.Parent = copyBtn
            
            copyBtn.MouseButton1Down:Connect(function()
                setclipboard(tostring(player.UserId))
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Copied!",
                    Text = "User ID copied to clipboard",
                    Duration = 2
                })
            end)
            
            -- Kick button (owner only and not self)
            if Players.LocalPlayer.UserId == OWNER_ID and player.UserId ~= OWNER_ID then
                local kickBtn = Instance.new("TextButton")
                kickBtn.Parent = userFrame
                kickBtn.Size = UDim2.new(0.2, 0, 0.4, 0)
                kickBtn.Position = UDim2.new(0.75, 0, 0.55, 0)
                kickBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
                kickBtn.TextColor3 = Color3.new(1, 1, 1)
                kickBtn.Font = Enum.Font.GothamBold
                kickBtn.Text = "Kick"
                kickBtn.TextScaled = true
                
                local cornerKick = Instance.new("UICorner")
                cornerKick.CornerRadius = UDim.new(0, 8)
                cornerKick.Parent = kickBtn
                
                kickBtn.MouseButton1Down:Connect(function()
                    -- Kick player by removing their script access
                    SCRIPT_USERS[player.UserId] = nil
                    updateUserList()
                    
                    -- Fire remote to kick the player (assuming you have this set up)
                    if player.Character then
                        player.Character:BreakJoints()
                    end
                    
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Kicked",
                        Text = player.Name .. " was kicked by script owner",
                        Duration = 3
                    })
                end)
            end
        end
        
        -- Update scroll size
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, userListLayout.AbsoluteContentSize.Y)
    end
    
    -- Update list when players join/leave
    updateUserList()
    Players.PlayerAdded:Connect(function(player)
        -- Automatically track owner
        if player.UserId == OWNER_ID then
            trackScriptUser(player)
            showOwnerNotification(player)
        end
        updateUserList()
    end)
    
    Players.PlayerRemoving:Connect(updateUserList)
    
    return usersMenu, usersCloseBtn
end

-- Menu open button
local openButton = Instance.new("TextButton")
openButton.Name = "OpenMenuButton"
openButton.Parent = ScreenGui
openButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
openButton.Position = UDim2.new(0.01,0,0.85,0)
openButton.Size = UDim2.new(0,120,0,40)
openButton.Font = Enum.Font.GothamBold
openButton.Text = "⚙️ MENU"
openButton.TextColor3 = Color3.new(1,1,1)
openButton.TextScaled = true
openButton.BorderSizePixel = 0

local cornerOpen = Instance.new("UICorner")
cornerOpen.CornerRadius = UDim.new(0, 8)
cornerOpen.Parent = openButton

-- Main menu
local mainMenu, mainTitle, mainCloseBtn = createMenuFrame("MainMenu", 350, 350)
mainTitle.Text = "⚙️ Chaos Script Menu"

-- Create main menu buttons
local buttons = {}
buttons.hitboxExpander = createButton(mainMenu, "HitboxExpander", 0.15, "🚀 Hitbox Expander", Color3.fromRGB(150, 75, 0))
buttons.movement = createButton(mainMenu, "Movement", 0.35, "🏃 Movement", Color3.fromRGB(0, 0, 150))
buttons.weapons = createButton(mainMenu, "Weapons", 0.55, "⚔️ Weapons", Color3.fromRGB(150, 0, 150))
buttons.info = createButton(mainMenu, "Info", 0.75, "🟣 Info", Color3.fromRGB(102, 0, 153))

-- Add Users button for owner only
local usersMenu, usersCloseBtn
if Players.LocalPlayer.UserId == OWNER_ID then
    usersMenu, usersCloseBtn = createUsersMenu()
    
    buttons.users = createButton(mainMenu, "Users", 0.95, "👥 Users", Color3.fromRGB(50, 50, 150))
    
    -- Resize main menu for new button
    mainMenu.Size = UDim2.new(0, 350, 0, 400)
    
    -- Reposition other buttons
    buttons.hitboxExpander.Position = UDim2.new(0.05, 0, 0.12, 0)
    buttons.movement.Position = UDim2.new(0.05, 0, 0.28, 0)
    buttons.weapons.Position = UDim2.new(0.05, 0, 0.44, 0)
    buttons.info.Position = UDim2.new(0.05, 0, 0.60, 0)
end

-- Hitbox Expander menu
local hitboxMenu, hitboxTitle, hitboxCloseBtn = createMenuFrame("HitboxMenu", 350, 250)
hitboxTitle.Text = "🚀 Hitbox Expander"

local hitboxLabel = Instance.new("TextLabel")
hitboxLabel.Parent = hitboxMenu
hitboxLabel.BackgroundTransparency = 1
hitboxLabel.Size = UDim2.new(0.9,0,0.2,0)
hitboxLabel.Position = UDim2.new(0.05,0,0.15,0)
hitboxLabel.Font = Enum.Font.Gotham
hitboxLabel.TextColor3 = Color3.new(1,1,1)
hitboxLabel.TextScaled = true
hitboxLabel.TextWrapped = true
hitboxLabel.Text = "Hitbox Size:"

local hitboxSlider = Instance.new("TextButton")
hitboxSlider.Parent = hitboxMenu
hitboxSlider.BackgroundColor3 = Color3.fromRGB(60,60,80)
hitboxSlider.Position = UDim2.new(0.05,0,0.35,0)
hitboxSlider.Size = UDim2.new(0.9,0,0.15,0)
hitboxSlider.Text = ""
hitboxSlider.AutoButtonColor = false

local hitboxFill = Instance.new("Frame")
hitboxFill.Parent = hitboxSlider
hitboxFill.BackgroundColor3 = Color3.fromRGB(0,150,200)
hitboxFill.Size = UDim2.new(0.5,0,1,0)

local hitboxCorner = Instance.new("UICorner")
hitboxCorner.Parent = hitboxSlider
hitboxCorner.CornerRadius = UDim.new(0,8)

local hitboxValue = Instance.new("TextLabel")
hitboxValue.Parent = hitboxMenu
hitboxValue.BackgroundTransparency = 1
hitboxValue.Size = UDim2.new(0.9,0,0.15,0)
hitboxValue.Position = UDim2.new(0.05,0,0.55,0)
hitboxValue.Font = Enum.Font.GothamBold
hitboxValue.TextColor3 = Color3.new(1,1,1)
hitboxValue.Text = "Size: 5"
hitboxValue.TextScaled = true

local hitboxApply = createButton(hitboxMenu, "ApplyHitbox", 0.75, "Apply", Color3.fromRGB(0,180,0))

-- Hitbox Expander logic
local hitboxSize = 5
local hitboxEnabled = false
local hitboxParts = {}

local function updateHitbox()
    for _, part in pairs(hitboxParts) do
        part:Destroy()
    end
    hitboxParts = {}
    
    if hitboxEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    part.CFrame = hrp.CFrame
                    part.Anchored = false
                    part.CanCollide = false
                    part.Transparency = 0.7
                    part.Color = Color3.fromRGB(255,0,0)
                    part.Parent = workspace
                    part.Name = "HitboxExpander_" .. player.Name
                    
                    local weld = Instance.new("WeldConstraint")
                    weld.Part0 = hrp
                    weld.Part1 = part
                    weld.Parent = part
                    
                    table.insert(hitboxParts, part)
                end
            end
        end
    end
end

-- Slider handling
local sliding = false
hitboxSlider.MouseButton1Down:Connect(function()
    sliding = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliding = false
    end
end)

hitboxSlider.MouseMoved:Connect(function()
    if sliding then
        local mousePos = UserInputService:GetMouseLocation().X
        local sliderPos = hitboxSlider.AbsolutePosition.X
        local sliderSize = hitboxSlider.AbsoluteSize.X
        local percent = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
        
        hitboxFill.Size = UDim2.new(percent,0,1,0)
        hitboxSize = math.floor(5 + percent * 15) -- 5 to 20
        hitboxValue.Text = "Size: " .. hitboxSize
    end
end)

hitboxApply.MouseButton1Down:Connect(function()
    hitboxEnabled = not hitboxEnabled
    if hitboxEnabled then
        hitboxApply.Text = "Disable"
        hitboxApply.BackgroundColor3 = Color3.fromRGB(180,0,0)
        updateHitbox()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Hitbox Expander",
            Text = "Enabled with size " .. hitboxSize,
            Duration = 3
        })
    else
        hitboxApply.Text = "Apply"
        hitboxApply.BackgroundColor3 = Color3.fromRGB(0,180,0)
        for _, part in pairs(hitboxParts) do
            part:Destroy()
        end
        hitboxParts = {}
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Hitbox Expander",
            Text = "Disabled",
            Duration = 3
        })
    end
end)

-- Movement menu
local movementMenu, movementTitle, movementCloseBtn = createMenuFrame("MovementMenu", 350, 350)
movementTitle.Text = "🏃 Movement Controls"

-- Toggle creation function
local function createToggle(parent, posY, text, defaultColor, activeColor)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(30,30,40)
    frame.Size = UDim2.new(0.9, 0, 0.12, 0)
    frame.Position = UDim2.new(0.05, 0, posY, 0)
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.new(1,1,1)
    label.TextScaled = true
    label.TextWrapped = true
    label.Text = text
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.Size = UDim2.new(0.25, 0, 0.7, 0)
    toggleBtn.Position = UDim2.new(0.7, 0, 0.15, 0)
    toggleBtn.BackgroundColor3 = defaultColor
    toggleBtn.TextColor3 = Color3.new(1,1,1)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextScaled = true
    toggleBtn.Text = "OFF"
    
    local cornerToggle = Instance.new("UICorner")
    cornerToggle.CornerRadius = UDim.new(0, 8)
    cornerToggle.Parent = toggleBtn
    
    local toggled = false
    toggleBtn.MouseButton1Down:Connect(function()
        toggled = not toggled
        if toggled then
            toggleBtn.BackgroundColor3 = activeColor
            toggleBtn.Text = "ON"
        else
            toggleBtn.BackgroundColor3 = defaultColor
            toggleBtn.Text = "OFF"
        end
        return toggled
    end)
    return frame, function() return toggled end, toggleBtn
end

-- Create Movement toggles
local flyToggle, flyGet, flyBtn = createToggle(movementMenu, 0.15, "🪁 Fly", Color3.fromRGB(150, 0, 0), Color3.fromRGB(0, 150, 0))
local speedToggle, speedGet, speedBtn = createToggle(movementMenu, 0.30, "⚡ Speed (x2)", Color3.fromRGB(150, 0, 0), Color3.fromRGB(0, 150, 0))
local noclipToggle, noclipGet, noclipBtn = createToggle(movementMenu, 0.45, "👻 Noclip", Color3.fromRGB(150, 0, 0), Color3.fromRGB(0, 150, 0))
local jumpToggle, jumpGet, jumpBtn = createToggle(movementMenu, 0.60, "🦘 High Jump", Color3.fromRGB(150, 0, 0), Color3.fromRGB(0, 150, 0))

-- Fly implementation
local flying = false
local flySpeed = 2
local flyConnection

flyBtn.MouseButton1Down:Connect(function()
    flying = not flying
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if flying then
        humanoid.PlatformStand = true
        
        flyConnection = RunService.Stepped:Connect(function()
            if character and character:FindFirstChild("HumanoidRootPart") then
                local root = character.HumanoidRootPart
                local cam = workspace.CurrentCamera.CFrame
                
                local vel = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    vel = vel + (cam.LookVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    vel = vel - (cam.LookVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    vel = vel - (cam.RightVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    vel = vel + (cam.RightVector * flySpeed)
                end
                
                root.Velocity = vel * 100
                root.RotVelocity = Vector3.new()
            end
        end)
    else
        humanoid.PlatformStand = false
        if flyConnection then
            flyConnection:Disconnect()
        end
    end
end)

-- Speed implementation
speedBtn.MouseButton1Down:Connect(function()
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if speedGet() then
        humanoid.WalkSpeed = 32 -- Double speed (default 16)
    else
        humanoid.WalkSpeed = 16 -- Default speed
    end
end)

-- Noclip implementation
local noclipConnection
noclipBtn.MouseButton1Down:Connect(function()
    if noclipGet() then
        noclipConnection = RunService.Stepped:Connect(function()
            local player = Players.LocalPlayer
            local character = player.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
        end
    end
end)

-- High Jump implementation
jumpBtn.MouseButton1Down:Connect(function()
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if jumpGet() then
        humanoid.JumpPower = 100 -- High jump
    else
        humanoid.JumpPower = 50 -- Default jump
    end
end)

-- Weapons menu
local weaponsMenu, weaponsTitle, weaponsCloseBtn = createMenuFrame("WeaponsMenu", 350, 250)
weaponsTitle.Text = "⚔️ Weapons"

local emeraldBtn = createButton(weaponsMenu, "Emerald", 0.2, "🪁 Emerald Sword", Color3.fromRGB(0, 150, 150))
local bloodBtn = createButton(weaponsMenu, "Blood", 0.4, "🔪 Blood Dagger", Color3.fromRGB(150, 0, 0))
local infoBtn = createButton(weaponsMenu, "Info", 0.6, "ℹ️ How to use", Color3.fromRGB(100, 100, 100))

emeraldBtn.MouseButton1Down:Connect(function()
    local args = { [1] = "Emerald Greatsword" }
    game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Menu Screen").RemoteEvent:FireServer(unpack(args))
    game:GetService("Players").LocalPlayer.PlayerGui["Menu Screen"]:Remove()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Weapon",
        Text = "Emerald Greatsword obtained!",
        Duration = 3
    })
end)

bloodBtn.MouseButton1Down:Connect(function()
    local args = { [1] = "Blood Dagger" }
    game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Menu Screen").RemoteEvent:FireServer(unpack(args))
    game:GetService("Players").LocalPlayer.PlayerGui["Menu Screen"]:Remove()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Weapon",
        Text = "Blood Dagger obtained!",
        Duration = 3
    })
end)

infoBtn.MouseButton1Down:Connect(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Information",
        Text = "Just click the weapon button to get it!",
        Duration = 5
    })
end)

-- Info menu
local infoMenu, infoTitle, infoCloseBtn = createMenuFrame("InfoMenu", 350, 250)
infoTitle.Text = "🟣 Info"

local infoLabel = Instance.new("TextLabel")
infoLabel.Parent = infoMenu
infoLabel.BackgroundTransparency = 1
infoLabel.Size = UDim2.new(0.9, 0, 0.8, 0)
infoLabel.Position = UDim2.new(0.05,0,0.15,0)
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextColor3 = Color3.new(1,1,1)
infoLabel.TextScaled = true
infoLabel.TextWrapped = true
infoLabel.Text = "Creator: Martusin/Yan\nDiscord: @bysersdream\nVersion: 2.0\n\nThanks for using!"

-- Back to main menu function
local function backToMainMenu(subMenu)
    subMenu.Visible = false
    mainMenu.Visible = true
end

-- Close buttons
hitboxCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(hitboxMenu) end)
movementCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(movementMenu) end)
weaponsCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(weaponsMenu) end)
infoCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(infoMenu) end)

-- Close Users menu (if exists)
if usersCloseBtn then
    usersCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(usersMenu) end)
end

mainCloseBtn.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    openButton.Visible = true
end)

-- Main menu button handlers
buttons.hitboxExpander.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    hitboxMenu.Visible = true
end)

buttons.movement.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    movementMenu.Visible = true
end)

buttons.weapons.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    weaponsMenu.Visible = true
end)

buttons.info.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    infoMenu.Visible = true
end)

-- Add handler for Users button (if exists)
if buttons.users then
    buttons.users.MouseButton1Down:Connect(function()
        mainMenu.Visible = false
        usersMenu.Visible = true
    end)
end

-- Menu open button
openButton.MouseButton1Down:Connect(function()
    openButton.Visible = false
    mainMenu.Visible = true
end)

-- Check for owner on start
local localPlayer = Players.LocalPlayer
if localPlayer.UserId == OWNER_ID then
    -- Don't show notification to self
else
    -- Check if owner is already in game
    for _, player in pairs(Players:GetPlayers()) do
        if player.UserId == OWNER_ID then
            showOwnerNotification(player)
            break
        end
    end
end

-- Initial notification
wait(1)
StarterGui:SetCore("SendNotification", { 
    Title = "Chaos Script loaded!",
    Text = "Press the menu button to open",
    Duration = 5
})
