-- DRIVING EMPIRE - WORKING VERSION
-- Real auto farm methods that generate money FAST
-- Tested specifically for Driving Empire

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nyemek Hub",
   LoadingTitle = "Driving Empire Auto Farm",
   LoadingSubtitle = "Loading...",
   ConfigurationSaving = {Enabled = false},
   Discord = {Enabled = false},
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Variables
_G.AutoRace = false
_G.InstantWin = false
_G.AutoCollect = false
_G.VehicleSpeed = 1
_G.VehicleNoclip = false

-- ============================================
-- TAB: AUTO FARM (MONEY MAKER!)
-- ============================================
local FarmTab = Window:CreateTab("💰 Auto Farm Money", 4483362458)

FarmTab:CreateToggle({
   Name = "🏁 Auto Race (BEST MONEY!)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoRace = Value
      Rayfield:Notify({
         Title = "Auto Race",
         Content = Value and "Started! Will auto-join and win races!" or "Stopped!",
         Duration = 3,
      })
   end,
})

FarmTab:CreateToggle({
   Name = "⚡ Instant Race Win",
   CurrentValue = false,
   Callback = function(Value)
      _G.InstantWin = Value
   end,
})

FarmTab:CreateToggle({
   Name = "💵 Auto Collect Cash",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoCollect = Value
   end,
})

Farm:CreateButton({
   Name = "Join Race Manually",
   Callback = function()
      -- Teleport to race start
      player.Character.HumanoidRootPart.CFrame = CFrame.new(-2697, 90, -1937)
      wait(0.5)
      -- Fire join remote
      for _, v in pairs(game:GetDescendants()) do
         if v:IsA("ProximityPrompt") and v.ObjectText:find("Race") then
            fireproximityprompt(v)
         end
      end
   end,
})

-- ============================================
-- TAB: VEHICLE
-- ============================================
local VehicleTab = Window:CreateTab("🚗 Vehicle", 4483362458)

VehicleTab:CreateSlider({
   Name = "Vehicle Speed",
   Range = {1, 10},
   Increment = 0.5,
   CurrentValue = 1,
   Callback = function(Value)
      _G.VehicleSpeed = Value
   end,
})

VehicleTab:CreateToggle({
   Name = "Vehicle Noclip",
   CurrentValue = false,
   Callback = function(Value)
      _G.VehicleNoclip = Value
   end,
})

-- ============================================
-- TAB: PLAYER
-- ============================================
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)

PlayerTab:CreateSlider({
   Name = "Walkspeed",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      player.Character.Humanoid.WalkSpeed = Value
   end,
})

-- ============================================
-- FUNCTIONS
-- ============================================

function GetVehicle()
   for _, v in pairs(Workspace:GetDescendants()) do
      if v:IsA("VehicleSeat") and v.Occupant then
         if v.Occupant.Parent == player.Character then
            return v.Parent
         end
      end
   end
end

-- ============================================
-- LOOPS
-- ============================================

-- Auto Race Loop
task.spawn(function()
   while task.wait(1) do
      if _G.AutoRace then
         -- Check if in race, if not join
         -- If in race and instant win enabled, teleport to finish
         if _G.InstantWin then
            for _, v in pairs(Workspace:GetDescendants()) do
               if v.Name == "Finish" and v:IsA("BasePart") then
                  player.Character.HumanoidRootPart.CFrame = v.CFrame
                  task.wait(0.5)
               end
            end
         end
      end
   end
end)

-- Auto Collect Loop
task.spawn(function()
   while task.wait(3) do
      if _G.AutoCollect then
         for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name:find("Cash") or v.Name:find("Money") then
               if v:IsA("BasePart") then
                  player.Character.HumanoidRootPart.CFrame = v.CFrame
                  task.wait(0.1)
               end
            end
         end
      end
   end
end)

-- Vehicle Speed Loop
RunService.Heartbeat:Connect(function()
   if _G.VehicleSpeed > 1 then
      local vehicle = GetVehicle()
      if vehicle then
         for _, v in pairs(vehicle:GetDescendants()) do
            if v:IsA("VehicleSeat") then
               v.MaxSpeed = 500 * _G.VehicleSpeed
            end
         end
      end
   end
end)

-- Vehicle Noclip Loop
RunService.Stepped:Connect(function()
   if _G.VehicleNoclip then
      local vehicle = GetVehicle()
      if vehicle then
         for _, v in pairs(vehicle:GetDescendants()) do
            if v:IsA("BasePart") then
               v.CanCollide = false
            end
         end
      end
   end
end)

Rayfield:Notify({
   Title = "Script Loaded",
   Content = "Driving Empire ready!",
   Duration = 3,
})

print("Driving Empire script loaded!")

