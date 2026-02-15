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
local VehicleSection = VehicleTab:CreateSection("Vehicle Controls")

local vehicleSpeed = 1
local noClipEnabled = false

VehicleTab:CreateButton({
   Name = "🔓 Unlock All Cars (Method 1)",
   Callback = function()
      -- Method 1: Direct ownership
      local unlocked = 0
      
      -- Look for car ownership in player data
      for _, folder in pairs(player:GetDescendants()) do
         if folder.Name:lower():find("car") or folder.Name:lower():find("vehicle") or folder.Name:lower():find("owned") then
            for _, item in pairs(folder:GetChildren()) do
               if item:IsA("BoolValue") or item:IsA("IntValue") then
                  item.Value = true
                  unlocked = unlocked + 1
               end
            end
         end
      end
      
      -- Try ReplicatedStorage
      if game.ReplicatedStorage:FindFirstChild("Cars") or game.ReplicatedStorage:FindFirstChild("Vehicles") then
         local carsFolder = game.ReplicatedStorage:FindFirstChild("Cars") or game.ReplicatedStorage:FindFirstChild("Vehicles")
         for _, car in pairs(carsFolder:GetChildren()) do
            unlocked = unlocked + 1
         end
      end
      
      Rayfield:Notify({
         Title = "Unlock All Cars",
         Content = "Attempted to unlock " .. unlocked .. " cars!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🔓 Unlock All Cars (Method 2 - Remote)",
   Callback = function()
      -- Method 2: Fire unlock remotes
      for _, remote in pairs(game.ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local remoteName = remote.Name:lower()
            if remoteName:find("unlock") or remoteName:find("buy") or remoteName:find("purchase") or remoteName:find("own") then
               pcall(function()
                  if remote:IsA("RemoteEvent") then
                     -- Try different car IDs/names
                     for i = 1, 100 do
                        remote:FireServer(i)
                        remote:FireServer("Car" .. i)
                        remote:FireServer(tostring(i))
                     end
                     remote:FireServer("all")
                     remote:FireServer(true)
                  end
               end)
            end
         end
      end
      
      Rayfield:Notify({
         Title = "Unlock Cars Remote",
         Content = "Fired unlock remotes for all cars!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🔓 Unlock All Cars (Method 3 - GamePass)",
   Callback = function()
      -- Method 3: Bypass gamepass checks
      local mt = getrawmetatable(game)
      local oldNamecall = mt.__namecall
      setreadonly(mt, false)
      
      mt.__namecall = newcclosure(function(self, ...)
         local args = {...}
         local method = getnamecallmethod()
         
         if method == "UserOwnsGamePassAsync" then
            return true
         end
         
         return oldNamecall(self, ...)
      end)
      
      setreadonly(mt, true)
      
      Rayfield:Notify({
         Title = "GamePass Bypass",
         Content = "GamePass bypass enabled! All cars should be unlocked.",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🚗 Spawn Car (Free)",
   Callback = function()
      -- Try to spawn cars for free
      for _, remote in pairs(game.ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") then
            local remoteName = remote.Name:lower()
            if remoteName:find("spawn") or remoteName:find("equip") or remoteName:find("select") then
               pcall(function()
                  for i = 1, 50 do
                     remote:FireServer(i)
                     remote:FireServer("Car" .. i)
                  end
               end)
            end
         end
      end
      
      Rayfield:Notify({
         Title = "Spawn Car",
         Content = "Attempted to spawn cars!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

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
      local vehicle = character:FindFirstChildOfClass("Model") or character.Parent:FindFirstChildOfClass("VehicleSeat")
      if vehicle then
         vehicle.CFrame = vehicle.CFrame * CFrame.new(0, 5, 0)
      end
   end,
})

VehicleTab:CreateButton({
   Name = "Flip Vehicle",
   Callback = function()
      for _, v in pairs(workspace:GetDescendants()) do
         if v:IsA("VehicleSeat") and v.Occupant == humanoid then
            local car = v.Parent
            car:SetPrimaryPartCFrame(car.PrimaryPart.CFrame * CFrame.Angles(0, 0, math.pi))
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
local MoneySection = MoneyTab:CreateSection("Money Features")

local moneyAmount = 1000000

local MoneyInput = MoneyTab:CreateInput({
   Name = "Money Amount",
   PlaceholderText = "Enter amount",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      moneyAmount = tonumber(Text) or 1000000
   end,
})

MoneyTab:CreateButton({
   Name = "Give Money (Method 1)",
   Callback = function()
      -- Method 1: Direct value change
      local success = false
      
      -- Try to find Money/Cash in PlayerGui or leaderstats
      if player:FindFirstChild("leaderstats") then
         if player.leaderstats:FindFirstChild("Money") then
            player.leaderstats.Money.Value = moneyAmount
            success = true
         elseif player.leaderstats:FindFirstChild("Cash") then
            player.leaderstats.Cash.Value = moneyAmount
            success = true
         elseif player.leaderstats:FindFirstChild("Coins") then
            player.leaderstats.Coins.Value = moneyAmount
            success = true
         end
      end
      
      -- Try PlayerGui
      if not success then
         for _, gui in pairs(player.PlayerGui:GetDescendants()) do
            if gui:IsA("TextLabel") or gui:IsA("TextBox") then
               if gui.Name == "Money" or gui.Name == "Cash" or gui.Name == "Coins" then
                  gui.Text = tostring(moneyAmount)
               end
            end
         end
      end
      
      Rayfield:Notify({
         Title = "Money",
         Content = "Attempted to set money to " .. moneyAmount,
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateButton({
   Name = "Give Money (Method 2 - Remote)",
   Callback = function()
      -- Method 2: Fire RemoteEvents/Functions
      for _, remote in pairs(game.ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local remoteName = remote.Name:lower()
            if remoteName:find("money") or remoteName:find("cash") or remoteName:find("coin") or remoteName:find("currency") then
               pcall(function()
                  if remote:IsA("RemoteEvent") then
                     remote:FireServer(moneyAmount)
                     remote:FireServer("AddMoney", moneyAmount)
                     remote:FireServer("GiveMoney", moneyAmount)
                  end
               end)
            end
         end
      end
      
      Rayfield:Notify({
         Title = "Money Remote",
         Content = "Fired money remotes with amount: " .. moneyAmount,
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateButton({
   Name = "Unlimited Money (Loop)",
   Callback = function()
      spawn(function()
         while wait(1) do
            pcall(function()
               if player:FindFirstChild("leaderstats") then
                  if player.leaderstats:FindFirstChild("Money") then
                     player.leaderstats.Money.Value = 999999999
                  elseif player.leaderstats:FindFirstChild("Cash") then
                     player.leaderstats.Cash.Value = 999999999
                  elseif player.leaderstats:FindFirstChild("Coins") then
                     player.leaderstats.Coins.Value = 999999999
                  end
               end
            end)
         end
      end)
      
      Rayfield:Notify({
         Title = "Unlimited Money",
         Content = "Unlimited money loop started!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateParagraph({
   Title = "Note",
   Content = "Try different methods if one doesn't work. Some games have server-side checks."
})

-- Tab: Misc
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)
local MiscSection = MiscTab:CreateSection("Miscellaneous")

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
