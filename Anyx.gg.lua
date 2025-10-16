local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local DataStoreService = game:GetService("DataStoreService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

local ConfigDataStore = DataStoreService:GetDataStore("AnyxConfigs")

local MenuOpen = false
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnyxMobileMenu"
ScreenGui.Parent = PlayerGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

local ScreenSize = workspace.CurrentCamera.ViewportSize
local MenuWidth = math.min(350, ScreenSize.X * 0.8)
local MenuHeight = math.min(450, ScreenSize.Y * 0.7)
local TabWidth = 60
local TabHeight = 40

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleBtn"
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 60)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
ToggleButton.Text = "▶"
ToggleButton.TextColor3 = Color3.new(1,1,1)
ToggleButton.TextScaled = true
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.BorderSizePixel = 0
local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainMenu"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, MenuWidth, 0, MenuHeight)
MainFrame.Position = UDim2.new(0.5, -MenuWidth/2, 0.5, -MenuHeight/2)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local OutlineStroke = Instance.new("UIStroke")
OutlineStroke.Parent = MainFrame
OutlineStroke.Color = Color3.fromRGB(100, 200, 255)
OutlineStroke.Thickness = 2
OutlineStroke.Transparency = 0.3
OutlineStroke.Enabled = true

local TopOutline = Instance.new("Frame")
TopOutline.Name = "TopOutline"
TopOutline.Parent = MainFrame
TopOutline.Size = UDim2.new(1, 0, 0, 2)
TopOutline.Position = UDim2.new(0, 0, 0, 0)
TopOutline.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
TopOutline.BorderSizePixel = 0
TopOutline.Visible = false
local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopOutline

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Header.BorderSizePixel = 0
local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header
local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20,20,20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40,40,40))
}
HeaderGradient.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Parent = Header
TitleLabel.Size = UDim2.new(0, 150, 0, 40)
TitleLabel.Position = UDim2.new(0, 10, 0, 5)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Anyx.gg"
TitleLabel.TextColor3 = Color3.new(1,1,1)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Visible = false

local SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "SettingsBtn"
SettingsButton.Parent = Header
SettingsButton.Size = UDim2.new(0, 40, 0, 40)
SettingsButton.Position = UDim2.new(1, -110, 0, 5)
SettingsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
SettingsButton.Text = "⚙️"
SettingsButton.TextColor3 = Color3.new(1,1,1)
SettingsButton.TextScaled = true
SettingsButton.Font = Enum.Font.SourceSans
SettingsButton.BorderSizePixel = 0
local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 8)
SettingsCorner.Parent = SettingsButton
SettingsButton.Visible = false

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseBtn"
CloseButton.Parent = Header
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -10, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.BorderSizePixel = 0
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

local TabsFrame = Instance.new("ScrollingFrame")
TabsFrame.Name = "Tabs"
TabsFrame.Parent = MainFrame
TabsFrame.Size = UDim2.new(0, TabWidth, 1, -50)
TabsFrame.Position = UDim2.new(0, 0, 0, 50)
TabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabsFrame.BorderSizePixel = 0
TabsFrame.ScrollBarThickness = 0
local TabsLayout = Instance.new("UIListLayout")
TabsLayout.Parent = TabsFrame
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Padding = UDim.new(0, 2)

local BackgroundFrame = Instance.new("Frame")
BackgroundFrame.Name = "BackgroundFrame"
BackgroundFrame.Parent = MainFrame
BackgroundFrame.Size = UDim2.new(1, -TabWidth, 1, -50)
BackgroundFrame.Position = UDim2.new(0, TabWidth, 0, 50)
BackgroundFrame.BackgroundTransparency = 1
BackgroundFrame.ZIndex = -1

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "Content"
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, -TabWidth, 1, -50)
ContentFrame.Position = UDim2.new(0, TabWidth, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.ClipsDescendants = true
local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Parent = ContentFrame
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 5)
ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
end)

local Tabs = {
    {Name = "Rage", Emoji = "🔫", LayoutOrder = 1},
    {Name = "Legitbot", Emoji = "🎯", LayoutOrder = 2},
    {Name = "Visuals", Emoji = "👁️", LayoutOrder = 3},
    {Name = "Misc", Emoji = "🛠️", LayoutOrder = 4},
    {Name = "Configs", Emoji = "📁", LayoutOrder = 5},
    {Name = "Settings", Emoji = "⚙️", LayoutOrder = 6}
}

local CurrentTab = nil
local TabButtons = {}
local OutlineMode = "Full"
local FirefliesEnabled = false

local Fireflies = {}
local function CreateFirefly()
    local fly = Instance.new("TextLabel")
    fly.Parent = BackgroundFrame
    fly.Size = UDim2.new(0, 4, 0, 4)
    fly.Position = UDim2.new(math.random(), 0, math.random(), 0)
    fly.BackgroundColor3 = Color3.new(1,1,1)
    fly.BackgroundTransparency = 0.5
    fly.Text = ""
    fly.BorderSizePixel = 0
    local flyCorner = Instance.new("UICorner")
    flyCorner.CornerRadius = UDim.new(1, 0)
    flyCorner.Parent = fly
    local glowStroke = Instance.new("UIStroke")
    glowStroke.Color = Color3.new(1,1,1)
    glowStroke.Thickness = 2
    glowStroke.Transparency = 0.5
    glowStroke.Parent = fly
    table.insert(Fireflies, fly)
    spawn(function()
        while FirefliesEnabled and fly.Parent do
            local tween = TweenService:Create(fly, TweenInfo.new(math.random(2,5), Enum.EasingStyle.Linear), {Position = UDim2.new(math.random(), 0, math.random(), 0)})
            tween:Play()
            tween.Completed:Wait()
        end
    end)
end

local function ToggleFireflies()
    FirefliesEnabled = not FirefliesEnabled
    if FirefliesEnabled then
        for i = 1, 20 do
            CreateFirefly()
        end
    else
        for _, fly in ipairs(Fireflies) do
            fly:Destroy()
        end
        Fireflies = {}
    end
end

local function SaveConfig(configName)
    local configData = {
        OutlineMode = OutlineMode,
        FirefliesEnabled = FirefliesEnabled,
        OutlineColor = {OutlineStroke.Color.R * 255, OutlineStroke.Color.G * 255, OutlineStroke.Color.B * 255},
        TitleColor = {TitleLabel.TextColor3.R * 255, TitleLabel.TextColor3.G * 255, TitleLabel.TextColor3.B * 255}
    }
    local success, err = pcall(function()
        ConfigDataStore:SetAsync(LocalPlayer.UserId .. "_" .. configName, HttpService:JSONEncode(configData))
    end)
    if success then
        print("Config saved: " .. configName)
    else
        warn("Save error: " .. tostring(err))
    end
end

local function LoadConfig(configName)
    local success, data = pcall(function()
        return ConfigDataStore:GetAsync(LocalPlayer.UserId .. "_" .. configName)
    end)
    if success and data then
        local configData = HttpService:JSONDecode(data)
        OutlineMode = configData.OutlineMode or "Full"
        FirefliesEnabled = configData.FirefliesEnabled or false
        if configData.OutlineColor then
            OutlineStroke.Color = Color3.fromRGB(configData.OutlineColor[1], configData.OutlineColor[2], configData.OutlineColor[3])
            TopOutline.BackgroundColor3 = OutlineStroke.Color
        end
        if configData.TitleColor then
            TitleLabel.TextColor3 = Color3.fromRGB(configData.TitleColor[1], configData.TitleColor[2], configData.TitleColor[3])
        end
        ToggleFireflies()
        print("Config loaded: " .. configName)
    else
        warn("Load error or no config: " .. configName)
    end
end

local function CreateTabContent(tabData)
    for _, child in ipairs(ContentFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("Frame") or child:IsA("TextBox") then
            child:Destroy()
        end
    end
    
    if tabData.Name == "Settings" then
        local ColorLabel = Instance.new("TextLabel")
        ColorLabel.Parent = ContentFrame
        ColorLabel.Size = UDim2.new(1, -10, 0, 30)
        ColorLabel.BackgroundTransparency = 1
        ColorLabel.Text = "🎨 Select Outline & Text Color:"
        ColorLabel.TextColor3 = Color3.new(1,1,1)
        ColorLabel.TextScaled = true
        ColorLabel.Font = Enum.Font.SourceSans
        ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local ColorRow = Instance.new("Frame")
        ColorRow.Parent = ContentFrame
        ColorRow.Size = UDim2.new(1, -10, 0, 40)
        ColorRow.BackgroundTransparency = 1
        local RowLayout = Instance.new("UIListLayout")
        RowLayout.Parent = ColorRow
        RowLayout.FillDirection = Enum.FillDirection.Horizontal
        RowLayout.SortOrder = Enum.SortOrder.LayoutOrder
        RowLayout.Padding = UDim.new(0, 5)
        RowLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        
        local colors = {
            {Name = "Red", Color = Color3.fromRGB(255, 0, 0)},
            {Name = "Black", Color = Color3.new(0,0,0)},
            {Name = "Yellow", Color = Color3.fromRGB(255, 255, 0)},
            {Name = "Blue", Color = Color3.fromRGB(0, 0, 255)},
            {Name = "Green", Color = Color3.fromRGB(0, 255, 0)},
            {Name = "Purple", Color = Color3.fromRGB(128, 0, 128)}
        }
        
        for _, colorData in ipairs(colors) do
            local ColorBtn = Instance.new("TextButton")
            ColorBtn.Parent = ColorRow
            ColorBtn.Size = UDim2.new(0, 30, 0, 30)
            ColorBtn.BackgroundColor3 = colorData.Color
            ColorBtn.Text = ""
            ColorBtn.BorderSizePixel = 0
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 4)
            BtnCorner.Parent = ColorBtn
            ColorBtn.MouseButton1Click:Connect(function()
                OutlineStroke.Color = colorData.Color
                TopOutline.BackgroundColor3 = colorData.Color
                TitleLabel.TextColor3 = colorData.Color
            end)
        end
        
        local OutlineToggle = Instance.new("TextButton")
        OutlineToggle.Parent = ContentFrame
        OutlineToggle.Size = UDim2.new(1, -10, 0, 30)
        OutlineToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        OutlineToggle.Text = "📏 Outline: Full"
        OutlineToggle.TextColor3 = Color3.new(1,1,1)
        OutlineToggle.TextScaled = true
        OutlineToggle.Font = Enum.Font.SourceSans
        local OutlineCorner = Instance.new("UICorner")
        OutlineCorner.CornerRadius = UDim.new(0, 4)
        OutlineCorner.Parent = OutlineToggle
        OutlineToggle.MouseButton1Click:Connect(function()
            OutlineMode = OutlineMode == "Full" and "Top" or "Full"
            OutlineToggle.Text = "📏 Outline: " .. OutlineMode
            OutlineStroke.Enabled = (OutlineMode == "Full")
            TopOutline.Visible = (OutlineMode == "Top")
        end)
        
        local FireflyToggle = Instance.new("TextButton")
        FireflyToggle.Parent = ContentFrame
        FireflyToggle.Size = UDim2.new(1, -10, 0, 30)
        FireflyToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        FireflyToggle.Text = "✨ Fireflies: Off"
        FireflyToggle.TextColor3 = Color3.new(1,1,1)
        FireflyToggle.TextScaled = true
        FireflyToggle.Font = Enum.Font.SourceSans
        local FireflyCorner = Instance.new("UICorner")
        FireflyCorner.CornerRadius = UDim.new(0, 4)
        FireflyCorner.Parent = FireflyToggle
        FireflyToggle.MouseButton1Click:Connect(function()
            ToggleFireflies()
            FireflyToggle.Text = "✨ Fireflies: " .. (FirefliesEnabled and "On" or "Off")
        end)
    elseif tabData.Name == "Configs" then
        local ConfigLabel = Instance.new("TextLabel")
        ConfigLabel.Parent = ContentFrame
        ConfigLabel.Size = UDim2.new(1, -10, 0, 30)
        ConfigLabel.BackgroundTransparency = 1
        ConfigLabel.Text = "📁 Config Name:"
        ConfigLabel.TextColor3 = Color3.new(1,1,1)
        ConfigLabel.TextScaled = true
        ConfigLabel.Font = Enum.Font.SourceSans
        ConfigLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local ConfigNameBox = Instance.new("TextBox")
        ConfigNameBox.Parent = ContentFrame
        ConfigNameBox.Size = UDim2.new(1, -10, 0, 30)
        ConfigNameBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        ConfigNameBox.Text = ""
        ConfigNameBox.TextColor3 = Color3.new(1,1,1)
        ConfigNameBox.PlaceholderText = "Enter config name"
        ConfigNameBox.TextScaled = true
        ConfigNameBox.Font = Enum.Font.SourceSans
        local ConfigBoxCorner = Instance.new("UICorner")
        ConfigBoxCorner.CornerRadius = UDim.new(0, 4)
        ConfigBoxCorner.Parent = ConfigNameBox
        
        local SaveBtn = Instance.new("TextButton")
        SaveBtn.Parent = ContentFrame
        SaveBtn.Size = UDim2.new(1, -10, 0, 30)
        SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
        SaveBtn.Text = "💾 Save Config"
        SaveBtn.TextColor3 = Color3.new(1,1,1)
        SaveBtn.TextScaled = true
        SaveBtn.Font = Enum.Font.SourceSans
        local SaveCorner = Instance.new("UICorner")
        SaveCorner.CornerRadius = UDim.new(0, 4)
        SaveCorner.Parent = SaveBtn
        SaveBtn.MouseButton1Click:Connect(function()
            local name = ConfigNameBox.Text
            if name ~= "" then
                SaveConfig(name)
            end
        end)
        
        local LoadBtn = Instance.new("TextButton")
        LoadBtn.Parent = ContentFrame
        LoadBtn.Size = UDim2.new(1, -10, 0, 30)
        LoadBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        LoadBtn.Text = "📂 Load Config"
        LoadBtn.TextColor3 = Color3.new(1,1,1)
        LoadBtn.TextScaled = true
        LoadBtn.Font = Enum.Font.SourceSans
        local LoadCorner = Instance.new("UICorner")
        LoadCorner.CornerRadius = UDim.new(0, 4)
        LoadCorner.Parent = LoadBtn
        LoadBtn.MouseButton1Click:Connect(function()
            local name = ConfigNameBox.Text
            if name ~= "" then
                LoadConfig(name)
            end
        end)
    elseif tabData.Name == "Visuals" then
        ToggleESP()
    end
end

local function SwitchTab(tabData)
    local tabButton = TabsFrame:FindFirstChild(tabData.Name .. "Tab")
    if tabButton then
        if CurrentTab then
            CurrentTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
        tabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        CurrentTab = tabButton
        CreateTabContent(tabData)
    end
end

for _, tabData in ipairs(Tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabData.Name .. "Tab"
    TabButton.Parent = TabsFrame
    TabButton.Size = UDim2.new(1, 0, 0, TabHeight)
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabButton.Text = tabData.Emoji .. " " .. tabData.Name
    TabButton.TextColor3 = Color3.new(1,1,1)
    TabButton.TextScaled = true
    TabButton.Font = Enum.Font.SourceSans
    TabButton.BorderSizePixel = 0
    TabButton.LayoutOrder = tabData.LayoutOrder
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 4)
    TabCorner.Parent = TabButton
    table.insert(TabButtons, {Button = TabButton, Data = tabData})
    
    TabButton.MouseButton1Click:Connect(function()
        SwitchTab(tabData)
    end)
end

SettingsButton.MouseButton1Click:Connect(function()
    local settingsData = {Name = "Settings", Emoji = "⚙️"}
    SwitchTab(settingsData)
end)

local firstTabData = Tabs[1]
SwitchTab(firstTabData)

local dragging = false
local dragStart = nil
local startPos = nil
local dragConnection = nil

local function updateInput(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        dragConnection = UserInputService.InputChanged:Connect(updateInput)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            dragging = false
            if dragConnection then
                dragConnection:Disconnect()
                dragConnection = nil
            end
        end
    end
end)

local function ToggleMenu()
    MenuOpen = not MenuOpen
    MainFrame.Visible = MenuOpen
    TitleLabel.Visible = MenuOpen
    SettingsButton.Visible = MenuOpen
    ToggleButton.Text = MenuOpen and "◀" or "▶"
    if MenuOpen then
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame:TweenSize(UDim2.new(0, MenuWidth, 0, MenuHeight), "Out", "Quad", 0.3)
    end
end

ToggleButton.MouseButton1Click:Connect(ToggleMenu)
CloseButton.MouseButton1Click:Connect(ToggleMenu)

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        ToggleMenu()
    end
end)

local ESPEnabled = false
local ESPObjects = {}

local function CreateESP(Player)
    if Player == LocalPlayer then return end
    if not Player.Character or not Player.Character:FindFirstChild("Head") then return end
    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "ESP"
    Billboard.Parent = Player.Character.Head
    Billboard.Size = UDim2.new(0, 100, 0, 100)
    Billboard.StudsOffset = Vector3.new(0, 2, 0)
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Parent = Billboard
    NameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = Player.Name
    NameLabel.TextColor3 = Color3.new(1,1,1)
    NameLabel.TextStrokeTransparency = 0
    NameLabel.Font = Enum.Font.SourceSansBold
    table.insert(ESPObjects, Billboard)
end

function ToggleESP()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        for _, Player in ipairs(Players:GetPlayers()) do
            if Player.Character then
                CreateESP(Player)
            end
        end
    else
        for _, obj in ipairs(ESPObjects) do
            obj:Destroy()
        end
        ESPObjects = {}
    end
end

Players.PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function()
        if ESPEnabled then
            wait(1)
            CreateESP(Player)
        end
    end)
end)

for _, Player in ipairs(Players:GetPlayers()) do
    if Player.Character then
        Player.CharacterAdded:Connect(function()
            if ESPEnabled then
                wait(1)
                CreateESP(Player)
            end
        end)
    end
end

RunService.Heartbeat:Connect(function()
    if ESPEnabled then
        for _, Player in ipairs(Players:GetPlayers()) do
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Head") then
                local Root = Player.Character.HumanoidRootPart
                local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Root.Position)
                if Player.Character.Head:FindFirstChild("ESP") then
                    local esp = Player.Character.Head.ESP
                    esp.Enabled = OnScreen
                end
            end
        end
    end
end)

print("Anyx.gg With Config System Loaded - Tap Blue Triangle to Open")
