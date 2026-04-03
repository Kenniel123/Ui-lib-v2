-- v.1.1

local library = {}
library.__index = library

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- 🔥 THEME (CLEAN BLACK/WHITE)
local Theme = {
    Background = Color3.fromRGB(0,0,0),
    Surface = Color3.fromRGB(15,15,15),

    Border = Color3.fromRGB(255,255,255),

    TextPrimary = Color3.fromRGB(255,255,255),
    TextSecondary = Color3.fromRGB(200,200,200)
}

-- CREATE
local function Create(class, props)
    local obj = Instance.new(class)
    for i,v in pairs(props) do
        pcall(function()
            obj[i] = v
        end)
    end
    return obj
end

-- 🔥 CORNER (NOT ROUND CIRCLE)
local function ApplyCorner(obj, scale)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(scale or 0.07, 0)
    c.Parent = obj
end

-- 🔥 SOFT OUTLINE
local function ApplyStroke(obj)
    local s = Instance.new("UIStroke")
    s.Color = Theme.Border
    s.Thickness = 1
    s.Transparency = 0.85
    s.Parent = obj
    return s
end

-- TWEEN
local function Tween(obj, props, t)
    TweenService:Create(
        obj,
        TweenInfo.new(t or 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        props
    ):Play()
end

-- CLICK
local function SafeClick(obj, cb)
    if obj:IsA("TextButton") then
        obj.MouseButton1Click:Connect(cb)
    end
end

function library:CreateWindow(title)
    local self = setmetatable({}, library)

    local gui = Create("ScreenGui", {
        Parent = game.CoreGui,
        Name = "CleanUI"
    })

    local main = Create("Frame", {
        Parent = gui,
        Size = UDim2.fromOffset(620, 420),
        Position = UDim2.new(0.5, -310, 0.5, -210),
        BackgroundColor3 = Theme.Background
    })
    ApplyCorner(main, 0.03)
    ApplyStroke(main)

    -- 🔥 DRAGGING
    do
        local dragging, dragInput, dragStart, startPos

        main.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = main.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                main.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end)
    end

    -- 🔥 HEADER FRAME (YOUR REQUEST)
    local headerFrame = Create("Frame", {
        Parent = main,
        Size = UDim2.new(1, -20, 0, 40),
        Position = UDim2.fromOffset(10, 10),
        BackgroundColor3 = Theme.Surface
    })
    ApplyCorner(headerFrame)
    ApplyStroke(headerFrame)

    local header = Create("TextLabel", {
        Parent = headerFrame,
        Size = UDim2.new(1, -16, 1, 0),
        Position = UDim2.fromOffset(8, 0),
        BackgroundTransparency = 1,
        Text = title or "My Hub",
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    -- 🔥 SIDEBAR (MOVED DOWN)
    local sidebar = Create("Frame", {
        Parent = main,
        Position = UDim2.fromOffset(10, 60),
        Size = UDim2.fromOffset(160, 350),
        BackgroundColor3 = Theme.Surface
    })
    ApplyCorner(sidebar)
    ApplyStroke(sidebar)

    -- 🔥 MAIN TAB BUTTON
    local mainTab = Create("TextButton", {
        Parent = sidebar,
        Size = UDim2.new(1, -10, 0, 30),
        Position = UDim2.fromOffset(5, 5),
        BackgroundColor3 = Theme.Surface,
        Text = "Main",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        AutoButtonColor = false
    })
    ApplyCorner(mainTab)
    ApplyStroke(mainTab)

    -- 🔍 SEARCH (UNDER MAIN TAB)
    local search = Create("TextBox", {
        Parent = sidebar,
        Size = UDim2.new(1, -10, 0, 28),
        Position = UDim2.fromOffset(5, 40),
        PlaceholderText = "Search...",
        BackgroundColor3 = Theme.Background,
        TextColor3 = Theme.TextPrimary,
        Font = Enum.Font.Gotham,
        TextSize = 13
    })
    ApplyCorner(search)
    ApplyStroke(search)

    -- 🔥 TAB HOLDER (NO CORNER)
    local tabHolder = Create("Frame", {
        Parent = sidebar,
        Position = UDim2.fromOffset(0, 75),
        Size = UDim2.new(1, 0, 1, -75),
        BackgroundTransparency = 1
    })

    Create("UIListLayout", {
        Parent = tabHolder,
        Padding = UDim.new(0, 6)
    })

    -- 🔥 CONTENT
    local content = Create("Frame", {
        Parent = main,
        Position = UDim2.fromOffset(180, 60),
        Size = UDim2.new(1, -190, 1, -70),
        BackgroundTransparency = 1
    })

    self.Gui = gui
    self.Sidebar = tabHolder
    self.Content = content
    self.Tabs = {}

    return self
end

function library:CreateTab(name)
    local page = Create("Frame", {
        Parent = self.Content,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false
    })

    -- 🔥 CLEAN SPACING (fix ugly cramped look)
    Create("UIListLayout", {
        Parent = page,
        Padding = UDim.new(0, 10)
    })

    Create("UIPadding", {
        Parent = page,
        PaddingLeft = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10)
    })

    -- 🔥 TAB BUTTON
    local button = Create("TextButton", {
        Parent = self.Sidebar,
        Size = UDim2.new(1, -10, 0, 30),
        BackgroundColor3 = Theme.Surface,
        Text = name,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextSecondary,
        AutoButtonColor = false
    })
    ApplyCorner(button)
    local stroke = ApplyStroke(button)

    -- 🔥 SWITCHING
    SafeClick(button, function()
        for _, t in pairs(self.Tabs) do
            t.Page.Visible = false
            Tween(t.Button, {
                TextColor3 = Theme.TextSecondary
            })
        end

        page.Visible = true

        Tween(button, {
            TextColor3 = Theme.TextPrimary
        })
    end)

    table.insert(self.Tabs, {
        Button = button,
        Page = page
    })

    -- FIRST TAB AUTO
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
        AutoButtonColor = false,
        Text = ""
    })
    ApplyCorner(btn)
    local stroke = ApplyStroke(btn)

    -- 🔥 LABEL (PROPER PADDING)
    local label = Create("TextLabel", {
        Parent = btn,
        Size = UDim2.new(1, -16, 1, 0),
        Position = UDim2.fromOffset(8, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    -- 🔥 HOVER (makes outline visible)
    btn.MouseEnter:Connect(function()
        Tween(stroke, {Transparency = 0.5})
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
    ApplyCorner(frame)
    local stroke = ApplyStroke(frame)

    local label = Create("TextLabel", {
        Parent = frame,
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.fromOffset(8, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    -- 🔥 TOGGLE BG
    local toggle = Create("Frame", {
        Parent = frame,
        Size = UDim2.fromOffset(40, 18),
        Position = UDim2.new(1, -50, 0.5, -9),
        BackgroundColor3 = state and Theme.Border or Color3.fromRGB(60,60,60)
    })
    ApplyCorner(toggle, 1)

    local knob = Create("Frame", {
        Parent = toggle,
        Size = UDim2.fromOffset(14, 14),
        Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
        BackgroundColor3 = Color3.new(1,1,1)
    })
    ApplyCorner(knob, 1)

    local function set(val)
        state = val

        Tween(toggle, {
            BackgroundColor3 = state and Theme.Border or Color3.fromRGB(60,60,60)
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

    -- 🔥 HOVER
    frame.MouseEnter:Connect(function()
        Tween(stroke, {Transparency = 0.5})
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
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local bar = Create("Frame", {
        Parent = frame,
        Position = UDim2.fromOffset(0, 28),
        Size = UDim2.new(1, 0, 0, 8),
        BackgroundColor3 = Color3.fromRGB(60,60,60)
    })
    ApplyCorner(bar, 1)

    local fill = Create("Frame", {
        Parent = bar,
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Theme.Border
    })
    ApplyCorner(fill, 1)

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
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Theme.Surface,
        ClipsDescendants = true
    })
    ApplyCorner(frame)
    local stroke = ApplyStroke(frame)

    local label = Create("TextLabel", {
        Parent = frame,
        Size = UDim2.new(1, -30, 1, 0),
        Position = UDim2.fromOffset(8, 0),
        BackgroundTransparency = 1,
        Text = text .. " : ",
        Font = Enum.Font.GothamBold,
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
        Position = UDim2.fromOffset(0,36),
        Size = UDim2.new(1,0,0,0),
        BackgroundTransparency = 1
    })

    local layout = Create("UIListLayout", {
        Parent = container,
        Padding = UDim.new(0,6)
    })

    -- OPTIONS
    local function make(opt)
        local btn = Create("TextButton", {
            Parent = container,
            Size = UDim2.new(1, -10, 0, 28),
            Position = UDim2.fromOffset(5,0),
            BackgroundColor3 = Theme.Background,
            Text = tostring(opt),
            Font = Enum.Font.GothamBold,
            TextSize = 13,
            TextColor3 = Theme.TextPrimary,
            AutoButtonColor = false
        })
        ApplyCorner(btn)
        local s = ApplyStroke(btn)

        btn.MouseEnter:Connect(function()
            Tween(s, {Transparency = 0.5})
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
            Tween(frame, {Size = UDim2.new(1,0,0,36)})
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
        Size = UDim2.new(1,0,0,36),
        BackgroundTransparency = 1,
        Text = ""
    })

    SafeClick(click, function()
        opened = not opened

        local sizeY = 36 + container.AbsoluteSize.Y

        Tween(frame, {
            Size = opened and UDim2.new(1,0,0,sizeY) or UDim2.new(1,0,0,36)
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
    ApplyCorner(frame)
    local stroke = ApplyStroke(frame)

    local label = Create("TextLabel", {
        Parent = frame,
        Size = UDim2.new(0.4, 0, 1, 0),
        Position = UDim2.fromOffset(8, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local box = Create("TextBox", {
        Parent = frame,
        Size = UDim2.new(0.6, -16, 1, -10),
        Position = UDim2.new(0.4, 8, 0, 5),
        BackgroundColor3 = Theme.Background,
        Text = "",
        PlaceholderText = placeholder or "",
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Theme.TextPrimary,
        ClearTextOnFocus = false
    })
    ApplyCorner(box)
    ApplyStroke(box)

    box.FocusLost:Connect(function()
        if callback then
            pcall(callback, box.Text)
        end
    end)

    frame.MouseEnter:Connect(function()
        Tween(stroke, {Transparency = 0.5})
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
    ApplyCorner(notif)
    ApplyStroke(notif)

    local t = Create("TextLabel", {
        Parent = notif,
        Size = UDim2.new(1,-16,0,20),
        Position = UDim2.fromOffset(8,6),
        BackgroundTransparency = 1,
        Text = title,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local d = Create("TextLabel", {
        Parent = notif,
        Size = UDim2.new(1,-16,0,40),
        Position = UDim2.fromOffset(8,26),
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
