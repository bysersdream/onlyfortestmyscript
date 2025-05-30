local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local OWNER_ID = 8567813665
local SCRIPT_USERS = {} -- Track script users

-- Track script users
local function trackScriptUser(player)
    SCRIPT_USERS[player.UserId] = true
end

-- Check if player is using the script
local function isScriptUser(player)
    return SCRIPT_USERS[player.UserId] or false
end

-- Show owner notification (only to script users except owner)
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
    
    wait(0.5)
    local Sound = Instance.new("Sound", game:GetService("SoundService"))
    Sound.SoundId = "rbxassetid://7545764969"
    Sound:Play()
end

-- Auto-track local player as script user on load
trackScriptUser(Players.LocalPlayer)

-- Notify script users when owner joins dynamically
Players.PlayerAdded:Connect(function(player)
    if player.UserId == OWNER_ID then
        -- Track owner as script user too
        trackScriptUser(player)
        -- Notify all script users except owner
        for userId, _ in pairs(SCRIPT_USERS) do
            if userId ~= OWNER_ID then
                -- For notification to all script users, this script runs locally only for the local player
                -- So notify only local player if tracked
                if Players.LocalPlayer.UserId == userId then
                    showOwnerNotification(player)
                end
            end
        end
    end
end)

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChaosScriptGUI"
ScreenGui.Parent = game.CoreGui

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
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(
            math.clamp(color.R * 255 + 30, 0, 255),
            math.clamp(color.G * 255 + 30, 0, 255),
            math.clamp(color.B * 255 + 30, 0, 255)
        )}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
    
    return btn
end

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
    
    closeBtn.MouseButton1Click:Connect(function()
        frame.Visible = false
    end)
    
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
    
    local function kickPlayer(player)
        if player and player ~= Players.LocalPlayer then
            -- Kick the player with reason
            player:Kick("Owner kicked you")
        end
    end
    
    local function updateUserList()
        for _, child in ipairs(scrollFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        local players = Players:GetPlayers()
        local scriptUsers = {}
        
        for _, player in ipairs(players) do
            if isScriptUser(player) or player.UserId == OWNER_ID then
                table.insert(scriptUsers, player)
            end
        end
        
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
            userIdLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7)
            userIdLabel.TextScaled = true
            userIdLabel.TextXAlignment = Enum.TextXAlignment.Left
            userIdLabel.Text = "UserId: "..player.UserId
            
            -- Only owner can see kick button and can't kick self
            if Players.LocalPlayer.UserId == OWNER_ID and player.UserId ~= OWNER_ID then
                local kickBtn = Instance.new("TextButton")
                kickBtn.Parent = userFrame
                kickBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                kickBtn.Size = UDim2.new(0.2, 0, 0.6, 0)
                kickBtn.Position = UDim2.new(0.75, 0, 0.2, 0)
                kickBtn.Font = Enum.Font.GothamBold
                kickBtn.TextColor3 = Color3.new(1,1,1)
                kickBtn.TextScaled = true
                kickBtn.Text = "Kick"
                kickBtn.AutoButtonColor = false
                
                local cornerKick = Instance.new("UICorner")
                cornerKick.CornerRadius = UDim.new(0, 8)
                cornerKick.Parent = kickBtn
                
                kickBtn.MouseEnter:Connect(function()
                    TweenService:Create(kickBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 70, 70)}):Play()
                end)
                
                kickBtn.MouseLeave:Connect(function()
                    TweenService:Create(kickBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
                end)
                
                kickBtn.MouseButton1Click:Connect(function()
                    kickPlayer(player)
                    updateUserList()
                end)
            end
        end
        
        -- Update scroll canvas size
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #scriptUsers * 65 + 10)
    end
    
    updateUserList()
    
    return usersMenu, updateUserList
end

-- Main GUI buttons
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,25)
mainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
mainFrame.Size = UDim2.new(0, 200, 0, 300)
mainFrame.Parent = ScreenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local usersBtn = createButton(mainFrame, "UsersBtn", 0.1, "👥 Users", Color3.fromRGB(100,100,200))
local closeBtn = createButton(mainFrame, "CloseBtn", 0.75, "Close Script", Color3.fromRGB(200, 50, 50))

local usersMenu, updateUsersList = createUsersMenu()

usersBtn.MouseButton1Click:Connect(function()
    usersMenu.Visible = true
    updateUsersList()
end)

closeBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Notify if owner already present when script loads
for _, player in pairs(Players:GetPlayers()) do
    if player.UserId == OWNER_ID and Players.LocalPlayer.UserId ~= OWNER_ID then
        showOwnerNotification(player)
    end
end
