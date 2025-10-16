local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

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

local DotsButton = Instance.new("TextButton")
DotsButton.Name = "DotsBtn"
DotsButton.Parent = TabsFrame
DotsButton.Size = UDim2.new(1, 0, 0, TabHeight)
DotsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
DotsButton.Text = "⋯"
DotsButton.TextColor3 = Color3.new(1,1,1)
DotsButton.TextScaled = true
DotsButton.Font = Enum.Font.SourceSans
DotsButton.BorderSizePixel = 0
local DotsCorner = Instance.new("UICorner")
DotsCorner.CornerRadius = UDim.new(0, 4)
DotsCorner.Parent = DotsButton
DotsButton.LayoutOrder = 100

local SettingsMenu = Instance.new("Frame")
SettingsMenu.Name = "SettingsMenu"
SettingsMenu.Parent = MainFrame
SettingsMenu.Size = UDim2.new(1, -TabWidth, 0, 200)
SettingsMenu.Position = UDim2.new(0, TabWidth, 1, 0)
SettingsMenu.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SettingsMenu.BorderSizePixel = 0
SettingsMenu.Visible = false
local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 12)
SettingsCorner.Parent = SettingsMenu
local SettingsLayout = Instance.new("UIListLayout")
SettingsLayout.Parent = SettingsMenu
SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
SettingsLayout.Padding = UDim.new(0, 5)

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

-- Переменные для Rage
local RageEnabled = false
local SilentAimMethod = "RaycastPredict"
local HitChance = 100
local MissChance = 0
local AutoFireMethod = "TapFire"
local SilentAimMethods = {"RaycastPredict", "RaycastFOV", "RaycastSmooth", "RaycastLegit", "RaycastFlick", "RaycastSnap", "RaycastCurve", "RaycastBullet", "RaycastHeadOnly", "RaycastBodyPrior"}
local AutoFireMethods = {"TapFire", "HoldFire", "BurstFire", "RapidTap", "SmartBurst"}

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

local function CreateRageContent()
    for _, child in ipairs(ContentFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local RageToggle = Instance.new("TextButton")
    RageToggle.Parent = ContentFrame
    RageToggle.Size = UDim2.new(1, -10, 0, 30)
    RageToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    RageToggle.Text = "🔫 Rage: Off"
    RageToggle.TextColor3 = Color3.new(1,1,1)
    RageToggle.TextScaled = true
    RageToggle.Font = Enum.Font.SourceSans
    local RageCorner = Instance.new("UICorner")
    RageCorner.CornerRadius = UDim.new(0, 4)
    RageCorner.Parent = RageToggle
    RageToggle.MouseButton1Click:Connect(function()
        RageEnabled = not RageEnabled
        RageToggle.Text = "🔫 Rage: " .. (RageEnabled and "On" or "Off")
    end)
end

local function CreateSettingsMenu()
    for _, child in ipairs(SettingsMenu:GetChildren()) do
        child:Destroy()
    end
    
    local MethodLabel = Instance.new("TextLabel")
    MethodLabel.Parent = SettingsMenu
    MethodLabel.Size = UDim2.new(1, -10, 0, 25)
    MethodLabel.BackgroundTransparency = 1
    MethodLabel.Text = "Silent Aim Method:"
    MethodLabel.TextColor3 = Color3.new(1,1,1)
    MethodLabel.TextScaled = true
    MethodLabel.Font = Enum.Font.SourceSans
    MethodLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local MethodDropdown = Instance.new("TextButton")
    MethodDropdown.Parent = SettingsMenu
    MethodDropdown.Size = UDim2.new(1, -10, 0, 30)
    MethodDropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    MethodDropdown.Text = SilentAimMethod
    MethodDropdown.TextColor3 = Color3.new(1,1,1)
    MethodDropdown.TextScaled = true
    MethodDropdown.Font = Enum.Font.SourceSans
    local MethodCorner = Instance.new("UICorner")
    MethodCorner.CornerRadius = UDim.new(0, 4)
    MethodCorner.Parent = MethodDropdown
    local currentIndex = 1
    for i, method in ipairs(SilentAimMethods) do
        if method == SilentAimMethod then currentIndex = i end
    end
    MethodDropdown.MouseButton1Click:Connect(function()
        currentIndex = currentIndex % #SilentAimMethods + 1
        SilentAimMethod = SilentAimMethods[currentIndex]
        MethodDropdown.Text = SilentAimMethod
    end)
    
    local HitLabel = Instance.new("TextLabel")
    HitLabel.Parent = SettingsMenu
    HitLabel.Size = UDim2.new(1, -10, 0, 25)
    HitLabel.BackgroundTransparency = 1
    HitLabel.Text = "Hit Chance (%): " .. HitChance
    HitLabel.TextColor3 = Color3.new(1,1,1)
    HitLabel.TextScaled = true
    HitLabel.Font = Enum.Font.SourceSans
    HitLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local HitSlider = Instance.new("TextButton")
    HitSlider.Parent = SettingsMenu
    HitSlider.Size = UDim2.new(1, -10, 0, 20)
    HitSlider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    HitSlider.Text = ""
    local HitSliderCorner = Instance.new("UICorner")
    HitSliderCorner.CornerRadius = UDim.new(0, 10)
    HitSliderCorner.Parent = HitSlider
    local HitFill = Instance.new("Frame")
    HitFill.Parent = HitSlider
    HitFill.Size = UDim2.new(HitChance / 100, 0, 1, 0)
    HitFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    HitFill.BorderSizePixel = 0
    local HitFillCorner = Instance.new("UICorner")
    HitFillCorner.CornerRadius = UDim.new(0, 10)
    HitFillCorner.Parent = HitFill
    local draggingHit = false
    HitSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingHit = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingHit = false
        end
    end)
    RunService.Heartbeat:Connect(function()
        if draggingHit then
            local mousePos = UserInputService:GetMouseLocation()
            local relativeX = math.clamp((mousePos.X - HitSlider.AbsolutePosition.X) / HitSlider.AbsoluteSize.X, 0, 1)
            HitChance = math.floor(relativeX * 100)
            HitLabel.Text = "Hit Chance (%): " .. HitChance
            HitFill.Size = UDim2.new(HitChance / 100, 0, 1, 0)
        end
    end)
    
    local MissLabel = Instance.new("TextLabel")
    MissLabel.Parent = SettingsMenu
    MissLabel.Size = UDim2.new(1, -10, 0, 25)
    MissLabel.BackgroundTransparency = 1
    MissLabel.Text = "Miss Chance (%): " .. MissChance
    MissLabel.TextColor3 = Color3.new(1,1,1)
    MissLabel.TextScaled = true
    MissLabel.Font = Enum.Font.SourceSans
    MissLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local MissSlider = Instance.new("TextButton")
    MissSlider.Parent = SettingsMenu
    MissSlider.Size = UDim2.new(1, -10, 0, 20)
    MissSlider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    MissSlider.Text = ""
    local MissSliderCorner = Instance.new("UICorner")
    MissSliderCorner.CornerRadius = UDim.new(0, 10)
    MissSliderCorner.Parent = MissSlider
    local MissFill = Instance.new("Frame")
    MissFill.Parent = MissSlider
    MissFill.Size = UDim2.new(MissChance / 100, 0, 1, 0)
    MissFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    MissFill.BorderSizePixel = 0
    local MissFillCorner = Instance.new("UICorner")
    MissFillCorner.CornerRadius = UDim.new(0, 10)
    MissFillCorner.Parent = MissFill
    local draggingMiss = false
    MissSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMiss = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMiss = false
        end
    end)
    RunService.Heartbeat:Connect(function()
        if draggingMiss then
            local mousePos = UserInputService:GetMouseLocation()
            local relativeX = math.clamp((mousePos.X - MissSlider.AbsolutePosition.X) / MissSlider.AbsoluteSize.X, 0, 1)
            MissChance = math.floor(relativeX * 100)
            MissLabel.Text = "Miss Chance (%): " .. MissChance
            MissFill.Size = UDim2.new(MissChance / 100, 0, 1, 0)
        end
    end)
    
    local AutoFireLabel = Instance.new("TextLabel")
    AutoFireLabel.Parent = SettingsMenu
    AutoFireLabel.Size = UDim2.new(1, -10, 0, 25)
    AutoFireLabel.BackgroundTransparency = 1
    AutoFireLabel.Text = "Auto Fire Method:"
    AutoFireLabel.TextColor3 = Color3.new(1,1,1)
    AutoFireLabel.TextScaled = true
    AutoFireLabel.Font = Enum.Font.SourceSans
    AutoFireLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local AutoFireDropdown = Instance.new("TextButton")
    AutoFireDropdown.Parent = SettingsMenu
    AutoFireDropdown.Size = UDim2.new(1, -10, 0, 30)
    AutoFireDropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    AutoFireDropdown.Text = AutoFireMethod
    AutoFireDropdown.TextColor3 = Color3.new(1,1,1)
    AutoFireDropdown.TextScaled = true
    AutoFireDropdown.Font = Enum.Font.SourceSans
    local AutoFireCorner = Instance.new("UICorner")
    AutoFireCorner.CornerRadius = UDim.new(0, 4)
    AutoFireCorner.Parent = AutoFireDropdown
    local currentAutoIndex = 1
    for i, method in ipairs(AutoFireMethods) do
        if method == AutoFireMethod then currentAutoIndex = i end
    end
    AutoFireDropdown.MouseButton1Click:Connect(function()
        currentAutoIndex = currentAutoIndex % #AutoFireMethods + 1
        AutoFireMethod = AutoFireMethods[currentAutoIndex]
        AutoFireDropdown.Text = AutoFireMethod
    end)
end

local function CreateTabContent(tabData)
    for _, child in ipairs(ContentFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    if tabData.Name == "Rage" then
        CreateRageContent()
    elseif tabData.Name == "Settings" then
        -- Color Selection Label
        local ColorLabel = Instance.new("TextLabel")
        ColorLabel.Parent = ContentFrame
        ColorLabel.Size = UDim2.new(1, -10, 0, 30)
        ColorLabel.BackgroundTransparency = 1
        ColorLabel.Text = "🎨 Select Outline & Text Color:"
        ColorLabel.TextColor3 = Color3.new(1,1,1)
        ColorLabel.TextScaled = true
        ColorLabel.Font = Enum.Font.SourceSans
        ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Color Buttons Row
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

-- Логика Silent Aim
local function GetClosestEnemy()
    local closest, dist = nil, math.huge
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character.HumanoidRootPart.Health > 0 then
            local root = Player.Character.HumanoidRootPart
            local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
            if onScreen then
                local d = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                if d < dist then
                    dist = d
                    closest = root
                end
            end
        end
    end
    return closest
end

local function SilentAim(target)
    if not target then return end
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then return end
    
    local hitChanceRoll = math.random(1, 100)
    if hitChanceRoll > HitChance or math.random(1, 100) <= MissChance then return end
    
    local origin = tool.Handle.Position
    local direction = (target.Position - origin).Unit * 1000
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {character}
    
    local raycast = workspace:Raycast(origin, direction, raycastParams)
    if raycast then
        target = raycast.Instance
    end
    
    local methodHandlers = {
        RaycastPredict = function()
            local velocity = target.AssemblyLinearVelocity
            local predictPos = target.Position + velocity * 0.1
            return Camera:ScreenPointToRay(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2):Direction:lerp((predictPos - Camera.CFrame.Position).Unit, 0.8)
        end,
        RaycastFOV = function()
            return (target.Position - Camera.CFrame.Position).Unit
        end,
        RaycastSmooth = function()
            local currentDir = Camera.CFrame.LookVector
            return currentDir:lerp((target.Position - Camera.CFrame.Position).Unit, 0.5)
        end,
        RaycastLegit = function()
            local noise = Vector3.new(math.random(-1,1), math.random(-1,1), math.random(-1,1)).Unit * 0.1
            return (target.Position + noise - Camera.CFrame.Position).Unit
        end,
        RaycastFlick = function()
            return (target.Position - Camera.CFrame.Position).Unit
        end,
        RaycastSnap = function()
            return (target.Position - Camera.CFrame.Position).Unit
        end,
        RaycastCurve = function()
            local curve = CFrame.new(Camera.CFrame.Position, target.Position)
            return curve.LookVector
        end,
        RaycastBullet = function()
            local bulletDrop = Vector3.new(0, -0.5, 0)
            return (target.Position + bulletDrop - Camera.CFrame.Position).Unit
        end,
        RaycastHeadOnly = function()
            local head = target.Parent:FindFirstChild("Head")
            if head then return (head.Position - Camera.CFrame.Position).Unit end
            return (target.Position - Camera.CFrame.Position).Unit
        end,
        RaycastBodyPrior = function()
            local parts = {"Head", "Torso", "UpperTorso", "HumanoidRootPart"}
            for _, partName in ipairs(parts) do
                local part = target.Parent:FindFirstChild(partName)
                if part then return (part.Position - Camera.CFrame.Position).Unit end
            end
            return (target.Position - Camera.CFrame.Position).Unit
        end
    }
    
    local aimDir = methodHandlers[SilentAimMethod] and methodHandlers[SilentAimMethod]() or (target.Position - Camera.CFrame.Position).Unit
    tool.Handle.CFrame = CFrame.lookAt(tool.Handle.Position, tool.Handle.Position + aimDir)
end

-- Логика Auto Fire для мобильного
local firing = false
local fireConnection = nil
local function StartAutoFire()
    if fireConnection then fireConnection:Disconnect() end
    local character = LocalPlayer.Character
    if not character then return end
    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then return end
    
    local methodHandlers = {
        TapFire = function()
            fireConnection = RunService.Heartbeat:Connect(function()
                if math.random(1, 100) <= 80 then -- Быстрые тапы
                    tool:Activate()
                    wait(0.05)
                    tool:Deactivate()
                end
            end)
        end,
        HoldFire = function()
            fireConnection = RunService.Heartbeat:Connect(function()
                tool:Activate()
            end)
        end,
        BurstFire = function()
            local burstCount = 0
            fireConnection = RunService.Heartbeat:Connect(function()
                if burstCount < 3 then
                    tool:Activate()
                    burstCount = burstCount + 1
                    wait(0.1)
                else
                    tool:Deactivate()
                    burstCount = 0
                    wait(1)
                end
            end)
        end,
        RapidTap = function()
            fireConnection = RunService.Heartbeat:Connect(function()
                tool:Activate()
                wait(0.03)
                tool:Deactivate()
            end)
        end,
        SmartBurst = function()
            local burstCount = 0
            fireConnection = RunService.Heartbeat:Connect(function()
                local target = GetClosestEnemy()
                if target and burstCount < 5 then
                    tool:Activate()
                    burstCount = burstCount + 1
                    wait(0.08)
                else
                    tool:Deactivate()
                    burstCount = 0
                end
            end)
        end
    }
    
    methodHandlers[AutoFireMethod]()
end

local function StopAutoFire()
    if fireConnection then
        fireConnection:Disconnect()
        fireConnection = nil
    end
    local character = LocalPlayer.Character
    if character then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool then tool:Deactivate() end
    end
end

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and RageEnabled then
        local target = GetClosestEnemy()
        SilentAim(target)
        if AutoFireMethod ~= "HoldFire" then
            StartAutoFire()
        end
        firing = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and RageEnabled and firing then
        StopAutoFire()
        firing = false
    end
end)

RunService.Heartbeat:Connect(function()
    if RageEnabled then
        local target = GetClosestEnemy()
        if target then
            SilentAim(target)
            if AutoFireMethod == "HoldFire" then
                StartAutoFire()
            end
        else
            StopAutoFire()
        end
    else
        StopAutoFire()
    end
end)

print("Anyx.gg Rage Added - Silent Aim & Mobile Auto Fire Ready")
