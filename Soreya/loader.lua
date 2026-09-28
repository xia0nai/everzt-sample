local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

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
    local ListCheckpoints = {"Cp 01;463.7599;444.9600;-8945.7236;-0.0000;0.0000;-0.0000",
                             "Cp 02;449.5000;489.3040;-9568.0000;0.0000;0.0000;0.0000",
                             "Cp 03;398.2754;629.3039;-10113.5293;0.0000;0.0000;0.0000",
                             "Cp 04;486.5005;637.3039;-10681.0000;-3.1416;-1.4921;-3.1416",
                             "Cp 05;1088.5012;725.3039;-11156.4990;-0.0000;0.0000;-0.0000",
                             "Cp 06;973.6875;733.3039;-11808.9043;-0.0000;1.4402;0.0000",
                             "Cp 07;390.2701;885.3039;-11839.1084;0.0000;1.5191;-0.0000",
                             "Cp 08;-325.8742;849.3039;-11738.4873;0.0000;1.5177;-0.0000",
                             "Cp 09;-869.7002;853.3039;-11737.4004;-0.0000;1.5447;0.0000",
                             "Cp 10;-1281.5297;857.3039;-12093.6221;-0.0000;0.0000;-0.0000",
                             "Cp 11;-1310.5959;889.3039;-12834.4150;-0.0000;1.5532;0.0000",
                             "Cp 12;-2326.6870;913.3039;-12672.8594;3.1416;-0.0085;-3.1416",
                             "Cp 13;-2309.0996;917.3039;-11856.9004;-3.1416;-0.0000;-3.1416",
                             "Cp 14;-2444.7588;961.3039;-11057.5000;-0.0000;1.5532;0.0000",
                             "Cp 15;-3480.1536;981.1478;-11014.8867;-0.0000;1.5621;0.0000",
                             "Cp 16;-4225.6997;1001.3039;-11018.0068;3.1416;1.5614;-3.1416",
                             "Cp 17;-4650.5503;1081.3037;-11665.2578;-3.1416;1.5360;3.1416",
                             "Cp 18;-5543.9072;1101.3037;-11651.7510;-0.0000;1.5615;0.0000",
                             "Cp 19;-6766.4370;1097.3037;-11512.1367;-3.1416;0.0261;3.1416",
                             "Cp 20;-6761.0996;1102.5223;-10802.5566;3.1416;0.0093;-3.1416",
                             "Summit;-6764.0317;1321.1573;-10100.9102;-3.1416;0.0500;-3.1416"}
    local ListSpotCore = {"Spot 1;-6891.1274;1327.9509;-9796.7715;-3.1416;-1.2807;-3.1416",
                          "Spot 2;-8139.1079;1239.3344;-6196.1689;3.1416;-0.0022;-3.1416",
                          "Spot Core;-9050.6523;1250.8180;-6508.4370;-0.0000;0.1158;0.0000"}
    local SavedCoords = {}
    local CoreCoords = {}
    local selectedCheckpoint = nil
    local selectedCoreSpot = nil

    local function StringToCFrame(str)
        local parts = {}
        for value in str:gmatch("[^;]+") do
            table.insert(parts, value)
        end

        local key = parts[1]
        local x, y, z, rx, ry, rz = tonumber(parts[2]), tonumber(parts[3]), tonumber(parts[4]), tonumber(parts[5]),
            tonumber(parts[6]), tonumber(parts[7])
        local pos = Vector3.new(x, y, z)
        local rot = Vector3.new(rx, ry, rz)

        local cframe = CFrame.new(pos) * CFrame.fromEulerAnglesXYZ(math.rad(rot.X), math.rad(rot.Y), math.rad(rot.Z))
        return key, cframe
    end

    local function GetCoordinate(lst, key)
        return lst[key]
    end

    local function TeleportTo(lst, key)
        local cframe = lst[key]
        if not cframe then
            return
        end

        local character = player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = cframe
            showNotif("Teleport", "Teleported to " .. key, nil, 3)
        end
    end

    local function GetCoordinateKeys(lst)
        local keys = {}
        for key, _ in pairs(lst) do
            table.insert(keys, key)
        end
        table.sort(keys)
        return keys
    end

    for idx, value in ipairs(ListCheckpoints) do
        local key, cframe = StringToCFrame(value)
        SavedCoords[key] = cframe
    end

    for idx, value in ipairs(ListSpotCore) do
        local key, cframe = StringToCFrame(value)
        CoreCoords[key] = cframe
    end

    local TeleportSection = Tabs.Main:AddSection("Teleport")
    local CheckpointsDropdown = TeleportSection:AddDropdown("Checkpoints", {
        Title = "Checkpoints",
        Values = GetCoordinateKeys(SavedCoords),
        Multi = false,
        Default = 1
    })
    CheckpointsDropdown:OnChanged(function(value)
        if value ~= nil then
            selectedCheckpoint = value
        end
    end)
    local TeleportToCPButton = TeleportSection:AddButton("TeleportToCheckpoint", {
        Title = "Teleport to Checkpoint",
        Callback = function()
            if selectedCheckpoint then
                TeleportTo(SavedCoords, selectedCheckpoint)
            end
        end
    })
end

-- / Miscellaneous Tab / --
do
    local AntiAFK = {
        Enabled = false,
        IdleThreshold = 900
    }
    local lastInput = tick()
    local heartbeatConn = nil
    local inputConns = {}

    local function resetTimer()
        lastInput = tick()
    end

    function AntiAFK.Toggle(state)
        AntiAFK.Enabled = state
        if heartbeatConn then
            heartbeatConn:Disconnect()
            heartbeatConn = nil
        end
        for _, conn in ipairs(inputConns) do
            conn:Disconnect()
        end
        inputConns = {}
        if not state then
            return
        end
        lastInput = tick()
        table.insert(inputConns, UserInputService.InputBegan:Connect(resetTimer))
        table.insert(inputConns, UserInputService.InputChanged:Connect(resetTimer))

        task.spawn(function()
            while AntiAFK.Enabled do
                task.wait(30)
                if AntiAFK.Enabled and tick() - lastInput >= AntiAFK.IdleThreshold then
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                    lastInput = tick()
                end
            end
        end)
    end

    local MiscSection = Tabs.Settings:AddSection("Miscellaneous")
    local AntiAFKToggle = MiscSection:AddToggle("AntiAFK", {
        Title = "Anti-AFK",
        Default = true
    })
    AntiAFKToggle:OnChanged(function(state)
        AntiAFK.Toggle(state)
        if AntiAFK.Enabled then
            showNotif("Anti-AFK", "Anti-AFK is now " .. (state and "enabled" or "disabled"), nil, 3)
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

SaveManager:LoadAutoloadConfig()
