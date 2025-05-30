local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local OWNER_ID = 8567813665
local SCRIPT_USERS = {} -- Таблица для отслеживания пользователей скрипта

-- Отслеживание пользователей скрипта
local function trackScriptUser(player)
    SCRIPT_USERS[player.UserId] = true
end

-- Проверка, использует ли игрок скрипт
local function isScriptUser(player)
    return SCRIPT_USERS[player.UserId] or false
end

-- Уведомление о входе владельца
local function showOwnerNotification()
    local owner = Players:GetPlayerByUserId(OWNER_ID)
    if not owner then return end

    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size48

    local content, isReady = Players:GetUserThumbnailAsync(OWNER_ID, thumbType, thumbSize)

    StarterGui:SetCore("SendNotification", {
        Title = "Владелец " .. owner.Name .. " зашёл!",
        Text = "Chaos Script активирован",
        Duration = 5,
        Icon = content
    })
    
    -- Проигрывание звука
    wait(0.5)
    local Sound = Instance.new("Sound",game:GetService("SoundService"))
    Sound.SoundId = "rbxassetid://7545764969"
    Sound:Play()
end

-- Отслеживание локального игрока как пользователя скрипта
trackScriptUser(Players.LocalPlayer)

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChaosScriptGUI"
ScreenGui.Parent = game.CoreGui

-- Улучшенный дизайн кнопок
local function createButton(parent, name, positionY, text, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = parent
    btn.BackgroundColor3 = color
    btn.Position = UDim2.new(0.05, 0, positionY, 0)
    btn.Size = UDim2.new(0.9, 0, 0.12, 0)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextScaled = true
    btn.TextWrapped = true
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    -- Анимация при наведении
    btn.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(
            math.floor(color.R * 255 + 30),
            math.floor(color.G * 255 + 30),
            math.floor(color.B * 255 + 30)
        )}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
    
    return btn
end

-- Создание меню
local function createMenuFrame(name, sizeX, sizeY)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.BackgroundColor3 = Color3.fromRGB(15,15,20)
    frame.Position = UDim2.new(0.3,0,0.2,0)
    frame.Size = UDim2.new(0,sizeX,0,sizeY)
    frame.Visible = false
    frame.Active = true
    frame.Draggable = true
    frame.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.BackgroundColor3 = Color3.fromRGB(30,30,40)
    title.Size = UDim2.new(1,0,0,50)
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Color3.new(1,1,1)
    title.TextScaled = true
    title.TextWrapped = true
    title.Parent = frame
    
    local cornerTitle = Instance.new("UICorner")
    cornerTitle.CornerRadius = UDim.new(0, 12)
    cornerTitle.Parent = title
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "Close"
    closeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    closeBtn.Position = UDim2.new(1,-50,0,0)
    closeBtn.Size = UDim2.new(0,50,0,50)
    closeBtn.Font = Enum.Font.GothamBlack
    closeBtn.Text = "✖"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.TextScaled = true
    closeBtn.Parent = frame
    
    local cornerClose = Instance.new("UICorner")
    cornerClose.CornerRadius = UDim.new(0, 12)
    cornerClose.Parent = closeBtn
    
    return frame, title, closeBtn
end

-- Создание меню Users (только для владельца)
local function createUsersMenu()
    local usersMenu, usersTitle, usersCloseBtn = createMenuFrame("UsersMenu", 350, 400)
    usersTitle.Text = "👥 Пользователи скрипта"
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Parent = usersMenu
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.Size = UDim2.new(0.9, 0, 0.8, 0)
    scrollFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.ScrollBarThickness = 5
    
    local userListLayout = Instance.new("UIListLayout")
    userListLayout.Parent = scrollFrame
    userListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    userListLayout.Padding = UDim.new(0, 5)
    
    local function updateUserList()
        -- Очистка существующих записей
        for _, child in ipairs(scrollFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        -- Получение всех игроков и фильтрация пользователей скрипта
        local players = Players:GetPlayers()
        local scriptUsers = {}
        
        for _, player in ipairs(players) do
            if isScriptUser(player) or player.UserId == OWNER_ID then
                table.insert(scriptUsers, player)
            end
        end
        
        -- Создание записей для каждого пользователя скрипта
        for i, player in ipairs(scriptUsers) do
            local userFrame = Instance.new("Frame")
            userFrame.Parent = scrollFrame
            userFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            userFrame.Size = UDim2.new(1, 0, 0, 60)
            userFrame.LayoutOrder = i
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = userFrame
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Parent = userFrame
            nameLabel.BackgroundTransparency = 1
            nameLabel.Size = UDim2.new(0.7, 0, 0.4, 0)
            nameLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextColor3 = Color3.new(1, 1, 1)
            nameLabel.TextScaled = true
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Text = player.Name
            
            local userIdLabel = Instance.new("TextLabel")
            userIdLabel.Parent = userFrame
            userIdLabel.BackgroundTransparency = 1
            userIdLabel.Size = UDim2.new(0.7, 0, 0.3, 0)
            userIdLabel.Position = UDim2.new(0.1, 0, 0.5, 0)
            userIdLabel.Font = Enum.Font.Gotham
            userIdLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
            userIdLabel.TextScaled = true
            userIdLabel.TextXAlignment = Enum.TextXAlignment.Left
            userIdLabel.Text = "ID: " .. player.UserId
            
            -- Кнопка копирования
            local copyBtn = Instance.new("TextButton")
            copyBtn.Parent = userFrame
            copyBtn.Size = UDim2.new(0.2, 0, 0.4, 0)
            copyBtn.Position = UDim2.new(0.75, 0, 0.1, 0)
            copyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
            copyBtn.TextColor3 = Color3.new(1, 1, 1)
            copyBtn.Font = Enum.Font.Gotham
            copyBtn.Text = "Копировать"
            copyBtn.TextScaled = true
            
            local cornerCopy = Instance.new("UICorner")
            cornerCopy.CornerRadius = UDim.new(0, 8)
            cornerCopy.Parent = copyBtn
            
            copyBtn.MouseButton1Down:Connect(function()
                setclipboard(tostring(player.UserId))
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Скопировано!",
                    Text = "ID пользователя скопирован",
                    Duration = 2
                })
            end)
            
            -- Кнопка кика (только для владельца и не для себя)
            if Players.LocalPlayer.UserId == OWNER_ID and player.UserId ~= OWNER_ID then
                local kickBtn = Instance.new("TextButton")
                kickBtn.Parent = userFrame
                kickBtn.Size = UDim2.new(0.2, 0, 0.4, 0)
                kickBtn.Position = UDim2.new(0.75, 0, 0.55, 0)
                kickBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
                kickBtn.TextColor3 = Color3.new(1, 1, 1)
                kickBtn.Font = Enum.Font.GothamBold
                kickBtn.Text = "Кикнуть"
                kickBtn.TextScaled = true
                
                local cornerKick = Instance.new("UICorner")
                cornerKick.CornerRadius = UDim.new(0, 8)
                cornerKick.Parent = kickBtn
                
                kickBtn.MouseButton1Down:Connect(function()
                    -- Кикнуть игрока, удалив его доступ к скрипту
                    SCRIPT_USERS[player.UserId] = nil
                    updateUserList()
                    
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Кикнут",
                        Text = player.Name .. " был кикнут из скрипта",
                        Duration = 3
                    })
                end)
            end
        end
        
        -- Обновление размера прокрутки
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, userListLayout.AbsoluteContentSize.Y)
    end
    
    -- Обновление списка при входе/выходе игроков
    updateUserList()
    Players.PlayerAdded:Connect(function(player)
        -- Автоматически отслеживать владельца
        if player.UserId == OWNER_ID then
            trackScriptUser(player)
            showOwnerNotification()
        end
        updateUserList()
    end)
    
    Players.PlayerRemoving:Connect(updateUserList)
    
    return usersMenu, usersCloseBtn
end

-- Кнопка открытия меню
local openButton = Instance.new("TextButton")
openButton.Name = "OpenMenuButton"
openButton.Parent = ScreenGui
openButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
openButton.Position = UDim2.new(0.01,0,0.85,0)
openButton.Size = UDim2.new(0,120,0,40)
openButton.Font = Enum.Font.GothamBold
openButton.Text = "⚙️ МЕНЮ"
openButton.TextColor3 = Color3.new(1,1,1)
openButton.TextScaled = true
openButton.BorderSizePixel = 0

local cornerOpen = Instance.new("UICorner")
cornerOpen.CornerRadius = UDim.new(0, 8)
cornerOpen.Parent = openButton

-- Главное меню
local mainMenu, mainTitle, mainCloseBtn = createMenuFrame("MainMenu", 350, 350)
mainTitle.Text = "⚙️ Chaos Script Menu"

-- Создание кнопок главного меню
local buttons = {}
buttons.hitboxExpander = createButton(mainMenu, "HitboxExpander", 0.15, "🚀 Hitbox Expander", Color3.fromRGB(150, 75, 0))
buttons.movement = createButton(mainMenu, "Movement", 0.35, "🏃 Movement", Color3.fromRGB(0, 0, 150))
buttons.weapons = createButton(mainMenu, "Weapons", 0.55, "⚔️ Weapons", Color3.fromRGB(150, 0, 150))
buttons.info = createButton(mainMenu, "Info", 0.75, "🟣 Info", Color3.fromRGB(102, 0, 153))

-- Добавление кнопки Users только для владельца
local usersMenu, usersCloseBtn
if Players.LocalPlayer.UserId == OWNER_ID then
    usersMenu, usersCloseBtn = createUsersMenu()
    
    buttons.users = createButton(mainMenu, "Users", 0.95, "👥 Пользователи", Color3.fromRGB(50, 50, 150))
    
    -- Изменение размера главного меню для новой кнопки
    mainMenu.Size = UDim2.new(0, 350, 0, 400)
    
    -- Перемещение других кнопок
    buttons.hitboxExpander.Position = UDim2.new(0.05, 0, 0.12, 0)
    buttons.movement.Position = UDim2.new(0.05, 0, 0.28, 0)
    buttons.weapons.Position = UDim2.new(0.05, 0, 0.44, 0)
    buttons.info.Position = UDim2.new(0.05, 0, 0.60, 0)
end

-- Меню Hitbox Expander
local hitboxMenu, hitboxTitle, hitboxCloseBtn = createMenuFrame("HitboxMenu", 350, 250)
hitboxTitle.Text = "🚀 Hitbox Expander"

local hitboxLabel = Instance.new("TextLabel")
hitboxLabel.Parent = hitboxMenu
hitboxLabel.BackgroundTransparency = 1
hitboxLabel.Size = UDim2.new(0.9,0,0.2,0)
hitboxLabel.Position = UDim2.new(0.05,0,0.15,0)
hitboxLabel.Font = Enum.Font.Gotham
hitboxLabel.TextColor3 = Color3.new(1,1,1)
hitboxLabel.TextScaled = true
hitboxLabel.TextWrapped = true
hitboxLabel.Text = "Размер Hitbox:"

local hitboxSlider = Instance.new("TextButton")
hitboxSlider.Parent = hitboxMenu
hitboxSlider.BackgroundColor3 = Color3.fromRGB(60,60,80)
hitboxSlider.Position = UDim2.new(0.05,0,0.35,0)
hitboxSlider.Size = UDim2.new(0.9,0,0.15,0)
hitboxSlider.Text = ""
hitboxSlider.AutoButtonColor = false

local hitboxFill = Instance.new("Frame")
hitboxFill.Parent = hitboxSlider
hitboxFill.BackgroundColor3 = Color3.fromRGB(0,150,200)
hitboxFill.Size = UDim2.new(0.5,0,1,0)

local hitboxCorner = Instance.new("UICorner")
hitboxCorner.Parent = hitboxSlider
hitboxCorner.CornerRadius = UDim.new(0,8)

local hitboxValue = Instance.new("TextLabel")
hitboxValue.Parent = hitboxMenu
hitboxValue.BackgroundTransparency = 1
hitboxValue.Size = UDim2.new(0.9,0,0.15,0)
hitboxValue.Position = UDim2.new(0.05,0,0.55,0)
hitboxValue.Font = Enum.Font.GothamBold
hitboxValue.TextColor3 = Color3.new(1,1,1)
hitboxValue.Text = "Размер: 5"
hitboxValue.TextScaled = true

local hitboxApply = createButton(hitboxMenu, "ApplyHitbox", 0.75, "Применить", Color3.fromRGB(0,180,0))

-- Hitbox Expander логика
local hitboxSize = 5
local hitboxEnabled = false
local hitboxParts = {}

local function updateHitbox()
    for _, part in pairs(hitboxParts) do
        part:Destroy()
    end
    hitboxParts = {}
    
    if hitboxEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    part.CFrame = hrp.CFrame
                    part.Anchored = false
                    part.CanCollide = false
                    part.Transparency = 0.7
                    part.Color = Color3.fromRGB(255,0,0)
                    part.Parent = workspace
                    part.Name = "HitboxExpander_" .. player.Name
                    
                    local weld = Instance.new("WeldConstraint")
                    weld.Part0 = hrp
                    weld.Part1 = part
                    weld.Parent = part
                    
                    table.insert(hitboxParts, part)
                end
            end
        end
    end
end

-- Обработка слайдера
local sliding = false
hitboxSlider.MouseButton1Down:Connect(function()
    sliding = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliding = false
    end
end)

hitboxSlider.MouseMoved:Connect(function()
    if sliding then
        local mousePos = UserInputService:GetMouseLocation().X
        local sliderPos = hitboxSlider.AbsolutePosition.X
        local sliderSize = hitboxSlider.AbsoluteSize.X
        local percent = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
        
        hitboxFill.Size = UDim2.new(percent,0,1,0)
        hitboxSize = math.floor(5 + percent * 15) -- От 5 до 20
        hitboxValue.Text = "Размер: " .. hitboxSize
    end
end)

hitboxApply.MouseButton1Down:Connect(function()
    hitboxEnabled = not hitboxEnabled
    if hitboxEnabled then
        hitboxApply.Text = "Выключить"
        hitboxApply.BackgroundColor3 = Color3.fromRGB(180,0,0)
        updateHitbox()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Hitbox Expander",
            Text = "Включен с размером " .. hitboxSize,
            Duration = 3
        })
    else
        hitboxApply.Text = "Применить"
        hitboxApply.BackgroundColor3 = Color3.fromRGB(0,180,0)
        for _, part in pairs(hitboxParts) do
            part:Destroy()
        end
        hitboxParts = {}
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Hitbox Expander",
            Text = "Выключен",
            Duration = 3
        })
    end
end)

-- Меню Movement
local movementMenu, movementTitle, movementCloseBtn = createMenuFrame("MovementMenu", 350, 350)
movementTitle.Text = "🏃 Movement Controls"

-- Функция для создания переключателей
local function createToggle(parent, posY, text, defaultColor, activeColor)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(30,30,40)
    frame.Size = UDim2.new(0.9, 0, 0.12, 0)
    frame.Position = UDim2.new(0.05, 0, posY, 0)
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.new(1,1,1)
    label.TextScaled = true
    label.TextWrapped = true
    label.Text = text
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.Size = UDim2.new(0.25, 0, 0.7, 0)
    toggleBtn.Position = UDim2.new(0.7, 0, 0.15, 0)
    toggleBtn.BackgroundColor3 = defaultColor
    toggleBtn.TextColor3 = Color3.new(1,1,1)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextScaled = true
    toggleBtn.Text = "OFF"
    
    local cornerToggle = Instance.new("UICorner")
    cornerToggle.CornerRadius = UDim.new(0, 8)
    cornerToggle.Parent = toggleBtn
    
    local toggled = false
    toggleBtn.MouseButton1Down:Connect(function()
        toggled = not toggled
        if toggled then
            toggleBtn.BackgroundColor3 = activeColor
            toggleBtn.Text = "ON"
        else
            toggleBtn.BackgroundColor3 = defaultColor
            toggleBtn.Text = "OFF"
        end
        return toggled
    end)
    return frame, function() return toggled end, toggleBtn
end

-- Создание переключателей для Movement
local flyToggle, flyGet, flyBtn = createToggle(movementMenu, 0.15, "🪁 Fly", Color3.fromRGB(150, 0, 0), Color3.fromRGB(0, 150, 0))
local speedToggle, speedGet, speedBtn = createToggle(movementMenu, 0.30, "⚡ Speed (x2)", Color3.fromRGB(150, 0, 0), Color3.fromRGB(0, 150, 0))
local noclipToggle, noclipGet, noclipBtn = createToggle(movementMenu, 0.45, "👻 Noclip", Color3.fromRGB(150, 0, 0), Color3.fromRGB(0, 150, 0))
local jumpToggle, jumpGet, jumpBtn = createToggle(movementMenu, 0.60, "🦘 High Jump", Color3.fromRGB(150, 0, 0), Color3.fromRGB(0, 150, 0))

-- Реализация Fly
local flying = false
local flySpeed = 2
local flyConnection

flyBtn.MouseButton1Down:Connect(function()
    flying = not flying
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if flying then
        humanoid.PlatformStand = true
        
        flyConnection = RunService.Stepped:Connect(function()
            if character and character:FindFirstChild("HumanoidRootPart") then
                local root = character.HumanoidRootPart
                local cam = workspace.CurrentCamera.CFrame
                
                local vel = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    vel = vel + (cam.LookVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    vel = vel - (cam.LookVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    vel = vel - (cam.RightVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    vel = vel + (cam.RightVector * flySpeed)
                end
                
                root.Velocity = vel * 100
                root.RotVelocity = Vector3.new()
            end
        end)
    else
        humanoid.PlatformStand = false
        if flyConnection then
            flyConnection:Disconnect()
        end
    end
end)

-- Реализация Speed
speedBtn.MouseButton1Down:Connect(function()
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if speedGet() then
        humanoid.WalkSpeed = 32 -- Удвоенная скорость (стандартная 16)
    else
        humanoid.WalkSpeed = 16 -- Стандартная скорость
    end
end)

-- Реализация Noclip
local noclipConnection
noclipBtn.MouseButton1Down:Connect(function()
    if noclipGet() then
        noclipConnection = RunService.Stepped:Connect(function()
            local player = Players.LocalPlayer
            local character = player.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
        end
    end
end)

-- Реализация High Jump
jumpBtn.MouseButton1Down:Connect(function()
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if jumpGet() then
        humanoid.JumpPower = 100 -- Высокий прыжок
    else
        humanoid.JumpPower = 50 -- Стандартный прыжок
    end
end)

-- Меню Weapons
local weaponsMenu, weaponsTitle, weaponsCloseBtn = createMenuFrame("WeaponsMenu", 350, 250)
weaponsTitle.Text = "⚔️ Weapons"

local emeraldBtn = createButton(weaponsMenu, "Emerald", 0.2, "🪁 Emerald Sword", Color3.fromRGB(0, 150, 150))
local bloodBtn = createButton(weaponsMenu, "Blood", 0.4, "🔪 Blood Dagger", Color3.fromRGB(150, 0, 0))
local infoBtn = createButton(weaponsMenu, "Info", 0.6, "ℹ️ How to use", Color3.fromRGB(100, 100, 100))

emeraldBtn.MouseButton1Down:Connect(function()
    local args = { [1] = "Emerald Greatsword" }
    game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Menu Screen").RemoteEvent:FireServer(unpack(args))
    game:GetService("Players").LocalPlayer.PlayerGui["Menu Screen"]:Remove()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Weapon",
        Text = "Emerald Greatsword получен!",
        Duration = 3
    })
end)

bloodBtn.MouseButton1Down:Connect(function()
    local args = { [1] = "Blood Dagger" }
    game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Menu Screen").RemoteEvent:FireServer(unpack(args))
    game:GetService("Players").LocalPlayer.PlayerGui["Menu Screen"]:Remove()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Weapon",
        Text = "Blood Dagger получен!",
        Duration = 3
    })
end)

infoBtn.MouseButton1Down:Connect(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Информация",
        Text = "Просто нажмите на кнопку оружия чтобы получить его!",
        Duration = 5
    })
end)

-- Меню информации
local infoMenu, infoTitle, infoCloseBtn = createMenuFrame("InfoMenu", 350, 250)
infoTitle.Text = "🟣 Info"

local infoLabel = Instance.new("TextLabel")
infoLabel.Parent = infoMenu
infoLabel.BackgroundTransparency = 1
infoLabel.Size = UDim2.new(0.9, 0, 0.8, 0)
infoLabel.Position = UDim2.new(0.05,0,0.15,0)
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextColor3 = Color3.new(1,1,1)
infoLabel.TextScaled = true
infoLabel.TextWrapped = true
infoLabel.Text = "Creator: Martusin/Yan\nDiscord: @bysersdream\nVersion: 2.0\n\nСпасибо за использование!"

-- Функция возврата в главное меню
local function backToMainMenu(subMenu)
    subMenu.Visible = false
    mainMenu.Visible = true
end

-- Кнопки закрытия
hitboxCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(hitboxMenu) end)
movementCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(movementMenu) end)
weaponsCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(weaponsMenu) end)
infoCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(infoMenu) end)

-- Закрытие Users меню (если есть)
if usersCloseBtn then
    usersCloseBtn.MouseButton1Down:Connect(function() backToMainMenu(usersMenu) end)
end

mainCloseBtn.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    openButton.Visible = true
end)

-- Обработчики нажатий на главном меню
buttons.hitboxExpander.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    hitboxMenu.Visible = true
end)

buttons.movement.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    movementMenu.Visible = true
end)

buttons.weapons.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    weaponsMenu.Visible = true
end)

buttons.info.MouseButton1Down:Connect(function()
    mainMenu.Visible = false
    infoMenu.Visible = true
end)

-- Добавляем обработчик для кнопки Users (если есть)
if buttons.users then
    buttons.users.MouseButton1Down:Connect(function()
        mainMenu.Visible = false
        usersMenu.Visible = true
    end)
end

-- Кнопка открытия меню
openButton.MouseButton1Down:Connect(function()
    openButton.Visible = false
    mainMenu.Visible = true
end)

-- Проверка владельца при старте
local localPlayer = Players.LocalPlayer
if localPlayer.UserId == OWNER_ID then
    showOwnerNotification()
else
    -- Проверить, возможно владелец уже в игре
    for _, player in pairs(Players:GetPlayers()) do
        if player.UserId == OWNER_ID then
            showOwnerNotification()
            break
        end
    end
end

-- Первое уведомление при запуске
wait(1)
StarterGui:SetCore("SendNotification", { 
    Title = "Chaos Script loaded!",
    Text = "Created by yan/martusin",
    Duration = 5
})
