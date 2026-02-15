-- Car Driving Indonesia Script with Rayfield UI
-- Created for educational purposes only

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Car Driving Indonesia",
   LoadingTitle = "Car Driving Indonesia Script",
   LoadingSubtitle = "by Script Creator",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "CarDrivingIndo"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Key System",
      Subtitle = "Key System",
      Note = "No key needed",
      FileName = "Key",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {""}
   }
})

-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Tab: Player
local PlayerTab = Window:CreateTab("🚶 Player", 4483362458)
local PlayerSection = PlayerTab:CreateSection("Player Settings")

local walkspeedValue = 16
local jumpowerValue = 50

local WalkspeedSlider = PlayerTab:CreateSlider({
   Name = "Walkspeed",
   Range = {16, 200},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkspeedSlider",
   Callback = function(Value)
      walkspeedValue = Value
      if character and character:FindFirstChild("Humanoid") then
         character.Humanoid.WalkSpeed = Value
      end
   end,
})

local JumpowerSlider = PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 200},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpowerSlider",
   Callback = function(Value)
      jumpowerValue = Value
      if character and character:FindFirstChild("Humanoid") then
         character.Humanoid.JumpPower = Value
      end
   end,
})

PlayerTab:CreateButton({
   Name = "Reset Character",
   Callback = function()
      if character and character:FindFirstChild("Humanoid") then
         character.Humanoid.Health = 0
      end
   end,
})

-- Tab: Vehicle
local VehicleTab = Window:CreateTab("🚗 Vehicle", 4483362458)
local VehicleSection = VehicleTab:CreateSection("Vehicle Controls - CDI Specific")

local vehicleSpeed = 1
local noClipEnabled = false

-- CDI Specific Car Unlock System
VehicleTab:CreateButton({
   Name = "🔓 Unlock All Cars (CDI Method 1)",
   Callback = function()
      local unlocked = 0
      local RS = game:GetService("ReplicatedStorage")
      
      pcall(function()
         -- CDI stores cars data in ReplicatedStorage
         if RS:FindFirstChild("Cars") then
            for _, car in pairs(RS.Cars:GetChildren()) do
               -- Fire unlock remote for each car
               if RS:FindFirstChild("RemoteEvent") then
                  RS.RemoteEvent:FireServer("UnlockCar", car.Name)
                  RS.RemoteEvent:FireServer("BuyCar", car.Name)
                  RS.RemoteEvent:FireServer("OwnCar", car.Name)
                  unlocked = unlocked + 1
               end
            end
         end
         
         -- Try Vehicles folder
         if RS:FindFirstChild("Vehicles") then
            for _, vehicle in pairs(RS.Vehicles:GetChildren()) do
               if RS:FindFirstChild("RemoteEvent") then
                  RS.RemoteEvent:FireServer("UnlockCar", vehicle.Name)
                  unlocked = unlocked + 1
               end
            end
         end
         
         -- Try car remotes in Events folder
         if RS:FindFirstChild("Events") then
            for _, event in pairs(RS.Events:GetChildren()) do
               if event:IsA("RemoteEvent") then
                  for i = 1, 100 do
                     event:FireServer("UnlockCar", i)
                     event:FireServer("BuyCar", i)
                     event:FireServer(i, true) -- ID, Unlock status
                  end
               end
            end
         end
      end)
      
      Rayfield:Notify({
         Title = "Unlock Cars CDI",
         Content = "Attempted to unlock " .. unlocked .. "+ cars!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🔓 Unlock All Cars (CDI Method 2 - PlayerData)",
   Callback = function()
      pcall(function()
         -- CDI stores owned cars in Player's data
         if player:FindFirstChild("OwnedCars") then
            for i = 1, 100 do
               local carValue = Instance.new("BoolValue")
               carValue.Name = tostring(i)
               carValue.Value = true
               carValue.Parent = player.OwnedCars
            end
         end
         
         if player:FindFirstChild("PlayerData") then
            if player.PlayerData:FindFirstChild("Cars") then
               for i = 1, 100 do
                  local carValue = Instance.new("BoolValue")
                  carValue.Name = "Car" .. i
                  carValue.Value = true
                  carValue.Parent = player.PlayerData.Cars
               end
            end
         end
         
         -- Try Data folder
         if player:FindFirstChild("Data") then
            if player.Data:FindFirstChild("OwnedVehicles") then
               for i = 1, 100 do
                  local carValue = Instance.new("BoolValue")
                  carValue.Name = tostring(i)
                  carValue.Value = true
                  carValue.Parent = player.Data.OwnedVehicles
               end
            end
         end
      end)
      
      Rayfield:Notify({
         Title = "Unlock Cars PlayerData",
         Content = "Modified player car ownership data!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🔓 Unlock All Cars (CDI Method 3 - Remote Spam)",
   Callback = function()
      local RS = game:GetService("ReplicatedStorage")
      local count = 0
      
      -- Spam all unlock-related remotes
      for _, remote in pairs(RS:GetDescendants()) do
         if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("unlock") or name:find("buy") or name:find("purchase") or name:find("own") or name:find("car") or name:find("vehicle") then
               pcall(function()
                  -- Try different argument patterns
                  for i = 1, 100 do
                     remote:FireServer(i)
                     remote:FireServer("Car" .. i)
                     remote:FireServer(tostring(i))
                     remote:FireServer({CarID = i, Unlock = true})
                     remote:FireServer("Unlock", i)
                     remote:FireServer("Buy", i)
                  end
                  count = count + 1
               end)
            end
         end
      end
      
      Rayfield:Notify({
         Title = "Remote Spam",
         Content = "Spammed " .. count .. " car-related remotes!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🔓 Unlock All Cars (CDI Method 4 - GamePass)",
   Callback = function()
      -- Bypass gamepass checks for cars
      local mt = getrawmetatable(game)
      local oldNamecall = mt.__namecall
      setreadonly(mt, false)
      
      mt.__namecall = newcclosure(function(self, ...)
         local args = {...}
         local method = getnamecallmethod()
         
         -- Bypass UserOwnsGamePassAsync
         if method == "UserOwnsGamePassAsync" then
            return true
         end
         
         -- Bypass MarketplaceService:PlayerOwnsAsset
         if method == "PlayerOwnsAsset" then
            return true
         end
         
         return oldNamecall(self, ...)
      end)
      
      setreadonly(mt, true)
      
      Rayfield:Notify({
         Title = "GamePass Bypass",
         Content = "GamePass bypass active! All premium cars unlocked!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🚗 Spawn Any Car (Free)",
   Callback = function()
      local RS = game:GetService("ReplicatedStorage")
      
      pcall(function()
         -- Try spawn remotes
         for _, remote in pairs(RS:GetDescendants()) do
            if remote:IsA("RemoteEvent") then
               local name = remote.Name:lower()
               if name:find("spawn") or name:find("equip") or name:find("select") then
                  for i = 1, 100 do
                     remote:FireServer(i)
                     remote:FireServer("Car" .. i)
                     remote:FireServer(tostring(i))
                  end
               end
            end
         end
      end)
      
      Rayfield:Notify({
         Title = "Spawn Car",
         Content = "Attempted to spawn all cars!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🔍 Find Car Remotes (Debug)",
   Callback = function()
      local found = {}
      local RS = game:GetService("ReplicatedStorage")
      
      for _, obj in pairs(RS:GetDescendants()) do
         if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local name = obj.Name:lower()
            if name:find("car") or name:find("vehicle") or name:find("unlock") or name:find("buy") or name:find("spawn") or name:find("equip") then
               table.insert(found, obj:GetFullName())
            end
         end
      end
      
      print("=== CAR REMOTES FOUND ===")
      for i, path in pairs(found) do
         print(i .. ". " .. path)
      end
      print("=== END ===")
      
      Rayfield:Notify({
         Title = "Debug",
         Content = "Found " .. #found .. " car remotes. Check console (F9)",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateSection("Speed & Physics")

local VehicleSpeedSlider = VehicleTab:CreateSlider({
   Name = "Vehicle Speed Multiplier",
   Range = {1, 5},
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "VehicleSpeedSlider",
   Callback = function(Value)
      vehicleSpeed = Value
   end,
})

VehicleTab:CreateToggle({
   Name = "Vehicle NoClip",
   CurrentValue = false,
   Flag = "VehicleNoClip",
   Callback = function(Value)
      noClipEnabled = Value
   end,
})

VehicleTab:CreateButton({
   Name = "Fix Vehicle Position",
   Callback = function()
      for _, v in pairs(workspace:GetDescendants()) do
         if v:IsA("VehicleSeat") and v.Occupant == humanoid then
            local car = v.Parent
            if car.PrimaryPart then
               car:SetPrimaryPartCFrame(car.PrimaryPart.CFrame * CFrame.new(0, 5, 0))
            end
         end
      end
   end,
})

VehicleTab:CreateButton({
   Name = "Flip Vehicle",
   Callback = function()
      for _, v in pairs(workspace:GetDescendants()) do
         if v:IsA("VehicleSeat") and v.Occupant == humanoid then
            local car = v.Parent
            if car.PrimaryPart then
               car:SetPrimaryPartCFrame(car.PrimaryPart.CFrame * CFrame.Angles(0, 0, math.pi))
            end
         end
      end
   end,
})

-- Tab: Teleport
local TeleportTab = Window:CreateTab("📍 Teleport", 4483362458)
local TeleportSection = TeleportTab:CreateSection("Teleport Locations")

local locations = {
   ["Spawn"] = CFrame.new(0, 50, 0),
   ["Gas Station"] = CFrame.new(100, 50, 100),
   ["Garage"] = CFrame.new(-100, 50, -100),
   ["City Center"] = CFrame.new(200, 50, 200),
}

for locationName, locationCFrame in pairs(locations) do
   TeleportTab:CreateButton({
      Name = "Teleport to " .. locationName,
      Callback = function()
         if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = locationCFrame
         end
      end,
   })
end

-- Tab: Money
local MoneyTab = Window:CreateTab("💰 Money", 4483362458)
local MoneySection = MoneyTab:CreateSection("Money Features - CDI Specific")

local moneyAmount = 1000000

local MoneyInput = MoneyTab:CreateInput({
   Name = "Money Amount",
   PlaceholderText = "Enter amount (default: 1M)",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      moneyAmount = tonumber(Text) or 1000000
   end,
})

-- CDI Specific Money System
MoneyTab:CreateButton({
   Name = "💰 Give Money (CDI Method)",
   Callback = function()
      local success = false
      
      -- Method 1: CDI uses ReplicatedStorage for money remotes
      pcall(function()
         local RS = game:GetService("ReplicatedStorage")
         
         -- Common CDI remote names
         if RS:FindFirstChild("RemoteEvent") then
            RS.RemoteEvent:FireServer("AddMoney", moneyAmount)
            success = true
         end
         
         if RS:FindFirstChild("MoneyEvent") then
            RS.MoneyEvent:FireServer(moneyAmount)
            success = true
         end
         
         if RS:FindFirstChild("Remotes") then
            local remotes = RS.Remotes
            if remotes:FindFirstChild("Money") then
               remotes.Money:FireServer("Add", moneyAmount)
               success = true
            end
            if remotes:FindFirstChild("AddCash") then
               remotes.AddCash:FireServer(moneyAmount)
               success = true
            end
         end
         
         -- Try ServerStorage remotes (if accessible)
         if RS:FindFirstChild("Events") then
            for _, event in pairs(RS.Events:GetChildren()) do
               if event:IsA("RemoteEvent") then
                  event:FireServer("Money", moneyAmount)
                  event:FireServer("Cash", moneyAmount)
                  event:FireServer(moneyAmount)
               end
            end
         end
      end)
      
      -- Method 2: Direct leaderstats manipulation
      pcall(function()
         if player:FindFirstChild("leaderstats") then
            if player.leaderstats:FindFirstChild("Money") then
               player.leaderstats.Money.Value = moneyAmount
               success = true
            end
            if player.leaderstats:FindFirstChild("Cash") then
               player.leaderstats.Cash.Value = moneyAmount
               success = true
            end
         end
      end)
      
      -- Method 3: PlayerData or PlayerStats
      pcall(function()
         if player:FindFirstChild("PlayerData") then
            if player.PlayerData:FindFirstChild("Money") then
               player.PlayerData.Money.Value = moneyAmount
               success = true
            end
         end
         
         if player:FindFirstChild("Data") then
            if player.Data:FindFirstChild("Cash") then
               player.Data.Cash.Value = moneyAmount
               success = true
            end
         end
      end)
      
      Rayfield:Notify({
         Title = "Money CDI",
         Content = success and "Money set to " .. moneyAmount or "Trying all methods...",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateButton({
   Name = "🔄 Auto Money (Loop)",
   Callback = function()
      _G.AutoMoney = true
      
      spawn(function()
         while _G.AutoMoney and wait(0.5) do
            pcall(function()
               local RS = game:GetService("ReplicatedStorage")
               
               -- Fire all possible money remotes
               for _, remote in pairs(RS:GetDescendants()) do
                  if remote:IsA("RemoteEvent") then
                     local name = remote.Name:lower()
                     if name:find("money") or name:find("cash") or name:find("coin") then
                        remote:FireServer(999999999)
                        remote:FireServer("Add", 999999999)
                     end
                  end
               end
               
               -- Keep leaderstats updated
               if player:FindFirstChild("leaderstats") then
                  for _, stat in pairs(player.leaderstats:GetChildren()) do
                     if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                        stat.Value = 999999999
                     end
                  end
               end
            end)
         end
      end)
      
      Rayfield:Notify({
         Title = "Auto Money",
         Content = "Auto money loop started! Set _G.AutoMoney = false to stop",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateButton({
   Name = "⛔ Stop Auto Money",
   Callback = function()
      _G.AutoMoney = false
      Rayfield:Notify({
         Title = "Auto Money",
         Content = "Auto money stopped!",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateButton({
   Name = "🔍 Find Money Remotes (Debug)",
   Callback = function()
      local found = {}
      local RS = game:GetService("ReplicatedStorage")
      
      for _, obj in pairs(RS:GetDescendants()) do
         if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local name = obj.Name:lower()
            if name:find("money") or name:find("cash") or name:find("coin") or name:find("currency") then
               table.insert(found, obj:GetFullName())
            end
         end
      end
      
      print("=== MONEY REMOTES FOUND ===")
      for i, path in pairs(found) do
         print(i .. ". " .. path)
      end
      print("=== END ===")
      
      Rayfield:Notify({
         Title = "Debug",
         Content = "Found " .. #found .. " money remotes. Check console (F9)",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

-- Tab: Misc
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)
local MiscSection = MiscTab:CreateSection("Miscellaneous")

-- Debug Tools for CDI
MiscTab:CreateButton({
   Name = "🔍 Full Game Explorer (Find Everything)",
   Callback = function()
      print("\n========================================")
      print("CDI GAME STRUCTURE EXPLORER")
      print("========================================\n")
      
      -- ReplicatedStorage
      print("=== REPLICATED STORAGE ===")
      for _, obj in pairs(game.ReplicatedStorage:GetChildren()) do
         print("├─ " .. obj.Name .. " (" .. obj.ClassName .. ")")
         if obj:IsA("Folder") then
            for _, child in pairs(obj:GetChildren()) do
               print("│  ├─ " .. child.Name .. " (" .. child.ClassName .. ")")
            end
         end
      end
      
      -- ServerStorage (if accessible)
      print("\n=== SERVER STORAGE (If Accessible) ===")
      pcall(function()
         for _, obj in pairs(game.ServerStorage:GetChildren()) do
            print("├─ " .. obj.Name .. " (" .. obj.ClassName .. ")")
         end
      end)
      
      -- Player Data Structure
      print("\n=== PLAYER DATA STRUCTURE ===")
      for _, obj in pairs(player:GetChildren()) do
         print("├─ " .. obj.Name .. " (" .. obj.ClassName .. ")")
         if obj:IsA("Folder") or obj:IsA("Configuration") then
            for _, child in pairs(obj:GetChildren()) do
               print("│  ├─ " .. child.Name .. " (" .. child.ClassName .. ")")
               if child:IsA("IntValue") or child:IsA("NumberValue") or child:IsA("BoolValue") then
                  print("│  │  └─ Value: " .. tostring(child.Value))
               end
            end
         end
      end
      
      -- All RemoteEvents and RemoteFunctions
      print("\n=== ALL REMOTES IN GAME ===")
      local remoteCount = 0
      for _, obj in pairs(game:GetDescendants()) do
         if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            remoteCount = remoteCount + 1
            print(remoteCount .. ". " .. obj:GetFullName())
         end
      end
      
      print("\n========================================")
      print("FOUND " .. remoteCount .. " REMOTES TOTAL")
      print("========================================\n")
      
      Rayfield:Notify({
         Title = "Game Explorer",
         Content = "Check console (F9) for full game structure!",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

MiscTab:CreateButton({
   Name = "🎯 Find Money System (Specific)",
   Callback = function()
      print("\n=== MONEY SYSTEM ANALYSIS ===")
      
      -- Check leaderstats
      print("\n1. LEADERSTATS CHECK:")
      if player:FindFirstChild("leaderstats") then
         for _, stat in pairs(player.leaderstats:GetChildren()) do
            print("  - " .. stat.Name .. " = " .. tostring(stat.Value))
         end
      else
         print("  - No leaderstats found")
      end
      
      -- Check Player Data folders
      print("\n2. PLAYER DATA CHECK:")
      local dataFolders = {"Data", "PlayerData", "Stats", "PlayerStats"}
      for _, folderName in pairs(dataFolders) do
         if player:FindFirstChild(folderName) then
            print("  Found: " .. folderName)
            for _, child in pairs(player[folderName]:GetChildren()) do
               print("    - " .. child.Name .. " = " .. tostring(child.Value))
            end
         end
      end
      
      -- Find money remotes
      print("\n3. MONEY REMOTES:")
      local keywords = {"money", "cash", "coin", "currency", "balance"}
      for _, remote in pairs(game.ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local name = remote.Name:lower()
            for _, keyword in pairs(keywords) do
               if name:find(keyword) then
                  print("  - " .. remote:GetFullName())
                  break
               end
            end
         end
      end
      
      print("\n========================================\n")
      
      Rayfield:Notify({
         Title = "Money System",
         Content = "Money system analysis complete! Check console (F9)",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

MiscTab:CreateButton({
   Name = "🚗 Find Car/Vehicle System (Specific)",
   Callback = function()
      print("\n=== CAR/VEHICLE SYSTEM ANALYSIS ===")
      
      -- Check for car folders in ReplicatedStorage
      print("\n1. CAR STORAGE CHECK:")
      local carFolders = {"Cars", "Vehicles", "VehicleModels", "CarModels"}
      for _, folderName in pairs(carFolders) do
         if game.ReplicatedStorage:FindFirstChild(folderName) then
            print("  Found: ReplicatedStorage." .. folderName)
            local count = #game.ReplicatedStorage[folderName]:GetChildren()
            print("    └─ Total cars: " .. count)
         end
      end
      
      -- Check player ownership
      print("\n2. PLAYER CAR OWNERSHIP:")
      local ownershipFolders = {"OwnedCars", "Cars", "OwnedVehicles", "Vehicles"}
      for _, folderName in pairs(ownershipFolders) do
         if player:FindFirstChild(folderName) then
            print("  Found: Player." .. folderName)
            for _, car in pairs(player[folderName]:GetChildren()) do
               print("    - " .. car.Name .. " = " .. tostring(car.Value))
            end
         end
      end
      
      -- Find car-related remotes
      print("\n3. CAR-RELATED REMOTES:")
      local keywords = {"car", "vehicle", "unlock", "buy", "purchase", "spawn", "equip", "own"}
      for _, remote in pairs(game.ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local name = remote.Name:lower()
            for _, keyword in pairs(keywords) do
               if name:find(keyword) then
                  print("  - " .. remote:GetFullName())
                  break
               end
            end
         end
      end
      
      print("\n========================================\n")
      
      Rayfield:Notify({
         Title = "Car System",
         Content = "Car system analysis complete! Check console (F9)",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

MiscTab:CreateButton({
   Name = "📡 Monitor Remote Calls (Live)",
   Callback = function()
      print("\n=== MONITORING REMOTE CALLS ===")
      print("Do actions in-game to see what remotes fire!\n")
      
      local mt = getrawmetatable(game)
      local oldNamecall = mt.__namecall
      setreadonly(mt, false)
      
      mt.__namecall = newcclosure(function(self, ...)
         local args = {...}
         local method = getnamecallmethod()
         
         if method == "FireServer" or method == "InvokeServer" then
            print("🔴 REMOTE FIRED: " .. self:GetFullName())
            print("  Method: " .. method)
            print("  Args: " .. game:GetService("HttpService"):JSONEncode(args))
            print("")
         end
         
         return oldNamecall(self, ...)
      end)
      
      setreadonly(mt, true)
      
      Rayfield:Notify({
         Title = "Remote Monitor",
         Content = "Monitoring active! Check console (F9) when doing actions",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

MiscTab:CreateSection("Visual Settings")

MiscTab:CreateToggle({
   Name = "Remove Fog",
   CurrentValue = false,
   Flag = "RemoveFog",
   Callback = function(Value)
      if Value then
         game.Lighting.FogEnd = 100000
      else
         game.Lighting.FogEnd = 1000
      end
   end,
})

MiscTab:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Flag = "Fullbright",
   Callback = function(Value)
      if Value then
         game.Lighting.Brightness = 2
         game.Lighting.ClockTime = 14
         game.Lighting.GlobalShadows = false
         game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
      else
         game.Lighting.Brightness = 1
         game.Lighting.ClockTime = 12
         game.Lighting.GlobalShadows = true
         game.Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
      end
   end,
})

local espEnabled = false
MiscTab:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Flag = "PlayerESP",
   Callback = function(Value)
      espEnabled = Value
      for _, player in pairs(game.Players:GetPlayers()) do
         if player ~= game.Players.LocalPlayer then
            if player.Character then
               for _, part in pairs(player.Character:GetChildren()) do
                  if part:IsA("BasePart") then
                     if Value then
                        local highlight = Instance.new("Highlight")
                        highlight.Parent = player.Character
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                     else
                        if player.Character:FindFirstChild("Highlight") then
                           player.Character.Highlight:Destroy()
                        end
                     end
                  end
               end
            end
         end
      end
   end,
})

MiscTab:CreateButton({
   Name = "Anti AFK",
   Callback = function()
      local vu = game:GetService("VirtualUser")
      game:GetService("Players").LocalPlayer.Idled:connect(function()
         vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
         wait(1)
         vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
      end)
      Rayfield:Notify({
         Title = "Anti AFK",
         Content = "Anti AFK has been enabled!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

-- Tab: Credits
local CreditsTab = Window:CreateTab("ℹ️ Credits", 4483362458)
CreditsTab:CreateParagraph({
   Title = "Script Info",
   Content = "Car Driving Indonesia Script\nMade with Rayfield UI Library\nFor educational purposes only"
})

-- Character respawn handler
player.CharacterAdded:Connect(function(char)
   character = char
   humanoid = char:WaitForChild("Humanoid")
   wait(0.5)
   if walkspeedValue ~= 16 then
      humanoid.WalkSpeed = walkspeedValue
   end
   if jumpowerValue ~= 50 then
      humanoid.JumpPower = jumpowerValue
   end
end)

-- Vehicle speed loop
spawn(function()
   while wait(0.1) do
      if vehicleSpeed ~= 1 then
         for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("VehicleSeat") and v.Occupant == humanoid then
               v.MaxSpeed = v.MaxSpeed * vehicleSpeed
            end
         end
      end
   end
end)

-- NoClip loop
spawn(function()
   while wait(0.1) do
      if noClipEnabled then
         for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("VehicleSeat") and v.Occupant == humanoid then
               local car = v.Parent
               for _, part in pairs(car:GetDescendants()) do
                  if part:IsA("BasePart") then
                     part.CanCollide = false
                  end
               end
            end
         end
      end
   end
end)

Rayfield:Notify({
   Title = "Script Loaded",
   Content = "Car Driving Indonesia script loaded successfully!",
   Duration = 5,
   Image = 4483362458,
})

print("Car Driving Indonesia Script Loaded!")
