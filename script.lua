-- DRIVING EMPIRE - ULTIMATE HYBRID EDITION
-- Merging Old Features + New Visual Bypasses

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Driving Empire - ULTIMATE HYBRID",
   LoadingTitle = "Merging All Systems...",
   LoadingSubtitle = "By Gemini AI",
   ConfigurationSaving = { Enabled = true, FolderName = "DE_Ultimate", FileName = "Config" },
   Discord = { Enabled = false },
   KeySystem = false,
})

-- Services & Essentials
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Global Variables (Keep Old & New)
_G.AutoFarmRace = false
_G.AutoCollectCash = false
_G.VehicleSpeed = 1
_G.FarmDelay = 20 -- Updated for safety
_G.NoClip = false
_G.InfiniteNitro = false
_G.InfiniteJump = false
_G.VisualMoney = "203,164,000" -- Berdasarkan screenshotmu, ditambah 000

-- ============================================
-- NEW: BYPASS & VISUAL FUNCTIONS
-- ============================================

local function UpdateVisualMoney()
    local pGui = player:WaitForChild("PlayerGui")
    for _, v in pairs(pGui:GetDescendants()) do
        if v:IsA("TextLabel") and (v.Text:find(",") or v.Name:lower():find("money")) then
            v.Text = "$" .. _G.VisualMoney
        end
    end
end

local function BypassEverything()
    -- 1. Visual Money
    UpdateVisualMoney()
    -- 2. Unlock Vehicles (Client Side)
    local vehicleFolder = ReplicatedStorage:FindFirstChild("Vehicles")
    local ownedFolder = player:FindFirstChild("OwnedVehicles") or player:FindFirstChild("Data")
    if vehicleFolder and ownedFolder then
        for _, car in pairs(vehicleFolder:GetChildren()) do
            local val = Instance.new("BoolValue", ownedFolder)
            val.Name = car.Name
            val.Value = true
        end
    end
end

-- ============================================
-- TABS: SEMUA FITUR LAMA DIBAWA KEMBALI
-- ============================================

-- 1. TAB BYPASS (NEW + OLD)
local BypassTab = Window:CreateTab("🔓 Bypass & Visual", 4483362458)
BypassTab:CreateButton({
   Name = "🔥 ENABLE ALL BYPASSES (Visual & Vehicles)",
   Callback = function() BypassEverything() end,
})
BypassTab:CreateInput({
   Name = "Custom Money Text",
   PlaceholderText = "Contoh: 999,999,999",
   Callback = function(Text) _G.VisualMoney = Text; UpdateVisualMoney() end,
})

-- 2. TAB AUTO FARM (REFIXED)
local FarmTab = Window:CreateTab("💰 Auto Farm", 4483362458)
FarmTab:CreateToggle({
   Name = "🏁 Auto Farm Races (Teleport)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoFarmRace = Value end,
})
FarmTab:CreateSlider({
   Name = "Farm Delay (Safety)",
   Range = {5, 60},
   Increment = 1,
   CurrentValue = 20,
   Callback = function(V) _G.FarmDelay = V end,
})

-- 3. TAB VEHICLE (OLD FEATURES)
local VehicleTab = Window:CreateTab("🚗 Vehicle Mods", 4483362458)
VehicleTab:CreateSlider({
   Name = "Vehicle Speed Multiplier",
   Range = {1, 20},
   Increment = 1,
   CurrentValue = 1,
   Callback = function(Value) _G.VehicleSpeed = Value end,
})
VehicleTab:CreateToggle({
   Name = "Infinite Nitro",
   CurrentValue = false,
   Callback = function(V) _G.InfiniteNitro = V end,
})
VehicleTab:CreateButton({
   Name = "Flip Vehicle",
   Callback = function()
      local veh = player.Character.Humanoid.SeatPart
      if veh then veh.Parent:SetPrimaryPartCFrame(veh.Parent.PrimaryPart.CFrame * CFrame.Angles(0,0,0)) end
   end,
})

-- 4. TAB PLAYER (OLD FEATURES)
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSlider({
   Name = "Walkspeed",
   Range = {16, 250},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(V) player.Character.Humanoid.WalkSpeed = V end,
})
PlayerTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Callback = function(V) _G.NoClip = V end,
})
PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(V) _G.InfiniteJump = V end,
})

-- ============================================
-- LOOPS (MENJALANKAN FITUR)
-- ============================================

-- Farm Loop
task.spawn(function()
    while task.wait(_G.FarmDelay) do
        if _G.AutoFarmRace then
            local root = player.Character.HumanoidRootPart
            root.CFrame = CFrame.new(-2697, 90, -1937) -- Start Airport
            task.wait(2)
            root.CFrame = CFrame.new(-2800, 90, -2100) -- Finish
        end
    end
end)

-- Vehicle Speed & Nitro Loop
RunService.Heartbeat:Connect(function()
    local seat = (player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.SeatPart)
    if seat and seat:IsA("VehicleSeat") then
        if _G.VehicleSpeed > 1 then
            seat.MaxSpeed = 500 * _G.VehicleSpeed
            seat.Torque = 10000 * _G.VehicleSpeed
        end
        if _G.InfiniteNitro then
            local n = seat.Parent:FindFirstChild("Nitro") or seat.Parent:FindFirstChild("Boost")
            if n then n.Value = 100 end
        end
    end
end)

-- Noclip Loop
RunService.Stepped:Connect(function()
    if _G.NoClip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- Infinite Jump
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfiniteJump and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Anti AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

Rayfield:Notify({Title = "Ultimate Hybrid Loaded", Content = "Semua fitur lama & baru siap digunakan!"})
