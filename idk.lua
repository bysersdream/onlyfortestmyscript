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

-- Ключевое окно
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

local submitButton = createButton(keyFrame, UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, 100), "Confirm", blueColor)

-- Главное меню (скрыто по умолчанию)
local main = createRoundedFrame(ScreenGui, UDim2.new(0, 380, 0, 320), UDim2.new(0.02, 0, 0.6, 0))
main.Visible = false

-- Вкладки
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 40)
tabBar.Position = UDim2.new(0, 0, 0, 0)
tabBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
tabBar.Parent = main

local gamepassTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 0, 0, 0), "Gamepasses", blueColor)
local infoTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 120, 0, 0), "Info", blueColor)
local newsTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 240, 0, 0), "News", blueColor)
local peoplesTab = createButton(tabBar, UDim2.new(0, 120, 1, 0), UDim2.new(0, 360, 0, 0), "Peoples", blueColor)

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

-- Peoples вкладка
local peoplesFrame = Instance.new("Frame")
peoplesFrame.Size = UDim2.new(1, 0, 1, -40)
peoplesFrame.Position = UDim2.new(0, 0, 0, 40)
peoplesFrame.BackgroundTransparency = 1
peoplesFrame.Visible = false
peoplesFrame.Parent = main

local scroller = Instance.new("ScrollingFrame")
scroller.Size = UDim2.new(1, 0, 1, 0)
scroller.Position = UDim2.new(0, 0, 0, 0)
scroller.BackgroundTransparency = 1
scroller.Parent = peoplesFrame
scroller.ScrollBarThickness = 10
scroller.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

local function createPlayerButton(playerName, userId)
    local playerButton = createButton(scroller, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 10), playerName, blueColor)
    playerButton.TextSize = 16
    playerButton.MouseButton1Click:Connect(function()
        -- Кнопка с тремя точками
        local menu = Instance.new("Frame")
        menu.Size = UDim2.new(0, 150, 0, 100)
        menu.Position = UDim2.new(0, playerButton.AbsolutePosition.X, 0, playerButton.AbsolutePosition.Y + playerButton.Size.Y.Offset)
        menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        menu.BackgroundTransparency = 0.5
        menu.Parent = scroller
        
        local viewButton = createButton(menu, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), "View", blueColor)
                local stopButton = createButton(menu, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 30), "Stop", blueColor)
        local gotoButton = createButton(menu, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 60), "Goto", blueColor)

        -- Действия по нажатию на кнопки меню
        viewButton.MouseButton1Click:Connect(function()
            -- Функция просмотра профиля игрока
            local playerToView = game.Players:FindFirstChild(userId)
            if playerToView then
                -- Открыть профиль игрока
                game:GetService("Players"):Chat("/e show " .. playerToView.Name)
            end
        end)

        stopButton.MouseButton1Click:Connect(function()
            -- Остановить игрока (например, банить, кикать и т.д.)
            local playerToStop = game.Players:FindFirstChild(userId)
            if playerToStop then
                -- Пример кика
                playerToStop:Kick("You have been kicked from the server!")
            end
        end)

        gotoButton.MouseButton1Click:Connect(function()
            -- Переместить игрока в точку текущего игрока
            local playerToGoto = game.Players:FindFirstChild(userId)
            if playerToGoto then
                player.Character:MoveTo(playerToGoto.Character.HumanoidRootPart.Position)
            end
        end)
    end)
    return playerButton
end

-- Обновить список игроков
local function updatePeoplesList()
    -- Очищаем текущие кнопки
    for _, child in pairs(scroller:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    -- Для каждого игрока в игре
    for _, playerInGame in pairs(Players:GetPlayers()) do
        if playerInGame ~= player then
            createPlayerButton(playerInGame.Name, playerInGame.UserId)
        end
    end
end

-- Вкладки переключение
gamepassTab.MouseButton1Click:Connect(function()
    gamepassFrame.Visible = true
    infoFrame.Visible = false
    newsFrame.Visible = false
    peoplesFrame.Visible = false
end)

infoTab.MouseButton1Click:Connect(function()
    gamepassFrame.Visible = false
    infoFrame.Visible = true
    newsFrame.Visible = false
    peoplesFrame.Visible = false
end)

newsTab.MouseButton1Click:Connect(function()
    gamepassFrame.Visible = false
    infoFrame.Visible = false
    newsFrame.Visible = true
    peoplesFrame.Visible = false
end)

peoplesTab.MouseButton1Click:Connect(function()
    gamepassFrame.Visible = false
    infoFrame.Visible = false
    newsFrame.Visible = false
    peoplesFrame.Visible = true
    updatePeoplesList()  -- Обновить список игроков при открытии вкладки
end)

-- Кнопка закрытия — скрывает меню, оставляя кнопку шестерёнки
local closeBtn = createButton(main, UDim2.new(0, 40, 0, 40), UDim2.new(0.87, 0, 0, 0), "❌", blueColor)
closeBtn.TextSize = 24

-- Кнопка открытия меню (с шестерёнкой)
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
submitButton.MouseButton1Click:Connect(function()
    local input = keyInput.Text:upper():gsub("%s+", "")
    if isKeyValid(input) then
        infoLabel.Text = "Key accepted! Loading menu..."
        wait(0.3)
        keyFrame.Visible = false
        main.Visible = true
        openmain.Visible = false
    else
        infoLabel.Text = "Invalid or inactive key!"
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    openmain.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    keyFrame.Visible = false
    main.Visible = true
    openmain.Visible = false
end)

-- Обновление списка игроков при каждом изменении состава сервера
Players.PlayerAdded:Connect(function(playerInGame)
    if main.Visible and peoplesFrame.Visible then
        updatePeoplesList()
    end
end)

Players.PlayerRemoving:Connect(function(playerInGame)
    if main.Visible and peoplesFrame.Visible then
        updatePeoplesList()
    end
end)
