-- ============================================================
-- QWERTYsteel v12.0
-- Автор: ROCKET для Миши
-- Игра: Steal an Egg
-- Экзекьютор: Delta
-- Ключ: CELEBRATE6667
-- Каркас GUI: CustomGUI.lua (Claude)
-- ============================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ============================================================
-- 1. ПРОВЕРКА КЛЮЧА
-- ============================================================
local SECRET_KEY = "CELEBRATE6667"

local oldKeyGui = player.PlayerGui:FindFirstChild("QWERTYsteelKey")
if oldKeyGui then oldKeyGui:Destroy() end

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "QWERTYsteelKey"
keyGui.Parent = player.PlayerGui
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.DisplayOrder = 999

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 320, 0, 230)
keyFrame.Position = UDim2.new(0.5, -160, 0.5, -115)
keyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
keyFrame.BorderSizePixel = 1
keyFrame.BorderColor3 = Color3.fromRGB(40, 50, 80)
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Parent = keyGui

Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 8)

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 36)
keyTitle.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
keyTitle.Text = "QWERTYsteel — ВВОД КЛЮЧА"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.TextSize = 15
keyTitle.Font = Enum.Font.GothamBold
keyTitle.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.8, 0, 0, 36)
keyInput.Position = UDim2.new(0.1, 0, 0.22, 0)
keyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
keyInput.Text = ""
keyInput.PlaceholderText = "Введи ключ..."
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextSize = 14
keyInput.Font = Enum.Font.Gotham
keyInput.Parent = keyFrame

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.8, 0, 0, 36)
submitBtn.Position = UDim2.new(0.1, 0, 0.42, 0)
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
submitBtn.Text = "ПОДТВЕРДИТЬ"
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.TextSize = 14
submitBtn.Font = Enum.Font.GothamBold
submitBtn.Active = true
submitBtn.Selectable = true
submitBtn.Parent = keyFrame

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 0, 50)
infoLabel.Position = UDim2.new(0, 0, 0.62, 0)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Discord: https://discord.gg/qnccJQQJ\nTelegram: @teddyleak"
infoLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
infoLabel.TextSize = 11
infoLabel.Font = Enum.Font.Gotham
infoLabel.Parent = keyFrame

local errorLabel = Instance.new("TextLabel")
errorLabel.Size = UDim2.new(1, 0, 0, 20)
errorLabel.Position = UDim2.new(0, 0, 0.88, 0)
errorLabel.BackgroundTransparency = 1
errorLabel.Text = ""
errorLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
errorLabel.TextSize = 12
errorLabel.Font = Enum.Font.Gotham
errorLabel.Parent = keyFrame

-- ============================================================
-- 2. ЛОГИКА ФУНКЦИЙ
-- ============================================================
local activeLoops = {}

local function findNearestTarget(maxDist)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local nearest, dist = nil, maxDist or 500
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") and obj ~= player.Character then
            local d = (obj.HumanoidRootPart.Position - hrp.Position).Magnitude
            if d < dist then
                nearest, dist = obj, d
            end
        end
    end
    return nearest
end

local function startAutoSteal()
    activeLoops.AutoSteal = true
    task.spawn(function()
        while activeLoops.AutoSteal do
            local target = findNearestTarget(300)
            if target then
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = target.HumanoidRootPart.CFrame + Vector3.new(0, 0, 3)
                end
            end
            task.wait(0.3)
        end
    end)
end

local function stopAutoSteal()
    activeLoops.AutoSteal = false
end

local function setSpeed(value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = value
    end
end

local function startFly()
    activeLoops.Fly = true
    task.spawn(function()
        while activeLoops.Fly do
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local move = Vector3.new(0, 0, 0)
                if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.new(0, 0, -50) end
                if UIS:IsKeyDown(Enum.KeyCode.S) then move = move + Vector3.new(0, 0, 50) end
                if UIS:IsKeyDown(Enum.KeyCode.A) then move = move + Vector3.new(-50, 0, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.new(50, 0, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 50, 0) end
                hrp.Velocity = move
            end
            task.wait(0.05)
        end
    end)
end

local function stopFly()
    activeLoops.Fly = false
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.Velocity = Vector3.new(0, 0, 0) end
end

-- ============================================================
-- 3. ГЛАВНЫЙ GUI (CustomGUI.lua + функции)
-- ============================================================
local function startMain()
    keyGui:Destroy()

    local old = player.PlayerGui:FindFirstChild("QWERTYsteel")
    if old then old:Destroy() end

    local TABS = {"MAIN", "VISUAL", "STYLE", "SETTINGS"}

    local state = {
        AutoSteal = false, SmartSteal = false, FreezeSteal = false,
        AntiTP = false, AntiKill = false, SmartStealth = false,
        ESPEggs = false, ESPPlayers = false, ESPTraps = false, Fly = false,
        AutoPlace = false, AutoHatch = false, AutoEquip = false,
        Treadmill = false, WaitSecret = false,
        SpeedValue = 400
    }

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "QWERTYsteel"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999
    screenGui.Parent = player.PlayerGui

    -- Главное окно
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 420, 0, 520)
    mainFrame.Position = UDim2.new(0.5, -210, 0.5, -260)
    mainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

    -- Заголовок
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    titleBar.Parent = mainFrame
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

    local titleMask = Instance.new("Frame")
    titleMask.Size = UDim2.new(1, 0, 0, 10)
    titleMask.Position = UDim2.new(0, 0, 1, -10)
    titleMask.BackgroundColor3 = titleBar.BackgroundColor3
    titleMask.BorderSizePixel = 0
    titleMask.ZIndex = titleBar.ZIndex
    titleMask.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -90, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "QWERTYsteel"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    -- Кнопка свёртывания
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 32, 0, 32)
    minimizeBtn.Position = UDim2.new(1, -40, 0.5, -16)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
    minimizeBtn.Text = "—"
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.TextSize = 20
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.Active = true
    minimizeBtn.Selectable = true
    minimizeBtn.Parent = titleBar
    Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)

    -- Мини-полоска
    local miniFrame = Instance.new("Frame")
    miniFrame.Size = UDim2.new(0, 180, 0, 44)
    miniFrame.Position = UDim2.new(0.5, -90, 0.5, -22)
    miniFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    miniFrame.Active = true
    miniFrame.Draggable = true
    miniFrame.Visible = false
    miniFrame.Parent = screenGui
    Instance.new("UICorner", miniFrame).CornerRadius = UDim.new(0, 10)

    local miniLabel = Instance.new("TextLabel")
    miniLabel.Size = UDim2.new(1, -50, 1, 0)
    miniLabel.Position = UDim2.new(0, 12, 0, 0)
    miniLabel.BackgroundTransparency = 1
    miniLabel.Text = "QWERTYsteel"
    miniLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    miniLabel.TextSize = 14
    miniLabel.Font = Enum.Font.GothamBold
    miniLabel.TextXAlignment = Enum.TextXAlignment.Left
    miniLabel.Parent = miniFrame

    local expandBtn = Instance.new("TextButton")
    expandBtn.Size = UDim2.new(0, 30, 0, 30)
    expandBtn.Position = UDim2.new(1, -37, 0.5, -15)
    expandBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
    expandBtn.Text = "+"
    expandBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    expandBtn.TextSize = 18
    expandBtn.Font = Enum.Font.GothamBold
    expandBtn.Active = true
    expandBtn.Selectable = true
    expandBtn.Parent = miniFrame
    Instance.new("UICorner", expandBtn).CornerRadius = UDim.new(1, 0)

    minimizeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        miniFrame.Visible = true
    end)

    expandBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = true
        miniFrame.Visible = false
    end)

    -- Вкладки
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1, -20, 0, 34)
    tabBar.Position = UDim2.new(0, 10, 0, 50)
    tabBar.BackgroundTransparency = 1
    tabBar.Parent = mainFrame

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 6)
    tabLayout.Parent = tabBar

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -20, 1, -100)
    content.Position = UDim2.new(0, 10, 0, 92)
    content.BackgroundColor3 = Color3.fromRGB(20, 20, 27)
    content.Parent = mainFrame
    Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.Parent = content

    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingTop = UDim.new(0, 10)
    contentPadding.PaddingLeft = UDim.new(0, 10)
    contentPadding.PaddingRight = UDim.new(0, 10)
    contentPadding.Parent = content

    -- Тумблер
    local function createToggle(parent, name, callback)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 40)
        row.BackgroundColor3 = Color3.fromRGB(28, 28, 37)
        row.Parent = parent
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -90, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.fromRGB(210, 210, 220)
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = row

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 64, 0, 28)
        btn.Position = UDim2.new(1, -74, 0.5, -14)
        btn.BackgroundColor3 = state[name] and Color3.fromRGB(0, 150, 90) or Color3.fromRGB(50, 50, 62)
        btn.Text = state[name] and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamBold
        btn.Active = true
        btn.Selectable = true
        btn.Parent = row
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        btn.MouseButton1Click:Connect(function()
            state[name] = not state[name]
            btn.Text = state[name] and "ON" or "OFF"
            btn.BackgroundColor3 = state[name] and Color3.fromRGB(0, 150, 90) or Color3.fromRGB(50, 50, 62)
            if callback then callback(state[name]) end
        end)

        return row
    end

    -- Ползунок
    local function createSlider(parent, name, min, max, callback)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 60)
        row.BackgroundColor3 = Color3.fromRGB(28, 28, 37)
        row.Parent = parent
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 0, 20)
        label.Position = UDim2.new(0, 10, 0, 4)
        label.BackgroundTransparency = 1
        label.Text = name .. ": " .. state[name]
        label.TextColor3 = Color3.fromRGB(210, 210, 220)
        label.TextSize = 13
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = row

        local hint = Instance.new("TextLabel")
        hint.Size = UDim2.new(1, -20, 0, 12)
        hint.Position = UDim2.new(0, 10, 0, 24)
        hint.BackgroundTransparency = 1
        hint.Text = "Рекомендуем: 400 | Макс: 600"
        hint.TextColor3 = Color3.fromRGB(120, 120, 140)
        hint.TextSize = 10
        hint.Font = Enum.Font.Gotham
        hint.TextXAlignment = Enum.TextXAlignment.Left
        hint.Parent = row

        local track = Instance.new("Frame")
        track.Size = UDim2.new(1, -20, 0, 8)
        track.Position = UDim2.new(0, 10, 0, 42)
        track.BackgroundColor3 = Color3.fromRGB(50, 50, 62)
        track.Parent = row
        Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

        local startPercent = (state[name] - min) / (max - min)

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(startPercent, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
        fill.Parent = track
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

        local knob = Instance.new("TextButton")
        knob.Size = UDim2.new(0, 18, 0, 18)
        knob.Position = UDim2.new(startPercent, -9, 0.5, -9)
        knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        knob.Text = ""
        knob.Active = true
        knob.Selectable = true
        knob.Parent = track
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

        local dragging = false

        local function setFromInputPos(x)
            local trackPos = track.AbsolutePosition.X
            local trackWidth = track.AbsoluteSize.X
            local percent = math.clamp((x - trackPos) / trackWidth, 0, 1)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            knob.Position = UDim2.new(percent, -9, 0.5, -9)
            local value = math.floor(min + (max - min) * percent + 0.5)
            state[name] = value
            label.Text = name .. ": " .. value
            if callback then callback(value) end
        end

        knob.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)

        knob.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                setFromInputPos(input.Position.X)
            end
        end)

        track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                setFromInputPos(input.Position.X)
            end
        end)

        return row
    end

    -- Загрузка вкладок
    local tabButtons = {}

    local function clearContent()
        for _, child in ipairs(content:GetChildren()) do
            if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
                child:Destroy()
            end
        end
    end

    local function loadTab(tabName)
        clearContent()

        if tabName == "MAIN" then
            createToggle(content, "AutoSteal", function(val)
                if val then startAutoSteal() else stopAutoSteal() end
            end)
            createToggle(content, "SmartSteal", function(val) end)
            createToggle(content, "FreezeSteal", function(val) end)
            createSlider(content, "SpeedValue", 16, 600, function(val)
                setSpeed(val)
            end)
            createToggle(content, "AntiTP", function(val) end)
            createToggle(content, "AntiKill", function(val) end)
            createToggle(content, "Умный стелс", function(val) end)

        elseif tabName == "VISUAL" then
            createToggle(content, "ESPEggs", function(val) end)
            createToggle(content, "ESPPlayers", function(val) end)
            createToggle(content, "ESP Traps", function(val) end)
            createToggle(content, "Fly", function(val)
                if val then startFly() else stopFly() end
            end)

        elseif tabName == "STYLE" then
            createToggle(content, "AutoPlace", function(val) end)
            createToggle(content, "AutoHatch", function(val) end)
            createToggle(content, "AutoEquip", function(val) end)
            createToggle(content, "Treadmill", function(val) end)
            createToggle(content, "WaitSecret", function(val) end)

        elseif tabName == "SETTINGS" then
            local colorLabel = Instance.new("TextLabel")
            colorLabel.Size = UDim2.new(1, 0, 0, 24)
            colorLabel.BackgroundTransparency = 1
            colorLabel.Text = "Цвет меню:"
            colorLabel.TextColor3 = Color3.fromRGB(210, 210, 220)
            colorLabel.TextSize = 13
            colorLabel.Font = Enum.Font.Gotham
            colorLabel.TextXAlignment = Enum.TextXAlignment.Left
            colorLabel.Parent = content

            local colors = {
                {name = "Тёмный", color = Color3.fromRGB(24, 24, 32)},
                {name = "Синий", color = Color3.fromRGB(15, 25, 60)},
                {name = "Красный", color = Color3.fromRGB(60, 15, 15)},
                {name = "Зелёный", color = Color3.fromRGB(15, 50, 25)},
                {name = "Фиолетовый", color = Color3.fromRGB(40, 15, 60)},
                {name = "Серый", color = Color3.fromRGB(35, 35, 35)}
            }

            local colorGrid = Instance.new("Frame")
            colorGrid.Size = UDim2.new(1, 0, 0, 100)
            colorGrid.BackgroundTransparency = 1
            colorGrid.Parent = content

            local gridLayout = Instance.new("UIGridLayout")
            gridLayout.CellSize = UDim2.new(0.3, 0, 0, 30)
            gridLayout.CellPadding = UDim2.new(0.02, 0, 0.05, 0)
            gridLayout.Parent = colorGrid

            for _, c in pairs(colors) do
                local cBtn = Instance.new("TextButton")
                cBtn.BackgroundColor3 = c.color
                cBtn.Text = c.name
                cBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                cBtn.TextSize = 11
                cBtn.Font = Enum.Font.Gotham
                cBtn.Active = true
                cBtn.Selectable = true
                cBtn.Parent = colorGrid
                Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 6)

                cBtn.MouseButton1Click:Connect(function()
                    mainFrame.BackgroundColor3 = c.color
                    miniFrame.BackgroundColor3 = c.color
                end)
            end
        end
    end

    for _, name in ipairs(TABS) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 92, 1, 0)
        btn.BackgroundColor3 = Color3.fromRGB(28, 28, 37)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(160, 160, 175)
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamBold
        btn.Active = true
        btn.Selectable = true
        btn.Parent = tabBar
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        tabButtons[name] = btn

        btn.MouseButton1Click:Connect(function()
            for _, b in pairs(tabButtons) do
                b.BackgroundColor3 = Color3.fromRGB(28, 28, 37)
                b.TextColor3 = Color3.fromRGB(160, 160, 175)
            end
            btn.BackgroundColor3 = Color3.fromRGB(50, 70, 130)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            loadTab(name)
        end)
    end

    local firstBtn = tabButtons[TABS[1]]
    firstBtn.BackgroundColor3 = Color3.fromRGB(50, 70, 130)
    firstBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadTab(TABS[1])

    print("QWERTYsteel v12 загружен!")
end

-- ============================================================
-- 4. КНОПКА ПОДТВЕРЖДЕНИЯ КЛЮЧА
-- ============================================================
submitBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == SECRET_KEY then
        errorLabel.Text = ""
        startMain()
    else
        errorLabel.Text = "Неверный ключ!"
    end
end)
