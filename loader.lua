function safeloadstring(url)
    local code = game:HttpGet(url)
    local func, errorMessage = loadstring(code)
    if func then
        print("Script compiled! Executing...")
        return func()
    else
        warn("LOADSTRING FAILED: " .. tostring(errorMessage))
        return nil
    end
end

local Fluent = safeloadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = safeloadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = safeloadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Everzt Hub",
    SubTitle = "by xia0nai",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 400),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "house" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}