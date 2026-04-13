--Welcome mate if you're using this ui atleast advertise my script https://discord.gg/88gR5XUpkC thank u
local function randomString(length)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local str = ""
    for i = 1, length do
        local rand = math.random(1, #chars)
        str = str .. string.sub(chars, rand, rand)
    end
    return str
end
local randomUI = randomString(12)
_G.CurrentUIName = randomUI
local function SafeDestroyUI()
    pcall(function()
        local containers = {game:GetService("CoreGui")}
        
        if gethui then
            local altGui = gethui()
            if altGui and altGui ~= game:GetService("CoreGui") then
                table.insert(containers, altGui)
            end
        end
        
        for _, container in pairs(containers) do
            for _, gui in pairs(container:GetChildren()) do
                if gui:IsA("ScreenGui") and (gui.Name == "ProjectWD" or gui:GetAttribute("SecureUI")) then
                    gui:Destroy()
                end
            end
        end
    end)
end

SafeDestroyUI()

if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(1)
local function GetScreenInfo()
    local viewportSize = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
    local isMobile = (viewportSize.X <= 768) or (game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").MouseEnabled)
    local isTablet = viewportSize.X > 768 and viewportSize.X <= 1024
    local isSmallDesktop = viewportSize.X > 1024 and viewportSize.X <= 1366
    local isLargeDesktop = viewportSize.X > 1366
    local responsiveWidth = math.clamp(viewportSize.X * 0.7, 300, 800)
    local responsiveHeight = math.clamp(viewportSize.Y * 0.8, 300, 600)
    if responsiveWidth > 600 then
        responsiveWidth = 600
    end
    if responsiveHeight > 400 then
        responsiveHeight = 400
    end
    
    return {
        ViewportSize = viewportSize,
        IsMobile = isMobile,
        IsTablet = isTablet,
        IsSmallDesktop = isSmallDesktop,
        IsLargeDesktop = isLargeDesktop,
        UIWidth = responsiveWidth,
        UIHeight = responsiveHeight,
        Scale = math.min(responsiveWidth / 600, responsiveHeight / 400) 
    }
end
local function ResponsiveSize(baseSize, screenInfo)
    local scale = screenInfo.Scale
    if screenInfo.IsMobile then
        scale = scale * 0.7
    elseif screenInfo.IsTablet then
        scale = scale * 0.85
    end
    return UDim2.new(baseSize.X.Scale, baseSize.X.Offset * scale, baseSize.Y.Scale, baseSize.Y.Offset * scale)
end

local function GetProtectedGui()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = randomUI
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
    end
    
    local parentContainer = gethui and gethui() or game:GetService("CoreGui")
    ScreenGui.Parent = parentContainer
    ScreenGui:SetAttribute("SecureUI", true)
    
    return ScreenGui
end


-- Modern High-Contrast Color Palette
_G.Color = Color3.fromRGB(99, 102, 241)
_G.BGColor = Color3.fromRGB(2, 6, 23)
_G.Surface = Color3.fromRGB(15, 23, 42)
_G.SurfaceLight = Color3.fromRGB(30, 41, 59)
_G.Border = Color3.fromRGB(51, 65, 85)
_G.BorderHighlight = Color3.fromRGB(71, 85, 105)
_G.TextPrimary = Color3.fromRGB(248, 250, 252)
_G.TextSecondary = Color3.fromRGB(148, 163, 184)
_G.TextMuted = Color3.fromRGB(100, 116, 139)
_G.Accent = Color3.fromRGB(99, 102, 241)
_G.AccentLight = Color3.fromRGB(129, 140, 248)
_G.AccentDark = Color3.fromRGB(79, 70, 229)
_G.Success = Color3.fromRGB(34, 197, 94)
_G.Warning = Color3.fromRGB(245, 158, 11)
_G.Error = Color3.fromRGB(239, 68, 68)  

IKAI = true
if IKAI then
    do
        local ui = game:GetService("CoreGui"):FindFirstChild("ProjectWD")
        if ui then
            ui:Destroy()
        end
    end
    
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    local tween = game:GetService("TweenService")
    local Red = {RainbowColorValue = 0, HueSelectionPosition = 0}
    
    local function Tween(instance, properties, style, wa)
        if style == nil or "" then
            return Back
        end
        tween:Create(instance, TweenInfo.new(wa, Enum.EasingStyle[style]), {properties}):Play()
    end
    
    local ActualTypes = {
        RoundFrame = "ImageLabel",
        Shadow = "ImageLabel",
        Circle = "ImageLabel",
        CircleButton = "ImageButton",
        Frame = "Frame",
        Label = "TextLabel",
        Button = "TextButton",
        SmoothButton = "ImageButton",
        Box = "TextBox",
        ScrollingFrame = "ScrollingFrame",
        Menu = "ImageButton",
        NavBar = "ImageButton"
    }
    
    local Properties = {
        RoundFrame = {
            BackgroundTransparency = 1,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(3, 3, 297, 297)
        },
        SmoothButton = {
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(3, 3, 297, 297)
        },
        Shadow = {
            Name = "Shadow",
            BackgroundTransparency = 1,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(23, 23, 277, 277),
            Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(30, 30),
            Position = UDim2.fromOffset(-15, -15)
        },
        Circle = {
            BackgroundTransparency = 1,
        },
        CircleButton = {
            BackgroundTransparency = 1,
            AutoButtonColor = false,
        },
        Frame = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1)
        },
        Label = {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(5, 0),
            Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(5, 0),
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left
        },
        Button = {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(5, 0),
            Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(5, 0),
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left
        },
        Box = {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(5, 0),
            Size = UDim2.fromScale(1, 1) - UDim2.fromOffset(5, 0),
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left
        },
        ScrollingFrame = {
            BackgroundTransparency = 1,
            ScrollBarThickness = 0,
            CanvasSize = UDim2.fromScale(0, 0),
            Size = UDim2.fromScale(1, 1)
        },
        Menu = {
            Name = "More",
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(20, 20),
            Position = UDim2.fromScale(1, 0.5) - UDim2.fromOffset(25, 10)
        },
        NavBar = {
            Name = "SheetToggle",
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(20, 20),
            Position = UDim2.fromOffset(5, 5),
            AutoButtonColor = false
        }
    }
    
    local Types = {
        "RoundFrame",
        "Shadow",
        "Circle",
        "CircleButton",
        "Frame",
        "Label",
        "Button",
        "SmoothButton",
        "Box",
        "ScrollingFrame",
        "Menu",
        "NavBar"
    }
    
    function FindType(String)
        for _, Type in next, Types do
            if Type:sub(1, #String):lower() == String:lower() then
                return Type
            end
        end
        return false
    end
    
    local Objects = {}
    
    function Objects.new(Type)
        local TargetType = FindType(Type)
        if TargetType then
            local NewImage = Instance.new(ActualTypes[TargetType])
            if Properties[TargetType] then
                for Property, Value in next, Properties[TargetType] do
                    NewImage[Property] = Value
                end
            end
            return NewImage
        else
            return Instance.new(Type)
        end
    end
    
    local function GetXY(GuiObject)
        local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
        local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
        return Px / Max, Py / May
    end
    
    local function CircleAnim(GuiObject, EndColour, StartColour)
        local PX, PY = GetXY(GuiObject)
        local Circle = Objects.new("Circle")
        Circle.Size = UDim2.fromScale(0, 0)
        Circle.Position = UDim2.fromScale(PX, PY)
        Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
        Circle.ZIndex = 200
        Circle.Parent = GuiObject
        local Size = GuiObject.AbsoluteSize.X
        TweenService:Create(Circle, TweenInfo.new(0.7), {Position = UDim2.fromScale(PX, PY) - UDim2.fromOffset(Size / 2, Size / 2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size, Size)}):Play()
        spawn(function()
            wait(0.5)
            Circle:Destroy()
        end)
    end
    
    local function MakeDraggable(topbarobject, object)
        local Dragging = nil
        local DragInput = nil
        local DragStart = nil
        local StartPosition = nil
        
        local function Update(input)
            local Delta = input.Position - DragStart
            local pos =
                UDim2.new(
                    StartPosition.X.Scale,
                    StartPosition.X.Offset + Delta.X,
                    StartPosition.Y.Scale,
                    StartPosition.Y.Offset + Delta.Y
            )
            local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
            Tween:Play()
        end
        
        topbarobject.InputBegan:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true
                    DragStart = input.Position
                    StartPosition = object.Position
                    
                    input.Changed:Connect(
                        function()
                            if input.UserInputState == Enum.UserInputState.End then
                                Dragging = false
                            end
                        end
                )
                end
            end
        )
        topbarobject.InputChanged:Connect(
            function(input)
                if
                    input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch
                then
                    DragInput = input
                end
            end
        )
        UserInputService.InputChanged:Connect(
            function(input)
                if input == DragInput and Dragging then
                    Update(input)
                end
            end
        )
    end
    
    local function gradient(text, colors)
        local colors = colors
        if #colors == 0 then
            return text
        end
        if #colors == 1 then
            local color = colors[1]
            local r = math.floor(color.R * 255)
            local g = math.floor(color.G * 255)
            local b = math.floor(color.B * 255)
            return string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text)
        end
        local result = ""
        local segments = #colors - 1
        local charsPerSegment = (#text - 1) / segments
        
        for i = 1, #text do
            local position = (i - 1) / (#text - 1)
            local segment = math.min(math.floor(position * segments), segments - 1)
            local segmentStart = segment / segments
            local segmentEnd = (segment + 1) / segments
            local t = (position - segmentStart) / (segmentEnd - segmentStart)
            local startColor = colors[segment + 1]
            local endColor = colors[segment + 2]
            local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
            local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
            local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
            result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
        end
        return result
    end

    library = {}
    
    function library:Window(text, logo, keybind, gradientText, accentColor)
		if accentColor then _G.Accent = accentColor end
        local uihide = false
        local abc = false
        local logo = logo or 0
        local currentpage = ""
        local keybind = keybind or Enum.KeyCode.LeftControl
        local yoo = string.gsub(tostring(keybind), "Enum.KeyCode.", "")
        
        local UserInputService = game:GetService("UserInputService")
        local TweenService = game:GetService("TweenService")
        local screenInfo = GetScreenInfo()

        
        local responsiveWidth = screenInfo.UIWidth
        local responsiveHeight = screenInfo.UIHeight

        local isMobileLayout = screenInfo.IsMobile or screenInfo.ViewportSize.X <= 768
        local tabWidth = isMobileLayout and 120 or 150
        local pageWidth = isMobileLayout and (responsiveWidth - tabWidth - 30) or (responsiveWidth - tabWidth - 20)
        local elementWidth = isMobileLayout and (pageWidth - 30) or (pageWidth - 20)

        
    local ShadcnUI = GetProtectedGui()
    ShadcnUI.Name = _G.CurrentUIName
    ShadcnUI.Parent = GetProtectedGui()
    ShadcnUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ShadcnUI
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = _G.Surface
    Main.BackgroundTransparency = 0.15
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, responsiveWidth, 0, responsiveHeight)
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true

    -- Gradient Background Effect
    local GradientBg = Instance.new("UIGradient")
    GradientBg.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 23, 42)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(2, 6, 23))
    })
    GradientBg.Rotation = 135
    GradientBg.Parent = Main

    -- Modern Rounded Corners
    local MCNR = Instance.new("UICorner")
    MCNR.CornerRadius = UDim.new(0, 12)
    MCNR.Parent = Main

    -- High-Contrast Border with Glow Effect
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Parent = Main
    MainStroke.Color = _G.Border
    MainStroke.Thickness = 1.5
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.ZIndex = 3

    -- Accent Glow Border (Top Only)
    local TopGlow = Instance.new("Frame")
    TopGlow.Name = "TopGlow"
    TopGlow.Parent = Main
    TopGlow.BackgroundColor3 = _G.Accent
    TopGlow.BackgroundTransparency = 0.7
    TopGlow.BorderSizePixel = 0
    TopGlow.Position = UDim2.new(0, 0, 0, 0)
    TopGlow.Size = UDim2.new(1, 0, 0, 2)
    TopGlow.ZIndex = 10

    local TopGlowCorner = Instance.new("UICorner")
    TopGlowCorner.CornerRadius = UDim.new(0, 12)
    TopGlowCorner.Parent = TopGlow

    local TopGlowStroke = Instance.new("UIStroke")
    TopGlowStroke.Parent = TopGlow
    TopGlowStroke.Color = _G.Accent
    TopGlowStroke.Thickness = 1
    TopGlowStroke.Transparency = 0.5

    -- TOP BAR (Modern Glassmorphism Style)
    local Top = Instance.new("Frame")
    Top.Name = "Top"
    Top.Parent = Main
    Top.BackgroundColor3 = _G.SurfaceLight
    Top.BackgroundTransparency = 0.5
    Top.Size = UDim2.new(1, 0, 0, isMobileLayout and 50 or 44)
    Top.BorderSizePixel = 0
    Top.ZIndex = 2

    local TopGradient = Instance.new("UIGradient")
    TopGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, _G.SurfaceLight),
        ColorSequenceKeypoint.new(1, _G.Surface)
    })
    TopGradient.Rotation = 180
    TopGradient.Parent = Top

    local TCNR = Instance.new("UICorner")
    TCNR.CornerRadius = UDim.new(0, 12)
    TCNR.Parent = Top

    -- Title with Modern Gradient Text
    local Name = Instance.new("TextLabel")
    Name.Name = "Name"
    Name.Parent = Top
    Name.BackgroundTransparency = 1
    Name.Position = UDim2.new(0, isMobileLayout and 12 or 18, 0, 0)
    Name.Size = UDim2.new(0, isMobileLayout and 160 or 220, 1, 0)
    Name.Font = Enum.Font.GothamBold
    Name.Text = text
    Name.TextColor3 = _G.TextPrimary
    Name.TextSize = isMobileLayout and 15 or 17
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.RichText = true
    Name.Text = gradient(text, gradientText or {_G.Accent, _G.AccentLight})
    Name.ZIndex = 3

    -- Modern Keybind Button
    local BindButton = Instance.new("TextButton")
    BindButton.Name = "BindButton"
    BindButton.Parent = Top
    BindButton.BackgroundColor3 = _G.Surface
    BindButton.BackgroundTransparency = 0.6
    BindButton.Position = isMobileLayout and UDim2.new(0.5, -60, 0.15, 0) or UDim2.new(0.65, 0, 0.18, 0)
    BindButton.Size = UDim2.new(0, 110, 0, 26)
    BindButton.Font = Enum.Font.GothamMedium
    BindButton.Text = "[ RightControl ]"
    BindButton.TextColor3 = _G.TextSecondary
    BindButton.TextSize = isMobileLayout and 10 or 11
    BindButton.AutoButtonColor = false
    BindButton.Visible = not isMobileLayout
    BindButton.ZIndex = 3

    local BindCorner = Instance.new("UICorner")
    BindCorner.CornerRadius = UDim.new(0, 8)
    BindCorner.Parent = BindButton

    local BindStroke = Instance.new("UIStroke")
    BindStroke.Parent = BindButton
    BindStroke.Color = _G.Border
    BindStroke.Thickness = 1
    BindStroke.Transparency = 0.5

    -- Modern Minimize Button (Icon Style)
    local MinimizeBtn = Instance.new("ImageButton")
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = Top
    MinimizeBtn.BackgroundColor3 = _G.Surface
    MinimizeBtn.BackgroundTransparency = 0.6
    MinimizeBtn.Position = UDim2.new(1, isMobileLayout and -38 or -42, 0.5, -12)
    MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
    MinimizeBtn.Image = "rbxassetid://10747383819"
    MinimizeBtn.ImageColor3 = _G.TextSecondary
    MinimizeBtn.ImageRectOffset = Vector2.new(284, 4)
    MinimizeBtn.ImageRectSize = Vector2.new(24, 24)
    MinimizeBtn.AutoButtonColor = false
    MinimizeBtn.ZIndex = 3

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = MinimizeBtn

    local MinStroke = Instance.new("UIStroke")
    MinStroke.Parent = MinimizeBtn
    MinStroke.Color = _G.Border
    MinStroke.Thickness = 1
    MinStroke.Transparency = 0.5

    -- Hover Effects for Minimize Button
    MinimizeBtn.MouseEnter:Connect(function()
        TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.4,
            ImageColor3 = _G.TextPrimary
        }):Play()
        TweenService:Create(MinStroke, TweenInfo.new(0.2), {
            Color = _G.BorderHighlight
        }):Play()
    end)

    MinimizeBtn.MouseLeave:Connect(function()
        TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.6,
            ImageColor3 = _G.TextSecondary
        }):Play()
        TweenService:Create(MinStroke, TweenInfo.new(0.2), {
            Color = _G.Border
        }):Play()
    end)

    -- CONTINUE YOUR CODE...
    local MiniFrame

        
        local function makeDraggable(gui)
            local dragging, dragInput, dragStart, startPos

            local function update(input)
                local delta = input.Position - dragStart
                local newPos = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
                gui.Position = newPos
            end

            gui.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    dragStart = input.Position
                    startPos = gui.Position

                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)

            gui.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    dragInput = input
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if input == dragInput and dragging then
                    update(input)
                end
            end)
        end

        local function createMiniFrame()
            if MiniFrame then return MiniFrame end

            MiniFrame = Instance.new("TextButton")
            MiniFrame.Parent = ShadcnUI
            MiniFrame.BackgroundColor3 = _G.Accent
            MiniFrame.BackgroundTransparency = 0.1
            MiniFrame.Size = UDim2.new(0, 120, 0, 36)
            MiniFrame.Position = UDim2.new(0.5, -60, 0, 15)
            MiniFrame.Text = "Open Hub"
            MiniFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
            MiniFrame.Font = Enum.Font.GothamBold
            MiniFrame.TextSize = 14
            MiniFrame.Visible = false
            MiniFrame.AutoButtonColor = false
            MiniFrame.ClipsDescendants = true

            -- Gradient effect
            local miniGradient = Instance.new("UIGradient")
            miniGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, _G.Accent),
                ColorSequenceKeypoint.new(1, _G.AccentDark)
            })
            miniGradient.Rotation = 90
            miniGradient.Parent = MiniFrame

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = MiniFrame

            local stroke = Instance.new("UIStroke")
            stroke.Parent = MiniFrame
            stroke.Color = _G.AccentLight
            stroke.Thickness = 1.5
            stroke.Transparency = 0.3

            -- Glow effect
            local glow = Instance.new("ImageLabel")
            glow.Name = "Glow"
            glow.Parent = MiniFrame
            glow.BackgroundTransparency = 1
            glow.Position = UDim2.new(0.5, -75, 0.5, -75)
            glow.Size = UDim2.new(0, 150, 0, 150)
            glow.Image = "rbxassetid://5554236805"
            glow.ImageColor3 = _G.Accent
            glow.ImageTransparency = 0.85
            glow.ScaleType = Enum.ScaleType.Slice
            glow.SliceCenter = Rect.new(23, 23, 277, 277)
            glow.ZIndex = -1

            makeDraggable(MiniFrame)

            -- Hover effects
            MiniFrame.MouseEnter:Connect(function()
                TweenService:Create(MiniFrame, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0,
                    Size = UDim2.new(0, 124, 0, 38)
                }):Play()
                TweenService:Create(stroke, TweenInfo.new(0.2), {
                    Transparency = 0
                }):Play()
            end)

            MiniFrame.MouseLeave:Connect(function()
                TweenService:Create(MiniFrame, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0.1,
                    Size = UDim2.new(0, 120, 0, 36)
                }):Play()
                TweenService:Create(stroke, TweenInfo.new(0.2), {
                    Transparency = 0.3
                }):Play()
            end)

            local isDragging = false
            MiniFrame.MouseButton1Down:Connect(function()
                isDragging = false
            end)
            MiniFrame.MouseMoved:Connect(function()
                isDragging = true
            end)
            MiniFrame.MouseButton1Up:Connect(function()
                if not isDragging then
                    Main.Visible = true
                    MiniFrame.Visible = false
                end
            end)

            return MiniFrame
        end

        
        
        MinimizeBtn.MouseButton1Click:Connect(function()
            Main.Visible = false
            local mini = createMiniFrame()
            mini.Visible = true
        end)
        
        BindButton.MouseButton1Click:Connect(function()
            BindButton.Text = "[ ... ]"
            local inputwait = game:GetService("UserInputService").InputBegan:wait()
            local shiba = inputwait.KeyCode == Enum.KeyCode.Unknown and inputwait.UserInputType or inputwait.KeyCode
            
            if shiba.Name ~= "Focus" and shiba.Name ~= "MouseMovement" then
                BindButton.Text = "[ " .. shiba.Name .. " ]"
                yoo = shiba.Name
            end
        end)
        
        toggled = false
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode[yoo] then
                if toggled == false then
                    toggled = true
                    Main.Visible = false
                    -- Don't hide the mini button when toggling with keybind
                    if MiniFrame then
                        MiniFrame.Visible = true
                    end
                else
                    toggled = false
                    Main.Visible = true
                    if MiniFrame then
                        MiniFrame.Visible = false
                    end
                end
            end
        end)
        
        -- Modern Tab Container
        local Tab = Instance.new("Frame")
        Tab.Name = "Tab"
        Tab.Parent = Main
        Tab.BackgroundColor3 = _G.SurfaceLight
        Tab.BackgroundTransparency = 0.7
        Tab.Position = UDim2.new(0, isMobileLayout and 8 or 12, 0, isMobileLayout and 58 or 54)
        Tab.Size = UDim2.new(0, tabWidth, 0, responsiveHeight - (isMobileLayout and 64 or 58))
        Tab.BorderSizePixel = 0

        local TabGradient = Instance.new("UIGradient")
        TabGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, _G.SurfaceLight),
            ColorSequenceKeypoint.new(1, _G.Surface)
        })
        TabGradient.Rotation = 180
        TabGradient.Parent = Tab

        local TCNR = Instance.new("UICorner")
        TCNR.Name = "TCNR"
        TCNR.Parent = Tab
        TCNR.CornerRadius = UDim.new(0, 10)

        local TabStroke = Instance.new("UIStroke")
        TabStroke.Parent = Tab
        TabStroke.Color = _G.Border
        TabStroke.Thickness = 1
        TabStroke.Transparency = 0.5

        local ScrollTab = Instance.new("ScrollingFrame")
        ScrollTab.Name = "ScrollTab"
        ScrollTab.Parent = Tab
        ScrollTab.Active = true
        ScrollTab.BackgroundTransparency = 1
        ScrollTab.Size = UDim2.new(0, tabWidth, 0, responsiveHeight - (isMobileLayout and 64 or 58))
        ScrollTab.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollTab.ScrollBarThickness = isMobileLayout and 3 or 0
        ScrollTab.ScrollBarImageColor3 = _G.Border

        local PLL = Instance.new("UIListLayout")
        PLL.Name = "PLL"
        PLL.Parent = ScrollTab
        PLL.SortOrder = Enum.SortOrder.LayoutOrder
        PLL.Padding = UDim.new(0, isMobileLayout and 4 or 6)
        PLL.HorizontalAlignment = Enum.HorizontalAlignment.Center

        local PPD = Instance.new("UIPadding")
        PPD.Name = "PPD"
        PPD.Parent = ScrollTab
        PPD.PaddingLeft = UDim.new(0, isMobileLayout and 6 or 8)
        PPD.PaddingRight = UDim.new(0, isMobileLayout and 6 or 8)
        PPD.PaddingTop = UDim.new(0, isMobileLayout and 8 or 12)
        
        -- Modern Page Container
        local Page = Instance.new("Frame")
        Page.Name = "Page"
        Page.Parent = Main
        Page.BackgroundColor3 = _G.SurfaceLight
        Page.BackgroundTransparency = 0.7
        Page.Position = UDim2.new(0, tabWidth + (isMobileLayout and 16 or 20), 0, isMobileLayout and 58 or 54)
        Page.Size = UDim2.new(0, pageWidth, 0, responsiveHeight - (isMobileLayout and 64 or 58))
        Page.BorderSizePixel = 0

        local PageGradient = Instance.new("UIGradient")
        PageGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, _G.SurfaceLight),
            ColorSequenceKeypoint.new(1, _G.Surface)
        })
        PageGradient.Rotation = 180
        PageGradient.Parent = Page

        local PCNR = Instance.new("UICorner")
        PCNR.Name = "PCNR"
        PCNR.Parent = Page
        PCNR.CornerRadius = UDim.new(0, 10)

        local PageStroke = Instance.new("UIStroke")
        PageStroke.Parent = Page
        PageStroke.Color = _G.Border
        PageStroke.Thickness = 1
        PageStroke.Transparency = 0.5
        
        local MainPage = Instance.new("Frame")
        MainPage.Name = "MainPage"
        MainPage.Parent = Page
        MainPage.ClipsDescendants = true
        MainPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MainPage.BackgroundTransparency = 1.000
        MainPage.Size = UDim2.new(0, pageWidth, 0, responsiveHeight - (isMobileLayout and 60 or 50))
        
        local PageList = Instance.new("Folder")
        PageList.Name = "PageList"
        PageList.Parent = MainPage
        
        local UIPageLayout = Instance.new("UIPageLayout")
        UIPageLayout.Parent = PageList
        UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
        UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
        UIPageLayout.FillDirection = Enum.FillDirection.Vertical
        UIPageLayout.Padding = UDim.new(0, isMobileLayout and 8 or 15)
        UIPageLayout.TweenTime = 0.400
        UIPageLayout.GamepadInputEnabled = false
        UIPageLayout.ScrollWheelInputEnabled = false
        UIPageLayout.TouchInputEnabled = false
        
        MakeDraggable(Top, Main)
        
        local uitab = {}
        
        function uitab:Tab(text, logo1)
            -- Modern Tab Button
            local TabButton = Instance.new("TextButton")
            TabButton.Parent = ScrollTab
            TabButton.Name = text .. "Server"
            TabButton.Text = isMobileLayout and string.sub(text, 1, 8) or text
            TabButton.BackgroundColor3 = _G.Surface
            TabButton.BackgroundTransparency = 1
            TabButton.Size = UDim2.new(0, tabWidth - (isMobileLayout and 16 or 16), 0, isMobileLayout and 32 or 38)
            TabButton.Font = Enum.Font.GothamSemibold
            TabButton.TextColor3 = _G.TextSecondary
            TabButton.TextSize = isMobileLayout and 12 or 14
            TabButton.AutoButtonColor = false

            local TabCorner = Instance.new("UICorner")
            TabCorner.CornerRadius = UDim.new(0, 8)
            TabCorner.Parent = TabButton

            local TabStroke = Instance.new("UIStroke")
            TabStroke.Parent = TabButton
            TabStroke.Color = _G.Border
            TabStroke.Thickness = 1
            TabStroke.Transparency = 0.7

            -- Active Indicator (Left side accent bar)
            local ActiveIndicator = Instance.new("Frame")
            ActiveIndicator.Name = "ActiveIndicator"
            ActiveIndicator.Parent = TabButton
            ActiveIndicator.BackgroundColor3 = _G.Accent
            ActiveIndicator.BorderSizePixel = 0
            ActiveIndicator.Position = UDim2.new(0, 0, 0.5, -10)
            ActiveIndicator.Size = UDim2.new(0, 3, 0, 20)
            ActiveIndicator.Visible = false

            local IndicatorCorner = Instance.new("UICorner")
            IndicatorCorner.CornerRadius = UDim.new(0, 2)
            IndicatorCorner.Parent = ActiveIndicator
            
            local MainFramePage = Instance.new("ScrollingFrame")
            MainFramePage.Name = text .. "_Page"
            MainFramePage.Parent = PageList
            MainFramePage.Active = true
            MainFramePage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MainFramePage.BackgroundTransparency = 1.000
            MainFramePage.BorderSizePixel = 0
            MainFramePage.Size = UDim2.new(0, pageWidth, 0, responsiveHeight - (isMobileLayout and 60 or 50))
            MainFramePage.CanvasSize = UDim2.new(0, 0, 0, 0)
            MainFramePage.ScrollBarThickness = isMobileLayout and 3 or 0
            MainFramePage.ClipsDescendants = true

            local UIPadding = Instance.new("UIPadding")
            local UIListLayout = Instance.new("UIListLayout")
            
            UIPadding.Parent = MainFramePage
            UIPadding.PaddingLeft = UDim.new(0, isMobileLayout and 10 or 15)
            UIPadding.PaddingTop = UDim.new(0, isMobileLayout and 10 or 15)
            UIPadding.PaddingRight = UDim.new(0, isMobileLayout and 10 or 15)
            
            UIListLayout.Padding = UDim.new(0, isMobileLayout and 6 or 8)
            UIListLayout.Parent = MainFramePage
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.HorizontalAlignment = "Center"
            
            -- Tab Hover Effects
            TabButton.MouseEnter:Connect(function()
                if TabButton.BackgroundTransparency > 0.5 then
                    TweenService:Create(TabButton, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.85,
                        TextColor3 = _G.TextPrimary
                    }):Play()
                    TweenService:Create(TabStroke, TweenInfo.new(0.2), {
                        Transparency = 0.4
                    }):Play()
                end
            end)

            TabButton.MouseLeave:Connect(function()
                if TabButton.BackgroundTransparency > 0.5 then
                    TweenService:Create(TabButton, TweenInfo.new(0.2), {
                        BackgroundTransparency = 1,
                        TextColor3 = _G.TextSecondary
                    }):Play()
                    TweenService:Create(TabStroke, TweenInfo.new(0.2), {
                        Transparency = 0.7
                    }):Play()
                end
            end)

            TabButton.MouseButton1Click:Connect(function()
                for i, v in next, ScrollTab:GetChildren() do
                    if v:IsA("TextButton") then
                        local indicator = v:FindFirstChild("ActiveIndicator")
                        if indicator then
                            indicator.Visible = false
                        end
                        TweenService:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            BackgroundColor3 = _G.Surface,
                            BackgroundTransparency = 1,
                            TextColor3 = _G.TextSecondary
                        }):Play()
                        local stroke = v:FindFirstChildOfClass("UIStroke")
                        if stroke then
                            TweenService:Create(stroke, TweenInfo.new(0.3), {
                                Transparency = 0.7,
                                Color = _G.Border
                            }):Play()
                        end
                    end
                end

                ActiveIndicator.Visible = true
                TweenService:Create(TabButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = _G.SurfaceLight,
                    BackgroundTransparency = 0.5,
                    TextColor3 = _G.TextPrimary
                }):Play()
                TweenService:Create(TabStroke, TweenInfo.new(0.3), {
                    Transparency = 0.2,
                    Color = _G.Accent
                }):Play()

                for i, v in next, PageList:GetChildren() do
                    currentpage = string.gsub(TabButton.Name, "Server", "") .. "_Page"
                    if v.Name == currentpage then
                        UIPageLayout:JumpTo(v)
                    end
                end
            end)
            
            if abc == false then
                for i, v in next, ScrollTab:GetChildren() do
                    if v:IsA("TextButton") then
                        local indicator = v:FindFirstChild("ActiveIndicator")
                        if indicator then
                            indicator.Visible = false
                        end
                        TweenService:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            BackgroundColor3 = _G.Surface,
                            BackgroundTransparency = 1,
                            TextColor3 = _G.TextSecondary
                        }):Play()
                        local stroke = v:FindFirstChildOfClass("UIStroke")
                        if stroke then
                            TweenService:Create(stroke, TweenInfo.new(0.3), {
                                Transparency = 0.7,
                                Color = _G.Border
                            }):Play()
                        end
                    end
                end

                ActiveIndicator.Visible = true
                TweenService:Create(TabButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = _G.SurfaceLight,
                    BackgroundTransparency = 0.5,
                    TextColor3 = _G.TextPrimary
                }):Play()
                TweenService:Create(TabStroke, TweenInfo.new(0.3), {
                    Transparency = 0.2,
                    Color = _G.Accent
                }):Play()
                UIPageLayout:JumpToIndex(1)
                abc = true
            end
            
            game:GetService("RunService").Stepped:Connect(function()
                pcall(function()
                    MainFramePage.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 30)
                    ScrollTab.CanvasSize = UDim2.new(0, 0, 0, PLL.AbsoluteContentSize.Y + 20)
                end)
            end)
            
            local main = {}
            
            function main:Button(text, callback)
                -- Modern Button Component
                local Button = Instance.new("TextButton")
                Button.Name = "Button"
                Button.Parent = MainFramePage
                Button.BackgroundColor3 = _G.SurfaceLight
                Button.BackgroundTransparency = 0.6
                Button.Size = UDim2.new(0, elementWidth, 0, isMobileLayout and 36 or 42)
                Button.Font = Enum.Font.GothamSemibold
                Button.Text = text
                Button.TextColor3 = _G.TextPrimary
                Button.TextSize = isMobileLayout and 13 or 15
                Button.AutoButtonColor = false
                Button.ClipsDescendants = true

                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 10)
                ButtonCorner.Parent = Button

                local ButtonStroke = Instance.new("UIStroke")
                ButtonStroke.Parent = Button
                ButtonStroke.Color = _G.Border
                ButtonStroke.Thickness = 1.5
                ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                ButtonStroke.Transparency = 0.5

                -- Shine Effect Overlay
                local Shine = Instance.new("Frame")
                Shine.Name = "Shine"
                Shine.Parent = Button
                Shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Shine.BackgroundTransparency = 0.9
                Shine.Position = UDim2.new(0, -100, 0, 0)
                Shine.Size = UDim2.new(0, 50, 1, 0)
                Shine.Rotation = 15
                Shine.ZIndex = 2

                local ShineCorner = Instance.new("UICorner")
                ShineCorner.CornerRadius = UDim.new(0, 10)
                ShineCorner.Parent = Shine

                -- Gradient Overlay
                local ButtonGradient = Instance.new("UIGradient")
                ButtonGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, _G.SurfaceLight),
                    ColorSequenceKeypoint.new(1, _G.Surface)
                })
                ButtonGradient.Rotation = 90
                ButtonGradient.Parent = Button

                -- Modern Hover Effects
                Button.MouseEnter:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.25), {
                        BackgroundTransparency = 0.4
                    }):Play()
                    TweenService:Create(ButtonStroke, TweenInfo.new(0.25), {
                        Color = _G.BorderHighlight,
                        Transparency = 0.3
                    }):Play()
                    TweenService:Create(Button, TweenInfo.new(0.25), {
                        TextColor3 = _G.AccentLight
                    }):Play()

                    -- Shine animation
                    TweenService:Create(Shine, TweenInfo.new(0.5), {
                        Position = UDim2.new(1, 50, 0, 0)
                    }):Play()
                end)

                Button.MouseLeave:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.25), {
                        BackgroundTransparency = 0.6
                    }):Play()
                    TweenService:Create(ButtonStroke, TweenInfo.new(0.25), {
                        Color = _G.Border,
                        Transparency = 0.5
                    }):Play()
                    TweenService:Create(Button, TweenInfo.new(0.25), {
                        TextColor3 = _G.TextPrimary
                    }):Play()

                    -- Reset shine
                    TweenService:Create(Shine, TweenInfo.new(0.3), {
                        Position = UDim2.new(0, -100, 0, 0)
                    }):Play()
                end)

                -- Click Effects
                Button.MouseButton1Down:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.1), {
                        BackgroundTransparency = 0.2,
                        Size = UDim2.new(0, elementWidth - 4, 0, isMobileLayout and 34 or 40)
                    }):Play()
                    TweenService:Create(ButtonStroke, TweenInfo.new(0.1), {
                        Color = _G.Accent,
                        Transparency = 0
                    }):Play()
                end)

                Button.MouseButton1Up:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.15), {
                        BackgroundTransparency = 0.4,
                        Size = UDim2.new(0, elementWidth, 0, isMobileLayout and 36 or 42)
                    }):Play()
                end)

                Button.MouseButton1Click:Connect(function()
                    -- Flash effect
                    TweenService:Create(Button, TweenInfo.new(0.1), {
                        BackgroundColor3 = _G.Accent,
                        BackgroundTransparency = 0.3
                    }):Play()
                    TweenService:Create(Button, TweenInfo.new(0.1), {
                        TextColor3 = Color3.fromRGB(255, 255, 255)
                    }):Play()

                    pcall(callback)

                    task.wait(0.15)
                    TweenService:Create(Button, TweenInfo.new(0.35), {
                        BackgroundColor3 = _G.SurfaceLight,
                        BackgroundTransparency = 0.6
                    }):Play()
                    TweenService:Create(Button, TweenInfo.new(0.35), {
                        TextColor3 = _G.TextPrimary
                    }):Play()
                    TweenService:Create(ButtonStroke, TweenInfo.new(0.35), {
                        Color = _G.Border,
                        Transparency = 0.5
                    }):Play()
                end)

                
                local ButtonObject = {}

                function ButtonObject:Set(newText, newCallback)
					if newText then
						ButtonText.Text = newText
						Button.Text = newText
					end
					if newCallback then
						callback = newCallback
					end
					return ButtonObject
				end

                function ButtonObject:SetColor(color)
                    ButtonText.TextColor3 = color
                    return ButtonObject
                end

                function ButtonObject:SetAccentColor(color)
                    _G.Accent = color
                    return ButtonObject
                end

                function ButtonObject:SetEnabled(enabled)
                    Button.AutoButtonColor = false
                    Button.Active = enabled
                    if enabled then
                        ButtonText.TextColor3 = _G.TextPrimary
                        Button.BackgroundTransparency = 0.9
                    else
                        ButtonText.TextColor3 = _G.TextSecondary
                        Button.BackgroundTransparency = 0.95
                    end
                    return ButtonObject
                end

                function ButtonObject:GetText()
                    return ButtonText.Text
                end

                return ButtonObject
            end

            function main:Toggle(text, config, callback)
                config = config or false
                local toggled = config

                -- Modern Toggle Container
                local Toggle = Instance.new("Frame")
                Toggle.Name = "Toggle"
                Toggle.Parent = MainFramePage
                Toggle.BackgroundColor3 = _G.SurfaceLight
                Toggle.BackgroundTransparency = 0.7
                Toggle.Size = UDim2.new(0, elementWidth, 0, isMobileLayout and 38 or 44)

                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 10)
                ToggleCorner.Parent = Toggle

                local ToggleStroke = Instance.new("UIStroke")
                ToggleStroke.Parent = Toggle
                ToggleStroke.Color = _G.Border
                ToggleStroke.Thickness = 1
                ToggleStroke.Transparency = 0.5

                local Label = Instance.new("TextLabel")
                Label.Name = "Label"
                Label.Parent = Toggle
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, isMobileLayout and 14 or 18, 0, 0)
                Label.Size = UDim2.new(0, isMobileLayout and 180 or 280, 1, 0)
                Label.Font = Enum.Font.GothamSemibold
                Label.Text = text
                Label.TextColor3 = _G.TextPrimary
                Label.TextSize = isMobileLayout and 13 or 15
                Label.TextXAlignment = Enum.TextXAlignment.Left

                -- Modern Switch Track
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Name = "ToggleButton"
                ToggleButton.Parent = Toggle
                ToggleButton.BackgroundColor3 = _G.Border
                ToggleButton.Position = UDim2.new(1, isMobileLayout and -50 or -62, 0.5, isMobileLayout and -11 or -13)
                ToggleButton.Size = isMobileLayout and UDim2.new(0, 44, 0, 22) or UDim2.new(0, 50, 0, 26)
                ToggleButton.Text = ""
                ToggleButton.AutoButtonColor = false

                local ToggleCorner2 = Instance.new("UICorner")
                ToggleCorner2.CornerRadius = UDim.new(1, 0)
                ToggleCorner2.Parent = ToggleButton

                -- Track Glow Effect
                local TrackGlow = Instance.new("UIStroke")
                TrackGlow.Parent = ToggleButton
                TrackGlow.Color = _G.Border
                TrackGlow.Thickness = 1
                TrackGlow.Transparency = 0.7

                -- Modern Toggle Knob
                local ToggleKnob = Instance.new("Frame")
                ToggleKnob.Name = "ToggleKnob"
                ToggleKnob.Parent = ToggleButton
                ToggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleKnob.Position = UDim2.new(0, 3, 0.5, -8)
                ToggleKnob.Size = isMobileLayout and UDim2.new(0, 16, 0, 16) or UDim2.new(0, 20, 0, 20)

                local ToggleKnobCorner = Instance.new("UICorner")
                ToggleKnobCorner.CornerRadius = UDim.new(1, 0)
                ToggleKnobCorner.Parent = ToggleKnob

                -- Knob Shadow
                local KnobShadow = Instance.new("ImageLabel")
                KnobShadow.Name = "Shadow"
                KnobShadow.Parent = ToggleKnob
                KnobShadow.BackgroundTransparency = 1
                KnobShadow.Position = UDim2.new(0.5, -12, 0.5, -12)
                KnobShadow.Size = UDim2.new(0, 24, 0, 24)
                KnobShadow.Image = "rbxassetid://5554236805"
                KnobShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
                KnobShadow.ImageTransparency = 0.7
                KnobShadow.ScaleType = Enum.ScaleType.Slice
                KnobShadow.SliceCenter = Rect.new(23, 23, 277, 277)
                KnobShadow.ZIndex = -1

                -- Status Indicator Dot
                local StatusDot = Instance.new("Frame")
                StatusDot.Name = "StatusDot"
                StatusDot.Parent = Toggle
                StatusDot.BackgroundColor3 = _G.TextMuted
                StatusDot.Position = UDim2.new(1, isMobileLayout and -72 or -88, 0.5, -3)
                StatusDot.Size = UDim2.new(0, 6, 0, 6)

                local StatusDotCorner = Instance.new("UICorner")
                StatusDotCorner.CornerRadius = UDim.new(1, 0)
                StatusDotCorner.Parent = StatusDot

                local function updateState(state)
                    toggled = state
                    if toggled then
                        -- ON State
                        TweenService:Create(ToggleButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                            BackgroundColor3 = _G.Accent
                        }):Play()
                        TweenService:Create(ToggleKnob, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
                            Position = isMobileLayout and UDim2.new(1, -19, 0.5, -8) or UDim2.new(1, -23, 0.5, -10)
                        }):Play()
                        TweenService:Create(TrackGlow, TweenInfo.new(0.25), {
                            Color = _G.AccentLight,
                            Transparency = 0.4
                        }):Play()
                        TweenService:Create(StatusDot, TweenInfo.new(0.25), {
                            BackgroundColor3 = _G.Accent
                        }):Play()
                        TweenService:Create(Label, TweenInfo.new(0.25), {
                            TextColor3 = _G.TextPrimary
                        }):Play()
                    else
                        -- OFF State
                        TweenService:Create(ToggleButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                            BackgroundColor3 = _G.Border
                        }):Play()
                        TweenService:Create(ToggleKnob, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
                            Position = UDim2.new(0, 3, 0.5, -8)
                        }):Play()
                        TweenService:Create(TrackGlow, TweenInfo.new(0.25), {
                            Color = _G.Border,
                            Transparency = 0.7
                        }):Play()
                        TweenService:Create(StatusDot, TweenInfo.new(0.25), {
                            BackgroundColor3 = _G.TextMuted
                        }):Play()
                        TweenService:Create(Label, TweenInfo.new(0.25), {
                            TextColor3 = _G.TextSecondary
                        }):Play()
                    end
                    pcall(callback, toggled)
                end

                -- Container Hover Effect
                Toggle.MouseEnter:Connect(function()
                    TweenService:Create(Toggle, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.5
                    }):Play()
                    TweenService:Create(ToggleStroke, TweenInfo.new(0.2), {
                        Transparency = 0.3
                    }):Play()
                end)

                Toggle.MouseLeave:Connect(function()
                    TweenService:Create(Toggle, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.7
                    }):Play()
                    TweenService:Create(ToggleStroke, TweenInfo.new(0.2), {
                        Transparency = 0.5
                    }):Play()
                end)

                ToggleButton.MouseButton1Click:Connect(function()
                    updateState(not toggled)
                end)

                if config == true then
                    updateState(true)
                end

                local ToggleObject = {}
                function ToggleObject:Set(state, newText)
                    if state ~= nil then
                        updateState(state)
                    end
                    if newText then
                        Label.Text = newText
                    end
                end
                return ToggleObject
            end

            function main:Slider(text, min, max, set, callback)
                -- Modern Slider Container
                local Slider = Instance.new("Frame")
                Slider.Name = "Slider"
                Slider.Parent = MainFramePage
                Slider.BackgroundColor3 = _G.SurfaceLight
                Slider.BackgroundTransparency = 0.7
                Slider.Size = UDim2.new(0, elementWidth, 0, isMobileLayout and 56 or 68)

                local SliderCorner = Instance.new("UICorner")
                SliderCorner.CornerRadius = UDim.new(0, 10)
                SliderCorner.Parent = Slider

                local SliderStroke = Instance.new("UIStroke")
                SliderStroke.Parent = Slider
                SliderStroke.Color = _G.Border
                SliderStroke.Thickness = 1
                SliderStroke.Transparency = 0.5

                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.Parent = Slider
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Position = UDim2.new(0, isMobileLayout and 14 or 18, 0, isMobileLayout and 8 or 10)
                SliderLabel.Size = UDim2.new(0, isMobileLayout and 160 or 220, 0, isMobileLayout and 18 or 22)
                SliderLabel.Font = Enum.Font.GothamSemibold
                SliderLabel.Text = text
                SliderLabel.TextColor3 = _G.TextPrimary
                SliderLabel.TextSize = isMobileLayout and 12 or 14
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

                -- Modern Value Badge
                local ValueBadge = Instance.new("Frame")
                ValueBadge.Name = "ValueBadge"
                ValueBadge.Parent = Slider
                ValueBadge.BackgroundColor3 = _G.Surface
                ValueBadge.Position = UDim2.new(1, isMobileLayout and -55 or -70, 0, isMobileLayout and 6 or 8)
                ValueBadge.Size = UDim2.new(0, isMobileLayout and 45 or 55, 0, isMobileLayout and 22 or 26)

                local ValueBadgeCorner = Instance.new("UICorner")
                ValueBadgeCorner.CornerRadius = UDim.new(0, 6)
                ValueBadgeCorner.Parent = ValueBadge

                local ValueBadgeStroke = Instance.new("UIStroke")
                ValueBadgeStroke.Parent = ValueBadge
                ValueBadgeStroke.Color = _G.Border
                ValueBadgeStroke.Thickness = 1

                local ValueLabel = Instance.new("TextLabel")
                ValueLabel.Parent = ValueBadge
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.Size = UDim2.new(1, 0, 1, 0)
                ValueLabel.Font = Enum.Font.GothamBold
                ValueLabel.Text = tostring(set)
                ValueLabel.TextColor3 = _G.Accent
                ValueLabel.TextSize = isMobileLayout and 12 or 14
                ValueLabel.TextXAlignment = Enum.TextXAlignment.Center

                -- Modern Track
                local SliderTrack = Instance.new("Frame")
                SliderTrack.Parent = Slider
                SliderTrack.BackgroundColor3 = _G.Border
                SliderTrack.Position = UDim2.new(0, isMobileLayout and 14 or 18, 0, isMobileLayout and 34 or 42)
                SliderTrack.Size = UDim2.new(0, elementWidth - (isMobileLayout and 28 or 36), 0, isMobileLayout and 6 or 8)

                local SliderTrackCorner = Instance.new("UICorner")
                SliderTrackCorner.CornerRadius = UDim.new(1, 0)
                SliderTrackCorner.Parent = SliderTrack

                -- Fill with Gradient
                local SliderFill = Instance.new("Frame")
                SliderFill.Parent = SliderTrack
                SliderFill.BackgroundColor3 = _G.Accent
                SliderFill.Size = UDim2.new(0, 0, 1, 0)

                local FillGradient = Instance.new("UIGradient")
                FillGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, _G.Accent),
                    ColorSequenceKeypoint.new(1, _G.AccentLight)
                })
                FillGradient.Rotation = 0
                FillGradient.Parent = SliderFill

                local SliderFillCorner = Instance.new("UICorner")
                SliderFillCorner.CornerRadius = UDim.new(1, 0)
                SliderFillCorner.Parent = SliderFill

                local SliderButton = Instance.new("TextButton")
                SliderButton.Parent = SliderTrack
                SliderButton.BackgroundTransparency = 1
                SliderButton.Size = UDim2.new(1, 0, 1, 0)
                SliderButton.Text = ""
                SliderButton.ZIndex = 2

                -- Modern Knob
                local SliderKnob = Instance.new("Frame")
                SliderKnob.Parent = SliderTrack
                SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderKnob.Size = isMobileLayout and UDim2.new(0, 16, 0, 16) or UDim2.new(0, 20, 0, 20)
                SliderKnob.Position = isMobileLayout and UDim2.new(0, -8, 0.5, -8) or UDim2.new(0, -10, 0.5, -10)
                SliderKnob.ZIndex = 3

                local SliderKnobCorner = Instance.new("UICorner")
                SliderKnobCorner.CornerRadius = UDim.new(1, 0)
                SliderKnobCorner.Parent = SliderKnob

                local KnobStroke = Instance.new("UIStroke")
                KnobStroke.Parent = SliderKnob
                KnobStroke.Color = _G.Border
                KnobStroke.Thickness = 1.5

                -- Knob Shadow
                local KnobShadow = Instance.new("ImageLabel")
                KnobShadow.Name = "Shadow"
                KnobShadow.Parent = SliderKnob
                KnobShadow.BackgroundTransparency = 1
                KnobShadow.Position = UDim2.new(0.5, -15, 0.5, -15)
                KnobShadow.Size = UDim2.new(0, 30, 0, 30)
                KnobShadow.Image = "rbxassetid://5554236805"
                KnobShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
                KnobShadow.ImageTransparency = 0.8
                KnobShadow.ScaleType = Enum.ScaleType.Slice
                KnobShadow.SliceCenter = Rect.new(23, 23, 277, 277)
                KnobShadow.ZIndex = -1

                local mouse = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")
                local Value = set

                -- Container Hover
                Slider.MouseEnter:Connect(function()
                    TweenService:Create(Slider, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.5
                    }):Play()
                    TweenService:Create(SliderStroke, TweenInfo.new(0.2), {
                        Transparency = 0.3
                    }):Play()
                end)

                Slider.MouseLeave:Connect(function()
                    TweenService:Create(Slider, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.7
                    }):Play()
                    TweenService:Create(SliderStroke, TweenInfo.new(0.2), {
                        Transparency = 0.5
                    }):Play()
                end)

                local function UpdateSlider(val)
                    val = math.clamp(val, min, max)
                    Value = val
                    ValueLabel.Text = tostring(val)

                    local percent = (val - min) / (max - min)
                    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    SliderKnob.Position = UDim2.new(percent, isMobileLayout and -8 or -10, 0.5, isMobileLayout and -8 or -10)

                    pcall(callback, val)
                end

                UpdateSlider(set)

                -- Knob Hover Effects
                SliderKnob.MouseEnter:Connect(function()
                    TweenService:Create(SliderKnob, TweenInfo.new(0.2), {
                        Size = isMobileLayout and UDim2.new(0, 20, 0, 20) or UDim2.new(0, 24, 0, 24)
                    }):Play()
                    TweenService:Create(SliderKnob, TweenInfo.new(0.2), {
                        Position = UDim2.new(SliderKnob.Position.X.Scale, SliderKnob.Position.X.Offset - (isMobileLayout and 2 or 2), 0.5, isMobileLayout and -10 or -12)
                    }):Play()
                end)

                SliderKnob.MouseLeave:Connect(function()
                    TweenService:Create(SliderKnob, TweenInfo.new(0.2), {
                        Size = isMobileLayout and UDim2.new(0, 16, 0, 16) or UDim2.new(0, 20, 0, 20)
                    }):Play()
                    TweenService:Create(SliderKnob, TweenInfo.new(0.2), {
                        Position = UDim2.new(SliderKnob.Position.X.Scale, SliderKnob.Position.X.Offset + (isMobileLayout and 2 or 2), 0.5, isMobileLayout and -8 or -10)
                    }):Play()
                end)

                SliderButton.MouseButton1Down:Connect(function()
                    TweenService:Create(SliderKnob, TweenInfo.new(0.15), {
                        Size = isMobileLayout and UDim2.new(0, 22, 0, 22) or UDim2.new(0, 26, 0, 26)
                    }):Play()

                    local moveConnection, releaseConnection

                    moveConnection = mouse.Move:Connect(function()
                        local percent = math.clamp((mouse.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                        UpdateSlider(math.floor(min + (max - min) * percent))
                    end)

                    releaseConnection = uis.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            TweenService:Create(SliderKnob, TweenInfo.new(0.15), {
                                Size = isMobileLayout and UDim2.new(0, 16, 0, 16) or UDim2.new(0, 20, 0, 20)
                            }):Play()
                            moveConnection:Disconnect()
                            releaseConnection:Disconnect()
                        end
                    end)
                end)
                
            end

            function main:RichParagraph(text, options)
                local options = options or {}
                local textSize = options.TextSize or (isMobileLayout and 11 or 13)
                local lineHeight = options.LineHeight or 1.3
                local textColor = options.TextColor or _G.TextPrimary
                local backgroundColor = options.BackgroundColor or _G.Surface
                local backgroundTransparency = options.BackgroundTransparency or 0.9
                local richText = options.RichText or true
                local maxHeight = options.MaxHeight or (isMobileLayout and 200 or 300)

                local Paragraph = Instance.new("Frame")
                Paragraph.Name = "RichParagraph"
                Paragraph.Parent = MainFramePage
                Paragraph.BackgroundColor3 = backgroundColor
                Paragraph.BackgroundTransparency = backgroundTransparency
                Paragraph.Size = UDim2.new(0, elementWidth, 0, 0)
                Paragraph.ClipsDescendants = true

                local ParagraphCorner = Instance.new("UICorner")
                ParagraphCorner.CornerRadius = UDim.new(0, 6)
                ParagraphCorner.Parent = Paragraph

                local ParagraphStroke = Instance.new("UIStroke")
                ParagraphStroke.Parent = Paragraph
                ParagraphStroke.Color = _G.Border
                ParagraphStroke.Thickness = 1

                
                local ScrollFrame = Instance.new("ScrollingFrame")
                ScrollFrame.Name = "ScrollFrame"
                ScrollFrame.Parent = Paragraph
                ScrollFrame.BackgroundTransparency = 1
                ScrollFrame.BorderSizePixel = 0
                ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
                ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
                ScrollFrame.ScrollBarThickness = isMobileLayout and 4 or 3
                ScrollFrame.ScrollBarImageColor3 = _G.Border
                ScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y

                local TextContainer = Instance.new("Frame")
                TextContainer.Name = "TextContainer"
                TextContainer.Parent = ScrollFrame
                TextContainer.BackgroundTransparency = 1
                TextContainer.Position = UDim2.new(0, isMobileLayout and 8 or 15, 0, isMobileLayout and 8 or 15)
                TextContainer.Size = UDim2.new(1, isMobileLayout and -16 or -30, 0, 0)

                local ParagraphText = Instance.new("TextLabel")
                ParagraphText.Name = "ParagraphText"
                ParagraphText.Parent = TextContainer
                ParagraphText.BackgroundTransparency = 1
                ParagraphText.Size = UDim2.new(1, 0, 0, 0)
                ParagraphText.Font = Enum.Font.Gotham
                ParagraphText.Text = text
                ParagraphText.TextColor3 = textColor
                ParagraphText.TextSize = textSize
                ParagraphText.TextWrapped = true
                ParagraphText.TextXAlignment = Enum.TextXAlignment.Left
                ParagraphText.TextYAlignment = Enum.TextYAlignment.Top
                ParagraphText.RichText = richText
                ParagraphText.LineHeight = lineHeight

                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.Parent = TextContainer
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

                
                local function updateSize()
                    task.wait(0.1)
                    
                    local textBounds = ParagraphText.TextBounds
                    local padding = isMobileLayout and 20 or 30
                    local requiredHeight = math.max(textBounds.Y + padding, isMobileLayout and 50 or 60)
                    
                    
                    local finalHeight = math.min(requiredHeight, maxHeight)
                    
                    ParagraphText.Size = UDim2.new(1, 0, 0, textBounds.Y)
                    TextContainer.Size = UDim2.new(1, 0, 0, textBounds.Y)
                    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, textBounds.Y + (isMobileLayout and 20 or 30))
                    Paragraph.Size = UDim2.new(0, elementWidth, 0, finalHeight)
                    
                    
                    ScrollFrame.ScrollBarThickness = requiredHeight > maxHeight and (isMobileLayout and 4 or 3) or 0
                end

                
                updateSize()

                
                ParagraphText:GetPropertyChangedSignal("Text"):Connect(updateSize)
                ParagraphText:GetPropertyChangedSignal("TextSize"):Connect(updateSize)
                ParagraphText:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)

                
                local ParagraphAPI = {}

                function ParagraphAPI:Set(newText)
                    ParagraphText.Text = tostring(newText or "")
                    return ParagraphAPI
                end

                function ParagraphAPI:Get()
                    return ParagraphText.Text
                end

                function ParagraphAPI:SetColor(color)
                    ParagraphText.TextColor3 = color
                    return ParagraphAPI
                end

                function ParagraphAPI:SetTextSize(size)
                    ParagraphText.TextSize = size
                    return ParagraphAPI
                end

                function ParagraphAPI:SetLineHeight(height)
                    ParagraphText.LineHeight = height
                    return ParagraphAPI
                end

                function ParagraphAPI:SetRichText(enabled)
                    ParagraphText.RichText = enabled
                    return ParagraphAPI
                end

                function ParagraphAPI:AddText(newText)
                    ParagraphText.Text = ParagraphText.Text .. newText
                    return ParagraphAPI
                end

                function ParagraphAPI:Clear()
                    ParagraphText.Text = ""
                    return ParagraphAPI
                end

                function ParagraphAPI:SetBackgroundColor(color)
                    Paragraph.BackgroundColor3 = color
                    return ParagraphAPI
                end

                function ParagraphAPI:SetBackgroundTransparency(transparency)
                    Paragraph.BackgroundTransparency = transparency
                    return ParagraphAPI
                end

                function ParagraphAPI:SetMaxHeight(height)
                    maxHeight = height
                    updateSize()
                    return ParagraphAPI
                end

                
                function ParagraphAPI:AddHeader(text, level)
                    level = level or 1
                    local headerSize = (isMobileLayout and 14 or 16) - (level - 1) * 2
                    local headerText = "\n<font size=\""..headerSize.."\"><b>"..text.."</b></font>\n"
                    ParagraphText.Text = ParagraphText.Text .. headerText
                    return ParagraphAPI
                end

                function ParagraphAPI:AddListItem(text)
                    local listItem = "\n• "..text
                    ParagraphText.Text = ParagraphText.Text .. listItem
                    return ParagraphAPI
                end

                function ParagraphAPI:AddLineBreak()
                    ParagraphText.Text = ParagraphText.Text .. "\n"
                    return ParagraphAPI
                end

                function ParagraphAPI:AddSeparator()
                    ParagraphText.Text = ParagraphText.Text .. "\n────────────────\n"
                    return ParagraphAPI
                end

                function ParagraphAPI:AddCode(text)
                    local codeText = "\n<font color=\"#60A5FA\">`"..text.."`</font>"
                    ParagraphText.Text = ParagraphText.Text .. codeText
                    return ParagraphAPI
                end

                function ParagraphAPI:AddWarning(text)
                    local warningText = "\n<font color=\"#FBBF24\">⚠ "..text.."</font>"
                    ParagraphText.Text = ParagraphText.Text .. warningText
                    return ParagraphAPI
                end

                function ParagraphAPI:AddSuccess(text)
                    local successText = "\n<font color=\"#34D399\">✓ "..text.."</font>"
                    ParagraphText.Text = ParagraphText.Text .. successText
                    return ParagraphAPI
                end

                function ParagraphAPI:AddError(text)
                    local errorText = "\n<font color=\"#F87171\">✗ "..text.."</font>"
                    ParagraphText.Text = ParagraphText.Text .. errorText
                    return ParagraphAPI
                end

                return ParagraphAPI
            end

            
            local NotificationService = {}

            
            local NotificationContainer = Instance.new("Frame")
            NotificationContainer.Name = "NotificationContainer"
            NotificationContainer.Parent = ShadcnUI
            NotificationContainer.BackgroundTransparency = 1
            NotificationContainer.Size = UDim2.new(0, 350, 1, 0) 
            NotificationContainer.Position = UDim2.new(1, -30, 1, 40) 
            NotificationContainer.AnchorPoint = Vector2.new(1, 1) 
            NotificationContainer.ZIndex = 100

            
            local NotificationList = Instance.new("Frame")
            NotificationList.Name = "NotificationList"
            NotificationList.Parent = NotificationContainer
            NotificationList.BackgroundTransparency = 1
            NotificationList.Size = UDim2.new(1, 0, 1, 0)
            NotificationList.ClipsDescendants = true

            
            local activeNotifications = {}

            function NotificationService:Notify(settings)
                spawn(function()
                    local config = {
                        Title = settings.Title or "Notification",
                        Content = settings.Content or "",
                        Duration = settings.Duration or 5,
                        Type = settings.Type or "info", 
                        Actions = settings.Actions or nil,
                        Image = settings.Image or nil
                    }
                    
                    
                    -- Modern Notification Frame
                    local Notification = Instance.new("Frame")
                    Notification.Name = "Notification_" .. config.Title
                    Notification.Parent = NotificationList
                    Notification.BackgroundColor3 = _G.Surface
                    Notification.BackgroundTransparency = 1
                    Notification.Size = UDim2.new(0, 340, 0, 0)
                    Notification.ClipsDescendants = true
                    Notification.ZIndex = 101

                    -- Gradient Background
                    local NotifGradient = Instance.new("UIGradient")
                    NotifGradient.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, _G.SurfaceLight),
                        ColorSequenceKeypoint.new(1, _G.Surface)
                    })
                    NotifGradient.Rotation = 90
                    NotifGradient.Parent = Notification

                    local Corner = Instance.new("UICorner")
                    Corner.CornerRadius = UDim.new(0, 12)
                    Corner.Parent = Notification

                    -- Modern Stroke
                    local Stroke = Instance.new("UIStroke")
                    Stroke.Color = _G.Border
                    Stroke.Thickness = 1.5
                    Stroke.Transparency = 1
                    Stroke.Parent = Notification

                    -- Enhanced Shadow
                    local Shadow = Instance.new("ImageLabel")
                    Shadow.Name = "Shadow"
                    Shadow.Image = "rbxassetid://5554236805"
                    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
                    Shadow.ImageTransparency = 0.85
                    Shadow.ScaleType = Enum.ScaleType.Slice
                    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
                    Shadow.Size = UDim2.new(1, 20, 1, 20)
                    Shadow.Position = UDim2.new(0, -10, 0, -10)
                    Shadow.BackgroundTransparency = 1
                    Shadow.Parent = Notification
                    Shadow.ZIndex = 100

                    -- Accent Line (Left side)
                    local AccentLine = Instance.new("Frame")
                    AccentLine.Name = "AccentLine"
                    AccentLine.Parent = Notification
                    AccentLine.BackgroundColor3 = colorMap[config.Type] or _G.Accent
                    AccentLine.BorderSizePixel = 0
                    AccentLine.Position = UDim2.new(0, 0, 0, 0)
                    AccentLine.Size = UDim2.new(0, 4, 1, 0)
                    AccentLine.ZIndex = 102

                    local AccentLineCorner = Instance.new("UICorner")
                    AccentLineCorner.CornerRadius = UDim.new(0, 2)
                    AccentLineCorner.Parent = AccentLine

                    
                    -- Modern Content Layout
                    local Content = Instance.new("Frame")
                    Content.Name = "Content"
                    Content.Parent = Notification
                    Content.BackgroundTransparency = 1
                    Content.Size = UDim2.new(1, -28, 1, -24)
                    Content.Position = UDim2.new(0, 16, 0, 12)

                    local Layout = Instance.new("UIListLayout")
                    Layout.Parent = Content
                    Layout.SortOrder = Enum.SortOrder.LayoutOrder
                    Layout.Padding = UDim.new(0, 10)

                    -- Modern Header
                    local Header = Instance.new("Frame")
                    Header.Name = "Header"
                    Header.Parent = Content
                    Header.BackgroundTransparency = 1
                    Header.Size = UDim2.new(1, 0, 0, 26)

                    local HeaderLayout = Instance.new("UIListLayout")
                    HeaderLayout.Parent = Header
                    HeaderLayout.FillDirection = Enum.FillDirection.Horizontal
                    HeaderLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    HeaderLayout.Padding = UDim.new(0, 12)

                    local HeaderPadding = Instance.new("UIPadding")
                    HeaderPadding.Parent = Header
                    HeaderPadding.PaddingTop = UDim.new(0, 3)

                    -- Modern Icon
                    local Icon = Instance.new("ImageLabel")
                    Icon.Name = "Icon"
                    Icon.Parent = Header
                    Icon.BackgroundTransparency = 1
                    Icon.Size = UDim2.new(0, 22, 0, 22)
                    Icon.ImageTransparency = 1
                    
                    
                    local iconMap = {
                        info = "rbxassetid://10723415903",
                        success = "rbxassetid://10709790644", 
                        warning = "rbxassetid://10709753149",
                        error = "rbxassetid://10747384394"
                    }
                    Icon.Image = config.Image or iconMap[config.Type] or iconMap.info
                    
                    
                    local colorMap = {
                        info = _G.Accent,
                        success = Color3.fromRGB(34, 197, 94),
                        warning = Color3.fromRGB(245, 158, 11),
                        error = Color3.fromRGB(239, 68, 68)
                    }
                    Icon.ImageColor3 = colorMap[config.Type] or _G.Accent

                    
                    -- Modern Title
                    local Title = Instance.new("TextLabel")
                    Title.Name = "Title"
                    Title.Parent = Header
                    Title.BackgroundTransparency = 1
                    Title.Size = UDim2.new(1, -50, 1, 0)
                    Title.Font = Enum.Font.GothamBold
                    Title.Text = config.Title
                    Title.TextColor3 = _G.TextPrimary
                    Title.TextTransparency = 1
                    Title.TextSize = 15
                    Title.TextXAlignment = Enum.TextXAlignment.Left
                    Title.TextYAlignment = Enum.TextYAlignment.Center

                    -- Modern Description
                    local Description = Instance.new("TextLabel")
                    Description.Name = "Description"
                    Description.Parent = Content
                    Description.BackgroundTransparency = 1
                    Description.Size = UDim2.new(1, 0, 0, 0)
                    Description.Font = Enum.Font.Gotham
                    Description.Text = config.Content
                    Description.TextColor3 = _G.TextSecondary
                    Description.TextTransparency = 1
                    Description.TextSize = 13
                    Description.TextXAlignment = Enum.TextXAlignment.Left
                    Description.TextYAlignment = Enum.TextYAlignment.Top
                    Description.TextWrapped = true
                    Description.AutomaticSize = Enum.AutomaticSize.Y

                    
                    -- Modern Close Button
                    local CloseButton = Instance.new("ImageButton")
                    CloseButton.Name = "CloseButton"
                    CloseButton.Parent = Header
                    CloseButton.BackgroundTransparency = 1
                    CloseButton.Size = UDim2.new(0, 18, 0, 18)
                    CloseButton.Position = UDim2.new(1, -22, 0, 4)
                    CloseButton.Image = "rbxassetid://10747383819"
                    CloseButton.ImageRectOffset = Vector2.new(284, 4)
                    CloseButton.ImageRectSize = Vector2.new(24, 24)
                    CloseButton.ImageColor3 = _G.TextSecondary
                    CloseButton.ImageTransparency = 0
                    CloseButton.ZIndex = 102

                    -- Close Button Hover Effect
                    CloseButton.MouseEnter:Connect(function()
                        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
                            ImageColor3 = _G.Error
                        }):Play()
                    end)

                    CloseButton.MouseLeave:Connect(function()
                        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
                            ImageColor3 = _G.TextSecondary
                        }):Play()
                    end)

                    
                    local ActionsContainer = Instance.new("Frame")
                    ActionsContainer.Name = "Actions"
                    ActionsContainer.Parent = Content
                    ActionsContainer.BackgroundTransparency = 1
                    ActionsContainer.Size = UDim2.new(1, 0, 0, 36)
                    ActionsContainer.Visible = false

                    local ActionsLayout = Instance.new("UIListLayout")
                    ActionsLayout.Parent = ActionsContainer
                    ActionsLayout.FillDirection = Enum.FillDirection.Horizontal
                    ActionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    ActionsLayout.Padding = UDim.new(0, 8)
                    ActionsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right

                    local ActionsPadding = Instance.new("UIPadding")
                    ActionsPadding.Parent = ActionsContainer
                    ActionsPadding.PaddingTop = UDim.new(0, 8)

                    
                    local actionButtons = {}
                    if config.Actions then
                        ActionsContainer.Visible = true
                        for i, action in ipairs(config.Actions) do
                            local ActionButton = Instance.new("TextButton")
                            ActionButton.Name = action.Name
                            ActionButton.Parent = ActionsContainer
                            ActionButton.BackgroundColor3 = _G.Surface
                            ActionButton.BackgroundTransparency = 0.9
                            ActionButton.Size = UDim2.new(0, 0, 0, 32)
                            ActionButton.AutoButtonColor = false
                            ActionButton.Font = Enum.Font.GothamMedium
                            ActionButton.Text = action.Name
                            ActionButton.TextColor3 = _G.TextPrimary
                            ActionButton.TextSize = 12
                            ActionButton.TextTransparency = 1
                            
                            local ActionCorner = Instance.new("UICorner")
                            ActionCorner.CornerRadius = UDim.new(0, 6)
                            ActionCorner.Parent = ActionButton
                            
                            local ActionStroke = Instance.new("UIStroke")
                            ActionStroke.Color = _G.Border
                            ActionStroke.Thickness = 1
                            ActionStroke.Transparency = 1
                            ActionStroke.Parent = ActionButton
                            
                            
                            local textSize = game:GetService("TextService"):GetTextSize(action.Name, 12, Enum.Font.GothamMedium, Vector2.new(1000, 32))
                            ActionButton.Size = UDim2.new(0, textSize.X + 24, 0, 32)
                            
                            
                            ActionButton.MouseEnter:Connect(function()
                                TweenService:Create(ActionButton, TweenInfo.new(0.2), {
                                    BackgroundTransparency = 0.8,
                                    TextColor3 = _G.Accent
                                }):Play()
                                TweenService:Create(ActionStroke, TweenInfo.new(0.2), {
                                    Transparency = 0
                                }):Play()
                            end)
                            
                            ActionButton.MouseLeave:Connect(function()
                                TweenService:Create(ActionButton, TweenInfo.new(0.2), {
                                    BackgroundTransparency = 0.9,
                                    TextColor3 = _G.TextPrimary
                                }):Play()
                                TweenService:Create(ActionStroke, TweenInfo.new(0.2), {
                                    Transparency = 1
                                }):Play()
                            end)
                            
                            ActionButton.MouseButton1Click:Connect(function()
                                
                                TweenService:Create(ActionButton, TweenInfo.new(0.1), {
                                    BackgroundColor3 = _G.Accent,
                                    BackgroundTransparency = 0.7,
                                    TextColor3 = Color3.fromRGB(255, 255, 255)
                                }):Play()
                                
                                local success, result = pcall(action.Callback)
                                if not success then
                                    warn("Notification action error: " .. tostring(result))
                                end
                                
                                task.wait(0.15)
                                TweenService:Create(ActionButton, TweenInfo.new(0.2), {
                                    BackgroundColor3 = _G.Surface,
                                    BackgroundTransparency = 0.9,
                                    TextColor3 = _G.TextPrimary
                                }):Play()
                            end)
                            
                            table.insert(actionButtons, ActionButton)
                        end
                    end

                    
                    local function calculateHeight()
                        local baseHeight = 80
                        if config.Content ~= "" then
                            local textSize = game:GetService("TextService"):GetTextSize(config.Content, 12, Enum.Font.Gotham, Vector2.new(280, 1000))
                            baseHeight = baseHeight + math.min(textSize.Y, 60)
                        end
                        if config.Actions then
                            baseHeight = baseHeight + 44
                        end
                        return math.min(baseHeight, 200)
                    end

                    local finalHeight = calculateHeight()

                    
                    local function updateNotificationPositions()
                        local totalHeight = 0
                        local spacing = 10
                        
                        
                        for i, notifData in ipairs(activeNotifications) do
                            if notifData.notification.Parent then
                                local targetY = 1 - (totalHeight + notifData.height) / NotificationList.AbsoluteSize.Y
                                TweenService:Create(notifData.notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                                    Position = UDim2.new(1, 0, targetY, 0)
                                }):Play()
                                totalHeight = totalHeight + notifData.height + spacing
                            end
                        end
                    end

                    
                    local notificationData = {
                        notification = Notification,
                        height = finalHeight,
                        close = nil 
                    }
                    table.insert(activeNotifications, 1, notificationData) 

                    
                    local function closeNotification()
                        if closeConnection then
                            closeConnection:Disconnect()
                        end
                        
                        
                        for i, notifData in ipairs(activeNotifications) do
                            if notifData.notification == Notification then
                                table.remove(activeNotifications, i)
                                break
                            end
                        end
                        
                        
                        TweenService:Create(Icon, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                            ImageTransparency = 1
                        }):Play()
                        
                        TweenService:Create(Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                            TextTransparency = 1
                        }):Play()
                        
                        TweenService:Create(Description, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                            TextTransparency = 1
                        }):Play()
                        
                        TweenService:Create(CloseButton, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                            ImageTransparency = 1
                        }):Play()
                        
                        for _, button in ipairs(actionButtons) do
                            TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                                TextTransparency = 1
                            }):Play()
                        end
                        
                        wait(0.2)
                        
                        
                        TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                            BackgroundTransparency = 1,
                            Size = UDim2.new(0, 320, 0, 0)
                        }):Play()
                        
                        TweenService:Create(Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                            Transparency = 1
                        }):Play()
                        
                        TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                            ImageTransparency = 0.9
                        }):Play()
                        
                        wait(0.4)
                        
                        
                        updateNotificationPositions()
                        
                        if Notification.Parent then
                            Notification:Destroy()
                        end
                    end

                    
                    notificationData.close = closeNotification

                    
                    CloseButton.MouseButton1Click:Connect(function()
                        closeNotification()
                    end)

                    
                    CloseButton.MouseEnter:Connect(function()
                        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
                            ImageColor3 = _G.Accent
                        }):Play()
                    end)

                    CloseButton.MouseLeave:Connect(function()
                        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
                            ImageColor3 = _G.TextSecondary
                        }):Play()
                    end)

                    
                    Notification.Position = UDim2.new(1, 50, 1, 0) 
                    Notification.AnchorPoint = Vector2.new(1, 1) 

                    
                    TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                        BackgroundTransparency = 0,
                        Size = UDim2.new(0, 320, 0, finalHeight)
                    }):Play()
                    
                    TweenService:Create(Stroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                        Transparency = 0
                    }):Play()
                    
                    TweenService:Create(Shadow, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                        ImageTransparency = 0.4
                    }):Play()

                    
                    updateNotificationPositions()

                    wait(0.2)
                    
                    
                    TweenService:Create(Icon, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                        ImageTransparency = 0
                    }):Play()
                    
                    TweenService:Create(Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                        TextTransparency = 0
                    }):Play()
                    
                    TweenService:Create(CloseButton, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                        ImageTransparency = 0
                    }):Play()
                    
                    if config.Content ~= "" then
                        TweenService:Create(Description, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                            TextTransparency = 0.2
                        }):Play()
                    end

                    
                    if config.Actions then
                        wait(0.3)
                        for i, button in ipairs(actionButtons) do
                            TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                                TextTransparency = 0
                            }):Play()
                            wait(0.05)
                        end
                    end

                    
                    local closeConnection
                    if config.Duration > 0 then
                        closeConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
                            config.Duration = config.Duration - deltaTime
                            if config.Duration <= 0 then
                                closeConnection:Disconnect()
                                closeNotification()
                            end
                        end)
                    end

                    
                    return {
                        Close = function()
                            closeNotification()
                        end
                    }
                end)
            end

            
            function NotificationService:CloseAll()
                for i = #activeNotifications, 1, -1 do
                    local notifData = activeNotifications[i]
                    if notifData.close then
                        notifData.close()
                    end
                end
                activeNotifications = {}
            end
            function library:Notify(settings)
                return NotificationService:Notify(settings)
            end

            function library:CloseAllNotifications()
                NotificationService:CloseAll()
            end


            function main:Dropdown(text, old, options, mode, callback)
                assert(typeof(text) == "string", "text must be a string")
                assert(typeof(options) == "table", "options must be a table")
                assert(typeof(callback) == "function", "callback must be a function")
                mode = string.lower(mode or "single")
                local isMulti = (mode == "multi")

                
                local theme = {
                    Surface = _G.Surface,
                    Border = _G.Border,
                    TextPrimary = _G.TextPrimary,
                    TextSecondary = _G.TextSecondary,
                    Accent = _G.Accent,
                }

                
                local selections = isMulti and {} or nil
                if old ~= nil then
                    if isMulti then
                        selections = typeof(old) == "table" and old or {old}
                    else
                        selections = old
                    end
                end

                local isDropped = false
                local itemMap = {} 
                local allOptions = table.clone(options) 

                
                -- Modern Dropdown Container
                local Dropdown = Instance.new("Frame")
                Dropdown.Name = "Dropdown"
                Dropdown.AnchorPoint = Vector2.new(0.5, 0)
                Dropdown.BackgroundColor3 = theme.Surface
                Dropdown.BackgroundTransparency = 0.7
                Dropdown.Size = UDim2.new(0, elementWidth, 0, isMobileLayout and 38 or 44)
                Dropdown.ClipsDescendants = true
                Dropdown.Parent = MainFramePage

                local DropdownCorner = Instance.new("UICorner")
                DropdownCorner.CornerRadius = UDim.new(0, 10)
                DropdownCorner.Parent = Dropdown

                local DropdownStroke = Instance.new("UIStroke")
                DropdownStroke.Color = theme.Border
                DropdownStroke.Thickness = 1.5
                DropdownStroke.Transparency = 0.5
                DropdownStroke.Parent = Dropdown

                -- Dropdown Header
                local DropHeader = Instance.new("Frame")
                DropHeader.Name = "DropHeader"
                DropHeader.BackgroundTransparency = 1
                DropHeader.Size = UDim2.new(1, 0, 0, isMobileLayout and 38 or 44)
                DropHeader.Parent = Dropdown

                local DropTitle = Instance.new("TextLabel")
                DropTitle.Name = "DropTitle"
                DropTitle.BackgroundTransparency = 1
                DropTitle.Position = UDim2.fromOffset(isMobileLayout and 14 or 18, 0)
                DropTitle.Size = UDim2.new(0, isMobileLayout and 180 or 280, 1, 0)
                DropTitle.Font = Enum.Font.GothamSemibold
                DropTitle.TextColor3 = theme.TextPrimary
                DropTitle.TextSize = isMobileLayout and 13 or 15
                DropTitle.TextXAlignment = Enum.TextXAlignment.Left
                DropTitle.Parent = DropHeader

                -- Modern Chevron Icon
                local DropImage = Instance.new("ImageLabel")
                DropImage.Name = "DropImage"
                DropImage.BackgroundTransparency = 1
                DropImage.Position = UDim2.new(1, isMobileLayout and -32 or -38, 0.5, -8)
                DropImage.Size = UDim2.fromOffset(16, 16)
                DropImage.Image = "rbxassetid://6031090990"
                DropImage.ImageColor3 = theme.TextSecondary
                DropImage.Parent = DropHeader

                local DropButton = Instance.new("TextButton")
                DropButton.Name = "DropButton"
                DropButton.BackgroundTransparency = 1
                DropButton.Size = UDim2.new(1, 0, 1, 0)
                DropButton.Text = ""
                DropButton.Parent = DropHeader

                -- Container Hover Effect
                Dropdown.MouseEnter:Connect(function()
                    if not isDropped then
                        TweenService:Create(Dropdown, TweenInfo.new(0.2), {
                            BackgroundTransparency = 0.5
                        }):Play()
                        TweenService:Create(DropdownStroke, TweenInfo.new(0.2), {
                            Transparency = 0.3
                        }):Play()
                    end
                end)

                Dropdown.MouseLeave:Connect(function()
                    if not isDropped then
                        TweenService:Create(Dropdown, TweenInfo.new(0.2), {
                            BackgroundTransparency = 0.7
                        }):Play()
                        TweenService:Create(DropdownStroke, TweenInfo.new(0.2), {
                            Transparency = 0.5
                        }):Play()
                    end
                end)

                
                -- Modern Search Container
                local SearchContainer = Instance.new("Frame")
                SearchContainer.Name = "SearchContainer"
                SearchContainer.BackgroundTransparency = 1
                SearchContainer.Position = UDim2.fromOffset(isMobileLayout and 10 or 14, isMobileLayout and 44 or 50)
                SearchContainer.Size = UDim2.new(1, isMobileLayout and -20 or -28, 0, isMobileLayout and 30 or 36)
                SearchContainer.Visible = false
                SearchContainer.Parent = Dropdown

                -- Modern Search Input
                local SearchInputContainer = Instance.new("Frame")
                SearchInputContainer.Name = "SearchInputContainer"
                SearchInputContainer.Parent = SearchContainer
                SearchInputContainer.BackgroundColor3 = theme.SurfaceLight
                SearchInputContainer.BackgroundTransparency = 0.5
                SearchInputContainer.Size = UDim2.new(1, 0, 1, 0)
                SearchInputContainer.ClipsDescendants = true

                local SearchInputCorner = Instance.new("UICorner")
                SearchInputCorner.CornerRadius = UDim.new(0, 8)
                SearchInputCorner.Parent = SearchInputContainer

                local SearchInputStroke = Instance.new("UIStroke")
                SearchInputStroke.Color = theme.Border
                SearchInputStroke.Thickness = 1.5
                SearchInputStroke.Transparency = 0.5
                SearchInputStroke.Parent = SearchInputContainer

                -- Search Icon
                local SearchIcon = Instance.new("ImageLabel")
                SearchIcon.Name = "SearchIcon"
                SearchIcon.Parent = SearchInputContainer
                SearchIcon.BackgroundTransparency = 1
                SearchIcon.Position = UDim2.new(0, 10, 0.5, -8)
                SearchIcon.Size = UDim2.new(0, 16, 0, 16)
                SearchIcon.Image = "rbxassetid://10734950309"
                SearchIcon.ImageColor3 = theme.TextSecondary

                local SearchBox = Instance.new("TextBox")
                SearchBox.Name = "SearchBox"
                SearchBox.Parent = SearchInputContainer
                SearchBox.BackgroundTransparency = 1
                SearchBox.Position = UDim2.new(0, 32, 0, 0)
                SearchBox.Size = UDim2.new(1, -40, 1, 0)
                SearchBox.Font = Enum.Font.GothamMedium
                SearchBox.PlaceholderText = "Search options..."
                SearchBox.PlaceholderColor3 = theme.TextSecondary
                SearchBox.TextColor3 = theme.TextPrimary
                SearchBox.TextSize = isMobileLayout and 12 or 14
                SearchBox.Text = ""
                SearchBox.ClearTextOnFocus = false
                SearchBox.TextXAlignment = Enum.TextXAlignment.Left

                
                SearchBox.Focused:Connect(function()
                    TweenService:Create(SearchInputStroke, TweenInfo.new(0.2), {
                        Color = theme.Accent
                    }):Play()
                    TweenService:Create(SearchInputContainer, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.85
                    }):Play()
                end)

                SearchBox.FocusLost:Connect(function()
                    TweenService:Create(SearchInputStroke, TweenInfo.new(0.2), {
                        Color = theme.Border
                    }):Play()
                    TweenService:Create(SearchInputContainer, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.9
                    }):Play()
                end)

                
                SearchInputContainer.MouseEnter:Connect(function()
                    if not SearchBox:IsFocused() then
                        TweenService:Create(SearchInputStroke, TweenInfo.new(0.2), {
                            Color = Color3.fromRGB(100, 100, 100)
                        }):Play()
                    end
                end)

                SearchInputContainer.MouseLeave:Connect(function()
                    if not SearchBox:IsFocused() then
                        TweenService:Create(SearchInputStroke, TweenInfo.new(0.2), {
                            Color = theme.Border
                        }):Play()
                    end
                end)

                
                -- Modern Options Container
                local OptionsContainer = Instance.new("Frame")
                OptionsContainer.Name = "OptionsContainer"
                OptionsContainer.BackgroundTransparency = 1
                OptionsContainer.Position = UDim2.fromOffset(0, isMobileLayout and 80 or 92)
                OptionsContainer.Size = UDim2.new(1, 0, 0, 0)
                OptionsContainer.Visible = false
                OptionsContainer.ClipsDescendants = true
                OptionsContainer.Parent = Dropdown

                local DropScroll = Instance.new("ScrollingFrame")
                DropScroll.Name = "DropScroll"
                DropScroll.Active = true
                DropScroll.BackgroundTransparency = 1
                DropScroll.BorderSizePixel = 0
                DropScroll.Size = UDim2.new(1, 0, 1, 0)
                DropScroll.ScrollBarThickness = isMobileLayout and 4 or 6
                DropScroll.ScrollBarImageColor3 = theme.Border
                DropScroll.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
                DropScroll.ScrollingDirection = Enum.ScrollingDirection.Y
                DropScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropScroll.Parent = OptionsContainer

                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, isMobileLayout and 4 or 6)
                UIListLayout.Parent = DropScroll

                local UIPadding = Instance.new("UIPadding")
                UIPadding.PaddingLeft = UDim.new(0, isMobileLayout and 10 or 14)
                UIPadding.PaddingTop = UDim.new(0, isMobileLayout and 6 or 8)
                UIPadding.PaddingRight = UDim.new(0, isMobileLayout and 10 or 14)
                UIPadding.PaddingBottom = UDim.new(0, isMobileLayout and 6 or 8)
                UIPadding.Parent = DropScroll

                
                local TweenService = game:GetService("TweenService")

                local function updateTitle()
                    if isMulti then
                        if #selections == 0 then
                            DropTitle.Text = text .. " : "
                        elseif #selections == 1 then
                            DropTitle.Text = text .. " : " .. tostring(selections[1])
                        else
                            DropTitle.Text = text .. " : " .. #selections .. " selected"
                        end
                    else
                        DropTitle.Text = text .. " : " .. (selections and tostring(selections) or "")
                    end
                end

                local function isItemSelected(val)
                    if isMulti then
                        return table.find(selections, val) ~= nil
                    else
                        return selections == val
                    end
                end

                local function updateItemAppearance(button, isSelected)
                    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)
                    if isSelected then
                        TweenService:Create(button, tweenInfo, {
                            BackgroundTransparency = 0.7,
                            TextColor3 = theme.Accent
                        }):Play()
                    else
                        TweenService:Create(button, tweenInfo, {
                            BackgroundTransparency = 0.9,
                            TextColor3 = theme.TextPrimary
                        }):Play()
                    end
                end
                local createOption, refreshOptions
                createOption = function(value)
                    -- Modern Option Button
                    local button = Instance.new("TextButton")
                    button.Name = "Option_" .. tostring(value)
                    button.BackgroundColor3 = theme.SurfaceLight
                    button.BackgroundTransparency = 0.9
                    button.Size = UDim2.new(1, isMobileLayout and -10 or -20, 0, isMobileLayout and 32 or 38)
                    button.Font = Enum.Font.GothamMedium
                    button.Text = tostring(value)
                    button.TextColor3 = theme.TextPrimary
                    button.TextSize = isMobileLayout and 12 or 14
                    button.TextXAlignment = Enum.TextXAlignment.Left
                    button.TextYAlignment = Enum.TextYAlignment.Center
                    button.AutoButtonColor = false
                    button.Parent = DropScroll

                    local padding = Instance.new("UIPadding")
                    padding.PaddingLeft = UDim.new(0, 14)
                    padding.Parent = button

                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(0, 8)
                    corner.Parent = button

                    local stroke = Instance.new("UIStroke")
                    stroke.Color = theme.Border
                    stroke.Thickness = 1
                    stroke.Transparency = 0.6
                    stroke.Parent = button

                    -- Modern Hover Effects
                    button.MouseEnter:Connect(function()
                        if not isItemSelected(value) then
                            TweenService:Create(button, TweenInfo.new(0.2), {
                                BackgroundTransparency = 0.6,
                                TextColor3 = theme.Accent
                            }):Play()
                            TweenService:Create(stroke, TweenInfo.new(0.2), {
                                Transparency = 0.3
                            }):Play()
                        end
                    end)

                    button.MouseLeave:Connect(function()
                        if not isItemSelected(value) then
                            TweenService:Create(button, TweenInfo.new(0.2), {
                                BackgroundTransparency = 0.9,
                                TextColor3 = theme.TextPrimary
                            }):Play()
                            TweenService:Create(stroke, TweenInfo.new(0.2), {
                                Transparency = 0.6
                            }):Play()
                        end
                    end)

                    
                    local function updateItemAppearance(button, isSelected)
                        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)
                        local checkmark = button:FindFirstChild("Checkmark")
                        local stroke = button:FindFirstChildOfClass("UIStroke")

                        if isSelected then
                            if not checkmark then
                                checkmark = Instance.new("ImageLabel")
                                checkmark.Name = "Checkmark"
                                checkmark.BackgroundTransparency = 1
                                checkmark.Size = UDim2.new(0, 18, 0, 18)
                                checkmark.Position = UDim2.new(1, -32, 0.5, -9)
                                checkmark.Image = "rbxassetid://10709790644"
                                checkmark.ImageColor3 = theme.Accent
                                checkmark.Parent = button
                            end

                            TweenService:Create(button, tweenInfo, {
                                BackgroundTransparency = 0.5,
                                BackgroundColor3 = theme.Accent,
                                TextColor3 = Color3.fromRGB(255, 255, 255)
                            }):Play()
                            TweenService:Create(checkmark, tweenInfo, {
                                ImageTransparency = 0
                            }):Play()
                            if stroke then
                                TweenService:Create(stroke, tweenInfo, {
                                    Transparency = 0,
                                    Color = theme.Accent
                                }):Play()
                            end
                        else
                            if checkmark then
                                TweenService:Create(checkmark, tweenInfo, {
                                    ImageTransparency = 1
                                }):Play()
                                delay(0.2, function()
                                    if checkmark and checkmark.Parent then
                                        checkmark:Destroy()
                                    end
                                end)
                            end

                            TweenService:Create(button, tweenInfo, {
                                BackgroundTransparency = 0.9,
                                BackgroundColor3 = theme.SurfaceLight,
                                TextColor3 = theme.TextPrimary
                            }):Play()
                            if stroke then
                                TweenService:Create(stroke, tweenInfo, {
                                    Transparency = 0.6,
                                    Color = theme.Border
                                }):Play()
                            end
                        end
                    end

                    button.MouseButton1Click:Connect(function()
                        if isMulti then
                            local idx = table.find(selections, value)
                            if idx then
                                table.remove(selections, idx)
                            else
                                table.insert(selections, value)
                            end
                            callback(table.clone(selections))
                        else
                            selections = value
                            callback(selections)
                            isDropped = false
                            Dropdown:TweenSize(UDim2.new(0, elementWidth, 0, isMobileLayout and 32 or 36), 
                                Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                            DropImage.Rotation = 0
                            SearchContainer.Visible = false
                            OptionsContainer.Visible = false
                        end
                        if isMulti and isDropped then
                            local currentFilter = SearchBox.Text
                            refreshOptions(currentFilter)
                        else
                            for _, data in pairs(itemMap) do
                                updateItemAppearance(data.Button, isItemSelected(data.Value))
                            end
                        end
                    updateTitle()
                end)

                    itemMap[value] = {Button = button, Value = value}
                    updateItemAppearance(button, isItemSelected(value))
                end

                local function clearOptions()
                    for _, child in ipairs(DropScroll:GetChildren()) do
                        if child.Name:find("Option_") or child.Name:find("Separator_") then
                            child:Destroy()
                        end
                    end
                    itemMap = {}
                    DropScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
                end

                local function updateScrollSize()
                    if DropScroll and DropScroll.Parent then
                        local totalHeight = 0
                        local childCount = 0
                        for _, child in ipairs(DropScroll:GetChildren()) do
                            if child:IsA("GuiObject") and child.Name:find("Option_") then
                                totalHeight = totalHeight + child.AbsoluteSize.Y + UIListLayout.Padding.Offset
                                childCount = childCount + 1
                            end
                        end
                        if childCount > 0 then
                            totalHeight = totalHeight + (isMobileLayout and 5 or 10)
                        end
                        DropScroll.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
                    end
                end
                UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    updateScrollSize()
                end)

                refreshOptions = function(filter)
                    clearOptions()
                    local filtered = {}
                    filter = filter and string.lower(tostring(filter)) or ""
                    local selectedItems = {}
                    local unselectedItems = {}
                
                    for _, opt in ipairs(allOptions) do
                        local optStr = tostring(opt)
                        if filter == "" or string.lower(optStr):find(filter, 1, true) then
                            if isItemSelected(opt) then
                                table.insert(selectedItems, opt)
                            else
                                table.insert(unselectedItems, opt)
                            end
                        end
                    end
                    if #selectedItems > 0 then
                        local separator = Instance.new("TextLabel")
                        separator.Name = "Separator_Selected"
                        separator.BackgroundTransparency = 1
                        separator.Size = UDim2.new(1, isMobileLayout and -10 or -20, 0, isMobileLayout and 20 or 25)
                        separator.Font = Enum.Font.GothamMedium
                        separator.Text = "  SELECTED (" .. #selectedItems .. ")"
                        separator.TextColor3 = theme.Accent
                        separator.TextSize = isMobileLayout and 10 or 12
                        separator.TextXAlignment = Enum.TextXAlignment.Left
                        separator.Parent = DropScroll
                        local underline = Instance.new("Frame")
                        underline.Name = "Underline"
                        underline.BackgroundColor3 = theme.Accent
                        underline.BackgroundTransparency = 0.5
                        underline.BorderSizePixel = 0
                        underline.Position = UDim2.new(0, 10, 1, -2)
                        underline.Size = UDim2.new(1, -20, 0, 1)
                        underline.Parent = separator
                    end
                    for _, opt in ipairs(selectedItems) do
                        createOption(opt)
                    end
                    if #selectedItems > 0 and #unselectedItems > 0 then
                        local separator = Instance.new("TextLabel")
                        separator.Name = "Separator_All"
                        separator.BackgroundTransparency = 1
                        separator.Size = UDim2.new(1, isMobileLayout and -10 or -20, 0, isMobileLayout and 20 or 25)
                        separator.Font = Enum.Font.GothamMedium
                        separator.Text = "  ALL ITEMS"
                        separator.TextColor3 = theme.TextSecondary
                        separator.TextSize = isMobileLayout and 10 or 12
                        separator.TextXAlignment = Enum.TextXAlignment.Left
                        separator.Parent = DropScroll
                        local underline = Instance.new("Frame")
                        underline.Name = "Underline"
                        underline.BackgroundColor3 = theme.TextSecondary
                        underline.BackgroundTransparency = 0.7
                        underline.BorderSizePixel = 0
                        underline.Position = UDim2.new(0, 10, 1, -2)
                        underline.Size = UDim2.new(1, -20, 0, 1)
                        underline.Parent = separator
                    end
                    for _, opt in ipairs(unselectedItems) do
                        createOption(opt)
                    end
                    task.wait(0.01)
                    
                    if OptionsContainer and OptionsContainer.Parent then
                        local itemHeight = isMobileLayout and 28 or 35
                        local separatorHeight = isMobileLayout and 25 or 30
                        local maxVisibleItems = 5
                        local minVisibleItems = 1
                        local totalItemCount = #selectedItems + #unselectedItems
                        local separatorCount = 0
                        if #selectedItems > 0 then separatorCount = separatorCount + 1 end
                        if #selectedItems > 0 and #unselectedItems > 0 then separatorCount = separatorCount + 1 end
                        
                        local visibleItems = math.clamp(totalItemCount, minVisibleItems, maxVisibleItems)
                        local containerHeight = (visibleItems * itemHeight) + (separatorCount * separatorHeight) + (isMobileLayout and 10 or 15)
                        OptionsContainer.Size = UDim2.new(1, 0, 0, containerHeight)
                        local totalCanvasHeight = (totalItemCount * itemHeight) + (separatorCount * separatorHeight) + (isMobileLayout and 10 or 15)
                        DropScroll.CanvasSize = UDim2.new(0, 0, 0, totalCanvasHeight)
                        if isDropped then
                            local dropdownHeight = (isMobileLayout and 32 or 36) + (isMobileLayout and 30 or 35) + containerHeight + 5
                            Dropdown:TweenSize(UDim2.new(0, elementWidth, 0, dropdownHeight), 
                                Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                        end
                    end
                end

                

                
                SearchBox.Changed:Connect(function(prop)
                    if prop == "Text" then
                        refreshOptions(SearchBox.Text)
                    end
                end)

                
                DropButton.MouseButton1Click:Connect(function()
                    isDropped = not isDropped
                    if isDropped then
                        SearchContainer.Visible = true
                        OptionsContainer.Visible = true
                        local itemHeight = isMobileLayout and 32 or 38
                        local initialHeight = 3 * itemHeight + (isMobileLayout and 16 or 20)

                        OptionsContainer.Size = UDim2.new(1, 0, 0, initialHeight)

                        local dropdownHeight = (isMobileLayout and 38 or 44) + (isMobileLayout and 36 or 42) + initialHeight + 8

                        Dropdown:TweenSize(UDim2.new(0, elementWidth, 0, dropdownHeight),
                            Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
                        TweenService:Create(DropImage, TweenInfo.new(0.25), {Rotation = 180}):Play()
                        TweenService:Create(Dropdown, TweenInfo.new(0.25), {
                            BackgroundTransparency = 0.4
                        }):Play()
                        TweenService:Create(DropdownStroke, TweenInfo.new(0.25), {
                            Color = theme.Accent,
                            Transparency = 0.2
                        }):Play()

                        refreshOptions("")
                        task.delay(0.05, function()
                            if SearchBox and SearchBox.Parent then
                                SearchBox:CaptureFocus()
                            end
                        end)
                    else
                        Dropdown:TweenSize(UDim2.new(0, elementWidth, 0, isMobileLayout and 38 or 44),
                            Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
                        TweenService:Create(DropImage, TweenInfo.new(0.25), {Rotation = 0}):Play()
                        TweenService:Create(Dropdown, TweenInfo.new(0.25), {
                            BackgroundTransparency = 0.7
                        }):Play()
                        TweenService:Create(DropdownStroke, TweenInfo.new(0.25), {
                            Color = theme.Border,
                            Transparency = 0.5
                        }):Play()
                        SearchContainer.Visible = false
                        OptionsContainer.Visible = false
                    end
                end)

                
                local inputBeganConn
                inputBeganConn = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed or input.UserInputType ~= Enum.UserInputType.MouseButton1 or not isDropped then
                        return
                    end

                    local mousePos = game:GetService("UserInputService"):GetMouseLocation()
                    local absPos = Dropdown.AbsolutePosition
                    local absSize = Dropdown.AbsoluteSize
                    local inBounds = (
                        mousePos.X >= absPos.X and mousePos.X <= absPos.X + absSize.X and
                        mousePos.Y >= absPos.Y and mousePos.Y <= absPos.Y + absSize.Y
                    )

                    if not inBounds then
                        isDropped = false
                        Dropdown:TweenSize(UDim2.new(0, elementWidth, 0, isMobileLayout and 32 or 36), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                        DropImage.Rotation = 0
                        SearchContainer.Visible = false
                        OptionsContainer.Visible = false
                    end
                end)

                
                Dropdown.AncestryChanged:Connect(function()
                    if not Dropdown.Parent then
                        if inputBeganConn then
                            inputBeganConn:Disconnect()
                            inputBeganConn = nil
                        end
                    end
                end)

                
                updateTitle()
                refreshOptions("")

                
                local api = {}

                function api:Get()
                    return isMulti and table.clone(selections) or selections
                end

                function api:Set(val)
                    if isMulti then
                        selections = typeof(val) == "table" and table.clone(val) or {val}
                    else
                        selections = val
                    end

                    
                    for _, data in pairs(itemMap) do
                        updateItemAppearance(data.Button, isItemSelected(data.Value))
                    end

                    updateTitle()
                    callback(api:Get())
                end

                function api:Add(value)
                    if table.find(allOptions, value) then return end 
                    table.insert(allOptions, value)
                    if isDropped then
                        refreshOptions(SearchBox.Text)
                    end
                end

                function api:Remove(value)
                    local idx = table.find(allOptions, value)
                    if idx then
                        table.remove(allOptions, idx)
                    end

                    if isMulti then
                        local selIdx = table.find(selections, value)
                        if selIdx then
                            table.remove(selections, selIdx)
                        end
                    elseif selections == value then
                        selections = nil
                    end

                    if isDropped then
                        refreshOptions(SearchBox.Text)
                    end

                    updateTitle()
                    callback(api:Get())
                end

                function api:Clear()
                    selections = isMulti and {} or nil
                    allOptions = {}
                    clearOptions()
                    updateTitle()
                    callback(api:Get())
                end

                function api:Refresh(newOpts)
                    if newOpts then
                        assert(typeof(newOpts) == "table", "newOpts must be a table")
                        allOptions = table.clone(newOpts)
                    end
                    if isDropped then
                        refreshOptions(SearchBox.Text)
                    end
                end

                function api:GetOptions()
                    return table.clone(allOptions)
                end

                return api
            end

            function main:Textbox(text, placeholder, callback)
                -- Modern Textbox Container
                local Textbox = Instance.new("Frame")
                Textbox.Name = "Textbox"
                Textbox.Parent = MainFramePage
                Textbox.BackgroundColor3 = _G.SurfaceLight
                Textbox.BackgroundTransparency = 0.7
                Textbox.Size = UDim2.new(0, elementWidth, 0, isMobileLayout and 44 or 52)

                local TextboxCorner = Instance.new("UICorner")
                TextboxCorner.CornerRadius = UDim.new(0, 10)
                TextboxCorner.Parent = Textbox

                local TextboxStroke = Instance.new("UIStroke")
                TextboxStroke.Parent = Textbox
                TextboxStroke.Color = _G.Border
                TextboxStroke.Thickness = 1
                TextboxStroke.Transparency = 0.5

                local Label = Instance.new("TextLabel")
                Label.Name = "Label"
                Label.Parent = Textbox
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, isMobileLayout and 14 or 18, 0, 0)
                Label.Size = UDim2.new(0, isMobileLayout and 100 or 130, 1, 0)
                Label.Font = Enum.Font.GothamSemibold
                Label.Text = text
                Label.TextColor3 = _G.TextPrimary
                Label.TextSize = isMobileLayout and 12 or 14
                Label.TextXAlignment = Enum.TextXAlignment.Left

                -- Modern Input Container
                local InputContainer = Instance.new("Frame")
                InputContainer.Name = "InputContainer"
                InputContainer.Parent = Textbox
                InputContainer.BackgroundColor3 = _G.Surface
                InputContainer.BackgroundTransparency = 0.4
                InputContainer.Position = UDim2.new(0, isMobileLayout and 110 or 150, 0.5, -14)
                InputContainer.Size = UDim2.new(0, elementWidth - (isMobileLayout and 125 or 170), 0, 28)
                InputContainer.ClipsDescendants = true

                local InputContainerCorner = Instance.new("UICorner")
                InputContainerCorner.CornerRadius = UDim.new(0, 8)
                InputContainerCorner.Parent = InputContainer

                local InputContainerStroke = Instance.new("UIStroke")
                InputContainerStroke.Parent = InputContainer
                InputContainerStroke.Color = _G.Border
                InputContainerStroke.Thickness = 1.5
                InputContainerStroke.Transparency = 0.6

                local Input = Instance.new("TextBox")
                Input.Name = "Input"
                Input.Parent = InputContainer
                Input.BackgroundTransparency = 1
                Input.Position = UDim2.new(0, 12, 0, 0)
                Input.Size = UDim2.new(1, -24, 1, 0)
                Input.Font = Enum.Font.GothamMedium
                Input.PlaceholderText = placeholder or ""
                Input.PlaceholderColor3 = _G.TextMuted
                Input.Text = ""
                Input.TextColor3 = _G.TextPrimary
                Input.TextSize = isMobileLayout and 12 or 14
                Input.ClearTextOnFocus = false
                Input.TextXAlignment = Enum.TextXAlignment.Left

                local isFocused = false

                -- Container Hover Effect
                Textbox.MouseEnter:Connect(function()
                    TweenService:Create(Textbox, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.5
                    }):Play()
                    TweenService:Create(TextboxStroke, TweenInfo.new(0.2), {
                        Transparency = 0.3
                    }):Play()
                end)

                Textbox.MouseLeave:Connect(function()
                    TweenService:Create(Textbox, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.7
                    }):Play()
                    TweenService:Create(TextboxStroke, TweenInfo.new(0.2), {
                        Transparency = 0.5
                    }):Play()
                end)

                Input.Focused:Connect(function()
                    isFocused = true
                    TweenService:Create(InputContainerStroke, TweenInfo.new(0.2), {
                        Color = _G.Accent,
                        Transparency = 0.2
                    }):Play()
                    TweenService:Create(InputContainer, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.2
                    }):Play()
                    TweenService:Create(TextboxStroke, TweenInfo.new(0.2), {
                        Color = _G.Accent
                    }):Play()
                end)

                Input.FocusLost:Connect(function()
                    isFocused = false
                    TweenService:Create(InputContainerStroke, TweenInfo.new(0.2), {
                        Color = _G.Border,
                        Transparency = 0.6
                    }):Play()
                    TweenService:Create(InputContainer, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.4
                    }):Play()
                    TweenService:Create(TextboxStroke, TweenInfo.new(0.2), {
                        Color = _G.Border
                    }):Play()
                    pcall(callback, Input.Text)
                end)

                InputContainer.MouseEnter:Connect(function()
                    if not isFocused then
                        TweenService:Create(InputContainerStroke, TweenInfo.new(0.2), {
                            Color = _G.BorderHighlight,
                            Transparency = 0.4
                        }):Play()
                    end
                end)

                InputContainer.MouseLeave:Connect(function()
                    if not isFocused then
                        TweenService:Create(InputContainerStroke, TweenInfo.new(0.2), {
                            Color = _G.Border,
                            Transparency = 0.6
                        }):Play()
                    end
                end)

                
                local TextboxObject = {}

                function TextboxObject:Set(newText)
                    Input.Text = tostring(newText or "")
                    return TextboxObject
                end

                function TextboxObject:Get()
                    return Input.Text
                end

                function TextboxObject:SetPlaceholder(newPlaceholder)
                    Input.PlaceholderText = newPlaceholder or ""
                    return TextboxObject
                end

                function TextboxObject:Clear()
                    Input.Text = ""
                    return TextboxObject
                end

                function TextboxObject:Focus()
                    Input:CaptureFocus()
                    return TextboxObject
                end

                function TextboxObject:SetTextColor(color)
                    Input.TextColor3 = color
                    return TextboxObject
                end

                function TextboxObject:SetPlaceholderColor(color)
                    Input.PlaceholderColor3 = color
                    return TextboxObject
                end

                return TextboxObject
            end

            function main:Label(text)
                -- Modern Label
                local Label = Instance.new("TextLabel")
                Label.Name = "Label"
                Label.Parent = MainFramePage
                Label.BackgroundTransparency = 1
                Label.Size = UDim2.new(0, elementWidth, 0, isMobileLayout and 30 or 36)
                Label.Font = Enum.Font.GothamBold
                Label.Text = text
                Label.TextColor3 = _G.TextPrimary
                Label.TextSize = isMobileLayout and 14 or 16
                Label.TextXAlignment = Enum.TextXAlignment.Center

                local LabelObject = {}
                function LabelObject:Set(newText)
                    Label.Text = newText
                end
                function LabelObject:Get()
                    return Label.Text
                end
                return LabelObject
            end

            function main:Seperator(text)
                -- Modern Separator with Gradient
                local Seperator = Instance.new("Frame")
                Seperator.Name = "Seperator"
                Seperator.Parent = MainFramePage
                Seperator.BackgroundTransparency = 1
                Seperator.Size = UDim2.new(0, elementWidth, 0, isMobileLayout and 24 or 28)

                -- Left Line with Gradient
                local Line1 = Instance.new("Frame")
                Line1.Name = "Line1"
                Line1.Parent = Seperator
                Line1.BackgroundColor3 = _G.Border
                Line1.BorderSizePixel = 0
                Line1.AnchorPoint = Vector2.new(0, 0.5)
                Line1.Position = UDim2.new(0, 0, 0.5, 0)
                Line1.Size = UDim2.new(0.35, -15, 0, 2)

                local Line1Corner = Instance.new("UICorner")
                Line1Corner.CornerRadius = UDim.new(0, 1)
                Line1Corner.Parent = Line1

                -- Label with Accent Color
                local Label = Instance.new("TextLabel")
                Label.Name = "Label"
                Label.Parent = Seperator
                Label.BackgroundTransparency = 1
                Label.AnchorPoint = Vector2.new(0.5, 0.5)
                Label.Position = UDim2.new(0.5, 0, 0.5, 0)
                Label.Size = UDim2.new(0, isMobileLayout and 120 or 160, 1, 0)
                Label.Font = Enum.Font.GothamBold
                Label.Text = text
                Label.TextColor3 = _G.Accent
                Label.TextSize = isMobileLayout and 11 or 13
                Label.TextXAlignment = Enum.TextXAlignment.Center

                -- Right Line with Gradient
                local Line2 = Instance.new("Frame")
                Line2.Name = "Line2"
                Line2.Parent = Seperator
                Line2.BackgroundColor3 = _G.Border
                Line2.BorderSizePixel = 0
                Line2.AnchorPoint = Vector2.new(1, 0.5)
                Line2.Position = UDim2.new(1, 0, 0.5, 0)
                Line2.Size = UDim2.new(0.35, -15, 0, 2)

                local Line2Corner = Instance.new("UICorner")
                Line2Corner.CornerRadius = UDim.new(0, 1)
                Line2Corner.Parent = Line2
            end
            return main
        end
        return uitab
    end
end
return library
