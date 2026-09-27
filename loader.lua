function safeloadstring(url)
    local code = game:HttpGet(url)
    local func, errorMessage = loadstring(code)
    if func then
        return func()
    else
        warn("LOADSTRING FAILED: " .. tostring(errorMessage))
        return nil
    end
end

local Fluent = safeloadstring("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua")
local SaveManager = safeloadstring("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua")
local InterfaceManager = safeloadstring("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua")

local Window = Fluent:CreateWindow({
    Title = "Everzt Hub",
    SubTitle = "by xia0nai",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Orange",
    MinimizeKey = Enum.KeyCode.LeftControl,
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}