-- Driving Empire Script - DEEP ANALYSIS VERSION
-- Multiple methods for money and detailed debugging
-- This version will help you find the EXACT remote that works

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Driving Empire - Deep Analysis",
   LoadingTitle = "Driving Empire",
   LoadingSubtitle = "Finding Working Remotes...",
   ConfigurationSaving = {
      Enabled = false,
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

-- Player
local player = Players.LocalPlayer

-- Storage for found remotes
local AllRemotes = {}
local MonitoringEnabled = false

-- Scan ALL remotes in the game
print("\n" .. string.rep("=", 50))
print("SCANNING ALL GAME REMOTES")
print(string.rep("=", 50))

for _, obj in pairs(game:GetDescendants()) do
   if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
      table.insert(AllRemotes, obj)
      print(#AllRemotes .. ". " .. obj:GetFullName())
   end
end

print("\nTotal Remotes Found: " .. #AllRemotes)
print(string.rep("=", 50) .. "\n")

-- ============================================
-- TAB: MONEY DETECTIVE
-- ============================================
local MoneyTab = Window:CreateTab("💰 Money Detective", 4483362458)

MoneyTab:CreateParagraph({
   Title = "🔍 How to Find Working Money Remote",
   Content = "1. Click 'Start Remote Monitor'\n2. Go buy something in game or earn money\n3. Check console (F9) to see which remote fired\n4. Use that remote number in Manual Fire"
})

MoneyTab:CreateButton({
   Name = "🎯 Start Remote Monitor (IMPORTANT!)",
   Callback = function()
      StartRemoteMonitor()
      Rayfield:Notify({
         Title = "Monitor Started",
         Content = "Do actions in game! Check F9 console!",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateButton({
   Name = "📋 List All Remotes",
   Callback = function()
      ListAllRemotes()
   end,
})

MoneyTab:CreateSection("Try All Money Methods")

MoneyTab:CreateButton({
   Name = "💵 Method 1: Fire ALL Remotes with 10K",
   Callback = function()
      FireAllRemotesWith10K()
      Rayfield:Notify({
         Title = "Method 1",
         Content = "Fired all " .. #AllRemotes .. " remotes!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateButton({
   Name = "💵 Method 2: leaderstats Direct Edit",
   Callback = function()
      EditLeaderstatsDirectly(100000)
   end,
})

MoneyTab:CreateButton({
   Name = "💵 Method 3: PlayerData Edit",
   Callback = function()
      EditPlayerData(100000)
   end,
})

MoneyTab:CreateButton({
   Name = "💵 Method 4: Workspace Money Edit",
   Callback = function()
      EditWorkspaceMoney(100000)
   end,
})

MoneyTab:CreateSection("Manual Remote Testing")

local RemoteNumberInput = MoneyTab:CreateInput({
   Name = "Remote Number (from monitor)",
   PlaceholderText = "Enter number (e.g., 15)",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      -- Store for later use
      _G.SelectedRemoteNumber = tonumber(Text)
   end,
})

local MoneyAmountInput = MoneyTab:CreateInput({
   Name = "Money Amount",
   PlaceholderText = "Enter amount (e.g., 50000)",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      _G.MoneyAmount = tonumber(Text) or 10000
   end,
})

MoneyTab:CreateButton({
   Name = "🔥 Fire Selected Remote",
   Callback = function()
      if _G.SelectedRemoteNumber and AllRemotes[_G.SelectedRemoteNumber] then
         FireSpecificRemote(_G.SelectedRemoteNumber, _G.MoneyAmount or 10000)
      else
         Rayfield:Notify({
            Title = "Error",
            Content = "Enter a valid remote number first!",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})

MoneyTab:CreateSection("Auto Farm (Use After Finding Remote)")

MoneyTab:CreateToggle({
   Name = "Auto Farm (Selected Remote)",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
      _G.AutoFarm = Value
   end,
})

-- ============================================
-- TAB: VEHICLE DETECTIVE
-- ============================================
local VehicleTab = Window:CreateTab("🚗 Vehicle Detective", 4483362458)

VehicleTab:CreateParagraph({
   Title = "🔍 How to Find Working Vehicle Remote",
   Content = "1. Start Remote Monitor\n2. Buy a cheap car in game\n3. Check console to see which remote fired\n4. Use that remote for unlock all"
})

VehicleTab:CreateButton({
   Name = "🎯 Start Remote Monitor",
   Callback = function()
      StartRemoteMonitor()
      Rayfield:Notify({
         Title = "Monitor Started",
         Content = "Now buy a car! Check F9!",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateSection("Try All Vehicle Methods")

VehicleTab:CreateButton({
   Name = "🚗 Method 1: Fire ALL Remotes (Unlock ID 1-100)",
   Callback = function()
      UnlockMethod1()
   end,
})

VehicleTab:CreateButton({
   Name = "🚗 Method 2: PlayerData Vehicle Edit",
   Callback = function()
      UnlockMethod2()
   end,
})

VehicleTab:CreateButton({
   Name = "🚗 Method 3: GamePass Bypass",
   Callback = function()
      GamePassBypass()
   end,
})

VehicleTab:CreateSection("Manual Vehicle Unlock")

local VehicleRemoteInput = VehicleTab:CreateInput({
   Name = "Remote Number (from monitor)",
   PlaceholderText = "Enter remote number",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      _G.SelectedVehicleRemote = tonumber(Text)
   end,
})

VehicleTab:CreateButton({
   Name = "🔥 Unlock All Using Selected Remote",
   Callback = function()
      if _G.SelectedVehicleRemote and AllRemotes[_G.SelectedVehicleRemote] then
         UnlockUsingRemote(_G.SelectedVehicleRemote)
      else
         Rayfield:Notify({
            Title = "Error",
            Content = "Enter remote number first!",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})

-- ============================================
-- TAB: PLAYER INFO
-- ============================================
local InfoTab = Window:CreateTab("📊 Player Info", 4483362458)

InfoTab:CreateButton({
   Name = "Show Current Stats",
   Callback = function()
      ShowPlayerStats()
   end,
})

InfoTab:CreateButton({
   Name = "Show Player Structure",
   Callback = function()
      ShowPlayerStructure()
   end,
})

InfoTab:CreateButton({
   Name = "Show ReplicatedStorage Structure",
   Callback = function()
      ShowReplicatedStorageStructure()
   end,
})

InfoTab:CreateButton({
   Name = "Find Money Values in Player",
   Callback = function()
      FindMoneyInPlayer()
   end,
})

-- ============================================
-- TAB: INSTRUCTIONS
-- ============================================
local HelpTab = Window:CreateTab("❓ Instructions", 4483362458)

HelpTab:CreateParagraph({
   Title = "Step 1: Find Money Remote",
   Content = "Click 'Start Remote Monitor' in Money tab, then earn money in game (deliver cargo, race, etc). Check console (F9) to see which remote number fired."
})

HelpTab:CreateParagraph({
   Title = "Step 2: Test Remote",
   Content = "Enter the remote number you found, enter money amount, then click 'Fire Selected Remote'. Check if your money increased."
})

HelpTab:CreateParagraph({
   Title = "Step 3: Auto Farm",
   Content = "Once you found the working remote, enable 'Auto Farm' toggle and it will keep firing that remote."
})

HelpTab:CreateParagraph({
   Title = "Alternative: Brute Force",
   Content = "If monitoring doesn't work, use 'Method 1: Fire ALL Remotes with 10K'. It will try every single remote in the game."
})

-- ============================================
-- FUNCTIONS
-- ============================================

function StartRemoteMonitor()
   if MonitoringEnabled then
      print("Monitor already running!")
      return
   end
   
   MonitoringEnabled = true
   
   local mt = getrawmetatable(game)
   local oldNamecall = mt.__namecall
   setreadonly(mt, false)
   
   mt.__namecall = newcclosure(function(self, ...)
      local args = {...}
      local method = getnamecallmethod()
      
      if method == "FireServer" or method == "InvokeServer" then
         -- Find remote number
         local remoteNum = "?"
         for i, remote in pairs(AllRemotes) do
            if remote == self then
               remoteNum = i
               break
            end
         end
         
         print("\n" .. string.rep("=", 60))
         print("🔴 REMOTE FIRED!")
         print("Number: " .. remoteNum)
         print("Path: " .. self:GetFullName())
         print("Method: " .. method)
         
         -- Print arguments
         print("Arguments:")
         for i, arg in pairs(args) do
            print("  [" .. i .. "] = " .. tostring(arg) .. " (" .. type(arg) .. ")")
         end
         print(string.rep("=", 60) .. "\n")
      end
      
      return oldNamecall(self, ...)
   end)
   
   setreadonly(mt, true)
   
   print("\n🎯 REMOTE MONITOR STARTED!")
   print("Do actions in game and watch this console!\n")
end

function ListAllRemotes()
   print("\n" .. string.rep("=", 60))
   print("ALL REMOTES IN GAME")
   print(string.rep("=", 60))
   
   for i, remote in pairs(AllRemotes) do
      print(i .. ". " .. remote:GetFullName() .. " (" .. remote.ClassName .. ")")
   end
   
   print("\nTotal: " .. #AllRemotes)
   print(string.rep("=", 60) .. "\n")
   
   Rayfield:Notify({
      Title = "Remotes Listed",
      Content = "Check console (F9) for " .. #AllRemotes .. " remotes",
      Duration = 3,
      Image = 4483362458,
   })
end

function FireAllRemotesWith10K()
   print("\n🔥 FIRING ALL REMOTES WITH 10,000...")
   local amount = 10000
   
   for i, remote in pairs(AllRemotes) do
      pcall(function()
         if remote:IsA("RemoteEvent") then
            -- Try multiple argument patterns
            remote:FireServer(amount)
            remote:FireServer("Add", amount)
            remote:FireServer("AddMoney", amount)
            remote:FireServer({Amount = amount})
            remote:FireServer({Money = amount})
            remote:FireServer({Cash = amount})
            remote:FireServer(player, amount)
            
            print("✓ Fired #" .. i .. ": " .. remote.Name)
         elseif remote:IsA("RemoteFunction") then
            remote:InvokeServer(amount)
            remote:InvokeServer("Add", amount)
            
            print("✓ Invoked #" .. i .. ": " .. remote.Name)
         end
      end)
      wait(0.05) -- Small delay to avoid overwhelming
   end
   
   print("✓ Finished firing all remotes!")
end

function EditLeaderstatsDirectly(amount)
   print("\n💰 Trying leaderstats edit...")
   local found = false
   
   if player:FindFirstChild("leaderstats") then
      for _, stat in pairs(player.leaderstats:GetChildren()) do
         if stat:IsA("IntValue") or stat:IsA("NumberValue") then
            local oldValue = stat.Value
            stat.Value = stat.Value + amount
            print("✓ " .. stat.Name .. ": " .. oldValue .. " -> " .. stat.Value)
            found = true
         end
      end
   end
   
   if found then
      Rayfield:Notify({
         Title = "leaderstats",
         Content = "Edited leaderstats!",
         Duration = 3,
         Image = 4483362458,
      })
   else
      Rayfield:Notify({
         Title = "Error",
         Content = "No leaderstats found!",
         Duration = 3,
         Image = 4483362458,
      })
   end
end

function EditPlayerData(amount)
   print("\n💰 Trying PlayerData edit...")
   local found = false
   
   local dataFolders = {"Data", "PlayerData", "Stats", "PlayerStats", "Profile"}
   
   for _, folderName in pairs(dataFolders) do
      if player:FindFirstChild(folderName) then
         for _, value in pairs(player[folderName]:GetDescendants()) do
            if value:IsA("IntValue") or value:IsA("NumberValue") then
               local name = value.Name:lower()
               if name:find("cash") or name:find("money") or name:find("coin") then
                  local oldValue = value.Value
                  value.Value = value.Value + amount
                  print("✓ " .. value:GetFullName() .. ": " .. oldValue .. " -> " .. value.Value)
                  found = true
               end
            end
         end
      end
   end
   
   if found then
      Rayfield:Notify({
         Title = "PlayerData",
         Content = "Edited player data!",
         Duration = 3,
         Image = 4483362458,
      })
   else
      Rayfield:Notify({
         Title = "Error",
         Content = "No player data found!",
         Duration = 3,
         Image = 4483362458,
      })
   end
end

function EditWorkspaceMoney(amount)
   print("\n💰 Trying Workspace edit...")
   
   for _, obj in pairs(Workspace:GetDescendants()) do
      if obj:IsA("IntValue") or obj:IsA("NumberValue") then
         local name = obj.Name:lower()
         if name:find("cash") or name:find("money") then
            local oldValue = obj.Value
            obj.Value = obj.Value + amount
            print("✓ " .. obj:GetFullName() .. ": " .. oldValue .. " -> " .. obj.Value)
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Workspace",
      Content = "Tried workspace edit!",
      Duration = 3,
      Image = 4483362458,
   })
end

function FireSpecificRemote(number, amount)
   local remote = AllRemotes[number]
   
   if not remote then
      print("❌ Remote #" .. number .. " not found!")
      return
   end
   
   print("\n🔥 Firing remote #" .. number .. ": " .. remote:GetFullName())
   
   pcall(function()
      if remote:IsA("RemoteEvent") then
         -- Try many patterns
         remote:FireServer(amount)
         remote:FireServer("Add", amount)
         remote:FireServer("AddMoney", amount)
         remote:FireServer("AddCash", amount)
         remote:FireServer({Amount = amount})
         remote:FireServer({Money = amount})
         remote:FireServer({Cash = amount})
         remote:FireServer(player, amount)
         remote:FireServer(player, "Add", amount)
         
         print("✓ Fired with multiple patterns")
      elseif remote:IsA("RemoteFunction") then
         remote:InvokeServer(amount)
         remote:InvokeServer("Add", amount)
         
         print("✓ Invoked")
      end
   end)
   
   Rayfield:Notify({
      Title = "Remote Fired",
      Content = "Fired remote #" .. number,
      Duration = 2,
      Image = 4483362458,
   })
end

function UnlockMethod1()
   print("\n🚗 Unlock Method 1: Firing all remotes...")
   
   for i, remote in pairs(AllRemotes) do
      pcall(function()
         if remote:IsA("RemoteEvent") then
            for carId = 1, 100 do
               remote:FireServer(carId)
               remote:FireServer("Unlock", carId)
               remote:FireServer("Buy", carId)
               remote:FireServer({VehicleId = carId})
               remote:FireServer({CarId = carId})
            end
         end
      end)
   end
   
   Rayfield:Notify({
      Title = "Method 1",
      Content = "Fired all remotes for 100 cars!",
      Duration = 3,
      Image = 4483362458,
   })
end

function UnlockMethod2()
   print("\n🚗 Unlock Method 2: PlayerData edit...")
   
   local vehicleFolders = {"OwnedVehicles", "Vehicles", "Cars", "OwnedCars"}
   
   for _, folderName in pairs(vehicleFolders) do
      if player:FindFirstChild(folderName) then
         for i = 1, 200 do
            local value = Instance.new("BoolValue")
            value.Name = tostring(i)
            value.Value = true
            value.Parent = player[folderName]
         end
         
         print("✓ Created 200 vehicle entries in " .. folderName)
      end
   end
   
   Rayfield:Notify({
      Title = "Method 2",
      Content = "Modified player vehicle data!",
      Duration = 3,
      Image = 4483362458,
   })
end

function GamePassBypass()
   pcall(function()
      local mt = getrawmetatable(game)
      local oldNamecall = mt.__namecall
      setreadonly(mt, false)
      
      mt.__namecall = newcclosure(function(self, ...)
         local method = getnamecallmethod()
         
         if method == "UserOwnsGamePassAsync" or method == "PlayerOwnsAsset" then
            return true
         end
         
         return oldNamecall(self, ...)
      end)
      
      setreadonly(mt, true)
      
      print("✓ GamePass bypass enabled")
      
      Rayfield:Notify({
         Title = "GamePass",
         Content = "GamePass bypass enabled!",
         Duration = 3,
         Image = 4483362458,
      })
   end)
end

function UnlockUsingRemote(number)
   local remote = AllRemotes[number]
   
   if not remote then
      print("❌ Remote not found!")
      return
   end
   
   print("\n🚗 Unlocking using remote #" .. number)
   
   for carId = 1, 150 do
      pcall(function()
         if remote:IsA("RemoteEvent") then
            remote:FireServer(carId)
            remote:FireServer("Unlock", carId)
            remote:FireServer({VehicleId = carId})
         end
      end)
      wait(0.1)
   end
   
   Rayfield:Notify({
      Title = "Unlock",
      Content = "Attempted unlock using remote #" .. number,
      Duration = 3,
      Image = 4483362458,
   })
end

function ShowPlayerStats()
   print("\n" .. string.rep("=", 60))
   print("PLAYER STATS")
   print(string.rep("=", 60))
   
   if player:FindFirstChild("leaderstats") then
      print("\nleaderstats:")
      for _, stat in pairs(player.leaderstats:GetChildren()) do
         print("  " .. stat.Name .. " = " .. tostring(stat.Value))
      end
   end
   
   print(string.rep("=", 60) .. "\n")
end

function ShowPlayerStructure()
   print("\n" .. string.rep("=", 60))
   print("PLAYER STRUCTURE")
   print(string.rep("=", 60))
   
   for _, obj in pairs(player:GetChildren()) do
      print("\n├─ " .. obj.Name .. " (" .. obj.ClassName .. ")")
      
      if obj:IsA("Folder") or obj:IsA("Configuration") then
         for _, child in pairs(obj:GetChildren()) do
            print("│  ├─ " .. child.Name .. " (" .. child.ClassName .. ")")
            
            if child:IsA("ValueBase") then
               print("│  │  └─ Value: " .. tostring(child.Value))
            end
         end
      end
   end
   
   print(string.rep("=", 60) .. "\n")
end

function ShowReplicatedStorageStructure()
   print("\n" .. string.rep("=", 60))
   print("REPLICATED STORAGE STRUCTURE")
   print(string.rep("=", 60))
   
   for _, obj in pairs(ReplicatedStorage:GetChildren()) do
      print("\n├─ " .. obj.Name .. " (" .. obj.ClassName .. ")")
   end
   
   print(string.rep("=", 60) .. "\n")
end

function FindMoneyInPlayer()
   print("\n" .. string.rep("=", 60))
   print("SEARCHING FOR MONEY VALUES")
   print(string.rep("=", 60))
   
   for _, obj in pairs(player:GetDescendants()) do
      if obj:IsA("IntValue") or obj:IsA("NumberValue") then
         local name = obj.Name:lower()
         if name:find("cash") or name:find("money") or name:find("coin") or name:find("currency") then
            print("\n✓ FOUND: " .. obj:GetFullName())
            print("  Value: " .. tostring(obj.Value))
            print("  Type: " .. obj.ClassName)
         end
      end
   end
   
   print(string.rep("=", 60) .. "\n")
end

-- Auto Farm Loop
spawn(function()
   while wait(0.5) do
      if _G.AutoFarm and _G.SelectedRemoteNumber then
         pcall(function()
            FireSpecificRemote(_G.SelectedRemoteNumber, _G.MoneyAmount or 10000)
         end)
      end
   end
end)

-- Load notification
Rayfield:Notify({
   Title = "Script Loaded",
   Content = "Use Money Detective to find working remote!",
   Duration = 5,
   Image = 4483362458,
})

print("\n" .. string.rep("=", 60))
print("DRIVING EMPIRE - DEEP ANALYSIS")
print("Found " .. #AllRemotes .. " total remotes")
print("Use 'Start Remote Monitor' and do actions in game!")
print(string.rep("=", 60) .. "\n")
