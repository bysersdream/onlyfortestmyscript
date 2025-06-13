local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("TheGamepassHub") then
    CoreGui.TheGamepassHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TheGamepassHub"
ScreenGui.Parent = CoreGui

local BLUE_COLOR = Color3.fromRGB(100, 200, 255)
local DARK_BG = Color3.fromRGB(20, 20, 30)
local LIGHT_TEXT = Color3.new(1, 1, 1)

local function createRoundedFrame(parent, size, position)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = DARK_BG
    frame.BackgroundTransparency = 0
    frame.Parent = parent
    frame.ClipsDescendants = true
    frame.Active = true
    frame.Draggable = true
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = frame
    return frame
end

local function createButton(parent, size, position, text, color, textColor)
    local btn = Instance.new("TextButton")
    btn.Size = size
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = textColor or Color3.new(0, 0, 0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.AutoButtonColor = false
    btn.Parent = parent
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = btn
    return btn
end

local function createRectButton(parent, size, position, text, color, textColor)
    local btn = Instance.new("TextButton")
    btn.Size = size
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = textColor or Color3.new(0, 0, 0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.AutoButtonColor = false
    btn.Parent = parent
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    return btn
end

local function createLabel(parent, size, position, text, fontsize)
    local label = Instance.new("TextLabel")
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = LIGHT_TEXT
    label.Font = Enum.Font.GothamBold
    label.TextSize = fontsize or 18
    label.Parent = parent
    return label
end

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

-- Кнопка шестерёнки (иконка) сверху справа
local gearButton = createButton(ScreenGui, UDim2.new(0, 50, 0, 50), UDim2.new(0.95, -55, 0, 10), "⚙️", BLUE_COLOR, Color3.new(1,1,1))
gearButton.TextSize = 30

-- Основное окно
local main = createRoundedFrame(ScreenGui, UDim2.new(0, 420, 0, 320), UDim2.new(0.3, 0, 0.5, 0))
main.Visible = false

-- Кнопка закрытия (крестик) в основном окне
local closeBtn = createRectButton(main, UDim2.new(0, 40, 0, 40), UDim2.new(0.95, -40, 0, 0), "X", Color3.fromRGB(220, 100, 100), Color3.new(1,1,1))
closeBtn.TextSize = 24

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    gearButton.Visible = true
end)

gearButton.MouseButton1Click:Connect(function()
    main.Visible = true
    gearButton.Visible = false
end)

-- Фрейм ввода ключа (внутри main)
local keyFrame = createRoundedFrame(main, UDim2.new(0, 400, 0, 230), UDim2.new(0.025, 0, 0.1, 0))
createLabel(keyFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 10), "Enter your passkey", 22)

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.9, 0, 0, 40)
keyInput.Position = UDim2.new(0.05, 0, 0, 50)
keyInput.PlaceholderText = "Enter key here"
keyInput.Text = ""
keyInput.ClearTextOnFocus = false
keyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyInput.TextColor3 = LIGHT_TEXT
keyInput.Font = Enum.Font.GothamBold
keyInput.TextSize = 18
keyInput.Parent = keyFrame
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 10)
inputCorner.Parent = keyInput

local submitButton = createRectButton(keyFrame, UDim2.new(0.9, 0, 0, 45), UDim2.new(0.05, 0, 0, 100), "Confirm", BLUE_COLOR, Color3.new(1,1,1))

local infoLabel = createLabel(keyFrame, UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 145), "", 16)
createLabel(keyFrame, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 160), "To get your key, go to Discord: #support", 16)

local copyBtn = createRectButton(keyFrame, UDim2.new(0, 160, 0, 35), UDim2.new(0.5, -80, 0, 190), "Copy link", Color3.fromRGB(70, 130, 180), Color3.new(1,1,1))
copyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/bxubNMDf")
    copyBtn.Text = "Copied!"
    wait(2)
    copyBtn.Text = "Copy link"
end)

-- Основные вкладки (Gamepasses, Info, News)
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 45)
tabBar.Position = UDim2.new(0, 0, 0, 0)
tabBar.BackgroundColor3 = DARK_BG
tabBar.Parent = main
tabBar.Visible = false -- скрыты пока ключ не введён

local tabs = {}
local selectedTab = nil

local function createTab(name, index)
    local tabBtn = createRectButton(tabBar, UDim2.new(0, 140, 1, 0), UDim2.new(0, (index - 1) * 140, 0, 0), name, BLUE_COLOR, Color3.new(0, 0, 0))
    tabBtn.TextSize = 20
    return tabBtn
end

local tabFrames = {}

local gamepassTab = createTab("Gamepasses", 1)
gamepassTab.Parent = tabBar
local gamepassFrame = Instance.new("Frame")
gamepassFrame.Size = UDim2.new(1, 0, 1, -45)
gamepassFrame.Position = UDim2.new(0, 0, 0, 45)
gamepassFrame.BackgroundTransparency = 1
gamepassFrame.Parent = main
gamepassFrame.Visible = false
tabFrames["Gamepasses"] = gamepassFrame

local infoTab = createTab("Info", 2)
infoTab.Parent = tabBar
local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 1, -45)
infoFrame.Position = UDim2.new(0, 0, 0, 45)
infoFrame.BackgroundTransparency = 1
infoFrame.Visible = false
infoFrame.Parent = main
tabFrames["Info"] = infoFrame

local newsTab = createTab("News", 3)
newsTab.Parent = tabBar
local newsFrame = Instance.new("Frame")
newsFrame.Size = UDim2.new(1, 0, 1, -45)
newsFrame.Position = UDim2.new(0, 0, 0, 45)
newsFrame.BackgroundTransparency = 1
newsFrame.Visible = false
newsFrame.Parent = main
tabFrames["News"] = newsFrame

local function selectTab(tabName)
    for name, frame in pairs(tabFrames) do
        frame.Visible = (name == tabName)
    end
    for _, tabBtn in pairs({gamepassTab, infoTab, newsTab}) do
        tabBtn.BackgroundColor3 = (tabBtn.Text == tabName) and (BLUE_COLOR) or DARK_BG
        tabBtn.TextColor3 = (tabBtn.Text == tabName) and Color3.new(0,0,0) or LIGHT_TEXT
    end
    selectedTab = tabName
end

selectTab("Gamepasses")

gamepassTab.MouseButton1Click:Connect(function()
    selectTab("Gamepasses")
end)
infoTab.MouseButton1Click:Connect(function()
    selectTab("Info")
end)
newsTab.MouseButton1Click:Connect(function()
    selectTab("News")
end)

-- Увеличенные кнопки геймпассов
local gamepasses = {
    {name = "Emerald Greatsword", color = Color3.fromRGB(0, 150, 150)},
    {name = "Blood Dagger", color = Color3.fromRGB(150, 0, 0)},
    {name = "Frost Spear", color = Color3.fromRGB(100, 100, 255)},
}

local pinnedItems = {}

local pinnedFrame = createRoundedFrame(ScreenGui, UDim2.new(0, 220, 0, 220), UDim2.new(0.7, 0, 0.3, 0))
pinnedFrame.Visible = false

local pinnedTitle = createLabel(pinnedFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 5), "📌 Pinned", 20)

local pinnedCloseBtn = createRectButton(pinnedFrame, UDim2.new(0, 30, 0, 30), UDim2.new(1, -35, 0, 5), "✖️", Color3.fromRGB(220, 100, 100), Color3.new(1,1,1))
pinnedCloseBtn.TextSize = 20
pinnedCloseBtn.MouseButton1Click:Connect(function()
    pinnedFrame.Visible = false
end)

local pinnedLayout = Instance.new("UIListLayout")
pinnedLayout.Parent = pinnedFrame
pinnedLayout.Padding = UDim.new(0, 5)
pinnedLayout.SortOrder = Enum.SortOrder.LayoutOrder
pinnedLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
pinnedLayout.FillDirection = Enum.FillDirection.Vertical

local function createGamepassButton(name, color)
    local btn = createRectButton(gamepassFrame, UDim2.new(0, 170, 0, 50), UDim2.new(0, 0, 0, 0), name, color, Color3.new(1,1,1))
    btn.TextSize = 18
    btn.BackgroundColor3 = color
    btn.TextWrapped = true

    local pinBtn = Instance.new("TextButton")
    pinBtn.Size = UDim2.new(0, 40, 0, 40)
    pinBtn.Position = UDim2.new(1, -45, 0, 5)
    pinBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pinBtn.Text = "📌"
    pinBtn.TextSize = 22
    pinBtn.TextColor3 = Color3.new(0, 0, 0)
    pinBtn.Font = Enum.Font.GothamBold
    pinBtn.Parent = btn
    local pinCorner = Instance.new("UICorner")
    pinCorner.CornerRadius = UDim.new(0, 10)
    pinCorner.Parent = pinBtn

    pinBtn.MouseButton1Click:Connect(function()
        if pinnedItems[name] then return end
        pinnedItems[name] = true

        local pinnedBtn = createRectButton(pinnedFrame, UDim2.new(1, -20, 0, 45), UDim2.new(0, 10, 0, 0), name, color, Color3.new(1,1,1))
        pinnedBtn.TextSize = 18
        pinnedBtn.TextWrapped = true
        pinnedBtn.BackgroundColor3 = color
        pinnedBtn.LayoutOrder = #pinnedFrame:GetChildren()
        pinnedBtn.Parent = pinnedFrame
        pinnedFrame.Visible = true

        pinnedBtn.MouseButton1Click:Connect(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Pinned Item",
                Text = name .. " clicked!",
                Duration = 2
            })
        end)
    end)

    return btn
end

for i, gp in ipairs(gamepasses) do
    local btn = createGamepassButton(gp.name, gp.color)
    btn.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 60)
    btn.Parent = gamepassFrame

    btn.MouseButton1Click:Connect(function()
        local args = { [1] = gp.name }
        local menuScreen = player.PlayerGui:FindFirstChild("Menu Screen")
        if menuScreen then
            menuScreen.RemoteEvent:FireServer(unpack(args))
            menuScreen:Remove()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Weapon",
                Text = gp.name .. " obtained!",
                Duration = 3
            })
        end
    end)
end

local discordButton = createRectButton(infoFrame, UDim2.new(0, 160, 0, 45), UDim2.new(0.1, 0, 0.2, 0), "Discord Link", Color3.fromRGB(70, 130, 180), Color3.new(1,1,1))
discordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/bxubNMDf")
    discordButton.Text = "Copied!"
    wait(2)
    discordButton.Text = "Discord Link"
end)

local robloxButton = createRectButton(infoFrame, UDim2.new(0, 160, 0, 45), UDim2.new(0.55, 0, 0.2, 0), "Roblox Profile", Color3.fromRGB(100, 100, 255), Color3.new(1,1,1))
robloxButton.MouseButton1Click:Connect(function()
    setclipboard("https://www.roblox.com/users/7231841888/profile")
    robloxButton.Text = "Copied!"
    wait(2)
    robloxButton.Text = "Roblox Profile"
end)

createLabel(infoFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), "Owner: Martusin/YT", 20)

submitButton.MouseButton1Click:Connect(function()
    local key = keyInput.Text
    if isKeyValid(key) then
        keyFrame.Visible = false
        tabBar.Visible = true
        selectTab("Gamepasses")
    else
        infoLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
        infoLabel.Text = "Invalid key. Please try again."
        wait(2)
        infoLabel.Text = ""
        infoLabel.TextColor3 = LIGHT_TEXT
    end
end)
