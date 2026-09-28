local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local univerId = game.gameId
local Config = {
    HubName = "Everzt Hub",
    HubVersion = "v0.0.1",
    HubAuthor = "xia0nai",
    HubFolder = "EverztHub",
    ConfigFolder = "EverztHub/Soreya"
}

local Window = Fluent:CreateWindow({
    Title = Config.HubName,
    SubTitle = Config.HubVersion,
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 400),
    Acrylic = false,
    Theme = "Darker",
    Transparency = false,
    MinimizeKey = nil
})

local ScreenGui = Instance.new("ScreenGui")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local MinimizerButton = Instance.new("ImageButton")

do
    ScreenGui.Name = "FluentToggle"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false
    MinimizerButton.Parent = ScreenGui
    MinimizerButton.Size = UDim2.new(0, 45, 0, 45)
    MinimizerButton.Position = UDim2.new(0, 30, 0, 60)
    MinimizerButton.Draggable = true
    MinimizerButton.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    MinimizerButton.Image = "rbxassetid://139088758451411"
    MinimizerButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
    MinimizerButton.ScaleType = Enum.ScaleType.Fit
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MinimizerButton
    UIStroke.Color = Color3.fromRGB(218, 31, 61)
    UIStroke.Thickness = 1
    UIStroke.Parent = MinimizerButton
    -- Toggle minimize window
    MinimizerButton.MouseButton1Click:Connect(function()
        Window:Minimize()
    end)
end

function showNotif(title, content, subcontent, duration)
    Fluent:Notify({
        Title = title,
        Content = content,
        SubContent = subcontent or nil,
        Duration = duration or 3
    })
end

-- / Init Tabs / --
local Tabs = {
    Main = Window:AddTab({
        Title = "Main",
        Icon = ""
    }),
    Fishing = Window:AddTab({
        Title = "Fishing",
        Icon = ""
    }),
    Settings = Window:AddTab({
        Title = "Settings",
        Icon = ""
    })
}
local Options = Fluent.Options

-- / Main Tab / --
do
    local TeleportSection = Tabs.Main:AddSection("Teleport")
    local CheckpointsDropdown = TeleportSection:AddDropdown("Checkpoints", {
        Title = "Checkpoints",
        Values = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve",
                  "thirteen", "fourteen"},
        Multi = false,
        Default = 1
    })
    CheckpointsDropdown:OnChanged(function(Value)
        showNotif("Teleport", "Teleported to: " .. Value, nil, 3)
    end)
end

-- / Miscellaneous Tab / --
do
    local MiscSection = Tabs.Settings:AddSection("Miscellaneous")

    local AntiAFKToggle = MiscSection:AddToggle("AntiAFK", {
        Title = "AntiAFKToggle",
        Default = true
    })
    AntiAFKToggle:OnChanged(function()
        if Options.AntiAFK.value then
            showNotif("Settings", "AntiAFK is now enabled", nil, 3)
        end
    end)
end

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder(Config.HubFolder)
SaveManager:SetFolder(Config.ConfigFolder)

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(0)
SaveManager:LoadAutoloadConfig()
