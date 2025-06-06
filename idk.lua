local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.IgnoreGuiInset = true

local function roundCorners(frame, radius)
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = radius or UDim.new(0, 12)
    uicorner.Parent = frame
end

-- Главное окно
local main = Instance.new("Frame")
main.Name = "main"
main.Parent = ScreenGui
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.Position = UDim2.new(0.05, 0, 0.55, 0)
main.Size = UDim2.new(0.4, 0, 0.5, 0)
main.Visible = true
main.Active = true
main.Draggable = true
roundCorners(main, UDim.new(0, 20))

local title = Instance.new("TextLabel")
title.Name = "title"
title.Parent = main
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0.12, 0)
title.Font = Enum.Font.GothamBold
title.Text = "Chaos Script"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.TextWrapped = true

-- Функция создания кнопок с параметрами
local function createButton(parent, name, posY, text, bgColor)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = parent
    btn.BackgroundColor3 = bgColor
    btn.Position = UDim2.new(0.1, 0, posY, 0)
    btn.Size = UDim2.new(0.8, 0, 0.12, 0)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.TextWrapped = true
    roundCorners(btn)
    return btn
end

-- Создаем кнопки оружия
local emeraldBtn = createButton(main, "Emerald", 0.25, "🪁 Emerald Sword", Color3.fromRGB(0, 150, 150))
local bloodBtn = createButton(main, "Blood", 0.45, "🔪 Blood Dagger", Color3.fromRGB(150, 0, 0))
local frostBtn = createButton(main, "Frost", 0.65, "❄️ Frost Spear", Color3.fromRGB(100, 100, 255))

-- Кнопка закрытия (сворачивания)
local close = Instance.new("TextButton")
close.Name = "close"
close.Parent = main
close.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
close.Position = UDim2.new(0.88, 0, 0, 0)
close.Size = UDim2.new(0.12, 0, 0.12, 0)
close.Font = Enum.Font.GothamBlack
close.Text = "❌"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextScaled = true
close.TextWrapped = true
roundCorners(close, UDim.new(0, 12))

-- Фрейм для кнопки меню
local openmain = Instance.new("Frame")
openmain.Name = "openmain"
openmain.Parent = ScreenGui
openmain.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openmain.Position = UDim2.new(0.005, 0, 0.85, 0)
openmain.Size = UDim2.new(0.15, 0, 0.06, 0)
openmain.Active = true
openmain.Draggable = true
roundCorners(openmain, UDim.new(0, 20))
openmain.Visible = false

local open = Instance.new("TextButton")
open.Name = "open"
open.Parent = openmain
open.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
open.Size = UDim2.new(1, 0, 1, 0)
open.Font = Enum.Font.GothamBold
open.Text = "Menu"
open.TextColor3 = Color3.fromRGB(255, 255, 255)
open.TextScaled = true
open.TextWrapped = true
roundCorners(open, UDim.new(0, 20))

-- Обработчики кнопок оружия
emeraldBtn.MouseButton1Down:Connect(function()
    local args = { [1] = "Emerald Greatsword" }
    local playerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui and playerGui:FindFirstChild("Menu Screen") then
        playerGui["Menu Screen"].RemoteEvent:FireServer(unpack(args))
        playerGui["Menu Screen"]:Remove()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Weapon",
            Text = "Emerald Greatsword obtained!",
            Duration = 3
        })
    end
end)

bloodBtn.MouseButton1Down:Connect(function()
    local args = { [1] = "Blood Dagger" }
    local playerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui and playerGui:FindFirstChild("Menu Screen") then
        playerGui["Menu Screen"].RemoteEvent:FireServer(unpack(args))
        playerGui["Menu Screen"]:Remove()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Weapon",
            Text = "Blood Dagger obtained!",
            Duration = 3
        })
    end
end)

frostBtn.MouseButton1Down:Connect(function()
    local args = { [1] = "Frost Spear" }
    local playerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui and playerGui:FindFirstChild("Menu Screen") then
        playerGui["Menu Screen"].RemoteEvent:FireServer(unpack(args))
        playerGui["Menu Screen"]:Remove()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Weapon",
            Text = "Frost Spear obtained!",
            Duration = 3
        })
    end
end)

-- Обработка кликов по кресту и кнопке меню
close.MouseButton1Down:Connect(function()
    main.Visible = false
    openmain.Visible = true
end)

open.MouseButton1Down:Connect(function()
    openmain.Visible = false
    main.Visible = true
end)

-- Звук и уведомления при загрузке
wait(1)
local Sound = Instance.new("Sound", game:GetService("SoundService"))
Sound.SoundId = "rbxassetid://7545764969"
Sound:Play()

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Chaos Script Loaded!",
    Text = "Follow Yan",
})

wait(2)
game.StarterGui:SetCore("SendNotification", {
    Title = "How to use?",
    Text = "Choose any weapon(Emerald Sword, Blood Dagger, Frost, Spear) and enjoy the game",
})
