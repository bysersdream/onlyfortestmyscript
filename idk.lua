-- Зависимости
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Функция для создания фрейма меню
local function createMenuFrame(name, width, height)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(0, width, 0, height)
    frame.Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = playerGui

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.Text = name
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseButton"
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.Text = "X"
    closeBtn.Parent = frame

    return frame, title, closeBtn
end

-- Функция для создания кнопки в меню
local function createButton(parent, name, posYScale, text, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, posYScale, 0)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = text
    btn.Parent = parent
    return btn
end

-- Создаём главное меню
local mainMenu, mainTitle, mainCloseBtn = createMenuFrame("Main Menu", 350, 350)
mainTitle.Text = "Main Menu"

-- Кнопки Gamepass и Info в главном меню
local gamepassBtn = createButton(mainMenu, "gamepassBtn", 0.3, "Gamepass", Color3.fromRGB(0, 150, 150))
local infoBtn = createButton(mainMenu, "infoBtn", 0.6, "Info", Color3.fromRGB(100, 100, 100))

-- Создаём меню Gamepass
local gamepassMenu, gamepassTitle, gamepassCloseBtn = createMenuFrame("Gamepass", 350, 250)
gamepassTitle.Text = "⚔️ Gamepass"

local emeraldBtn = createButton(gamepassMenu, "Emerald", 0.2, "🪁 Emerald Sword", Color3.fromRGB(0, 150, 150))
local bloodBtn = createButton(gamepassMenu, "Blood", 0.4, "🔪 Blood Dagger", Color3.fromRGB(150, 0, 0))
local frostBtn = createButton(gamepassMenu, "Frost", 0.6, "❄️ Frost Spear", Color3.fromRGB(100, 100, 255))
local gamepassInfoBtn = createButton(gamepassMenu, "gamepassInfo", 0.8, "ℹ️ How to use", Color3.fromRGB(100, 100, 100))

-- Создаём меню Info
local infoMenu, infoTitle, infoCloseBtn = createMenuFrame("Info", 350, 250)
infoTitle.Text = "🟣 Info"

local infoLabel = Instance.new("TextLabel")
infoLabel.Parent = infoMenu
infoLabel.BackgroundTransparency = 1
infoLabel.Size = UDim2.new(0.9, 0, 0.8, 0)
infoLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextScaled = true
infoLabel.TextWrapped = true
infoLabel.Text = "Creator: Martusin/Yan\nDiscord: @bysersdream\nVersion: 1.1\n\nThanks for using!"

-- Функция показа главного меню
local function showMainMenu()
    mainMenu.Visible = true
    gamepassMenu.Visible = false
    infoMenu.Visible = false
end

-- Обработчики закрытия меню (возврат к главному)
gamepassCloseBtn.MouseButton1Down:Connect(showMainMenu)
infoCloseBtn.MouseButton1Down:Connect(showMainMenu)

mainCloseBtn.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
end)

-- Обработчики кнопок главного меню
gamepassBtn.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    gamepassMenu.Visible = true
end)

infoBtn.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    infoMenu.Visible = true
end)

-- Обработчики кнопок Gamepass (оружие)

local function fireWeaponRequest(weaponName)
    local menuScreen = playerGui:FindFirstChild("Menu Screen")
    if menuScreen and menuScreen:FindFirstChild("RemoteEvent") then
        menuScreen.RemoteEvent:FireServer(weaponName)
        menuScreen:Destroy()
        StarterGui:SetCore("SendNotification", {
            Title = "Weapon",
            Text = weaponName .. " obtained!",
            Duration = 3
        })
    else
        StarterGui:SetCore("SendNotification", {
            Title = "Error",
            Text = "Menu Screen or RemoteEvent not found!",
            Duration = 3
        })
    end
end

emeraldBtn.MouseButton1Down:Connect(function()
    fireWeaponRequest("Emerald Greatsword")
end)

bloodBtn.MouseButton1Down:Connect(function()
    fireWeaponRequest("Blood Dagger")
end)

frostBtn.MouseButton1Down:Connect(function()
    fireWeaponRequest("Frost Spear")
end)

gamepassInfoBtn.MouseButton1Down:Connect(function()
    StarterGui:SetCore("SendNotification", {
        Title = "Information",
        Text = "Just click the weapon button to get it!",
        Duration = 5
    })
end)

-- Создаём кнопку для открытия меню (если её нет)
local openButton = Instance.new("TextButton")
openButton.Name = "OpenMenuButton"
openButton.Size = UDim2.new(0, 100, 0, 30)
openButton.Position = UDim2.new(0, 10, 0, 10)
openButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
openButton.TextColor3 = Color3.new(1, 1, 1)
openButton.Font = Enum.Font.GothamBold
openButton.TextSize = 18
openButton.Text = "Menu"
openButton.Parent = playerGui
openButton.ZIndex = 10

openButton.MouseButton1Down:Connect(function()
    openButton.Visible = false
    mainMenu.Visible = true
end)

-- Изначально меню закрыто, кнопка видна
mainMenu.Visible = false
gamepassMenu.Visible = false
infoMenu.Visible = false
openButton.Visible = true

-- Нотификация о загрузке
StarterGui:SetCore("SendNotification", { 
    Title = "Chaos Script loaded!",
    Text = "Press the menu button to open",
    Duration = 5
})
