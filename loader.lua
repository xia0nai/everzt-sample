function safeloadstring(url)
    local success, code = pcall(function()
        return game:HttpGet(url)
    end)
    local func, errorMessage = loadstring(success and code or "")
    if not func then
        warn("LOADSTRING FAILED: " .. tostring(errorMessage))
        return nil
    end
end

local Fluent = safeloadstring("https://github.com/StyearX/Fluent-Modded/releases/download/1.6.0/main.lua")
local SaveManager = safeloadstring("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua")
local InterfaceManager = safeloadstring("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua")

local Minimizer = Fluent:CreateMinimizer({
    Icon = "rbxassetid://109639117875913",
    Size = UDim2.fromOffset(48, 48),
    Position = UDim2.new(0.101969875, 0, 0.110441767, 0),
    Corner = 12,
    BackgroundTransparency = 1,
    IconCorner = 6,
    Transparency = 0,
    Lockable = false,
    Draggable = true,
})

Minimizer.Visible = true

Window = Fluent:CreateWindow({
    Title = "Everzt",
    TabWidth = 140,
    SubTitle = ".xia0nai",
    Acrylic = false,
    Animated = false,
    Transparency = 0,
    Size = UDim2.fromOffset(480, 400),
    Theme = "Dark",
    Background = false,
    Tags = {
        { Text = "Hello " .. tostring(LocalPlayer.DisplayName), Color = Color3.fromRGB(0, 0, 0) },
    },
    Font = "GothamSSm",
    TitleIcon = "rbxassetid://77838416429094",
    Search = {
        Search = true,
        Highlight = true,
        HighlightColor = Color3.fromRGB(180, 10, 20),
    },
    Anonymous = {
        Default = false,
        ShowAno = true,
        AnoUserInfoTitle = "Hide",
        AnoUserInfoSubTitle = "Any",
    },
    FolderName = "Everzt",
    ScreenGuiName = "Everzt",
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}