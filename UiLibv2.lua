local library = {}
library.__index = library

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

--// MODERN THEME (LIKE IMAGE)
local Theme = {
    Background = Color3.fromRGB(10, 10, 12),
    Surface = Color3.fromRGB(18, 18, 22),
    Surface2 = Color3.fromRGB(22, 22, 26),

    Border = Color3.fromRGB(255, 255, 255), -- soft white outline
    BorderTransparency = 0.85,

    Accent = Color3.fromRGB(255, 255, 255),

    TextPrimary = Color3.fromRGB(235, 235, 235),
    TextSecondary = Color3.fromRGB(140, 140, 140)
}

--// SAFE CREATE
local function Create(class, props)
    local obj = Instance.new(class)
    for i,v in pairs(props) do
        pcall(function()
            obj[i] = v
        end)
    end
    return obj
end

--// CORNER
local function ApplyCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 10)
    c.Parent = obj
    return c
end

--// SOFT OUTLINE (IMPORTANT)
local function ApplyStroke(obj)
    local s = Instance.new("UIStroke")
    s.Color = Theme.Border
    s.Transparency = Theme.BorderTransparency
    s.Thickness = 1
    s.Parent = obj
    return s
end

--// CLICK SAFE
local function SafeClick(obj, cb)
    if obj:IsA("TextButton") or obj:IsA("ImageButton") then
        obj.MouseButton1Click:Connect(cb)
    end
end

--// TWEEN
local function Tween(obj, props, t)
    TweenService:Create(
        obj,
        TweenInfo.new(t or 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        props
    ):Play()
end

function library:CreateWindow(title)
    local self = setmetatable({}, library)

    --// GUI
    local gui = Create("ScreenGui", {
        Name = "ModernUI",
        Parent = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    --// MAIN FRAME
    local main = Create("Frame", {
        Parent = gui,
        Size = UDim2.fromOffset(700, 420),
        Position = UDim2.new(0.5, -350, 0.5, -210),
        BackgroundColor3 = Theme.Background
    })
    ApplyCorner(main, 12)
    ApplyStroke(main)

    --// TOP BAR
    local top = Create("Frame", {
        Parent = main,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1
    })

    local titleLabel = Create("TextLabel", {
        Parent = top,
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(1, -100, 1, 0),
        BackgroundTransparency = 1,
        Text = title or "UI",
        Font = Enum.Font.GothamSemibold,
        TextSize = 15,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    --// CLOSE BUTTON
    local close = Create("TextButton", {
        Parent = top,
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(1, -35, 0.5, -15),
        BackgroundTransparency = 1,
        Text = "✕",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextSecondary
    })

    SafeClick(close, function()
        gui:Destroy()
    end)

    --// MINIMIZE BUTTON
    local minimize = Create("TextButton", {
        Parent = top,
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(1, -70, 0.5, -15),
        BackgroundTransparency = 1,
        Text = "—",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextSecondary
    })

    --// SIDEBAR
    local sidebar = Create("Frame", {
        Parent = main,
        Position = UDim2.fromOffset(0, 40),
        Size = UDim2.fromOffset(180, 380),
        BackgroundColor3 = Theme.Surface
    })
    ApplyStroke(sidebar)

    --// SEARCH BAR
    local searchBox = Create("TextBox", {
        Parent = sidebar,
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.fromOffset(10, 10),
        BackgroundColor3 = Theme.Surface2,
        PlaceholderText = "Search...",
        Text = "",
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Theme.TextPrimary
    })
    ApplyCorner(searchBox, 6)
    ApplyStroke(searchBox)

    --// TAB LIST
    local tabList = Create("Frame", {
        Parent = sidebar,
        Position = UDim2.fromOffset(0, 50),
        Size = UDim2.new(1, 0, 1, -50),
        BackgroundTransparency = 1
    })

    Create("UIListLayout", {
        Parent = tabList,
        Padding = UDim.new(0, 6)
    })

    --// MAIN CONTENT
    local content = Create("Frame", {
        Parent = main,
        Position = UDim2.fromOffset(190, 50),
        Size = UDim2.new(1, -200, 1, -60),
        BackgroundTransparency = 1
    })

    Create("UIListLayout", {
        Parent = content,
        Padding = UDim.new(0, 8)
    })

    --// MINIMIZE LOGIC
    local minimized = false
    SafeClick(minimize, function()
        minimized = not minimized
        content.Visible = not minimized
        sidebar.Visible = not minimized
    end)

    --// DRAG
    do
        local dragging, dragStart, startPos

        top.InputBegan:Connect(function(input)
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
    self.Sidebar = tabList
    self.Container = content
    self.Pages = {}

    return self
end

function library:CreateWindow(title)
    local self = setmetatable({}, library)

    --// GUI
    local gui = Create("ScreenGui", {
        Name = "ModernUI",
        Parent = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    --// MAIN FRAME
    local main = Create("Frame", {
        Parent = gui,
        Size = UDim2.fromOffset(700, 420),
        Position = UDim2.new(0.5, -350, 0.5, -210),
        BackgroundColor3 = Theme.Background
    })
    ApplyCorner(main, 12)
    ApplyStroke(main)

    --// TOP BAR
    local top = Create("Frame", {
        Parent = main,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1
    })

    local titleLabel = Create("TextLabel", {
        Parent = top,
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(1, -100, 1, 0),
        BackgroundTransparency = 1,
        Text = title or "UI",
        Font = Enum.Font.GothamSemibold,
        TextSize = 15,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    --// CLOSE BUTTON
    local close = Create("TextButton", {
        Parent = top,
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(1, -35, 0.5, -15),
        BackgroundTransparency = 1,
        Text = "✕",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextSecondary
    })

    SafeClick(close, function()
        gui:Destroy()
    end)

    --// MINIMIZE BUTTON
    local minimize = Create("TextButton", {
        Parent = top,
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(1, -70, 0.5, -15),
        BackgroundTransparency = 1,
        Text = "—",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextSecondary
    })

    --// SIDEBAR
    local sidebar = Create("Frame", {
        Parent = main,
        Position = UDim2.fromOffset(0, 40),
        Size = UDim2.fromOffset(180, 380),
        BackgroundColor3 = Theme.Surface
    })
    ApplyStroke(sidebar)

    --// SEARCH BAR
    local searchBox = Create("TextBox", {
        Parent = sidebar,
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.fromOffset(10, 10),
        BackgroundColor3 = Theme.Surface2,
        PlaceholderText = "Search...",
        Text = "",
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Theme.TextPrimary
    })
    ApplyCorner(searchBox, 6)
    ApplyStroke(searchBox)

    --// TAB LIST
    local tabList = Create("Frame", {
        Parent = sidebar,
        Position = UDim2.fromOffset(0, 50),
        Size = UDim2.new(1, 0, 1, -50),
        BackgroundTransparency = 1
    })

    Create("UIListLayout", {
        Parent = tabList,
        Padding = UDim.new(0, 6)
    })

    --// MAIN CONTENT
    local content = Create("Frame", {
        Parent = main,
        Position = UDim2.fromOffset(190, 50),
        Size = UDim2.new(1, -200, 1, -60),
        BackgroundTransparency = 1
    })

    Create("UIListLayout", {
        Parent = content,
        Padding = UDim.new(0, 8)
    })

    --// MINIMIZE LOGIC
    local minimized = false
    SafeClick(minimize, function()
        minimized = not minimized
        content.Visible = not minimized
        sidebar.Visible = not minimized
    end)

    --// DRAG
    do
        local dragging, dragStart, startPos

        top.InputBegan:Connect(function(input)
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
    self.Sidebar = tabList
    self.Container = content
    self.Pages = {}

    return self
end

local function CreateBox(parent, height)
    local box = Create("Frame", {
        Parent = parent,
        Size = UDim2.new(1, 0, 0, height or 40),
        BackgroundColor3 = Theme.Surface2
    })

    ApplyCorner(box, 8)
    ApplyStroke(box)

    return box
end

function library:Button(text, callback)
    local box = CreateBox(self.Container, 40)

    local btn = Create("TextButton", {
        Parent = box,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary
    })

    SafeClick(btn, function()
        if callback then
            pcall(callback)
        end
    end)

    return btn
end

function library:Toggle(text, default, callback)
    local state = default or false

    local box = CreateBox(self.Container, 40)

    local label = Create("TextLabel", {
        Parent = box,
        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.new(1, -60, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local switch = Create("Frame", {
        Parent = box,
        Size = UDim2.fromOffset(40, 20),
        Position = UDim2.new(1, -50, 0.5, -10),
        BackgroundColor3 = state and Theme.Accent or Theme.Surface
    })
    ApplyCorner(switch, 20)
    ApplyStroke(switch)

    local knob = Create("Frame", {
        Parent = switch,
        Size = UDim2.fromOffset(16, 16),
        Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
        BackgroundColor3 = Color3.new(1,1,1)
    })
    ApplyCorner(knob, 20)

    local function set(val)
        state = val

        Tween(knob, {
            Position = state and UDim2.new(1, -18, 0.5, -8)
                or UDim2.new(0, 2, 0.5, -8)
        })

        if callback then
            callback(state)
        end
    end

    local click = Create("TextButton", {
        Parent = box,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = ""
    })

    SafeClick(click, function()
        set(not state)
    end)

    return {
        Set = set,
        Get = function() return state end
    }
end

function library:Dropdown(text, options, callback, config)
    config = config or {}
    local multi = config.MultiSelection or false

    local selected = multi and {} or nil
    local opened = false

    local box = CreateBox(self.Container, 40)

    local title = Create("TextLabel", {
        Parent = box,
        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.new(1, -40, 1, 0),
        BackgroundTransparency = 1,
        Text = text .. " : ",
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local arrow = Create("TextLabel", {
        Parent = box,
        Size = UDim2.fromOffset(20, 20),
        Position = UDim2.new(1, -25, 0.5, -10),
        BackgroundTransparency = 1,
        Text = "⌄",
        TextSize = 16,
        TextColor3 = Theme.TextSecondary
    })

    local container = Create("Frame", {
        Parent = box,
        Position = UDim2.fromOffset(0, 40),
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    })

    local layout = Create("UIListLayout", {
        Parent = container,
        Padding = UDim.new(0, 6)
    })

    --// OPTION CREATOR
    local function createOption(opt)
        local btn = Create("TextButton", {
            Parent = container,
            Size = UDim2.new(1, -10, 0, 30),
            BackgroundColor3 = Theme.Surface,
            Text = "",
            AutoButtonColor = false
        })
        ApplyCorner(btn, 6)
        ApplyStroke(btn)

        local txt = Create("TextLabel", {
            Parent = btn,
            Position = UDim2.fromOffset(8, 0),
            Size = UDim2.new(1, -40, 1, 0),
            BackgroundTransparency = 1,
            Text = tostring(opt),
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextColor3 = Theme.TextPrimary,
            TextXAlignment = Enum.TextXAlignment.Left
        })

        -- CHECKBOX (for multi)
        local check = nil
        if multi then
            check = Create("Frame", {
                Parent = btn,
                Size = UDim2.fromOffset(16,16),
                Position = UDim2.new(1, -22, 0.5, -8),
                BackgroundColor3 = Theme.Surface2
            })
            ApplyCorner(check, 4)
            ApplyStroke(check)
        end

        local function updateText()
            if multi then
                local list = {}
                for k,v in pairs(selected) do
                    if v then table.insert(list, k) end
                end
                title.Text = text .. " : " .. table.concat(list, ", ")
            else
                title.Text = text .. " : " .. tostring(selected)
            end
        end

        SafeClick(btn, function()
            if multi then
                selected[opt] = not selected[opt]

                if selected[opt] then
                    check.BackgroundColor3 = Theme.Accent
                else
                    check.BackgroundColor3 = Theme.Surface2
                end

                updateText()

                if callback then
                    callback(selected)
                end
            else
                selected = opt
                updateText()

                if callback then
                    callback(opt)
                end

                opened = false
                Tween(container, {Size = UDim2.new(1,0,0,0)})
                Tween(box, {Size = UDim2.new(1,0,0,40)})
                Tween(arrow, {Rotation = 0})
            end
        end)
    end

    for _, opt in ipairs(options) do
        createOption(opt)
    end

    task.wait()
    local fullSize = layout.AbsoluteContentSize.Y

    local click = Create("TextButton", {
        Parent = box,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1,
        Text = ""
    })

    SafeClick(click, function()
        opened = not opened

        Tween(container, {
            Size = opened and UDim2.new(1,0,0,fullSize) or UDim2.new(1,0,0,0)
        })

        Tween(box, {
            Size = opened and UDim2.new(1,0,0,40 + fullSize + 5) or UDim2.new(1,0,0,40)
        })

        Tween(arrow, {
            Rotation = opened and 180 or 0
        })
    end)

    return {
        Get = function()
            return selected
        end
    }
end

function library:Slider(text, min, max, default, callback)
    local value = default or min

    local box = CreateBox(self.Container, 55)

    local label = Create("TextLabel", {
        Parent = box,
        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.new(1, -20, 0, 20),
        BackgroundTransparency = 1,
        Text = text .. " : " .. value,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local bar = Create("Frame", {
        Parent = box,
        Position = UDim2.fromOffset(10, 30),
        Size = UDim2.new(1, -20, 0, 6),
        BackgroundColor3 = Theme.Surface
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

        if callback then callback(value) end
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
        Get = function() return value end
    }
end

function library:Textbox(text, placeholder, callback)
    local box = CreateBox(self.Container, 40)

    local label = Create("TextLabel", {
        Parent = box,
        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.new(0.4, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local input = Create("TextBox", {
        Parent = box,
        Position = UDim2.new(0.4, 0, 0, 5),
        Size = UDim2.new(0.6, -10, 1, -10),
        BackgroundTransparency = 1,
        Text = "",
        PlaceholderText = placeholder or "",
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Theme.TextPrimary
    })

    input.FocusLost:Connect(function()
        if callback then callback(input.Text) end
    end)

    return input
end

function library:Notify(title, text, duration)
    duration = duration or 3

    if not self.NotifHolder then
        self.NotifHolder = Create("Frame", {
            Parent = self.Gui,
            Size = UDim2.new(0, 260, 1, -20),
            Position = UDim2.new(1, -10, 0, 10),
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1
        })

        Create("UIListLayout", {
            Parent = self.NotifHolder,
            Padding = UDim.new(0, 6)
        })
    end

    local box = Create("Frame", {
        Parent = self.NotifHolder,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = Theme.Surface
    })
    ApplyCorner(box, 8)
    ApplyStroke(box)

    local t = Create("TextLabel", {
        Parent = box,
        Position = UDim2.fromOffset(10, 5),
        Size = UDim2.new(1, -20, 0, 20),
        BackgroundTransparency = 1,
        Text = title,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local d = Create("TextLabel", {
        Parent = box,
        Position = UDim2.fromOffset(10, 25),
        Size = UDim2.new(1, -20, 0, 30),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextColor3 = Theme.TextSecondary,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    Tween(box, {Size = UDim2.new(1,0,0,60)}, 0.2)

    task.delay(duration, function()
        Tween(box, {Size = UDim2.new(1,0,0,0)}, 0.2)
        task.wait(0.2)
        box:Destroy()
    end)
end

function library:BindToggle(key)
    local visible = true

    UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end

        if input.KeyCode == key then
            visible = not visible
            self.Main.Visible = visible
        end
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

function library:SetTheme(new)
    for k,v in pairs(new) do
        Theme[k] = v
    end
end

local HttpService = game:GetService("HttpService")

function library:SaveConfig(name, data)
    writefile(name..".json", HttpService:JSONEncode(data))
end

function library:LoadConfig(name)
    if isfile(name..".json") then
        return HttpService:JSONDecode(readfile(name..".json"))
    end
end

return library
