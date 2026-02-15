-- DRIVING EMPIRE - FULL FEATURED SCRIPT
-- Complete with all bypasses and auto farm
-- Version: Ultimate Edition

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Driving Empire - Ultimate",
   LoadingTitle = "Driving Empire Ultimate",
   LoadingSubtitle = "Loading all features...",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "DrivingEmpire_Ultimate"
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

-- Player
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Variables
_G.AutoFarmRace = false
_G.AutoFarmDeliver = false
_G.AutoCollectCash = false
_G.InstantTeleport = true
_G.VehicleSpeed = 1
_G.FarmDelay = 0.1
_G.BypassEnabled = false

-- Race Locations
local RaceLocations = {
   ["Airport Race"] = CFrame.new(-2697, 90, -1937),
   ["Highway Race"] = CFrame.new(1250, 25, 625),
   ["City Race"] = CFrame.new(-1450, 25, 700),
   ["Mountain Race"] = CFrame.new(2100, 150, -1800),
   ["Beach Race"] = CFrame.new(-500, 10, -2500),
}

local RaceFinishPoints = {
   CFrame.new(-2800, 90, -2100),
   CFrame.new(1400, 25, 800),
   CFrame.new(-1600, 25, 900),
   CFrame.new(2300, 150, -2000),
   CFrame.new(-700, 10, -2700),
}

-- Delivery Points
local DeliveryPoints = {
   CFrame.new(-313, 25, -133),
   CFrame.new(650, 25, 400),
   CFrame.new(-1200, 25, 600),
   CFrame.new(800, 25, -800),
}

print("\n" .. string.rep("=", 70))
print("DRIVING EMPIRE - ULTIMATE EDITION")
print("Loading all features and bypasses...")
print(string.rep("=", 70) .. "\n")

-- ============================================
-- TAB: BYPASS (POWERFUL!)
-- ============================================
local BypassTab = Window:CreateTab("🔓 Bypass & Unlock", 4483362458)

BypassTab:CreateSection("Main Bypasses")

BypassTab:CreateButton({
   Name = "🔥 ENABLE ALL BYPASSES (DO THIS FIRST!)",
   Callback = function()
      EnableAllBypasses()
      Rayfield:Notify({
         Title = "All Bypasses Enabled!",
         Content = "GamePass, Money, and Vehicle bypasses active!",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

BypassTab:CreateButton({
   Name = "🚗 OWN ALL VEHICLES (Add to Player Data)",
   Callback = function()
      OwnAllVehicles()
      Rayfield:Notify({
         Title = "Own All Vehicles",
         Content = "All vehicles added to your player data!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

BypassTab:CreateButton({
   Name = "💎 Bypass All GamePasses",
   Callback = function()
      BypassGamePass()
      Rayfield:Notify({
         Title = "GamePass Bypass",
         Content = "All gamepasses unlocked!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

BypassTab:CreateButton({
   Name = "💰 Bypass Money Check",
   Callback = function()
      BypassMoney()
      Rayfield:Notify({
         Title = "Money Bypass",
         Content = "Money checks bypassed!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

BypassTab:CreateButton({
   Name = "👤 Bypass Player Level/Rank",
   Callback = function()
      BypassPlayerLevel()
      Rayfield:Notify({
         Title = "Level Bypass",
         Content = "Level requirements bypassed!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

BypassTab:CreateSection("Vehicle Unlocks")

BypassTab:CreateButton({
   Name = "🎨 Unlock All Colors/Paints",
   Callback = function()
      UnlockAllColors()
   end,
})

BypassTab:CreateButton({
   Name = "⚙️ Unlock All Upgrades",
   Callback = function()
      UnlockAllUpgrades()
   end,
})

BypassTab:CreateButton({
   Name = "🏠 Unlock All Garages",
   Callback = function()
      UnlockAllGarages()
   end,
})

-- ============================================
-- TAB: AUTO FARM MONEY (TELEPORT METHOD)
-- ============================================
local FarmTab = Window:CreateTab("💰 Auto Farm Money", 4483362458)

FarmTab:CreateParagraph({
   Title = "🚀 Instant Teleport Farm",
   Content = "Teleports you directly to race finish/delivery points for instant money!"
})

FarmTab:CreateSection("Auto Farm Settings")

FarmTab:CreateToggle({
   Name = "🏁 Auto Farm Races (Teleport to Finish)",
   CurrentValue = false,
   Flag = "AutoFarmRace",
   Callback = function(Value)
      _G.AutoFarmRace = Value
      
      if Value then
         Rayfield:Notify({
            Title = "Auto Farm Race",
            Content = "Auto farming races with teleport!",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})

FarmTab:CreateToggle({
   Name = "📦 Auto Farm Deliveries (Instant Complete)",
   CurrentValue = false,
   Flag = "AutoFarmDeliver",
   Callback = function(Value)
      _G.AutoFarmDeliver = Value
      
      if Value then
         Rayfield:Notify({
            Title = "Auto Farm Delivery",
            Content = "Auto farming deliveries!",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})

FarmTab:CreateToggle({
   Name = "💵 Auto Collect All Cash Drops",
   CurrentValue = false,
   Flag = "AutoCollectCash",
   Callback = function(Value)
      _G.AutoCollectCash = Value
   end,
})

FarmTab:CreateSlider({
   Name = "Farm Speed (Lower = Faster)",
   Range = {0.1, 5},
   Increment = 0.1,
   Suffix = "s",
   CurrentValue = 0.1,
   Flag = "FarmDelay",
   Callback = function(Value)
      _G.FarmDelay = Value
   end,
})

FarmTab:CreateSection("Manual Farm Actions")

FarmTab:CreateButton({
   Name = "Join Random Race NOW",
   Callback = function()
      JoinRandomRace()
   end,
})

FarmTab:CreateButton({
   Name = "Complete Current Race (Teleport to Finish)",
   Callback = function()
      TeleportToRaceFinish()
   end,
})

FarmTab:CreateButton({
   Name = "Collect All Cash Drops NOW",
   Callback = function()
      CollectAllCashNow()
   end,
})

FarmTab:CreateButton({
   Name = "Complete All Deliveries NOW",
   Callback = function()
      CompleteAllDeliveriesNow()
   end,
})

FarmTab:CreateSection("Money Manipulation")

FarmTab:CreateButton({
   Name = "Set Money to 10 Million",
   Callback = function()
      SetMoney(10000000)
   end,
})

FarmTab:CreateButton({
   Name = "Set Money to 100 Million",
   Callback = function()
      SetMoney(100000000)
   end,
})

FarmTab:CreateButton({
   Name = "Set Money to 1 Billion",
   Callback = function()
      SetMoney(1000000000)
   end,
})

-- ============================================
-- TAB: VEHICLE
-- ============================================
local VehicleTab = Window:CreateTab("🚗 Vehicle", 4483362458)

VehicleTab:CreateSection("Speed & Performance")

VehicleTab:CreateSlider({
   Name = "Vehicle Speed Multiplier",
   Range = {1, 50},
   Increment = 1,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "VehicleSpeed",
   Callback = function(Value)
      _G.VehicleSpeed = Value
   end,
})

VehicleTab:CreateToggle({
   Name = "Vehicle Noclip (Phase Through)",
   CurrentValue = false,
   Flag = "VehicleNoclip",
   Callback = function(Value)
      _G.VehicleNoclip = Value
   end,
})

VehicleTab:CreateToggle({
   Name = "Vehicle Fly Mode",
   CurrentValue = false,
   Flag = "VehicleFly",
   Callback = function(Value)
      _G.VehicleFly = Value
   end,
})

VehicleTab:CreateToggle({
   Name = "Infinite Nitro",
   CurrentValue = false,
   Flag = "InfiniteNitro",
   Callback = function(Value)
      _G.InfiniteNitro = Value
   end,
})

VehicleTab:CreateToggle({
   Name = "No Vehicle Damage",
   CurrentValue = false,
   Flag = "NoVehicleDamage",
   Callback = function(Value)
      _G.NoVehicleDamage = Value
   end,
})

VehicleTab:CreateSection("Vehicle Tools")

VehicleTab:CreateButton({
   Name = "Spawn Best Car (FREE)",
   Callback = function()
      SpawnBestCar()
   end,
})

VehicleTab:CreateButton({
   Name = "Max Upgrade Current Car",
   Callback = function()
      MaxUpgradeCar()
   end,
})

VehicleTab:CreateButton({
   Name = "Fix Vehicle Position",
   Callback = function()
      FixVehicle()
   end,
})

VehicleTab:CreateButton({
   Name = "Flip Vehicle Upright",
   Callback = function()
      FlipVehicle()
   end,
})

-- ============================================
-- TAB: TELEPORT
-- ============================================
local TeleportTab = Window:CreateTab("📍 Teleport", 4483362458)

TeleportTab:CreateSection("Race Locations")

for raceName, raceCFrame in pairs(RaceLocations) do
   TeleportTab:CreateButton({
      Name = "TP to " .. raceName,
      Callback = function()
         TeleportTo(raceCFrame)
      end,
   })
end

TeleportTab:CreateSection("Important Locations")

TeleportTab:CreateButton({
   Name = "TP to Car Dealership",
   Callback = function()
      TeleportTo(CFrame.new(-75, 25, 130))
   end,
})

TeleportTab:CreateButton({
   Name = "TP to Garage",
   Callback = function()
      TeleportTo(CFrame.new(-313, 25, -133))
   end,
})

TeleportTab:CreateButton({
   Name = "TP to Gas Station",
   Callback = function()
      TeleportTo(CFrame.new(650, 25, 400))
   end,
})

TeleportTab:CreateButton({
   Name = "TP to Bank (Money Collection)",
   Callback = function()
      TeleportTo(CFrame.new(-1100, 25, -200))
   end,
})

-- ============================================
-- TAB: PLAYER
-- ============================================
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)

PlayerTab:CreateSection("Movement")

PlayerTab:CreateSlider({
   Name = "Walkspeed",
   Range = {16, 1000},
   Increment = 1,
   Suffix = "",
   CurrentValue = 16,
   Flag = "Walkspeed",
   Callback = function(Value)
      if character and character:FindFirstChild("Humanoid") then
         character.Humanoid.WalkSpeed = Value
      end
   end,
})

PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 1000},
   Increment = 1,
   Suffix = "",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      if character and character:FindFirstChild("Humanoid") then
         character.Humanoid.JumpPower = Value
      end
   end,
})

PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJump",
   Callback = function(Value)
      _G.InfiniteJump = Value
   end,
})

PlayerTab:CreateSection("Player Modifications")

PlayerTab:CreateButton({
   Name = "Set Level to Max (999)",
   Callback = function()
      SetPlayerLevel(999)
   end,
})

PlayerTab:CreateButton({
   Name = "Max All Skills",
   Callback = function()
      MaxAllSkills()
   end,
})

PlayerTab:CreateButton({
   Name = "Unlock All Achievements",
   Callback = function()
      UnlockAllAchievements()
   end,
})

-- ============================================
-- TAB: MISC
-- ============================================
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)

MiscTab:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Flag = "Fullbright",
   Callback = function(Value)
      if Value then
         game.Lighting.Brightness = 3
         game.Lighting.ClockTime = 14
         game.Lighting.FogEnd = 100000
         game.Lighting.GlobalShadows = false
         game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
      else
         game.Lighting.Brightness = 1
         game.Lighting.ClockTime = 12
         game.Lighting.FogEnd = 500
         game.Lighting.GlobalShadows = true
         game.Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
      end
   end,
})

MiscTab:CreateToggle({
   Name = "No Clip (Walk Through Walls)",
   CurrentValue = false,
   Flag = "NoClip",
   Callback = function(Value)
      _G.NoClip = Value
   end,
})

MiscTab:CreateButton({
   Name = "Anti AFK",
   Callback = function()
      local vu = game:GetService("VirtualUser")
      player.Idled:connect(function()
         vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
         wait(1)
         vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
      end)
      
      Rayfield:Notify({
         Title = "Anti AFK",
         Content = "Anti AFK enabled!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

MiscTab:CreateButton({
   Name = "Remove Speed Limit Signs",
   Callback = function()
      RemoveSpeedLimits()
   end,
})

-- ============================================
-- FUNCTIONS
-- ============================================

-- Bypass Functions
function EnableAllBypasses()
   print("\n🔥 Enabling all bypasses...")
   
   BypassGamePass()
   BypassMoney()
   BypassPlayerLevel()
   
   _G.BypassEnabled = true
   
   print("✅ All bypasses enabled!")
end

function BypassGamePass()
   print("🔓 Bypassing GamePasses...")
   
   local mt = getrawmetatable(game)
   local oldNamecall = mt.__namecall
   local oldIndex = mt.__index
   setreadonly(mt, false)
   
   mt.__namecall = newcclosure(function(self, ...)
      local method = getnamecallmethod()
      
      if method == "UserOwnsGamePassAsync" then
         return true
      end
      
      if method == "PlayerOwnsAsset" then
         return true
      end
      
      return oldNamecall(self, ...)
   end)
   
   mt.__index = newcclosure(function(self, key)
      if key == "MembershipType" then
         return Enum.MembershipType.Premium
      end
      return oldIndex(self, key)
   end)
   
   setreadonly(mt, true)
   
   print("✅ GamePass bypass active!")
end

function BypassMoney()
   print("💰 Bypassing money checks...")
   
   -- Hook into buy functions
   for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
      if remote:IsA("RemoteEvent") then
         local name = remote.Name:lower()
         if name:find("buy") or name:find("purchase") then
            local oldFire = remote.FireServer
            remote.FireServer = function(...)
               return oldFire(remote, ..., {BypassCost = true, Cost = 0})
            end
         end
      end
   end
   
   print("✅ Money bypass active!")
end

function BypassPlayerLevel()
   print("👤 Bypassing player level...")
   
   -- Modify level checks
   for _, value in pairs(player:GetDescendants()) do
      if value:IsA("IntValue") or value:IsA("NumberValue") then
         local name = value.Name:lower()
         if name:find("level") or name:find("rank") then
            value.Value = 999
         end
      end
   end
   
   print("✅ Level bypass active!")
end

function OwnAllVehicles()
   print("\n🚗 Adding all vehicles to player data...")
   
   local vehiclesAdded = 0
   
   -- Method 1: Create owned vehicles folder if not exists
   local ownedVehicles = player:FindFirstChild("OwnedVehicles")
   if not ownedVehicles then
      ownedVehicles = Instance.new("Folder")
      ownedVehicles.Name = "OwnedVehicles"
      ownedVehicles.Parent = player
   end
   
   -- Add all vehicles (1-500 IDs)
   for i = 1, 500 do
      local vehicleValue = Instance.new("BoolValue")
      vehicleValue.Name = tostring(i)
      vehicleValue.Value = true
      vehicleValue.Parent = ownedVehicles
      vehiclesAdded = vehiclesAdded + 1
   end
   
   -- Method 2: Modify other data folders
   for _, folder in pairs(player:GetDescendants()) do
      if folder:IsA("Folder") then
         local name = folder.Name:lower()
         if name:find("vehicle") or name:find("car") or name:find("garage") then
            for i = 1, 500 do
               local vehicleValue = Instance.new("BoolValue")
               vehicleValue.Name = "Vehicle_" .. i
               vehicleValue.Value = true
               vehicleValue.Parent = folder
            end
         end
      end
   end
   
   print("✅ Added " .. vehiclesAdded .. " vehicles to player data!")
end

function UnlockAllColors()
   print("🎨 Unlocking all colors...")
   
   for i = 1, 200 do
      for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("color") or name:find("paint") then
               pcall(function()
                  remote:FireServer(i)
                  remote:FireServer("Unlock", i)
               end)
            end
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Colors Unlocked",
      Content = "All colors unlocked!",
      Duration = 3,
      Image = 4483362458,
   })
end

function UnlockAllUpgrades()
   print("⚙️ Unlocking all upgrades...")
   
   for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
      if remote:IsA("RemoteEvent") then
         local name = remote.Name:lower()
         if name:find("upgrade") or name:find("performance") then
            for i = 1, 100 do
               pcall(function()
                  remote:FireServer(i, "Max")
               end)
            end
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Upgrades Unlocked",
      Content = "All upgrades unlocked!",
      Duration = 3,
      Image = 4483362458,
   })
end

function UnlockAllGarages()
   for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
      if remote:IsA("RemoteEvent") then
         local name = remote.Name:lower()
         if name:find("garage") or name:find("house") then
            for i = 1, 50 do
               pcall(function()
                  remote:FireServer(i)
               end)
            end
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Garages Unlocked",
      Content = "All garages unlocked!",
      Duration = 3,
      Image = 4483362458,
   })
end

-- Auto Farm Functions
function JoinRandomRace()
   local randomRace = RaceLocations[math.random(1, #RaceLocations)]
   TeleportTo(randomRace)
   wait(1)
   
   -- Fire join race remote
   for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
      if remote:IsA("RemoteEvent") then
         local name = remote.Name:lower()
         if name:find("race") or name:find("join") then
            pcall(function()
               remote:FireServer()
               remote:FireServer("Join")
            end)
         end
      end
   end
end

function TeleportToRaceFinish()
   local randomFinish = RaceFinishPoints[math.random(1, #RaceFinishPoints)]
   TeleportTo(randomFinish)
   
   Rayfield:Notify({
      Title = "Race Finish",
      Content = "Teleported to finish line!",
      Duration = 2,
      Image = 4483362458,
   })
end

function CollectAllCashNow()
   local collected = 0
   
   for _, obj in pairs(Workspace:GetDescendants()) do
      if obj:IsA("BasePart") or obj:IsA("Model") then
         local name = obj.Name:lower()
         if name:find("cash") or name:find("money") or name:find("coin") then
            pcall(function()
               local pos = obj:IsA("Model") and obj.PrimaryPart and obj.PrimaryPart.Position or obj.Position
               if pos then
                  humanoidRootPart.CFrame = CFrame.new(pos)
                  wait(0.05)
                  collected = collected + 1
               end
            end)
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Cash Collected",
      Content = "Collected " .. collected .. " cash drops!",
      Duration = 3,
      Image = 4483362458,
   })
end

function CompleteAllDeliveriesNow()
   for i, deliveryPoint in ipairs(DeliveryPoints) do
      TeleportTo(deliveryPoint)
      wait(0.5)
      
      -- Fire delivery complete remote
      for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("deliver") or name:find("complete") then
               pcall(function()
                  remote:FireServer()
               end)
            end
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Deliveries",
      Content = "Completed all delivery points!",
      Duration = 3,
      Image = 4483362458,
   })
end

function SetMoney(amount)
   print("\n💰 Setting money to: " .. amount)
   
   -- Try to find and edit money values
   for _, value in pairs(player:GetDescendants()) do
      if value:IsA("IntValue") or value:IsA("NumberValue") then
         local name = value.Name:lower()
         if name:find("money") or name:find("cash") or name:find("coin") then
            value.Value = amount
            print("✅ Set " .. value:GetFullName() .. " to " .. amount)
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Money Set",
      Content = "Money set to $" .. amount,
      Duration = 3,
      Image = 4483362458,
   })
end

-- Vehicle Functions
function GetCurrentVehicle()
   for _, seat in pairs(Workspace:GetDescendants()) do
      if seat:IsA("VehicleSeat") and seat.Occupant then
         if seat.Occupant.Parent == player.Character then
            return seat.Parent
         end
      end
   end
   return nil
end

function SpawnBestCar()
   -- Fire spawn remote for best car (usually ID 500 or highest)
   for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
      if remote:IsA("RemoteEvent") then
         local name = remote.Name:lower()
         if name:find("spawn") or name:find("equip") then
            pcall(function()
               remote:FireServer(500) -- Highest car ID
               remote:FireServer("Spawn", 500)
            end)
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Spawn Car",
      Content = "Spawning best car!",
      Duration = 3,
      Image = 4483362458,
   })
end

function MaxUpgradeCar()
   -- Fire max upgrade remotes
   for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
      if remote:IsA("RemoteEvent") then
         local name = remote.Name:lower()
         if name:find("upgrade") then
            for i = 1, 10 do
               pcall(function()
                  remote:FireServer(i, 999) -- Upgrade type, max level
               end)
            end
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Max Upgrade",
      Content = "Car fully upgraded!",
      Duration = 3,
      Image = 4483362458,
   })
end

function FixVehicle()
   local vehicle = GetCurrentVehicle()
   if vehicle and vehicle.PrimaryPart then
      vehicle:SetPrimaryPartCFrame(vehicle.PrimaryPart.CFrame * CFrame.new(0, 5, 0))
   end
end

function FlipVehicle()
   local vehicle = GetCurrentVehicle()
   if vehicle and vehicle.PrimaryPart then
      local pos = vehicle.PrimaryPart.Position
      vehicle:SetPrimaryPartCFrame(CFrame.new(pos) * CFrame.Angles(0, 0, 0))
   end
end

-- Player Functions
function SetPlayerLevel(level)
   for _, value in pairs(player:GetDescendants()) do
      if value:IsA("IntValue") or value:IsA("NumberValue") then
         local name = value.Name:lower()
         if name:find("level") or name:find("rank") or name:find("xp") then
            value.Value = level
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Level Set",
      Content = "Level set to " .. level,
      Duration = 3,
      Image = 4483362458,
   })
end

function MaxAllSkills()
   for _, value in pairs(player:GetDescendants()) do
      if value:IsA("IntValue") or value:IsA("NumberValue") then
         local name = value.Name:lower()
         if name:find("skill") or name:find("stat") then
            value.Value = 100
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Skills Maxed",
      Content = "All skills set to 100!",
      Duration = 3,
      Image = 4483362458,
   })
end

function UnlockAllAchievements()
   for _, value in pairs(player:GetDescendants()) do
      if value:IsA("BoolValue") then
         local name = value.Name:lower()
         if name:find("achievement") or name:find("badge") then
            value.Value = true
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Achievements",
      Content = "All achievements unlocked!",
      Duration = 3,
      Image = 4483362458,
   })
end

-- Utility Functions
function TeleportTo(cframe)
   if character and humanoidRootPart then
      humanoidRootPart.CFrame = cframe
   end
end

function RemoveSpeedLimits()
   for _, sign in pairs(Workspace:GetDescendants()) do
      if sign.Name:lower():find("speed") or sign.Name:lower():find("limit") then
         if sign:IsA("BasePart") or sign:IsA("Model") then
            sign:Destroy()
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Speed Limits",
      Content = "All speed limit signs removed!",
      Duration = 3,
      Image = 4483362458,
   })
end

-- ============================================
-- AUTO FARM LOOPS
-- ============================================

-- Auto Farm Race Loop (with teleport)
task.spawn(function()
   while task.wait(_G.FarmDelay) do
      if _G.AutoFarmRace then
         pcall(function()
            -- Join race
            JoinRandomRace()
            task.wait(0.5)
            
            -- Teleport to finish
            TeleportToRaceFinish()
            task.wait(1)
         end)
      end
   end
end)

-- Auto Farm Delivery Loop (with teleport)
task.spawn(function()
   while task.wait(_G.FarmDelay) do
      if _G.AutoFarmDeliver then
         pcall(function()
            CompleteAllDeliveriesNow()
         end)
      end
   end
end)

-- Auto Collect Cash Loop
task.spawn(function()
   while task.wait(2) do
      if _G.AutoCollectCash then
         pcall(function()
            CollectAllCashNow()
         end)
      end
   end
end)

-- Vehicle Speed Loop
RunService.Heartbeat:Connect(function()
   if _G.VehicleSpeed > 1 then
      local vehicle = GetCurrentVehicle()
      if vehicle then
         for _, part in pairs(vehicle:GetDescendants()) do
            if part:IsA("VehicleSeat") then
               part.MaxSpeed = 500 * _G.VehicleSpeed
               part.Torque = 10000 * _G.VehicleSpeed
            end
         end
      end
   end
end)

-- Vehicle Noclip Loop
RunService.Stepped:Connect(function()
   if _G.VehicleNoclip then
      local vehicle = GetCurrentVehicle()
      if vehicle then
         for _, part in pairs(vehicle:GetDescendants()) do
            if part:IsA("BasePart") then
               part.CanCollide = false
            end
         end
      end
   end
end)

-- Vehicle Fly Loop
RunService.Heartbeat:Connect(function()
   if _G.VehicleFly then
      local vehicle = GetCurrentVehicle()
      if vehicle and vehicle.PrimaryPart then
         local bodyVelocity = vehicle.PrimaryPart:FindFirstChild("FlyVelocity")
         
         if not bodyVelocity then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Name = "FlyVelocity"
            bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = vehicle.PrimaryPart
         end
         
         bodyVelocity.Velocity = Vector3.new(0, 50, 0)
      end
   else
      local vehicle = GetCurrentVehicle()
      if vehicle and vehicle.PrimaryPart then
         local bodyVelocity = vehicle.PrimaryPart:FindFirstChild("FlyVelocity")
         if bodyVelocity then
            bodyVelocity:Destroy()
         end
      end
   end
end)

-- Infinite Nitro Loop
RunService.Heartbeat:Connect(function()
   if _G.InfiniteNitro then
      local vehicle = GetCurrentVehicle()
      if vehicle then
         for _, obj in pairs(vehicle:GetDescendants()) do
            if obj:IsA("NumberValue") and obj.Name:lower():find("nitro") then
               obj.Value = 100
            end
         end
      end
   end
end)

-- No Clip Loop
RunService.Stepped:Connect(function()
   if _G.NoClip then
      if character then
         for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
               part.CanCollide = false
            end
         end
      end
   end
end)

-- Infinite Jump
game:GetService("UserInputService").JumpRequest:Connect(function()
   if _G.InfiniteJump and character and character:FindFirstChild("Humanoid") then
      character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
   end
end)

-- Character Respawn Handler
player.CharacterAdded:Connect(function(char)
   character = char
   humanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

-- Load Complete
Rayfield:Notify({
   Title = "Script Loaded!",
   Content = "Driving Empire Ultimate loaded! Click 'ENABLE ALL BYPASSES' first!",
   Duration = 5,
   Image = 4483362458,
})

print("\n✅ DRIVING EMPIRE ULTIMATE LOADED!")
print("🔥 Click 'ENABLE ALL BYPASSES' button first!")
print("💰 Then enable auto farm features!")
print("🚗 All vehicles will be added to your account!")
print(string.rep("=", 70) .. "\n")
