-- ============================================================
-- QWERTYsteel v6.0
-- Автор: ROCKET для Миши
-- Игра: Steal an Egg
-- Экзекьютор: Delta
-- Ключ: CELEBRATE6667
-- ============================================================

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- ============================================================
-- 1. ПРОВЕРКА КЛЮЧА
-- ============================================================
local SECRET_KEY = "CELEBRATE6667"

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

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyFrame

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
-- 2. ГЛАВНЫЙ GUI
-- ============================================================
local function startMain()
    keyGui:Destroy()

    local gui = Instance.new("ScreenGui")
    gui.Name = "QWERTYsteel"
    gui.Parent = player.PlayerGui
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 999

    local oldGui = player.PlayerGui:FindFirstChild("QWERTYsteel")
    if oldGui and oldGui ~= gui then oldGui:Destroy() end

    -- ============================================================
    -- 2.1 КРУГЛАЯ КНОПКА "Q" (ФИКСИРОВАННАЯ)
    -- ============================================================
    local iconBtn = Instance.new("TextButton")
    iconBtn.Size = UDim2.new(0, 55, 0, 55)
    iconBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
    iconBtn.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
    iconBtn.Text = "Q"
    iconBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconBtn.TextSize = 26
    iconBtn.Font = Enum.Font.GothamBold
    iconBtn.BorderSizePixel = 0
    iconBtn.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = iconBtn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 120, 255)
    stroke.Thickness = 2
    stroke.Parent = iconBtn

    -- ============================================================
    -- 2.2 МЕНЮ (СКРЫТО ПО УМОЛЧАНИЮ)
    -- ============================================================
    local menuFrame = Instance.new("Frame")
    menuFrame.Size = UDim2.new(0, 440, 0, 520)
    menuFrame.Position = UDim2.new(0.5, -220, 0.5, -260)
    menuFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    menuFrame.BorderSizePixel = 1
    menuFrame.BorderColor3 = Color3.fromRGB(40, 50, 80)
    menuFrame.Active = true
    menuFrame.Draggable = true
    menuFrame.Visible = false
    menuFrame.Parent = gui

    local menuCorner = Instance.new("UICorner")
    menuCorner.CornerRadius = UDim.new(0, 10)
    menuCorner.Parent = menuFrame

    local menuTitle = Instance.new("TextLabel")
    menuTitle.Size = UDim2.new(1, 0, 0, 40)
    menuTitle.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    menuTitle.Text = "QWERTYsteel v6"
    menuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    menuTitle.TextSize = 20
    menuTitle.Font = Enum.Font.GothamBold
    menuTitle.TextXAlignment = Enum.TextXAlignment.Left
    menuTitle.PaddingLeft = 15
    menuTitle.Parent = menuFrame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(1, -45, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 20
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = menuFrame

    local function openMenu()
        menuFrame.Visible = true
        iconBtn.Visible = false
    end

    local function closeMenu()
        menuFrame.Visible = false
        iconBtn.Visible = true
    end

    closeBtn.TouchTap:Connect(function()
        task.wait(0.1)
        closeMenu()
    end)

    iconBtn.TouchTap:Connect(function()
        task.wait(0.1)
        openMenu()
    end)

    -- ============================================================
    -- 2.3 ВКЛАДКИ
    -- ============================================================
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 0, 40)
    tabContainer.Position = UDim2.new(0, 0, 0, 40)
    tabContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
    tabContainer.Parent = menuFrame

    local tabs = {"MAIN", "VISUAL", "STYLE", "SETTINGS"}
    local tabButtons = {}

    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, 0, 1, -80)
    contentContainer.Position = UDim2.new(0, 0, 0, 80)
    contentContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    contentContainer.Parent = menuFrame

    local state = {
        AutoSteal = false, SmartSteal = false, FreezeSteal = false,
        SpeedHack = false, AntiTP = false, AntiKill = false,
        ESPEggs = false, ESPPlayers = false, Fly = false,
        AutoPlace = false, AutoHatch = false, AutoEquip = false,
        Treadmill = false, WaitSecret = false, SpeedValue = 400
    }

    local function createToggle(parent, name, yPos)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.9, 0, 0, 40)
        frame.Position = UDim2.new(0.05, 0, 0, yPos)
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        frame.Parent = parent

        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(0, 6)
        fCorner.Parent = frame

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.6, 0, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.fromRGB(200, 200, 210)
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 70, 0, 30)
        btn.Position = UDim2.new(1, -80, 0.5, -15)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        btn.Text = "OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 14
        btn.Font = Enum.Font.GothamBold
        btn.Parent = frame

        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(0, 6)
        bCorner.Parent = btn

        btn.TouchTap:Connect(function()
            state[name] = not state[name]
            btn.Text = state[name] and "ON" or "OFF"
            btn.BackgroundColor3 = state[name] and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(40, 40, 55)
        end)
    end

    local function createSlider(parent, name, yPos, min, max, default)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.9, 0, 0, 60)
        frame.Position = UDim2.new(0.05, 0, 0, yPos)
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        frame.Parent = parent

        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(0, 6)
        fCorner.Parent = frame

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.6, 0, 0, 20)
        label.Position = UDim2.new(0, 10, 0, 5)
        label.BackgroundTransparency = 1
        label.Text = name .. ": " .. default
        label.TextColor3 = Color3.fromRGB(200, 200, 210)
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame

        local hint = Instance.new("TextLabel")
        hint.Size = UDim2.new(0.6, 0, 0, 15)
        hint.Position = UDim2.new(0, 10, 0, 20)
        hint.BackgroundTransparency = 1
        hint.Text = "Рекомендуем: 400 | Макс: 600"
        hint.TextColor3 = Color3.fromRGB(150, 150, 170)
        hint.TextSize = 10
        hint.Font = Enum.Font.Gotham
        hint.TextXAlignment = Enum.TextXAlignment.Left
        hint.Parent = frame

        local slider = Instance.new("Frame")
        slider.Size = UDim2.new(0.8, 0, 0, 10)
        slider.Position = UDim2.new(0.1, 0, 0, 40)
        slider.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        slider.Parent = frame

        local sCorner = Instance.new("UICorner")
        sCorner.CornerRadius = UDim.new(0, 6)
        sCorner.Parent = slider

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        fill.Parent = slider

        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(0, 6)
        fillCorner.Parent = fill

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 18, 0, 18)
        btn.Position = UDim2.new(fill.Size.X.Scale, -9, 0.5, -9)
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btn.Text = ""
        btn.Parent = slider

        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(1, 0)
        bCorner.Parent = btn

        local dragging = false

        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)

        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local mouseX = input.Position.X
                local sliderPos = slider.AbsolutePosition.X
                local sliderWidth = slider.AbsoluteSize.X
                local percent = math.clamp((mouseX - sliderPos) / sliderWidth, 0, 1)
                fill.Size = UDim2.new(percent, 0, 1, 0)
                btn.Position = UDim2.new(percent, -9, 0.5, -9)
                local value = math.floor(min + (max - min) * percent)
                label.Text = name .. ": " .. value
                state[name] = value
            end
        end)
    end

    local function loadTabContent(tabName)
        for _, child in pairs(contentContainer:GetChildren()) do
            child:Destroy()
        end

        if tabName == "MAIN" then
            createToggle(contentContainer, "AutoSteal", 10)
            createToggle(contentContainer, "SmartSteal", 60)
            createToggle(contentContainer, "FreezeSteal", 110)
            createSlider(contentContainer, "SpeedValue", 170, 16, 600, 400)
            createToggle(contentContainer, "AntiTP", 240)
            createToggle(contentContainer, "AntiKill", 290)
            createToggle(contentContainer, "Умный стелс", 340)
        elseif tabName == "VISUAL" then
            createToggle(contentContainer, "ESPEggs", 10)
            createToggle(contentContainer, "ESPPlayers", 60)
            createToggle(contentContainer, "ESP Traps", 110)
            createToggle(contentContainer, "Fly", 160)
        elseif tabName == "STYLE" then
            createToggle(contentContainer, "AutoPlace", 10)
            createToggle(contentContainer, "AutoHatch", 60)
            createToggle(contentContainer, "AutoEquip", 110)
            createToggle(contentContainer, "Treadmill", 160)
            createToggle(contentContainer, "WaitSecret", 210)
        elseif tabName == "SETTINGS" then
            local colorLabel = Instance.new("TextLabel")
            colorLabel.Size = UDim2.new(0.9, 0, 0, 30)
            colorLabel.Position = UDim2.new(0.05, 0, 0, 10)
            colorLabel.BackgroundTransparency = 1
            colorLabel.Text = "Цвет меню:"
            colorLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
            colorLabel.TextSize = 14
            colorLabel.Font = Enum.Font.Gotham
            colorLabel.TextXAlignment = Enum.TextXAlignment.Left
            colorLabel.Parent = contentContainer

            local colors = {
                {name = "Тёмный", color = Color3.fromRGB(10, 10, 15)},
                {name = "Синий", color = Color3.fromRGB(10, 20, 60)},
                {name = "Красный", color = Color3.fromRGB(60, 10, 10)},
                {name = "Зелёный", color = Color3.fromRGB(10, 50, 20)},
                {name = "Фиолетовый", color = Color3.fromRGB(40, 10, 60)},
                {name = "Серый", color = Color3.fromRGB(30, 30, 30)}
            }

            for i, c in pairs(colors) do
                local cBtn = Instance.new("TextButton")
                cBtn.Size = UDim2.new(0.4, 0, 0, 30)
                cBtn.Position = UDim2.new(0.05 + ((i-1) % 2) * 0.45, 0, 0, 50 + math.floor((i-1) / 2) * 40)
                cBtn.BackgroundColor3 = c.color
                cBtn.Text = c.name
                cBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                cBtn.TextSize = 12
                cBtn.Font = Enum.Font.Gotham
                cBtn.Parent = contentContainer

                local cCorner = Instance.new("UICorner")
                cCorner.CornerRadius = UDim.new(0, 6)
                cCorner.Parent = cBtn

                cBtn.TouchTap:Connect(function()
                    menuFrame.BackgroundColor3 = c.color
                end)
            end
        end
    end

    for i, name in pairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 95, 1, 0)
        btn.Position = UDim2.new((i-1) * 0.24, 0, 0, 0)
        btn.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(150, 150, 170)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamBold
        btn.Parent = tabContainer
        tabButtons[name] = btn

        btn.TouchTap:Connect(function()
            for _, child in pairs(contentContainer:GetChildren()) do
                child:Destroy()
            end
            for _, b in pairs(tabButtons) do
                b.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
                b.TextColor3 = Color3.fromRGB(150, 150, 170)
            end
            btn.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            loadTabContent(name)
        end)
    end

    local firstBtn = tabButtons["MAIN"]
    if firstBtn then
        firstBtn.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
        firstBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        loadTabContent("MAIN")
    end

    print("QWERTYsteel v6 загружен!")
end

-- ============================================================
-- 3. КНОПКА ПОДТВЕРЖДЕНИЯ КЛЮЧА
-- ============================================================
submitBtn.TouchTap:Connect(function()
    if keyInput.Text == SECRET_KEY then
        errorLabel.Text = ""
        startMain()
    else
        errorLabel.Text = "Неверный ключ!"
    end
end)
