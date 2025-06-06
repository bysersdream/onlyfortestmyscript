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
    ["U3VDJWM"] = true,
}

ocal keyFrame = createRoundedFrame(ScreenGui, UDim2.new(0, 420, 0, 230), UDim2.new(0.32, 0, 0.35, 0))
local keyLabel = createLabel(keyFrame, UDim2.new(1,0,0,30), UDim2.new(0,0,0,10), "Enter Access Key", 22)

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.9, 0, 0, 40)
keyInput.Position = UDim2.new(0.05, 0, 0, 60)
keyInput.PlaceholderText = "Enter your key here"
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

local submitButton = createButton(keyFrame, UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, 110), "Submit", Color3.fromRGB(216, 221, 86))

local infoLabel = createLabel(keyFrame, UDim2.new(1,0,0,20), UDim2.new(0,0,0,160), "", 16)

local discordLabel = createLabel(keyFrame, UDim2.new(1,0,0,25), UDim2.new(0,0,0,190), "💬 Join our Discord: discord.gg/bxubNMDf", 16)
discordLabel.TextColor3 = Color3.fromRGB(120, 200, 255)
discordLabel.TextWrapped = true
discordLabel.TextScaled = false
discordLabel.TextXAlignment = Enum.TextXAlignment.Center

local copyDiscordBtn = createButton(keyFrame, UDim2.new(0.9, 0, 0, 30), UDim2.new(0.05, 0, 0, 215), "📋 Copy Link", Color3.fromRGB(100, 100, 100))
copyDiscordBtn.TextSize = 16

copyDiscordBtn.MouseButton1Down:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/bxubNMDf")
        infoLabel.Text = "Discord link copied to clipboard!"
    else
        infoLabel.Text = "Your executor doesn't support setclipboard."
    end
end)

local main = createRoundedFrame(ScreenGui, UDim2.new(0, 340, 0, 220), UDim2.new(0.02, 0, 0.6, 0))
main.Visible = false

local title = createLabel(main, UDim2.new(1, 0, 0, 40), UDim2.new(0,0,0,0), "Chaos Script", 22)

local emeraldBtn = createButton(main, UDim2.new(0, 150, 0, 50), UDim2.new(0.05, 0, 0.25, 0), "Emerald Greatsword", Color3.fromRGB(0, 150, 150))
local bloodBtn = createButton(main, UDim2.new(0, 150, 0, 50), UDim2.new(0.55, 0, 0.25, 0), "Blood Dagger", Color3.fromRGB(150, 0, 0))
local frostBtn = createButton(main, UDim2.new(0, 150, 0, 50), UDim2.new(0.05, 0, 0.55, 0), "Frost Spear", Color3.fromRGB(100, 100, 255))

local closeBtn = createButton(main, UDim2.new(0, 40, 0, 40), UDim2.new(0.87, 0, 0, 0), "❌", Color3.fromRGB(216, 221, 86))
closeBtn.TextSize = 24

local openmain = createRoundedFrame(ScreenGui, UDim2.new(0, 100, 0, 35), UDim2.new(0.001, 0, 0.79, 0))
local openBtn = createButton(openmain, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), "Menu", Color3.fromRGB(216, 221, 86))
openBtn.TextSize = 18

openmain.Visible = false
keyFrame.Visible = true
main.Visible = false

local function isKeyValid(inputKey)
    return keys[inputKey] == true
end

submitButton.MouseButton1Down:Connect(function()
    local input = keyInput.Text
    if isKeyValid(input) then
        infoLabel.Text = "Key accepted! Loading menu..."
        wait(0.3)
        keyFrame.Visible = false
        main.Visible = true
        openmain.Visible = true
    else
        infoLabel.Text = "Invalid or inactive key!"
    end
end)

emeraldBtn.MouseButton1Down:Connect(function()
    local args = { [1] = "Emerald Greatsword" }
    local menuScreen = player.PlayerGui:FindFirstChild("Menu Screen")
    if menuScreen then
        menuScreen.RemoteEvent:FireServer(unpack(args))
        menuScreen:Remove()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Weapon",
            Text = "Emerald Greatsword obtained!",
            Duration = 3
        })
    end
end)

bloodBtn.MouseButton1Down:Connect(function()
    local args = { [1] = "Blood Dagger" }
    local menuScreen = player.PlayerGui:FindFirstChild("Menu Screen")
    if menuScreen then
        menuScreen.RemoteEvent:FireServer(unpack(args))
        menuScreen:Remove()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Weapon",
            Text = "Blood Dagger obtained!",
            Duration = 3
        })
    end
end)

frostBtn.MouseButton1Down:Connect(function()
    local args = { [1] = "Frost Spear" }
    local menuScreen = player.PlayerGui:FindFirstChild("Menu Screen")
    if menuScreen then
        menuScreen.RemoteEvent:FireServer(unpack(args))
        menuScreen:Remove()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Weapon",
            Text = "Frost Spear obtained!",
            Duration = 3
        })
    end
end)

closeBtn.MouseButton1Down:Connect(function()
    main.Visible = false
    openmain.Visible = true
end)

openBtn.MouseButton1Down:Connect(function()
    keyFrame.Visible = false
    main.Visible = true
    openmain.Visible = false
end)
