local library = {}
library.__index = library

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Theme = {
    Background = Color3.fromRGB(14, 14, 18),
    Surface = Color3.fromRGB(24, 24, 30),
    Border = Color3.fromRGB(45, 45, 55),

    Accent = Color3.fromRGB(99, 102, 241),

    TextPrimary = Color3.fromRGB(240, 240, 245),
    TextSecondary = Color3.fromRGB(160, 160, 170)
}

local function Create(class, props)
    local obj = Instance.new(class)

    for i, v in pairs(props) do
        local success, err = pcall(function()
            obj[i] = v
        end)

        if not success then
            warn("[UI LIB ERROR] Failed to set:", i, "on", class, err)
        end
    end

    return obj
end

local function ApplyCorner(obj, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = obj
    return corner
end

local function ApplyStroke(obj, color)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Border
    stroke.Thickness = 1
    stroke.Parent = obj
    return stroke
end

local function SafeClick(obj, callback)
    if obj:IsA("TextButton") or obj:IsA("ImageButton") then
        obj.MouseButton1Click:Connect(callback)
    else
        warn("[UI LIB] Tried to click non-button:", obj:GetFullName(), obj.ClassName)
    end
end

local function Tween(obj, props, time)
    TweenService:Create(
        obj,
        TweenInfo.new(time or 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        props
    ):Play()
end

function library:CreateWindow(title)
    local self = setmetatable({}, library)

    local gui = Create("ScreenGui", {
        Name = "ModernUI",
        Parent = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    local main = Create("Frame", {
        Parent = gui,
        Size = UDim2.fromOffset(520, 420),
        Position = UDim2.new(0.5, -260, 0.5, -210),
        BackgroundColor3 = Theme.Background
    })

    ApplyCorner(main, 12)
    ApplyStroke(main)

    local header = Create("Frame", {
        Parent = main,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1
    })

    local titleLabel = Create("TextLabel", {
        Parent = header,
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.fromOffset(10, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamSemibold,
        Text = title or "Modern UI",
        TextSize = 16,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local container = Create("Frame", {
        Parent = main,
        Position = UDim2.fromOffset(10, 50),
        Size = UDim2.new(1, -20, 1, -60),
        BackgroundTransparency = 1
    })

    Create("UIListLayout", {
        Parent = container,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    do
        local dragging = false
        local dragStart
        local startPos

        header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = main.Position
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart

                main.Position = startPos + UDim2.fromOffset(delta.X, delta.Y)
            end
        end)
    end

    self.Gui = gui
    self.Main = main
    self.Container = container

    return self
end

function library:Button(text, callback)
    local button = Create("TextButton", {
        Parent = self.Container,
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.9,
        Text = "",
        AutoButtonColor = false
    })

    ApplyCorner(button, 8)
    local stroke = ApplyStroke(button)

    local label = Create("TextLabel", {
        Parent = button,
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.fromOffset(10, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        Text = text or "Button",
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    button.MouseEnter:Connect(function()
        Tween(button, {BackgroundTransparency = 0.85})
        Tween(stroke, {Color = Theme.Accent})
    end)

    button.MouseLeave:Connect(function()
        Tween(button, {BackgroundTransparency = 0.9})
        Tween(stroke, {Color = Theme.Border})
    end)

    button.MouseButton1Down:Connect(function()
        Tween(button, {BackgroundTransparency = 0.75}, 0.1)
    end)

    button.MouseButton1Up:Connect(function()
        Tween(button, {BackgroundTransparency = 0.85}, 0.1)
    end)

    SafeClick(button, function()
        if callback then
            pcall(callback)
        end
    end)

    return button
end

function library:Toggle(text, default, callback)
    local state = default or false

    local toggle = Create("Frame", {
        Parent = self.Container,
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.9
    })

    ApplyCorner(toggle, 8)
    local stroke = ApplyStroke(toggle)

    local label = Create("TextLabel", {
        Parent = toggle,
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.fromOffset(10, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        Text = text or "Toggle",
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local switch = Create("Frame", {
        Parent = toggle,
        Size = UDim2.fromOffset(36, 18),
        Position = UDim2.new(1, -46, 0.5, -9),
        BackgroundColor3 = state and Theme.Accent or Theme.Border
    })

    ApplyCorner(switch, 20)

    local knob = Create("Frame", {
        Parent = switch,
        Size = UDim2.fromOffset(14, 14),
        Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
        BackgroundColor3 = Color3.fromRGB(255,255,255)
    })

    ApplyCorner(knob, 20)

    local function setState(val)
        state = val

        Tween(switch, {
            BackgroundColor3 = state and Theme.Accent or Theme.Border
        })

        Tween(knob, {
            Position = state 
                and UDim2.new(1, -16, 0.5, -7)
                or UDim2.new(0, 2, 0.5, -7)
        })

        if callback then
            pcall(callback, state)
        end
    end

    local click = Create("TextButton", {
        Parent = toggle,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = ""
    })

    SafeClick(click, function()
        setState(not state)
    end)

    toggle.MouseEnter:Connect(function()
        Tween(toggle, {BackgroundTransparency = 0.85})
        Tween(stroke, {Color = Theme.Accent})
    end)

    toggle.MouseLeave:Connect(function()
        Tween(toggle, {BackgroundTransparency = 0.9})
        Tween(stroke, {Color = Theme.Border})
    end)

    local api = {}

    function api:Set(val)
        setState(val)
    end

    function api:Get()
        return state
    end

    return api
end

function library:Dropdown(text, options, callback)
    local selected = nil
    local opened = false

    local dropdown = Create("Frame", {
        Parent = self.Container,
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.9,
        ClipsDescendants = true
    })

    ApplyCorner(dropdown, 10)
    local stroke = ApplyStroke(dropdown)

    local title = Create("TextLabel", {
        Parent = dropdown,
        Size = UDim2.new(1, -30, 1, 0),
        Position = UDim2.fromOffset(12, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        Text = text .. " : ",
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local arrow = Create("TextLabel", {
        Parent = dropdown,
        Size = UDim2.fromOffset(20, 20),
        Position = UDim2.new(1, -28, 0.5, -10),
        BackgroundTransparency = 1,
        Text = "⌄",
        TextSize = 18,
        TextColor3 = Theme.TextSecondary
    })

    local container = Create("Frame", {
        Parent = dropdown,
        Position = UDim2.fromOffset(0, 38),
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = 11
    })

    local layout = Create("UIListLayout", {
        Parent = container,
        Padding = UDim.new(0, 6)
    })

    -- CREATE OPTIONS
    local function createOption(opt)
        local btn = Create("TextButton", {
            Parent = container,
            Size = UDim2.new(1, -10, 0, 30),
            BackgroundColor3 = Theme.Surface,
            BackgroundTransparency = 0.9,
            Text = tostring(opt),
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextColor3 = Theme.TextPrimary,
            AutoButtonColor = false,
            ZIndex = 12
        })

        ApplyCorner(btn, 8)
        local optStroke = ApplyStroke(btn)

        btn.MouseEnter:Connect(function()
            Tween(btn, {BackgroundTransparency = 0.85})
            Tween(optStroke, {Color = Theme.Accent})
        end)

        btn.MouseLeave:Connect(function()
            Tween(btn, {BackgroundTransparency = 0.9})
            Tween(optStroke, {Color = Theme.Border})
        end)

        SafeClick(btn, function()
            selected = opt
            title.Text = text .. " : " .. tostring(opt)

            if callback then
                pcall(callback, opt)
            end

            opened = false

            Tween(dropdown, {
                Size = UDim2.new(1, 0, 0, 38)
            })

            Tween(arrow, {Rotation = 0})
        end)
    end

    for _, opt in ipairs(options) do
        createOption(opt)
    end

    -- FIX SIZE (NO MORE BUG)
    task.defer(function()
        container.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y)
    end)

    local click = Create("TextButton", {
        Parent = dropdown,
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 10
    })

    SafeClick(click, function()
        opened = not opened

        local newSize = opened and (38 + container.AbsoluteSize.Y) or 38

        Tween(dropdown, {
            Size = UDim2.new(1, 0, 0, newSize)
        })

        Tween(arrow, {
            Rotation = opened and 180 or 0
        })
    end)

    return dropdown
end

function library:Textbox(text, placeholder, callback)
    local box = Create("Frame", {
        Parent = self.Container,
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.9
    })

    ApplyCorner(box, 8)
    local stroke = ApplyStroke(box)

    local label = Create("TextLabel", {
        Parent = box,
        Size = UDim2.new(0.4, 0, 1, 0),
        Position = UDim2.fromOffset(10, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local input = Create("TextBox", {
        Parent = box,
        Size = UDim2.new(0.6, -15, 1, -10),
        Position = UDim2.new(0.4, 5, 0, 5),
        BackgroundTransparency = 1,
        Text = "",
        PlaceholderText = placeholder or "",
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Theme.TextPrimary
    })

    input.FocusLost:Connect(function()
        if callback then
            pcall(callback, input.Text)
        end
    end)

    return input
end

function library:Slider(text, min, max, default, callback)
    local value = default or min

    local slider = Create("Frame", {
        Parent = self.Container,
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1
    })

    local label = Create("TextLabel", {
        Parent = slider,
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = text .. " : " .. value,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local bar = Create("Frame", {
        Parent = slider,
        Position = UDim2.fromOffset(0, 25),
        Size = UDim2.new(1, 0, 0, 8),
        BackgroundColor3 = Theme.Border
    })

    ApplyCorner(bar, 10)

    local fill = Create("Frame", {
        Parent = bar,
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Theme.Accent
    })

    ApplyCorner(fill, 10)

    local dragging = false

    local function setValue(x)
        local percent = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        value = math.floor(min + (max - min) * percent)

        fill.Size = UDim2.new(percent, 0, 1, 0)
        label.Text = text .. " : " .. value

        if callback then
            pcall(callback, value)
        end
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            setValue(input.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            setValue(input.Position.X)
        end
    end)

    return slider
end

function library:CreateTab(name)
    if not self.Tabs then
        self.Tabs = {}

        self.TabButtons = Create("Frame", {
            Parent = self.Main,
            Position = UDim2.fromOffset(10, 40),
            Size = UDim2.new(1, -20, 0, 30),
            BackgroundTransparency = 1
        })

        Create("UIListLayout", {
            Parent = self.TabButtons,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, 6)
        })

        self.TabContainer = Create("Frame", {
            Parent = self.Main,
            Position = UDim2.fromOffset(10, 80),
            Size = UDim2.new(1, -20, 1, -90),
            BackgroundTransparency = 1
        })
    end

    local tabButton = Create("TextButton", {
        Parent = self.TabButtons,
        Size = UDim2.fromOffset(100, 30),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.9,
        Text = name,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextColor3 = Theme.TextSecondary,
        AutoButtonColor = false
    })

    ApplyCorner(tabButton, 6)
    local stroke = ApplyStroke(tabButton)

    local page = Create("Frame", {
        Parent = self.TabContainer,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false
    })

    Create("UIListLayout", {
        Parent = page,
        Padding = UDim.new(0, 8)
    })

    local tab = setmetatable({}, library)
    tab.Container = page
    tab.Main = self.Main

    SafeClick(tabButton, function()
        for _, t in pairs(self.Tabs) do
            t.Page.Visible = false
            Tween(t.Button, {BackgroundTransparency = 0.9})
            Tween(t.Button, {TextColor3 = Theme.TextSecondary})
        end

        page.Visible = true
        Tween(tabButton, {BackgroundTransparency = 0.7})
        Tween(tabButton, {TextColor3 = Theme.TextPrimary})
    end)

    table.insert(self.Tabs, {
        Button = tabButton,
        Page = page
    })

    -- AUTO SELECT FIRST TAB (FIXED)
    if #self.Tabs == 1 then
        page.Visible = true
        tabButton.BackgroundTransparency = 0.7
        tabButton.TextColor3 = Theme.TextPrimary
    end

    return tab
end

function library:Notify(title, text, duration)
    duration = duration or 3

    if not self.NotificationHolder then
        self.NotificationHolder = Create("Frame", {
            Parent = self.Gui,
            Size = UDim2.new(0, 300, 1, -20),
            Position = UDim2.new(1, -20, 0, 10),
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1
        })

        Create("UIListLayout", {
            Parent = self.NotificationHolder,
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    end

    local notif = Create("Frame", {
        Parent = self.NotificationHolder,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.1
    })

    ApplyCorner(notif, 8)
    ApplyStroke(notif)

    Create("TextLabel", {
        Parent = notif,
        Size = UDim2.new(1, -20, 0, 20),
        Position = UDim2.fromOffset(10, 8),
        BackgroundTransparency = 1,
        Text = title,
        Font = Enum.Font.GothamSemibold,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    Create("TextLabel", {
        Parent = notif,
        Size = UDim2.new(1, -20, 0, 40),
        Position = UDim2.fromOffset(10, 28),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextColor3 = Theme.TextSecondary,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    Tween(notif, {Size = UDim2.new(1, 0, 0, 70)}, 0.25)

    task.delay(duration, function()
        Tween(notif, {Size = UDim2.new(1, 0, 0, 0)}, 0.25)
        task.wait(0.25)
        notif:Destroy()
    end)
end

function library:EnableBlur()
    if self.Blur then return end

    local blur = Instance.new("BlurEffect")
    blur.Size = 12
    blur.Parent = game.Lighting

    self.Blur = blur
end

function library:DisableBlur()
    if self.Blur then
        self.Blur:Destroy()
        self.Blur = nil
    end
end

function library:SetTheme(newTheme)
    for k, v in pairs(newTheme) do
        Theme[k] = v
    end

    for _, obj in pairs(self.Gui:GetDescendants()) do
        if obj:IsA("Frame") then
            obj.BackgroundColor3 = Theme.Surface
        elseif obj:IsA("TextLabel") or obj:IsA("TextBox") then
            obj.TextColor3 = Theme.TextPrimary
        elseif obj:IsA("UIStroke") then
            obj.Color = Theme.Border
        end
    end
end

local HttpService = game:GetService("HttpService")

function library:SaveConfig(name, data)
    writefile(name .. ".json", HttpService:JSONEncode(data))
end

function library:LoadConfig(name)
    if isfile(name .. ".json") then
        return HttpService:JSONDecode(readfile(name .. ".json"))
    end
end

return library
