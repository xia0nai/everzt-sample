local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rod = character:WaitForChild("Withering Rod")
local remotes = rod:WaitForChild("Mechanics"):WaitForChild("Remotes")

remotes:WaitForChild("CastEvent"):FireServer(false, 52)

task.wait(2.5)

local backpackRod = player:WaitForChild("Backpack"):WaitForChild("Withering Rod")
local miniGame = backpackRod:WaitForChild("Mechanics"):WaitForChild("Remotes"):WaitForChild("MiniGame")
miniGame:FireServer(true)
