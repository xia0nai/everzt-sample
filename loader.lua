local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local UniverseId =  game.gameId
local Window = Fluent:CreateWindow({
    Title = "Everzt Hub",
    SubTitle = "by xia0nai",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 400),
    Acrylic = false,
    Transparency = 0,
    Theme = "Orange",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "" })
}

function Notify(title, content, duration)
    Fluent:Notify({
        Title = title,
        Content = content,
        Duration = duration or 3
    })
end

-- / Misc Tab / --
do
    local GameplaySection = Tabs.Misc:AddSection("Gameplay")

    local Toggle = GameplaySection:AddToggle("Anti-AFK", {
        Title = "Anti-AFK",
        Default = true,
        Callback = function(state)
            Notify("Misc", "Anti-AFK is now " .. (state and "enabled" or "disabled"))
        end
    })
end
-- / Settings Tab / --

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("EverztHub")
SaveManager:SetFolder("EverztHub/" .. UniverseId)

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(0)

Fluent:Notify({
    Title = "Success",
    Content = "The script has been loaded.",
    Duration = 3
})

SaveManager:LoadAutoloadConfig()