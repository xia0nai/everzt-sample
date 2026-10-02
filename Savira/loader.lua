local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local univerId = game.gameId
local player = Players.LocalPlayer
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
    Settings = Window:AddTab({
        Title = "Settings",
        Icon = ""
    })
}
local Options = Fluent.Options

-- / Main Tab / --
do
    local ListCheckpoints = {"Cp 01;-78.0974;7564.4717;-8558.7227;3.1416;-0.0000;-3.1416",
                            "Cp 02;-77.8258;7598.2593;-7883.5322;-3.1416;-0.0000;3.1416",
                            "Cp 03;-78.5978;7724.2183;-7319.3594;-3.1416;0.0000;-3.1416",
                            "Cp 04;-78.6078;7774.0459;-6603.2197;-3.1416;0.0000;-3.1416",
                            "Cp 05;-79.0998;7906.8740;-6031.0796;-3.1416;-0.0162;3.1416",
                            "Cp 06;-79.0998;8097.8740;-5261.0796;-3.1416;0.0011;3.1416",
                            "Cp 07;-79.6098;8201.0020;-4483.9585;-3.1416;-0.0336;3.1416",
                            "Cp 08;-80.2638;8403.1982;-3681.5903;3.1416;-0.0250;3.1416",
                            "Cp 09;-80.8298;8455.3740;-2810.2217;3.1416;-0.0424;3.1416",
                            "Cp 10;-81.4088;8740.0547;-1952.8535;-3.1416;-0.0076;-3.1416",
                            "Cp 11;-82.1838;9024.7383;-1013.4873;3.1416;0.0011;3.1416",
                            "Cp 12;-67.5187;9065.9150;-35.4747;-3.1416;-0.0164;-3.1416",
                            "Cp 13;-67.7208;9102.1045;957.2451;-3.1416;-0.0176;-3.1416",
                            "Cp 14;-135.5088;9328.2900;1840.6123;3.1416;0.0085;-3.1416",
                            "Cp 15;-122.2588;9544.4717;2566.9795;3.1416;-0.0090;-3.1416",
                            "Cp 16;-24.3748;9943.6562;3791.3486;3.1416;-0.0176;3.1416",
                            "Cp 17;-25.1498;10344.8398;4478.7158;3.1416;0.0251;3.1416",
                            "Cp 18;-25.7858;10981.0244;5760.2427;3.1416;0.0076;3.1416",
                            "Cp 19;-26.3948;11517.2148;6953.4541;-3.1416;-0.0100;-3.1416",
                            "Cp 20;-27.0228;11861.4033;7885.8242;-3.1416;-0.0630;3.1416",
                            "Summit;-50.6488;12528.7998;8774.2012;-3.1416;-0.0000;3.1416"}
    local SavedCoords = {}
    local selectedCheckpoint = nil

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
    local TeleportToCPButton = TeleportSection:AddButton({
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
        Default = true,
        Callback = function(state)
            AntiAFK.Toggle(state)
            if AntiAFK.Enabled then
                showNotif("Anti-AFK", "Anti-AFK is now " .. (state and "enabled" or "disabled"), nil, 3)
            end
        end
    })
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
