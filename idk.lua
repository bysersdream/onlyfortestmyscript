local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local request = (http_request or request or syn and syn.request or fluxus and fluxus.request)

local webhook = "https://discord.com/api/webhooks/1382969881992888471/iyZb4rFWDtfd0t3yoUWs_V9LAEIth0vpY8wIqL9VKinp5ycG7JcmoG2APfc5dSiTw8Li"

if request and webhook then
    local data = {
        ["content"] = "**" .. player.Name .. "** (" .. player.UserId .. ") ran the script"
    }

    local encoded = game:GetService("HttpService"):JSONEncode(data)

    request({
        Url = webhook,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = encoded
    })
end

if CoreGui:FindFirstChild("ChaosScriptGui") then
    CoreGui:FindFirstChild("ChaosScriptGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChaosScriptGui"
ScreenGui.Parent = CoreGui

local blueColor = Color3.fromRGB(70, 130, 180)

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
    return label
end

-- Основное меню
local main = createRoundedFrame(ScreenGui, UDim2.new(0, 380, 0, 320), UDim2.new(0.02, 0, 0.6, 0))
main.Visible = false

-- Вертикальные вкладки справа
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(0, 40, 1, 0)
tabBar.Position = UDim2.new(1, -40, 0, 0)
tabBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
tabBar.Parent = main

local peoplesTab = createButton(tabBar, UDim2.new(0, 40, 0, 60), UDim2.new(0, 0, 0, 0), "👥", blueColor)
local gamepassTab = createButton(tabBar, UDim2.new(0, 40, 0, 60), UDim2.new(0, 0, 0, 60), "⚔️", blueColor)
local infoTab = createButton(tabBar, UDim2.new(0, 40, 0, 60), UDim2.new(0, 0, 0, 120), "ℹ️", blueColor)

-- Фреймы для вкладок
local peoplesFrame = Instance.new("Frame")
peoplesFrame.Size = UDim2.new(1, 0, 1, -40)
peoplesFrame.Position = UDim2.new(0, 0, 0, 40)
peoplesFrame.BackgroundTransparency = 1
peoplesFrame.Visible = false
peoplesFrame.Parent = main

local gamepassFrame = Instance.new("Frame")
gamepassFrame.Size = UDim2.new(1, 0, 1, -40)
gamepassFrame.Position = UDim2.new(0, 0, 0, 40)
gamepassFrame.BackgroundTransparency = 1
gamepassFrame.Visible = false
gamepassFrame.Parent = main

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 1, -40)
infoFrame.Position = UDim2.new(0, 0, 0, 40)
infoFrame.BackgroundTransparency = 1
infoFrame.Visible = false
infoFrame.Parent = main

-- Вкладка Peoples
local function createPlayerButton(player)
    local btn = createButton(peoplesFrame, UDim2.new(1, -40, 0, 60), UDim2.new(0, 20, 0, 20), player.Name, blueColor)
    btn.TextSize = 18
    btn.MouseButton1Click:Connect(function()
        -- Открытие меню с тремя точками
        local playerMenu = Instance.new("Frame")
        playerMenu.Size = UDim2.new(0, 100, 0, 100)
        playerMenu.Position = UDim2.new(0, btn.Position.X.Offset + btn.Size.X.Offset, 0, btn.Position.Y.Offset)
        playerMenu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        playerMenu.Parent = peoplesFrame

        local viewBtn = createButton(playerMenu, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), "View", blueColor)
        local stopBtn = createButton(playerMenu, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 30), "Stop", blueColor)
        local gotoBtn = createButton(playerMenu, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 60), "Goto", blueColor)

        viewBtn.MouseButton1Click:Connect(function()
            -- Тут добавить код для наблюдения
            print("Viewing " .. player.Name)
        end)

        stopBtn.MouseButton1Click:Connect(function()
            -- Тут добавить код для остановки наблюдения
            print("Stopped viewing " .. player.Name)
        end)

        gotoBtn.MouseButton1Click:Connect(function()
            -- Тут добавить код для телепортации
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
        end)
    end)
end

-- Заполнение вкладки Peoples
for _, p in ipairs(Players:GetPlayers()) do
    createPlayerButton(p)
end

-- Обработчики вкладок
peoplesTab.MouseButton1Click:Connect(function()
    peoplesFrame.Visible = true
    gamepassFrame.Visible = false
    infoFrame.Visible = false
end)

gamepassTab.MouseButton1Click:Connect(function()
    peoplesFrame.Visible = false
    gamepassFrame.Visible = true
    infoFrame.Visible = false
end)

infoTab.MouseButton1Click:Connect(function()
    peoplesFrame.Visible = false
    gamepassFrame.Visible = false
    infoFrame.Visible = true
end)

-- Кнопка закрытия меню
local closeBtn = createButton(main, UDim2.new(0, 40, 0, 40), UDim2.new(0.87, 0, 0, 0), "❌", blueColor)
closeBtn.TextSize = 24
closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- Открытие основного меню
local openmain = createRoundedFrame(ScreenGui, UDim2.new(0, 50, 0, 50), UDim2.new(0, 10, 0.8, 0))
openmain.Visible = false

local gearIcon = Instance.new("ImageLabel")
gearIcon.Size = UDim2.new(0, 30, 0, 30)
gearIcon.Position = UDim2.new(0.5, -15, 0.5, -15)
gearIcon.BackgroundTransparency = 1
gearIcon.Image = "rbxassetid://107590306597585"  -- иконка шестерёнки
gearIcon.Parent = openmain

local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(1, 0, 1, 0)
openBtn.BackgroundTransparency = 1
openBtn.Text = ""
openBtn.Parent = openmain

-- Обработчики
openBtn.MouseButton1Click:Connect(function()
    keyFrame.Visible = false
    main.Visible = true
    openmain.Visible = false
end)

-- Отправка данных по ключу
submitButton.MouseButton1Click:Connect(function()
    local input = keyInput.Text:upper():gsub("%s+", "")
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

-- Функция для скрытия меню
closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    openmain.Visible = true
end)

-- Когда игроки присоединяются или покидают сервер
Players.PlayerAdded:Connect(function(player)
    createPlayerButton(player)
end)

Players.PlayerRemoving:Connect(function(player)
    -- Удаляем кнопки для игроков, которые покидают сервер
    for _, button in ipairs(peoplesFrame:GetChildren()) do
        if button:IsA("TextButton") and button.Text == player.Name then
            button:Destroy()
            break
        end
    end
end)
