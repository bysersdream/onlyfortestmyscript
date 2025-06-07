local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if CoreGui:FindFirstChild("ChaosScriptGui") then
    CoreGui:FindFirstChild("ChaosScriptGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChaosScriptGui"
ScreenGui.Parent = CoreGui

local function createRoundedFrame(parent, size, position)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    frame.BackgroundTransparency = 0
    frame.Parent = parent
    frame.ClipsDescendants = true
    frame.Active = true
    frame.Draggable = true
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    return frame
end

local function createButton(parent, size, position, text, color)
    local btn = Instance.new("TextButton")
    btn.Size = size
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.new(0,0,0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.AutoButtonColor = false
    btn.Parent = parent
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn
    return btn
end

local function createLabel(parent, size, position, text, fontsize)
    local label = Instance.new("TextLabel")
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = fontsize or 18
    label.Parent = parent
    return label
end

local keys = {
    ["XAO0466"] = true,
    ["6Y1YJ4K"] = true,
    ["0Z2S23Y"] = true,
    ["14Q2B6A"] = true,
    ["2G2RZAO"] = true,
    ["PCMPRK7"] = true,
    ["X23JF02"] = true,
    ["RI3D1FU"] = true,
    ["A9X7ZQP"] = true,
    ["BX4YJMR"] = true,
    ["C8K2VNS"] = true,
    ["D5MPWQX"] = true,
    ["E7JZLRT"] = true,
    ["F2YUKBC"] = true,
    ["G1QXVNH"] = true,
    ["H9RDAPF"] = true,
    ["J6ZKTME"] = true,
    ["K3BVYXS"] = true,
    ["L8PNDQA"] = true,
    ["M4FJREU"] = true,
    ["N0CXSVT"] = true,
    ["P5YHZKB"] = true,
    ["Q2MDLWR"] = true,
    ["R7UKXJF"] = true,
    ["S1ZNGTV"] = true,
    ["T6BYLQP"] = true,
}

local function isKeyValid(inputKey)
    return keys[inputKey] == true
end

local keyFrame = createRoundedFrame(ScreenGui, UDim2.new(0, 400, 0, 230), UDim2.new(0.35, 0, 0.4, 0))
createLabel(keyFrame, UDim2.new(1,0,0,30), UDim2.new(0,0,0,10), "Enter your passkey", 22)

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.9, 0, 0, 40)
keyInput.Position = UDim2.new(0.05, 0, 0, 50)
keyInput.PlaceholderText = "Enter key here"
keyInput.Text = ""
keyInput.ClearTextOnFocus = false
keyInput.BackgroundColor3 = Color3.fromRGB(30,30,30)
keyInput.TextColor3 = Color3.new(1,1,1)
keyInput.Font = Enum.Font.GothamBold
keyInput.TextSize = 18
keyInput.Parent = keyFrame
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0,10)
inputCorner.Parent = keyInput

local submitButton = createButton(keyFrame, UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, 100), "Confirm", Color3.fromRGB(216, 221, 86))
local infoLabel = createLabel(keyFrame, UDim2.new(1,0,0,20), UDim2.new(0,0,0,135), "", 16)
createLabel(keyFrame, UDim2.new(1, -20, 0, 40), UDim2.new(0,10,0,150), "To get your key, go to Discord: #support", 16)

local copyBtn = createButton(keyFrame, UDim2.new(0, 160, 0, 35), UDim2.new(0.5, -80, 0, 190), "Copy link", Color3.fromRGB(70, 130, 180))
copyBtn.TextColor3 = Color3.new(1,1,1)
copyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/bxubNMDf")
    copyBtn.Text = "Copied!"
    wait(2)
    copyBtn.Text = "Copy link"
end)

local main = createRoundedFrame(ScreenGui, UDim2.new(0, 380, 0, 300), UDim2.new(0.02, 0, 0.6, 0))
main.Visible = false

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 40)
tabBar.Position = UDim2.new(0, 0, 0, 0)
tabBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
tabBar.Parent = main

local gamepassTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 0, 0, 0), "Gamepasses", Color3.fromRGB(216, 221, 86))
local infoTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 120, 0, 0), "Info", Color3.fromRGB(216, 221, 86))
local ownerTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 240, 0, 0), "Owner", Color3.fromRGB(216, 221, 86))
ownerTab.Visible = false

local gamepassFrame = Instance.new("Frame")
gamepassFrame.Size = UDim2.new(1, 0, 1, -40)
gamepassFrame.Position = UDim2.new(0, 0, 0, 40)
gamepassFrame.BackgroundTransparency = 1
gamepassFrame.Parent = main

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 1, -40)
infoFrame.Position = UDim2.new(0, 0, 0, 40)
infoFrame.BackgroundTransparency = 1
infoFrame.Visible = false
infoFrame.Parent = main

local ownerFrame = createRoundedFrame(main, UDim2.new(1, 0, 1, -40), UDim2.new(0, 0, 0, 40))
ownerFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ownerFrame.Visible = false
ownerFrame.Parent = main

local ownerList = Instance.new("ScrollingFrame")
ownerList.Size = UDim2.new(0.95, 0, 0.8, 0)
ownerList.Position = UDim2.new(0.025, 0, 0.05, 0)
ownerList.CanvasSize = UDim2.new(0, 0, 5, 0)
ownerList.ScrollBarThickness = 6
ownerList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ownerList.BorderSizePixel = 0
ownerList.Parent = ownerFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 5)
ListLayout.Parent = ownerList

local leaveButton = createButton(ownerFrame, UDim2.new(0, 120, 0, 40), UDim2.new(0.8, 0, 0.9, 0), "Leave", Color3.fromRGB(200, 30, 30))
leaveButton.Visible = false

local emeraldBtn = createButton(gamepassFrame, UDim2.new(0, 150, 0, 50), UDim2.new(0.05, 0, 0.1, 0), "Emerald Greatsword", Color3.fromRGB(0, 150, 150))
local bloodBtn = createButton(gamepassFrame, UDim2.new(0, 150, 0, 50), UDim2.new(0.55, 0, 0.1, 0), "Blood Dagger", Color3.fromRGB(150, 0, 0))
local frostBtn = createButton(gamepassFrame, UDim2.new(0, 150, 0, 50), UDim2.new(0.3, 0, 0.4, 0), "Frost Spear", Color3.fromRGB(100, 100, 255))

local discordButton = createButton(infoFrame, UDim2.new(0, 140, 0, 40), UDim2.new(0.1, 0, 0.2, 0), "Discord Link", Color3.fromRGB(70,130,180))
discordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/bxubNMDf")
end)

local versionLabel = createLabel(infoFrame, UDim2.new(0.9, 0, 0, 30), UDim2.new(0.05, 0, 0.7, 0), "Version 2.3.5", 16)

local selectedTab = gamepassFrame
local function switchTab(tab)
    gamepassFrame.Visible = false
    infoFrame.Visible = false
    ownerFrame.Visible = false
    selectedTab = tab
    tab.Visible = true
end

gamepassTab.MouseButton1Click:Connect(function()
    switchTab(gamepassFrame)
end)
infoTab.MouseButton1Click:Connect(function()
    switchTab(infoFrame)
end)

ownerTab.MouseButton1Click:Connect(function()
    switchTab(ownerFrame)
end)

local ownerUserId = 8611106675
local RepStorage = ReplicatedStorage

local KickRemote = RepStorage:FindFirstChild("KickPlayer")
local UpdateRemote = RepStorage:FindFirstChild("UpdateActiveUsers")

if not KickRemote then
    KickRemote = Instance.new("RemoteEvent")
    KickRemote.Name = "KickPlayer"
    KickRemote.Parent = ReplicatedStorage
end

if not UpdateRemote then
    UpdateRemote = Instance.new("RemoteEvent")
    UpdateRemote.Name = "UpdateActiveUsers"
    UpdateRemote.Parent = ReplicatedStorage
end

local function sendActiveSignal()
    UpdateRemote:FireServer()
end

local function buildOwnerList(players)
    for _, child in pairs(ownerList:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
    for _, data in pairs(players) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 40)
        btn.BackgroundColor3 = Color3.fromRGB(216, 221, 86)
        btn.TextColor3 = Color3.new(0,0,0)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.Text = data.Name
        btn.Parent = ownerList

        btn.MouseButton1Click:Connect(function()
            KickRemote:FireServer(player, data.UserId)
        end)
    end
end

KickRemote.OnClientEvent:Connect(function(message)
    if message == "Kick" then
        local screenGui = Instance.new("ScreenGui")
        screenGui.ResetOnSpawn = false
        screenGui.Parent = CoreGui

        local msgFrame = Instance.new("Frame")
        msgFrame.Size = UDim2.new(1,0,1,0)
        msgFrame.BackgroundColor3 = Color3.new(0,0,0)
        msgFrame.BackgroundTransparency = 0.3
        msgFrame.Parent = screenGui

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(0.6,0,0.2,0)
        textLabel.Position = UDim2.new(0.2,0,0.4,0)
        textLabel.BackgroundColor3 = Color3.new(0.2,0,0.2)
        textLabel.TextColor3 = Color3.new(1,1,1)
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = 30
        textLabel.Text = "You were kicked by the owner"
        textLabel.Parent = msgFrame
    end
end)

leaveButton.MouseButton1Click:Connect(function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end)

submitButton.MouseButton1Click:Connect(function()
    if isKeyValid(keyInput.Text) then
        keyFrame.Visible = false
        main.Visible = true
        if player.UserId == ownerUserId then
            ownerTab.Visible = true
        end
        sendActiveSignal()
    else
        infoLabel.Text = "Invalid key"
        wait(2)
        infoLabel.Text = ""
    end
end)

gamepassTab.MouseButton1Click:Connect(function()
    switchTab(gamepassFrame)
end)

infoTab.MouseButton1Click:Connect(function()
    switchTab(infoFrame)
end)

ownerTab.MouseButton1Click:Connect(function()
    switchTab(ownerFrame)
end)

if player.UserId == ownerUserId then
    ownerTab.Visible = true
    switchTab(ownerFrame)
else
    switchTab(gamepassFrame)
end

UpdateRemote.OnClientEvent:Connect(function(activePlayers)
    if player.UserId == ownerUserId then
        buildOwnerList(activePlayers)
        leaveButton.Visible = true
    end
end)

sendActiveSignal()
