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
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
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
    btn.TextColor3 = Color3.new(1,1,1)
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
    label.TextWrapped = true
    return label
end

-- Ключи
local keys = {
    ["7281FJJ"] = true,
    ["KDJNVJD"] = true,
    ["S23DJJS"] = true,
    ["382DHJS"] = true,
    ["NM12HSJ"] = true,
    ["28SNJAI"] = true,
    ["KSNXUNS"] = true,
    ["FHAOSN1"] = true,
    ["XZXZIMS"] = true,
    ["SJSDOJD"] = true,
}

local function isKeyValid(inputKey)
    return keys[inputKey] == true
end

-- Окно ввода ключа
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

local submitButton = createButton(keyFrame, UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, 100), "Confirm", Color3.fromRGB(70, 130, 255)) -- голубой
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

-- Главное меню
local main = createRoundedFrame(ScreenGui, UDim2.new(0, 380, 0, 300), UDim2.new(0.02, 0, 0.6, 0))
main.Visible = false

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 40)
tabBar.Position = UDim2.new(0, 0, 0, 0)
tabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
tabBar.Parent = main

local blueColor = Color3.fromRGB(70, 130, 255)

local gamepassTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 0, 0, 0), "Gamepasses", blueColor)
local infoTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 120, 0, 0), "Info", blueColor)
local newsTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 240, 0, 0), "News", blueColor)

-- Фреймы вкладок
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

local newsFrame = Instance.new("Frame")
newsFrame.Size = UDim2.new(1, 0, 1, -40)
newsFrame.Position = UDim2.new(0, 0, 0, 40)
newsFrame.BackgroundTransparency = 1
newsFrame.Visible = false
newsFrame.Parent = main

-- Вертикальный список геймпасов с линиями
local gpStartY = 0.05
local gpHeight = 40
local gap = 10

local function createGamepassLabel(text, posY)
    local label = createLabel(gamepassFrame, UDim2.new(1, -40, 0, gpHeight), UDim2.new(0, 20, 0, posY), text, 18)
    label.TextColor3 = blueColor
    return label
end

local function createSeparator(posY)
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(0, 2, 0, 20)
    sep.Position = UDim2.new(0, 40, 0, posY)
    sep.BackgroundColor3 = blueColor
    sep.Parent = gamepassFrame
    return sep
end

-- Emerald Greatsword
createGamepassLabel("Emerald Greatsword", 20)
createSeparator(60)
createSeparator(80)
-- Blood Dagger
createGamepassLabel("Blood Dagger", 100)
createSeparator(140)
createSeparator(160)
-- Frost Spear
createGamepassLabel("Frost Spear", 180)

-- Кнопки для выдачи геймпасов (прозрачные, по позициям текста)
local function createGPButton(posY, name)
    local btn = createButton(gamepassFrame, UDim2.new(0, 150, 0, gpHeight), UDim2.new(0, 20, 0, posY), "", Color3.new(0,0,0))
    btn.BackgroundTransparency = 1
    btn.MouseButton1Click:Connect(function()
        local args = {[1] = name}
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
    end)
    return btn
end

createGPButton(20, "Emerald Greatsword")
createGPButton(100, "Blood Dagger")
createGPButton(180, "Frost Spear")

-- Info вкладка
local discordButton = createButton(infoFrame, UDim2.new(0, 140, 0, 40), UDim2.new(0.1, 0, 0.2, 0), "Discord Link", blueColor)
discordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/bxubNMDf")
    discordButton.Text = "Copied!"
    wait(2)
    discordButton.Text = "Discord Link"
end)

local robloxButton = createButton(infoFrame, UDim2.new(0, 140, 0, 40), UDim2.new(0.55, 0, 0.2, 0), "Roblox Profile", blueColor)
robloxButton.MouseButton1Click:Connect(function()
    setclipboard("https://www.roblox.com/users/7231841888/profile")
    robloxButton.Text = "Copied!"
    wait(2)
    robloxButton.Text = "Roblox Profile"
end)

createLabel(infoFrame, UDim2.new(1,0,0,30), UDim2.new(0,0,0,0), "Owner: Martusin/Yan", 18)

-- News вкладка (пример новости)
local newsText = createLabel(newsFrame, UDim2.new(1, -20, 1, -40), UDim2.new(0, 10, 0, 10),
    "Welcome to the News tab!\nStay tuned for updates and announcements.", 18)
newsText.TextColor3 = blueColor
newsText.TextWrapped = true

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

-- Кнопка закрытия меню
local closeBtn = createButton(main, UDim2.new(0, 40, 0, 40), UDim2.new(0.87, 0, 0, 0), "❌", blueColor)
closeBtn.TextSize = 24

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    openmain.Visible = true
end)

-- Голубой кружок с шестерёнкой (открытие меню)
local openmain = createRoundedFrame(ScreenGui, UDim2.new(0, 50, 0, 50), UDim2.new(0.001, 0, 0.79, 0))
openmain.BackgroundColor3 = blueColor
openmain.Visible = false
openmain.ClipsDescendants = false

local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(1, 0, 1, 0)
openBtn.Position = UDim2.new(0, 0, 0, 0)
openBtn.BackgroundTransparency = 1
openBtn.Text = "⚙️"
openBtn.Font = Enum.Font.GothamBold
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.TextScaled = true
openBtn.Parent = openmain

openBtn.MouseButton1Click:Connect(function()
    openmain.Visible = false
    main.Visible = true
end)

-- Обработка ввода ключа
submitButton.MouseButton1Down:Connect(function()
    local input = keyInput.Text:upper():gsub("%s+", "")
    if isKeyValid(input) then
        infoLabel.Text = "Key accepted! Loading menu..."
        wait(0.3)
        keyFrame.Visible = false
        openmain.Visible = true
    else
        infoLabel.Text = "Invalid or inactive key!"
    end
end)
