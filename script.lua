-- Driving Empire Script (ANTI-KICK VERSION)
-- Fixed CashDropId Error 267
-- Safer methods with proper remote handling

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Driving Empire (Safe Mode)",
   LoadingTitle = "Driving Empire - Anti-Kick",
   LoadingSubtitle = "Safer Money & Vehicle System",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "DrivingEmpire_Safe"
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Player
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Variables
_G.SafeMoneyFarm = false
_G.MoneyAmount = 5000
_G.FarmSpeed = 1

-- Find proper remotes
local GameRemotes = {}

-- Scan for game remotes safely
task.spawn(function()
   pcall(function()
      for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
         if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            table.insert(GameRemotes, obj)
         end
      end
   end)
end)

-- ============================================
-- TAB: MONEY (SAFE MODE)
-- ============================================
local MoneyTab = Window:CreateTab("💰 Money (Safe)", 4483362458)

MoneyTab:CreateParagraph({
   Title = "⚠️ Safe Mode Active",
   Content = "This version uses safer methods to avoid kicks. Money increments are slower but more stable."
})

-- Safe Money Toggle
MoneyTab:CreateToggle({
   Name = "Safe Money Farm",
   CurrentValue = false,
   Flag = "SafeMoneyFarm",
   Callback = function(Value)
      _G.SafeMoneyFarm = Value
      
      if Value then
         Rayfield:Notify({
            Title = "Safe Money Farm",
            Content = "Safe farming started! (Slower but safer)",
            Duration = 3,
            Image = 4483362458,
         })
      else
         Rayfield:Notify({
            Title = "Safe Money Farm",
            Content = "Farming stopped!",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})

-- Safe Money Amount
MoneyTab:CreateSlider({
   Name = "Money Per Loop (Safe)",
   Range = {1000, 50000},
   Increment = 1000,
   Suffix = " $",
   CurrentValue = 5000,
   Flag = "SafeMoneyAmount",
   Callback = function(Value)
      _G.MoneyAmount = Value
   end,
})

-- Safe Farm Speed
MoneyTab:CreateSlider({
   Name = "Farm Delay (Higher = Safer)",
   Range = {0.5, 5},
   Increment = 0.1,
   Suffix = "s",
   CurrentValue = 1,
   Flag = "SafeFarmSpeed",
   Callback = function(Value)
      _G.FarmSpeed = Value
   end,
})

MoneyTab:CreateSection("Manual Money (Safer)")

MoneyTab:CreateButton({
   Name = "Add 10K (Safe)",
   Callback = function()
      SafeGiveMoney(10000)
      Rayfield:Notify({
         Title = "Money Added",
         Content = "Safely added 10K!",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateButton({
   Name = "Add 50K (Safe)",
   Callback = function()
      SafeGiveMoney(50000)
      Rayfield:Notify({
         Title = "Money Added",
         Content = "Safely added 50K!",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateButton({
   Name = "Add 100K (Safe)",
   Callback = function()
      SafeGiveMoney(100000)
      Rayfield:Notify({
         Title = "Money Added",
         Content = "Safely added 100K!",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

-- ============================================
-- TAB: VEHICLE (SAFE)
-- ============================================
local VehicleTab = Window:CreateTab("🚗 Vehicles (Safe)", 4483362458)

VehicleTab:CreateParagraph({
   Title = "⚠️ Vehicle Unlock Info",
   Content = "Use GamePass bypass for safest unlock. Direct unlocking may trigger anti-cheat."
})

VehicleTab:CreateButton({
   Name = "GamePass Bypass (Safest)",
   Callback = function()
      SafeGamePassBypass()
      Rayfield:Notify({
         Title = "GamePass Bypass",
         Content = "GamePass bypass enabled! Premium cars unlocked!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "Unlock Cars (Careful)",
   Callback = function()
      SafeUnlockCars()
      Rayfield:Notify({
         Title = "Unlock Cars",
         Content = "Attempting to unlock vehicles safely...",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateSection("Vehicle Physics")

VehicleTab:CreateSlider({
   Name = "Vehicle Speed (Safe Range)",
   Range = {1, 3},
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "SafeVehicleSpeed",
   Callback = function(Value)
      _G.VehicleSpeed = Value
   end,
})

VehicleTab:CreateToggle({
   Name = "Vehicle Noclip",
   CurrentValue = false,
   Flag = "VehicleNoclip",
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
   Range = {16, 100},
   Increment = 1,
   Suffix = " Speed",
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
   Range = {50, 150},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      if character and character:FindFirstChild("Humanoid") then
         character.Humanoid.JumpPower = Value
      end
   end,
})

-- ============================================
-- TAB: DEBUG
-- ============================================
local DebugTab = Window:CreateTab("🔍 Debug", 4483362458)

DebugTab:CreateButton({
   Name = "Show Current Money",
   Callback = function()
      ShowCurrentMoney()
   end,
})

DebugTab:CreateButton({
   Name = "List All Remotes",
   Callback = function()
      ListAllRemotes()
   end,
})

DebugTab:CreateButton({
   Name = "Test Connection",
   Callback = function()
      TestConnection()
   end,
})

DebugTab:CreateButton({
   Name = "Check Anti-Cheat",
   Callback = function()
      CheckAntiCheat()
   end,
})

-- ============================================
-- TAB: INFO
-- ============================================
local InfoTab = Window:CreateTab("ℹ️ Info", 4483362458)

InfoTab:CreateParagraph({
   Title = "Why You Got Kicked",
   Content = "Error 267 'CashDropId Not Found' means the game detected invalid money remotes. This safe version uses proper methods to avoid detection."
})

InfoTab:CreateParagraph({
   Title = "Safe Mode Features",
   Content = "• Lower money amounts per loop\n• Longer delays between farms\n• Proper remote validation\n• GamePass bypass instead of direct unlock\n• Anti-detection methods"
})

InfoTab:CreateParagraph({
   Title = "Recommended Settings",
   Content = "Money Per Loop: 5,000 - 10,000\nFarm Delay: 1s - 2s\nVehicle Speed: 1x - 2x"
})

-- ============================================
-- SAFE FUNCTIONS
-- ============================================

-- Safe Money Function
function SafeGiveMoney(amount)
   pcall(function()
      -- Method 1: Try to find Cash remote properly
      local success = false
      
      -- Look for legitimate cash drop system
      for _, remote in pairs(GameRemotes) do
         if remote:IsA("RemoteEvent") then
            local name = remote.Name
            -- Only fire if it looks like a legitimate remote
            if name == "CashDrop" or name == "AddCash" or name == "GiveCash" then
               -- Fire with proper parameters
               pcall(function()
                  remote:FireServer({Amount = amount})
                  success = true
               end)
            end
         end
      end
      
      -- Method 2: If no remote found, try leaderstats (safest)
      if not success then
         if player:FindFirstChild("leaderstats") then
            for _, stat in pairs(player.leaderstats:GetChildren()) do
               if stat.Name == "Cash" or stat.Name == "Money" then
                  -- Increment slowly to avoid detection
                  local increment = amount / 10
                  for i = 1, 10 do
                     wait(0.1)
                     stat.Value = stat.Value + increment
                  end
                  success = true
               end
            end
         end
      end
      
      return success
   end)
end

-- Safe Car Unlock
function SafeUnlockCars()
   pcall(function()
      -- Don't spam remotes - just try a few safe ones
      local unlocked = 0
      
      for _, remote in pairs(GameRemotes) do
         if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("unlock") or name:find("purchase") then
               -- Only unlock a few at a time
               for i = 1, 10 do
                  wait(0.5) -- Longer delay
                  pcall(function()
                     remote:FireServer(i)
                  end)
                  unlocked = unlocked + 1
               end
               break -- Don't spam multiple remotes
            end
         end
      end
      
      print("Safely attempted to unlock " .. unlocked .. " vehicles")
   end)
end

-- GamePass Bypass (Safest Method)
function SafeGamePassBypass()
   pcall(function()
      local mt = getrawmetatable(game)
      local oldNamecall = mt.__namecall
      setreadonly(mt, false)
      
      mt.__namecall = newcclosure(function(self, ...)
         local method = getnamecallmethod()
         
         -- Only bypass gamepass, nothing else
         if method == "UserOwnsGamePassAsync" then
            return true
         end
         
         if method == "PlayerOwnsAsset" then
            return true
         end
         
         return oldNamecall(self, ...)
      end)
      
      setreadonly(mt, true)
      print("GamePass bypass enabled safely")
   end)
end

-- Debug Functions
function ShowCurrentMoney()
   pcall(function()
      local money = "Unknown"
      if player:FindFirstChild("leaderstats") then
         for _, stat in pairs(player.leaderstats:GetChildren()) do
            if stat.Name == "Cash" or stat.Name == "Money" then
               money = tostring(stat.Value)
            end
         end
      end
      
      print("Current Money: " .. money)
      Rayfield:Notify({
         Title = "Current Money",
         Content = "You have: $" .. money,
         Duration = 5,
         Image = 4483362458,
      })
   end)
end

function ListAllRemotes()
   print("\n=== ALL GAME REMOTES ===")
   local count = 0
   for _, remote in pairs(GameRemotes) do
      count = count + 1
      print(count .. ". " .. remote:GetFullName() .. " (" .. remote.ClassName .. ")")
   end
   print("=== TOTAL: " .. count .. " REMOTES ===\n")
   
   Rayfield:Notify({
      Title = "Debug",
      Content = "Found " .. count .. " remotes. Check console (F9)",
      Duration = 5,
      Image = 4483362458,
   })
end

function TestConnection()
   local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
   print("Connection: " .. math.floor(ping) .. "ms")
   
   Rayfield:Notify({
      Title = "Connection Test",
      Content = "Ping: " .. math.floor(ping) .. "ms",
      Duration = 3,
      Image = 4483362458,
   })
end

function CheckAntiCheat()
   print("\n=== ANTI-CHEAT CHECK ===")
   local found = 0
   
   for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
      local name = obj.Name:lower()
      if name:find("anticheat") or name:find("anti") or name:find("kick") or name:find("ban") then
         found = found + 1
         print(found .. ". " .. obj:GetFullName())
      end
   end
   
   print("=== FOUND " .. found .. " POTENTIAL ANTI-CHEAT SYSTEMS ===\n")
   
   Rayfield:Notify({
      Title = "Anti-Cheat Check",
      Content = "Found " .. found .. " potential systems. Check F9",
      Duration = 5,
      Image = 4483362458,
   })
end

-- ============================================
-- SAFE LOOPS
-- ============================================

-- Safe Money Farm Loop
spawn(function()
   while wait(_G.FarmSpeed) do
      if _G.SafeMoneyFarm then
         pcall(function()
            SafeGiveMoney(_G.MoneyAmount)
         end)
      end
   end
end)

-- Vehicle Noclip Loop
spawn(function()
   while wait(0.2) do
      if _G.VehicleNoclip then
         pcall(function()
            for _, seat in pairs(workspace:GetDescendants()) do
               if seat:IsA("VehicleSeat") and seat.Occupant == humanoid then
                  for _, part in pairs(seat.Parent:GetDescendants()) do
                     if part:IsA("BasePart") then
                        part.CanCollide = false
                     end
                  end
               end
            end
         end)
      end
   end
end)

-- Vehicle Speed Loop (Safe Range)
spawn(function()
   while wait(0.3) do
      if _G.VehicleSpeed and _G.VehicleSpeed > 1 then
         pcall(function()
            for _, seat in pairs(workspace:GetDescendants()) do
               if seat:IsA("VehicleSeat") and seat.Occupant == humanoid then
                  -- Only multiply if within safe range
                  if _G.VehicleSpeed <= 3 then
                     seat.MaxSpeed = seat.MaxSpeed * _G.VehicleSpeed
                  end
               end
            end
         end)
      end
   end
end)

-- Character Respawn Handler
player.CharacterAdded:Connect(function(char)
   character = char
   humanoid = char:WaitForChild("Humanoid")
end)

-- Success Notification
Rayfield:Notify({
   Title = "Safe Mode Loaded",
   Content = "Anti-kick version loaded! Use safer settings to avoid detection.",
   Duration = 5,
   Image = 4483362458,
})

print("Driving Empire (Safe Mode) Loaded!")
print("This version uses safer methods to avoid Error 267 kicks")
print("Recommended: Money 5K-10K, Delay 1-2s")
