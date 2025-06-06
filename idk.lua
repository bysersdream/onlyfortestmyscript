local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChaosMenu"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Функция центрирования окон
local function centerFrame(frame)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
end

-- Главное меню
local main = Instance.new("Frame")
main.Name = "main"
main.Parent = ScreenGui
main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
main.Size = UDim2.new(0, 320, 0, 220)
centerFrame(main)
main.Visible = false

local title = Instance.new("TextLabel")
title.Name = "title"
title.Parent = main
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.Size = UDim2.new(1, 0, 0, 40)
title.Font = Enum.Font.GothamBold
title.Text = "Chaos Script"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextSize = 22
title.TextWrapped = true

local gamepassBtn = Instance.new("TextButton")
gamepassBtn.Name = "gamepassBtn"
gamepassBtn.Parent = main
gamepassBtn.BackgroundColor3 = Color3.fromRGB(0, 128, 128)
gamepassBtn.Size = UDim2.new(0.8, 0, 0, 40)
gamepassBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
gamepassBtn.Font = Enum.Font.GothamBold
gamepassBtn.Text = "Gamepass"
gamepassBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
gamepassBtn.TextSize = 18
gamepassBtn.TextWrapped = true

local infoBtn = Instance.new("TextButton")
infoBtn.Name = "infoBtn"
infoBtn.Parent = main
infoBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
infoBtn.Size = UDim2.new(0.8, 0, 0, 40)
infoBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
infoBtn.Font = Enum.Font.GothamBold
infoBtn.Text = "Info"
infoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
infoBtn.TextSize = 18
infoBtn.TextWrapped = true

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "close"
closeBtn.Parent = main
closeBtn.BackgroundColor3 = Color3.fromRGB(216, 221, 86)
closeBtn.Size = UDim2.new(0, 40, 0, 30)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.Text = "❎"
closeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
closeBtn.TextSize = 22

-- Gamepass меню
local gamepassMenu = Instance.new("Frame")
gamepassMenu.Name = "gamepassMenu"
gamepassMenu.Parent = ScreenGui
gamepassMenu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
gamepassMenu.Size = UDim2.new(0, 320, 0, 220)
centerFrame(gamepassMenu)
gamepassMenu.Visible = false

local gamepassTitle = Instance.new("TextLabel")
gamepassTitle.Parent = gamepassMenu
gamepassTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
gamepassTitle.Size = UDim2.new(1, 0, 0, 40)
gamepassTitle.Font = Enum.Font.GothamBold
gamepassTitle.Text = "Gamepass"
gamepassTitle.TextColor3 = Color3.fromRGB(0, 0, 0)
gamepassTitle.TextSize = 22
gamepassTitle.TextWrapped = true

local backFromGamepass = Instance.new("TextButton")
backFromGamepass.Parent = gamepassMenu
backFromGamepass.BackgroundColor3 = Color3.fromRGB(216, 221, 86)
backFromGamepass.Size = UDim2.new(0, 40, 0, 30)
backFromGamepass.Position = UDim2.new(1, -45, 0, 5)
backFromGamepass.Font = Enum.Font.GothamBlack
backFromGamepass.Text = "⬅"
backFromGamepass.TextColor3 = Color3.fromRGB(0, 0, 0)
backFromGamepass.TextSize = 22

local infoGamepass = Instance.new("TextLabel")
infoGamepass.Parent = gamepassMenu
infoGamepass.BackgroundTransparency = 1
infoGamepass.Size = UDim2.new(1, -20, 1, -50)
infoGamepass.Position = UDim2.new(0, 10, 0, 45)
infoGamepass.Font = Enum.Font.Gotham
infoGamepass.TextColor3 = Color3.fromRGB(0, 0, 0)
infoGamepass.TextSize = 16
infoGamepass.TextWrapped = true
infoGamepass.Text = [[
This section is for Gamepass related features.

(You can add buttons here later.)
]]

-- Info меню
local infoMenu = Instance.new("Frame")
infoMenu.Name = "infoMenu"
infoMenu.Parent = ScreenGui
infoMenu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
infoMenu.Size = UDim2.new(0, 320, 0, 220)
centerFrame(infoMenu)
infoMenu.Visible = false

local infoTitle = Instance.new("TextLabel")
infoTitle.Parent = infoMenu
infoTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
infoTitle.Size = UDim2.new(1, 0, 0, 40)
infoTitle.Font = Enum.Font.GothamBold
infoTitle.Text = "Info"
infoTitle.TextColor3 = Color3.fromRGB(0, 0, 0)
infoTitle.TextSize = 22
infoTitle.TextWrapped = true

local backFromInfo = Instance.new("TextButton")
backFromInfo.Parent = infoMenu
backFromInfo.BackgroundColor3 = Color3.fromRGB(216, 221, 86)
backFromInfo.Size = UDim2.new(0, 40, 0, 30)
backFromInfo.Position = UDim2.new(1, -45, 0, 5)
backFromInfo.Font = Enum.Font.GothamBlack
backFromInfo.Text = "⬅"
backFromInfo.TextColor3 = Color3.fromRGB(0, 0, 0)
backFromInfo.TextSize = 22

local infoText = Instance.new("TextLabel")
infoText.Parent = infoMenu
infoText.BackgroundTransparency = 1
infoText.Size = UDim2.new(1, -20, 1, -50)
infoText.Position = UDim2.new(0, 10, 0, 45)
infoText.Font = Enum.Font.Gotham
infoText.TextColor3 = Color3.fromRGB(0, 0, 0)
infoText.TextSize = 16
infoText.TextWrapped = true
infoText.Text = [[
Creator: Martusin/Yan
Version: 1.2

Thanks for using the script!
]]

-- Кнопка открытия меню
local openMainFrame = Instance.new("Frame")
openMainFrame.Name = "openMainFrame"
openMainFrame.Parent = ScreenGui
openMainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
openMainFrame.Position = UDim2.new(0.01, 0, 0.8, 0)
openMainFrame.Size = UDim2.new(0, 100, 0, 30)

local openBtn = Instance.new("TextButton")
openBtn.Name = "openBtn"
openBtn.Parent = openMainFrame
openBtn.BackgroundColor3 = Color3.fromRGB(216, 221, 86)
openBtn.Size = UDim2.new(1, 0, 1, 0)
openBtn.Font = Enum.Font.GothamBold
openBtn.Text = "Open Menu"
openBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
openBtn.TextSize = 18
openBtn.TextWrapped = true

-- Кнопки управления меню
openBtn.MouseButton1Down:Connect(function()
    openMainFrame.Visible = false
    main.Visible = true
end)

closeBtn.MouseButton1Down:Connect(function()
    main.Visible = false
    openMainFrame.Visible = true
end)

gamepassBtn.MouseButton1Down:Connect(function()
    main.Visible = false
    gamepassMenu.Visible = true
end)

infoBtn.MouseButton1Down:Connect(function()
    main.Visible = false
    infoMenu.Visible = true
end)

backFromGamepass.MouseButton1Down:Connect(function()
    gamepassMenu.Visible = false
    main.Visible = true
end)

backFromInfo.MouseButton1Down:Connect(function()
    infoMenu.Visible = false
    main.Visible = true
end)

-- Изначально меню скрыто
main.Visible = false
gamepassMenu.Visible = false
infoMenu.Visible = false
openMainFrame.Visible = true
