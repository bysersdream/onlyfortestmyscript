local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local OWNER_ID = 8567813665
local SCRIPT_USERS = {}

trackScriptUser = function(player)
    SCRIPT_USERS[player.UserId] = true
end

isScriptUser = function(player)
    return SCRIPT_USERS[player.UserId] or false
end

trackScriptUser(Players.LocalPlayer)

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
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
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

    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.BackgroundColor3 = Color3.fromRGB(30,30,40)
    title.Size = UDim2.new(1,0,0,50)
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Color3.new(1,1,1)
    title.TextScaled = true
    title.TextWrapped = true
    title.Parent = frame
    Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

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
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 12)

    return frame, title, closeBtn
end

-- Gamepasses menu
local gamepassesMenu, gamepassesTitle, gamepassesCloseBtn = createMenuFrame("GamepassesMenu", 350, 200)
gamepassesTitle.Text = "🎫 Gamepasses"
local gamepassInfoBtn = createButton(gamepassesMenu, "Info", 0.3, "ℹ️ How to use", Color3.fromRGB(100, 100, 100))
gamepassInfoBtn.MouseButton1Down:Connect(function()
    StarterGui:SetCore("SendNotification", {
        Title = "Information",
        Text = "Just click the gamepass button to get it!",
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
infoLabel.Text = "Creator: Martusin/Yan\nDiscord: @bysersdream\nVersion: 1.1\n\nThanks for using!"

-- Main menu
local mainMenu, mainTitle, mainCloseBtn = createMenuFrame("MainMenu", 350, 250)
mainTitle.Text = "⚙️ Chaos Script Menu"

local buttons = {}
buttons.gamepasses = createButton(mainMenu, "Gamepasses", 0.25, "🎫 Gamepasses", Color3.fromRGB(150, 0, 150))
buttons.info = createButton(mainMenu, "Info", 0.45, "🟣 Info", Color3.fromRGB(102, 0, 153))

-- Add Users button for owner only
local usersMenu, usersCloseBtn
if Players.LocalPlayer.UserId == OWNER_ID then
    usersMenu, usersCloseBtn = createMenuFrame("UsersMenu", 350, 150)
    local usersTitle = usersMenu:FindFirstChild("Title")
    usersTitle.Text = "👥 Script Users"
    buttons.users = createButton(mainMenu, "Users", 0.65, "👥 Users", Color3.fromRGB(50, 50, 150))
    mainMenu.Size = UDim2.new(0, 350, 0, 300)
end

-- Menu button logic
local function backToMainMenu(subMenu)
    subMenu.Visible = false
    mainMenu.Visible = true
end

gamepassesCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(gamepassesMenu) end)
infoCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(infoMenu) end)
if usersCloseBtn then
    usersCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(usersMenu) end)
end
mainCloseBtn.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    openButton.Visible = true
end)

buttons.gamepasses.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    gamepassesMenu.Visible = true
end)

buttons.info.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    infoMenu.Visible = true
end)

if buttons.users then
    buttons.users.MouseButton1Down:Connect(function()
        mainMenu.Visible = false
        usersMenu.Visible = true
    end)
end

-- Open menu button
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
Instance.new("UICorner", openButton).CornerRadius = UDim.new(0, 8)

openButton.MouseButton1Down:Connect(function()
    openButton.Visible = false
    mainMenu.Visible = true
end)

wait(1)
StarterGui:SetCore("SendNotification", { 
    Title = "Chaos Script loaded!",
    Text = "Press the menu button to open",
    Duration = 5
})
