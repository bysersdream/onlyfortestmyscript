local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

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
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0
    frame.Parent = parent
    frame.ClipsDescendants = true
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
    btn.TextColor3 = Color3.new(0, 0, 0)
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
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = fontsize or 18
    label.Parent = parent
    return label
end

local keys = {
    ["7281FJJ"] = true, ["KDJNVJD"] = true, ["S23DJJS"] = true,
    ["382DHJS"] = true, ["NM12HSJ"] = true, ["28SNJAI"] = true,
    ["KSNXUNS"] = true, ["FHAOSN1"] = true, ["XZXZIMS"] = true, ["SJSDOJD"] = true,
}

local function isKeyValid(inputKey)
    return keys[inputKey] == true
end

-- Ввод ключа
local keyFrame = createRoundedFrame(ScreenGui, UDim2.new(0, 400, 0, 230), UDim2.new(0.35, 0, 0.4, 0))
createLabel(keyFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 10), "Enter your passkey", 22)

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.9, 0, 0, 40)
keyInput.Position = UDim2.new(0.05, 0, 0, 50)
keyInput.PlaceholderText = "Enter key here"
keyInput.Text = ""
keyInput.ClearTextOnFocus = false
keyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyInput.TextColor3 = Color3.new(1, 1, 1)
keyInput.Font = Enum.Font.GothamBold
keyInput.TextSize = 18
keyInput.Parent = keyFrame
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 10)
inputCorner.Parent = keyInput

local submitButton = createButton(keyFrame, UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, 100), "Confirm", Color3.fromRGB(70, 130, 180))
local infoLabel = createLabel(keyFrame, UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 135), "", 16)
createLabel(keyFrame, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 150), "To get your key, go to Discord: #support", 16)

local copyBtn = createButton(keyFrame, UDim2.new(0, 160, 0, 35), UDim2.new(0.5, -80, 0, 190), "Copy link", Color3.fromRGB(70, 130, 180))
copyBtn.TextColor3 = Color3.new(1, 1, 1)
copyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/bxubNMDf")
    copyBtn.Text = "Copied!"
    task.wait(2)
    copyBtn.Text = "Copy link"
end)
-- Главное окно (увеличенное)
local main = createRoundedFrame(ScreenGui, UDim2.new(0, 500, 0, 360), UDim2.new(0.02, 0, 0.5, 0))
main.Visible = false

-- Верхняя панель вкладок
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 40)
tabBar.Position = UDim2.new(0, 0, 0, 0)
tabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabBar.Parent = main

local titleLabel = createLabel(main, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), "The Gamepass Hub", 24)
titleLabel.TextColor3 = Color3.fromRGB(173, 216, 230)
titleLabel.TextXAlignment = Enum.TextXAlignment.Center

local gamepassTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 0, 0, 0), "Gamepasses", Color3.fromRGB(70, 130, 180))
local infoTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 120, 0, 0), "Info", Color3.fromRGB(70, 130, 180))
local newsTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 240, 0, 0), "News", Color3.fromRGB(70, 130, 180))

-- Содержимое вкладок
local gamepassFrame = Instance.new("ScrollingFrame")
gamepassFrame.Size = UDim2.new(1, 0, 1, -40)
gamepassFrame.Position = UDim2.new(0, 0, 0, 40)
gamepassFrame.BackgroundTransparency = 1
gamepassFrame.ScrollBarThickness = 6
gamepassFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
gamepassFrame.Parent = main

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 1, -40)
infoFrame.Position = UDim2.new(0, 0, 0, 40)
infoFrame.BackgroundTransparency = 1
infoFrame.Visible = false
infoFrame.Parent = main

local newsFrame = Instance.new("Frame")
newsFrame.Size = UDim2.new(1, 0, 1, -40)
newsFrame.Position = UDim2.new(0, 0, 0, 40)
newsFrame.BackgroundTransparency = 1
newsFrame.Visible = false
newsFrame.Parent = main

-- Вертикальная раскладка кнопок
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = gamepassFrame

-- Кнопки в Gamepass
local emeraldBtn = createButton(gamepassFrame, UDim2.new(0, 200, 0, 50), UDim2.new(), "Emerald Greatsword", Color3.fromRGB(0, 150, 255))
local bloodBtn = createButton(gamepassFrame, UDim2.new(0, 200, 0, 50), UDim2.new(), "Blood Dagger", Color3.fromRGB(150, 0, 0))
local frostBtn = createButton(gamepassFrame, UDim2.new(0, 200, 0, 50), UDim2.new(), "Frost Spear", Color3.fromRGB(100, 100, 255))
-- Вкладка Info
local discordButton = createButton(infoFrame, UDim2.new(0, 200, 0, 40), UDim2.new(0.1, 0, 0.2, 0), "Discord Link", Color3.fromRGB(70, 130, 180))
discordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/bxubNMDf")
    discordButton.Text = "Copied!"
    task.wait(2)
    discordButton.Text = "Discord Link"
end)

local robloxButton = createButton(infoFrame, UDim2.new(0, 200, 0, 40), UDim2.new(0.1, 0, 0.4, 0), "Roblox Profile", Color3.fromRGB(100, 100, 255))
robloxButton.MouseButton1Click:Connect(function()
    setclipboard("https://www.roblox.com/users/7231841888/profile")
    robloxButton.Text = "Copied!"
    task.wait(2)
    robloxButton.Text = "Roblox Profile"
end)

createLabel(infoFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), "Owner: Martusin/Yan", 18)

-- Вкладка News
createLabel(newsFrame, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 10), "News updates coming soon!", 18)

-- Переключение вкладок
gamepassTab.MouseButton1Click:Connect(function()
    gamepassFrame.Visible = true
    infoFrame.Visible = false
    newsFrame.Visible = false
end)

infoTab.MouseButton1Click:Connect(function()
    gamepassFrame.Visible = false
    infoFrame.Visible = true
    newsFrame.Visible = false
end)

newsTab.MouseButton1Click:Connect(function()
    gamepassFrame.Visible = false
    infoFrame.Visible = false
    newsFrame.Visible = true
end)

-- Шестерёнка
local gearFrame = Instance.new("Frame")
gearFrame.Size = UDim2.new(0, 50, 0, 50)
gearFrame.Position = UDim2.new(0.5, -25, 0.5, -25)
gearFrame.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
gearFrame.Active = true
gearFrame.Draggable = true
gearFrame.Visible = false
gearFrame.Parent = ScreenGui

local gearCorner = Instance.new("UICorner", gearFrame)
gearCorner.CornerRadius = UDim.new(1, 0)

local gearBtn = Instance.new("TextButton")
gearBtn.Text = "🔧"
gearBtn.Size = UDim2.new(1, 0, 1, 0)
gearBtn.Font = Enum.Font.GothamBold
gearBtn.TextSize = 30
gearBtn.TextColor3 = Color3.new(1, 1, 1)
gearBtn.BackgroundTransparency = 1
gearBtn.Parent = gearFrame

gearBtn.MouseButton1Click:Connect(function()
    gearFrame.Visible = false
    main.Visible = true
end)

-- Закрыть главное окно
local closeBtn = createButton(main, UDim2.new(0, 40, 0, 40), UDim2.new(0.87, 0, 0, 0), "❌", Color3.fromRGB(70, 130, 180))
closeBtn.TextSize = 24
closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    gearFrame.Visible = true
end)

-- Отправка предметов
local function sendItem(name)
    local args = { [1] = name }
    local menuScreen = player.PlayerGui:FindFirstChild("Menu Screen")
    if menuScreen then
        menuScreen.RemoteEvent:FireServer(unpack(args))
        menuScreen:Remove()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Weapon",
            Text = name .. " obtained!",
            Duration = 3
        })
    end
end

emeraldBtn.MouseButton1Click:Connect(function() sendItem("Emerald Greatsword") end)
bloodBtn.MouseButton1Click:Connect(function() sendItem("Blood Dagger") end)
frostBtn.MouseButton1Click:Connect(function() sendItem("Frost Spear") end)

-- Кнопка подтверждения ключа
submitButton.MouseButton1Click:Connect(function()
    local input = keyInput.Text:upper():gsub("%s+", "")
    if isKeyValid(input) then
        infoLabel.Text = "Key accepted!"
        task.wait(0.3)
        keyFrame.Visible = false
        gearFrame.Visible = true
    else
        infoLabel.Text = "Invalid or inactive key!"
    end
end)
