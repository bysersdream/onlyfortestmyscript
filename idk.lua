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
                    
                    -- Fire remote to kick the player
                    if player.Character then
                        player.Character:BreakJoints()
                    end
                    
                    -- Send notification to kicked player
                    if isScriptUser(player) then
                        local kickNotification = Instance.new("RemoteEvent")
                        kickNotification.Name = "KickNotification"
                        kickNotification.Parent = player:FindFirstChildOfClass("PlayerGui") or Instance.new("PlayerGui", player)
                        
                        kickNotification:FireClient(player, {
                            Title = "Kicked",
                            Text = "Owner kicked you",
                            Duration = 5
                        })
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
            -- Notify all script users that owner joined
            for _, plr in pairs(Players:GetPlayers()) do
                if isScriptUser(plr) and plr.UserId ~= OWNER_ID then
                    showOwnerNotification(player)
                end
            end
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

-- [Rest of your existing code remains the same...]

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
