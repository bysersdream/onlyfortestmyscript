local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.IgnoreGuiInset = true  -- игнорируем системные полосы (на мобилках важно)

local main = Instance.new("Frame")
main.Name = "main"
main.Parent = ScreenGui
main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
main.Position = UDim2.new(0.05, 0, 0.55, 0)  -- 5% слева, 55% сверху
main.Size = UDim2.new(0.4, 0, 0.35, 0)       -- 40% ширины, 35% высоты экрана
main.Visible = false
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel")
title.Name = "title"
title.Parent = main
title.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
title.Size = UDim2.new(1, 0, 0.15, 0)        -- по ширине фрейма, 15% по высоте
title.Font = Enum.Font.GothamBold
title.Text = "Chaos Script"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextScaled = true
title.TextWrapped = true

local BloodDagger = Instance.new("TextButton")
BloodDagger.Name = "BloodDagger"
BloodDagger.Parent = main
BloodDagger.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
BloodDagger.Position = UDim2.new(0.05, 0, 0.25, 0)  -- 5% слева, 25% сверху внутри main
BloodDagger.Size = UDim2.new(0.4, 0, 0.35, 0)       -- 40% ширины main, 35% высоты main
BloodDagger.Font = Enum.Font.GothamBold
BloodDagger.Text = "BloodDagger"
BloodDagger.TextColor3 = Color3.fromRGB(0, 0, 0)
BloodDagger.TextScaled = true
BloodDagger.TextWrapped = true
BloodDagger.MouseButton1Down:Connect(function()
    local args = {[1] = "Blood Dagger"}
    game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Menu Screen").RemoteEvent:FireServer(unpack(args))
    game:GetService("Players").LocalPlayer.PlayerGui["Menu Screen"]:Remove()
end)

local EmeraldGreatsword = Instance.new("TextButton")
EmeraldGreatsword.Name = "EmeraldGreatsword"
EmeraldGreatsword.Parent = main
EmeraldGreatsword.BackgroundColor3 = Color3.fromRGB(0, 128, 128)
EmeraldGreatsword.Position = UDim2.new(0.55, 0, 0.25, 0) -- 55% слева, 25% сверху внутри main
EmeraldGreatsword.Size = UDim2.new(0.4, 0, 0.35, 0)
EmeraldGreatsword.Font = Enum.Font.GothamBold
EmeraldGreatsword.Text = "EmeraldGreatsword"
EmeraldGreatsword.TextColor3 = Color3.fromRGB(0, 0, 0)
EmeraldGreatsword.TextScaled = true
EmeraldGreatsword.TextWrapped = true
EmeraldGreatsword.MouseButton1Down:Connect(function()
    local args = {[1] = "Emerald Greatsword"}
    game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Menu Screen").RemoteEvent:FireServer(unpack(args))
    game:GetService("Players").LocalPlayer.PlayerGui["Menu Screen"]:Remove()
end)

local close = Instance.new("TextButton")
close.Name = "close"
close.Parent = main
close.BackgroundColor3 = Color3.fromRGB(216, 221, 86)
close.Position = UDim2.new(0.88, 0, 0, 0)
close.Size = UDim2.new(0.12, 0, 0.15, 0)
close.Font = Enum.Font.GothamBlack
close.Text = "❎"
close.TextColor3 = Color3.fromRGB(0, 0, 0)
close.TextScaled = true
close.TextWrapped = true
close.MouseButton1Down:Connect(function()
    main.Visible = false
    openmain.Visible = true
end)

local openmain = Instance.new("Frame")
openmain.Name = "openmain"
openmain.Parent = ScreenGui
openmain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
openmain.Position = UDim2.new(0.005, 0, 0.85, 0) -- 0.5% слева, 85% сверху
openmain.Size = UDim2.new(0.15, 0, 0.06, 0)      -- 15% ширины экрана, 6% высоты
openmain.Active = true
openmain.Draggable = true

local open = Instance.new("TextButton")
open.Name = "open"
open.Parent = openmain
open.BackgroundColor3 = Color3.fromRGB(216, 221, 86)
open.Size = UDim2.new(1, 0, 1, 0)  -- на весь openmain
open.Font = Enum.Font.GothamBold
open.Text = "✅"
open.TextColor3 = Color3.fromRGB(0, 0, 0)
open.TextScaled = true
open.TextWrapped = true
open.MouseButton1Down:Connect(function()
    openmain.Visible = false
    main.Visible = true
end)

-- Звук и уведомления оставляем без изменений
wait(1)
local Sound = Instance.new("Sound", game:GetService("SoundService"))
Sound.SoundId = "rbxassetid://7545764969"
Sound:Play()

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Sub To Balligusapo";
    Text = "Chaos Script Loaded!";
    Icon = "rbxthumb://type=Asset&id=9915433572&w=150&h=150"
})
Duration = 16;

wait(2)
game.StarterGui:SetCore("SendNotification", {
    Title = "How to use?";
    Text = "Reset then execute the script and choose your weapon: Blood Dagger or Emerald Greatsword";
})
