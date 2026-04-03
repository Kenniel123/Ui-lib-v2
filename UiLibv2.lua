local library = {}
library.__index = library

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- 🔥 BETTER THEME (softer + glow feel)
local Theme = {
    Background = Color3.fromRGB(10, 10, 14),
    Surface = Color3.fromRGB(22, 22, 28),

    Border = Color3.fromRGB(60, 60, 75),
    SoftStroke = Color3.fromRGB(255, 255, 255), -- 🔥 WHITE OUTLINE

    Accent = Color3.fromRGB(120, 140, 255),

    TextPrimary = Color3.fromRGB(240, 240, 245),
    TextSecondary = Color3.fromRGB(170, 170, 180)
}

-- CREATE
local function Create(class, props)
    local obj = Instance.new(class)
    for i, v in pairs(props) do
        pcall(function()
            obj[i] = v
        end)
    end
    return obj
end

-- CORNER
local function ApplyCorner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = obj
end

-- 🔥 GLOW STROKE (MAIN CHANGE)
local function ApplyStroke(obj)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.SoftStroke
    stroke.Transparency = 0.85 -- soft white outline
    stroke.Thickness = 1
    stroke.Parent = obj
    return stroke
end

-- TWEEN
local function Tween(obj, props, t)
    TweenService:Create(
        obj,
        TweenInfo.new(t or 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        props
    ):Play()
end

-- SAFE CLICK
local function SafeClick(obj, cb)
    if obj:IsA("TextButton") then
        obj.MouseButton1Click:Connect(cb)
    end
end

function library:CreateWindow(title)
    local self = setmetatable({}, library)

    local gui = Create("ScreenGui", {
        Parent = game.CoreGui,
        Name = "RevampedUI"
    })

    local main = Create("Frame", {
        Parent = gui,
        Size = UDim2.fromOffset(600, 420),
        Position = UDim2.new(0.5, -300, 0.5, -210),
        BackgroundColor3 = Theme.Background
    })
    ApplyCorner(main, 14)
    ApplyStroke(main)

    -- HEADER
    local header = Create("TextLabel", {
        Parent = main,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1,
        Text = title or "Revamped UI",
        Font = Enum.Font.GothamSemibold,
        TextSize = 16,
        TextColor3 = Theme.TextPrimary
    })

    -- 🔥 SIDEBAR
    local sidebar = Create("Frame", {
        Parent = main,
        Size = UDim2.fromOffset(160, 1),
        BackgroundColor3 = Theme.Surface
    })
    ApplyStroke(sidebar)

    -- 🔍 SEARCH BAR
    local search = Create("TextBox", {
        Parent = sidebar,
        Size = UDim2.new(1, -10, 0, 30),
        Position = UDim2.fromOffset(5, 45),
        PlaceholderText = "Search...",
        Text = "",
        BackgroundColor3 = Theme.Background,
        TextColor3 = Theme.TextPrimary,
        Font = Enum.Font.Gotham,
        TextSize = 13
    })
    ApplyCorner(search, 8)
    ApplyStroke(search)

    local tabHolder = Create("Frame", {
        Parent = sidebar,
        Position = UDim2.fromOffset(0, 85),
        Size = UDim2.new(1, 0, 1, -85),
        BackgroundTransparency = 1
    })

    Create("UIListLayout", {
        Parent = tabHolder,
        Padding = UDim.new(0, 6)
    })

    -- CONTENT
    local content = Create("Frame", {
        Parent = main,
        Position = UDim2.fromOffset(170, 45),
        Size = UDim2.new(1, -180, 1, -55),
        BackgroundTransparency = 1
    })

    self.Gui = gui
    self.Main = main
    self.Sidebar = tabHolder
    self.Content = content
    self.Tabs = {}

    return self
end

function library:CreateTab(name)
    local page = Create("Frame", {
        Parent = self.Content,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = false,
        BackgroundTransparency = 1
    })

    Create("UIListLayout", {
        Parent = page,
        Padding = UDim.new(0, 8)
    })

    local button = Create("TextButton", {
        Parent = self.Sidebar,
        Size = UDim2.new(1, -10, 0, 30),
        BackgroundColor3 = Theme.Surface,
        Text = name,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextColor3 = Theme.TextSecondary,
        AutoButtonColor = false
    })
    ApplyCorner(button, 8)
    local stroke = ApplyStroke(button)

    SafeClick(button, function()
        for _, t in pairs(self.Tabs) do
            t.Page.Visible = false
            Tween(t.Button, {TextColor3 = Theme.TextSecondary})
        end

        page.Visible = true
        Tween(button, {TextColor3 = Theme.TextPrimary})
    end)

    table.insert(self.Tabs, {
        Button = button,
        Page = page
    })

    if #self.Tabs == 1 then
        page.Visible = true
        button.TextColor3 = Theme.TextPrimary
    end

    local tab = setmetatable({}, library)
    tab.Container = page

    return tab
end

function library:Button(text, callback)
    local btn = Create("TextButton", {
        Parent = self.Container,
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Theme.Surface,
        Text = "",
        AutoButtonColor = false
    })

    ApplyCorner(btn, 10)
    local stroke = ApplyStroke(btn)

    local label = Create("TextLabel", {
        Parent = btn,
        Size = UDim2.new(1, -10, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary
    })

    btn.MouseEnter:Connect(function()
        Tween(stroke, {Transparency = 0.6})
    end)

    btn.MouseLeave:Connect(function()
        Tween(stroke, {Transparency = 0.85})
    end)

    SafeClick(btn, function()
        if callback then pcall(callback) end
    end)
end

function library:Toggle(text, default, callback)
    local state = default or false

    local frame = Create("Frame", {
        Parent = self.Container,
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Theme.Surface
    })
    ApplyCorner(frame, 10)
    local stroke = ApplyStroke(frame)

    local label = Create("TextLabel", {
        Parent = frame,
        Size = UDim2.new(1, -60, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local toggle = Create("Frame", {
        Parent = frame,
        Size = UDim2.fromOffset(40, 18),
        Position = UDim2.new(1, -50, 0.5, -9),
        BackgroundColor3 = state and Theme.Accent or Theme.Border
    })
    ApplyCorner(toggle, 20)

    local knob = Create("Frame", {
        Parent = toggle,
        Size = UDim2.fromOffset(14, 14),
        Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
        BackgroundColor3 = Color3.new(1,1,1)
    })
    ApplyCorner(knob, 20)

    local function set(val)
        state = val

        Tween(toggle, {
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
        Parent = frame,
        Size = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        Text = ""
    })

    SafeClick(click, function()
        set(not state)
    end)

    frame.MouseEnter:Connect(function()
        Tween(stroke, {Transparency = 0.6})
    end)

    frame.MouseLeave:Connect(function()
        Tween(stroke, {Transparency = 0.85})
    end)

    return {
        Set = set,
        Get = function() return state end
    }
end

function library:Slider(text, min, max, default, callback)
    local value = default or min

    local frame = Create("Frame", {
        Parent = self.Container,
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1
    })

    local label = Create("TextLabel", {
        Parent = frame,
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = text .. " : " .. value,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local bar = Create("Frame", {
        Parent = frame,
        Position = UDim2.fromOffset(0, 28),
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

    local function set(x)
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
            set(input.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            set(input.Position.X)
        end
    end)

    return {
        Set = function(v)
            local percent = (v - min) / (max - min)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            label.Text = text .. " : " .. v
        end
    }
end

function library:Dropdown(text, options, callback)
    local selected
    local opened = false

    local frame = Create("Frame", {
        Parent = self.Container,
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = Theme.Surface,
        ClipsDescendants = true
    })
    ApplyCorner(frame, 10)
    local stroke = ApplyStroke(frame)

    local label = Create("TextLabel", {
        Parent = frame,
        Size = UDim2.new(1, -30, 1, 0),
        BackgroundTransparency = 1,
        Text = text .. " : ",
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local arrow = Create("TextLabel", {
        Parent = frame,
        Size = UDim2.fromOffset(20,20),
        Position = UDim2.new(1,-25,0.5,-10),
        BackgroundTransparency = 1,
        Text = "⌄",
        TextSize = 18,
        TextColor3 = Theme.TextSecondary
    })

    local container = Create("Frame", {
        Parent = frame,
        Position = UDim2.fromOffset(0,38),
        Size = UDim2.new(1,0,0,0),
        BackgroundTransparency = 1
    })

    local layout = Create("UIListLayout", {
        Parent = container,
        Padding = UDim.new(0,6)
    })

    local function make(opt)
        local btn = Create("TextButton", {
            Parent = container,
            Size = UDim2.new(1, -6, 0, 30),
            BackgroundColor3 = Theme.Surface,
            Text = tostring(opt),
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextColor3 = Theme.TextPrimary,
            AutoButtonColor = false
        })
        ApplyCorner(btn, 8)
        local s = ApplyStroke(btn)

        btn.MouseEnter:Connect(function()
            Tween(s, {Transparency = 0.6})
        end)

        btn.MouseLeave:Connect(function()
            Tween(s, {Transparency = 0.85})
        end)

        SafeClick(btn, function()
            selected = opt
            label.Text = text .. " : " .. tostring(opt)

            if callback then
                pcall(callback, opt)
            end

            opened = false
            Tween(frame, {Size = UDim2.new(1,0,0,38)})
            Tween(arrow, {Rotation = 0})
        end)
    end

    for _,v in ipairs(options) do
        make(v)
    end

    task.defer(function()
        container.Size = UDim2.new(1,0,0,layout.AbsoluteContentSize.Y)
    end)

    local click = Create("TextButton", {
        Parent = frame,
        Size = UDim2.new(1,0,0,38),
        BackgroundTransparency = 1,
        Text = ""
    })

    SafeClick(click, function()
        opened = not opened

        Tween(frame, {
            Size = opened and UDim2.new(1,0,0,38 + container.AbsoluteSize.Y) or UDim2.new(1,0,0,38)
        })

        Tween(arrow, {Rotation = opened and 180 or 0})
    end)

    return frame
end

function library:Textbox(text, placeholder, callback)
    local frame = Create("Frame", {
        Parent = self.Container,
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Theme.Surface
    })
    ApplyCorner(frame, 10)
    local stroke = ApplyStroke(frame)

    local label = Create("TextLabel", {
        Parent = frame,
        Size = UDim2.new(0.4, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local box = Create("TextBox", {
        Parent = frame,
        Size = UDim2.new(0.6, -10, 1, -10),
        Position = UDim2.new(0.4, 5, 0, 5),
        BackgroundTransparency = 1,
        PlaceholderText = placeholder or "",
        Text = "",
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Theme.TextPrimary
    })

    box.FocusLost:Connect(function()
        if callback then
            pcall(callback, box.Text)
        end
    end)

    frame.MouseEnter:Connect(function()
        Tween(stroke, {Transparency = 0.6})
    end)

    frame.MouseLeave:Connect(function()
        Tween(stroke, {Transparency = 0.85})
    end)

    return box
end

function library:Notify(title, text, duration)
    duration = duration or 3

    if not self.NotifHolder then
        self.NotifHolder = Create("Frame", {
            Parent = self.Gui,
            Size = UDim2.new(0, 260, 1, -20),
            Position = UDim2.new(1, -10, 0, 10),
            AnchorPoint = Vector2.new(1,0),
            BackgroundTransparency = 1
        })

        Create("UIListLayout", {
            Parent = self.NotifHolder,
            Padding = UDim.new(0,8)
        })
    end

    local notif = Create("Frame", {
        Parent = self.NotifHolder,
        Size = UDim2.new(1,0,0,0),
        BackgroundColor3 = Theme.Surface
    })
    ApplyCorner(notif, 10)
    ApplyStroke(notif)

    local t = Create("TextLabel", {
        Parent = notif,
        Size = UDim2.new(1,-10,0,20),
        Position = UDim2.fromOffset(5,5),
        BackgroundTransparency = 1,
        Text = title,
        Font = Enum.Font.GothamSemibold,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local d = Create("TextLabel", {
        Parent = notif,
        Size = UDim2.new(1,-10,0,40),
        Position = UDim2.fromOffset(5,25),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextColor3 = Theme.TextSecondary,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    Tween(notif, {Size = UDim2.new(1,0,0,70)}, 0.25)

    task.delay(duration, function()
        Tween(notif, {Size = UDim2.new(1,0,0,0)}, 0.25)
        task.wait(0.25)
        notif:Destroy()
    end)
end

return library
