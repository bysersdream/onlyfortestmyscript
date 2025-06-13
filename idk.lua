local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("TheGamepassHub") then
    CoreGui:FindFirstChild("TheGamepassHub"):Destroy()
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
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = btn
    return btn
end

local function createRectButton(parent, size, position, text, color)
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

local keyFrame = createRoundedFrame(ScreenGui, UDim2.new(0, 400, 0, 230), UDim2.new(0.35, 0, 0.4, 0))
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

local submitButton = createRectButton(keyFrame, UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, 100), "Confirm", BLUE_COLOR)
local infoLabel = createLabel(keyFrame, UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 135), "", 16)
createLabel(keyFrame, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 150), "To get your key, go to Discord: #support", 16)

local copyBtn = createRectButton(keyFrame, UDim2.new(0, 160, 0, 35), UDim2.new(0.5, -80, 0, 190), "Copy link", Color3.fromRGB(70, 130, 180))
copyBtn.TextColor3 = Color3.new(1, 1, 1)
copyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/bxubNMDf")
    copyBtn.Text = "Copied!"
    wait(2)
    copyBtn.Text = "Copy link"
end)

local main = createRoundedFrame(ScreenGui, UDim2.new(0, 400, 0, 300), UDim2.new(0.3, 0, 0.5, 0))
main.Visible = false

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 40)
tabBar.Position = UDim2.new(0, 0, 0, 0)
tabBar.BackgroundColor3 = DARK_BG
tabBar.Parent = main

local tabs = {}
local selectedTab = nil

local function createTab(name, index)
    local tabBtn = createRectButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, (index - 1) * 120, 0, 0), name, BLUE_COLOR)
    tabBtn.TextColor3 = Color3.new(0, 0, 0)
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 18
    return tabBtn
end

local tabFrames = {}

local gamepassTab = createTab("Gamepasses", 1)
gamepassTab.Parent = tabBar
local gamepassFrame = Instance.new("Frame")
gamepassFrame.Size = UDim2.new(1, 0, 1, -40)
gamepassFrame.Position = UDim2.new(0, 0, 0, 40)
gamepassFrame.BackgroundTransparency = 1
gamepassFrame.Parent = main
tabFrames["Gamepasses"] = gamepassFrame

local infoTab = createTab("Info", 2)
infoTab.Parent = tabBar
local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 1, -40)
infoFrame.Position = UDim2.new(0, 0, 0, 40)
infoFrame.BackgroundTransparency = 1
infoFrame.Visible = false
infoFrame.Parent = main
tabFrames["Info"] = infoFrame

local newsTab = createTab("News", 3)
newsTab.Parent = tabBar
local newsFrame = Instance.new("Frame")
newsFrame.Size = UDim2.new(1, 0, 1, -40)
newsFrame.Position = UDim2.new(0, 0, 0, 40)
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

local gamepasses = {
    {name = "Emerald Greatsword", color = Color3.fromRGB(0, 150, 150)},
    {name = "Blood Dagger", color = Color3.fromRGB(150, 0, 0)},
    {name = "Frost Spear", color = Color3.fromRGB(100, 100, 255)},
}

local pinnedItems = {}

local pinnedFrame = createRoundedFrame(ScreenGui, UDim2.new(0, 200, 0, 200), UDim2.new(0.7, 0, 0.3, 0))
pinnedFrame.Visible = false

local pinnedTitle = createLabel(pinnedFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 5), "📌 Pinned", 20)

local pinnedCloseBtn = createRectButton(pinnedFrame, UDim2.new(0, 30, 0, 30), UDim2.new(1, -35, 0, 5), "✖️", Color3.fromRGB(220, 100, 100))
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
    local btn = createRectButton(gamepassFrame, UDim2.new(0, 110, 0, 40), UDim2.new(0, 0, 0, 0), name, color)
    btn.TextSize = 16
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1,1,1)

    local pinBtn = Instance.new("TextButton")
    pinBtn.Size = UDim2.new(0, 30, 0, 30)
    pinBtn.Position = UDim2.new(1, -35, 0, 5)
    pinBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pinBtn.Text = "📌"
    pinBtn.TextSize = 18
    pinBtn.TextColor3 = Color3.new(0, 0, 0)
    pinBtn.Font = Enum.Font.GothamBold
    pinBtn.Parent = btn
    local pinCorner = Instance.new("UICorner")
    pinCorner.CornerRadius = UDim.new(0, 7)
    pinCorner.Parent = pinBtn

    pinBtn.MouseButton1Click:Connect(function()
        if pinnedItems[name] then return end
        pinnedItems[name] = true

        local pinnedBtn = createRectButton(pinnedFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 10, 0, 0), name, color)
        pinnedBtn.TextSize = 16
        pinnedBtn.TextColor3 = Color3.new(1,1,1)
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
    btn.Position = UDim2.new(0, 10 + (i - 1) * 130, 0, 40)
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

local discordButton = createRectButton(infoFrame, UDim2.new(0, 140, 0, 40), UDim2.new(0.1, 0, 0.2, 0), "Discord Link", Color3.fromRGB(70, 130, 180))
discordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/bxubNMDf")
    discordButton.Text = "Copied!"
    wait(2)
    discordButton.Text = "Discord Link"
end)

local robloxButton = createRectButton(infoFrame, UDim2.new(0, 140, 0, 40), UDim2.new(0.55, 0, 0.2, 0), "Roblox Profile", Color3.fromRGB(100, 100, 255))
robloxButton.MouseButton1Click:Connect(function()
    setclipboard("https://www.roblox.com/users/7231841888/profile")
    robloxButton.Text = "Copied!"
    wait(2)
    robloxButton.Text = "Roblox Profile"
end)

createLabel(infoFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), "Owner: Martusin/Yan", 18)

local newsLabel = createLabel(newsFrame, UDim2.new(1, -20, 0, 200), UDim2.new(0, 10, 0, 50),
[[Welcome to the latest updates!
- Added new weapons.
- Bug fixes and improvements.
- Stay tuned for more!]], 16)
newsLabel.TextWrapped = true

local closeBtn = createRectButton(main, UDim2.new(0, 40, 0, 40), UDim2.new(0.95, -40, 0, 0), "X", Color3.fromRGB(220, 100, 100))
closeBtn.TextSize = 20
closeBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

submitButton.MouseButton1Click:Connect(function()
    local key = keyInput.Text
    if isKeyValid(key) then
        keyFrame.Visible = false
        main.Visible = true
    else
        infoLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
        infoLabel.Text = "Invalid key. Please try again."
        wait(2)
        infoLabel.Text = ""
        infoLabel.TextColor3 = LIGHT_TEXT
    end
end)
