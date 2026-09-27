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

local UILibrary = safeloadstring("https://raw.githubusercontent.com/SugaBlaz/UI-Library/refs/heads/main/Orbital%20UI.lua")

local ui = UILibrary.Main.new({
    TitleText = "Everzt Hub",
    Size = UDim2.new(0, 175, 0, 225),
    Position = UDim2.new(0.5, -140, 0.5, -190),
    SettingSize = UDim2.new(0, 250, 0, 250),
    TitleHeight = 30,
    CornerRadius = 6,
    ElementPadding = 6,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    SectionHeight = 20,
    UIStrokeThickness = 1,
    SliderColor = Color3.fromRGB(54, 54, 54),
    NotifcationSound = "rbxassetid://80833448337193",
    ResetOnSpawn = false,
    Addons = {}, -- Addons to your Key link
    KeySystemEnabled = false,
    TabPadding = 10,
    UseOwnTheme = false,
    Key = nil -- Your cloud worker key verifier / static link / string
    KeyLink = nil -- Your Key Link eg. Lootlabs, Linkvertise, etc
    Theme = "Serenity",  -- You can choose any themes
    SaveOnExit = true,
})

ui:CreateUI()

ui:AddSection("Main Elements")