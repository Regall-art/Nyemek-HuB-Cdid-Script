-- DRIVING EMPIRE - TOTAL BYPASS & FULL FEATURES
-- Merged with Remote Hooking for Purchasing

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Driving Empire - GOD MODE",
   LoadingTitle = "Bypassing Server Checks...",
   LoadingSubtitle = "By Gemini AI",
   ConfigurationSaving = { Enabled = true, FolderName = "DE_God", FileName = "Config" },
   Discord = { Enabled = false },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Global Variables
_G.AutoFarmRace = false
_G.VehicleSpeed = 1
_G.NoClip = false
_G.InfiniteNitro = false
_G.InfiniteJump = false

-- ============================================
-- THE EXPLOIT CORE (BYPASS SYSTEM)
-- ============================================

local function FullBypass()
    -- 1. Money & Purchase Hook
    -- Mencoba memotong pengiriman data 'Harga' ke server
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        -- Bypass Gamepass & Ownership Checks
        if method == "UserOwnsGamePassAsync" or method == "PlayerOwnsAsset" then
            return true
        end
        
        -- Bypass Purchase Costs (Attempt)
        if tostring(self):lower():find("purchase") or tostring(self):lower():find("buy") then
            if args[1] and type(args[1]) == "number" then
                args[1] = 0 -- Mengubah harga menjadi 0 sebelum dikirim ke server
            end
        end
        
        return oldNamecall(self, unpack(args))
    end)
    setreadonly(mt, true)

    -- 2. Unlock All Vehicles (Visual & Functional Attempt)
    local vehicleData = ReplicatedStorage:FindFirstChild("Vehicles")
    local ownedFolder = player:FindFirstChild("OwnedVehicles") or player:FindFirstChild("Data")
    
    if vehicleData then
        for _, car in pairs(vehicleData:GetChildren()) do
            if not ownedFolder:FindFirstChild(car.Name) then
                local val = Instance.new("BoolValue", ownedFolder)
                val.Name = car.Name
                val.Value = true -- Menandai semua mobil sebagai "Sudah Dimiliki"
            end
        end
    end

    -- 3. Visual UI Fix (Seperti screenshot kamu)
    local pGui = player:WaitForChild("PlayerGui")
    for _, v in pairs(pGui:GetDescendants()) do
        if v:IsA("TextLabel") and (v.Text:find(",") or v.Name:lower():find("money")) then
            v.Text = "$999,999,999"
        end
    end
end

-- ============================================
-- UI TABS (KEEPING ALL YOUR OLD FEATURES)
-- ============================================

local BypassTab = Window:CreateTab("🔓 GOD BYPASS", 4483362458)
BypassTab:CreateButton({
   Name = "🔥 ACTIVATE ALL BYPASSES (Cars & Money)",
   Callback = function() 
      FullBypass()
      Rayfield:Notify({Title = "Exploit Active", Content = "Semua mobil terbuka & harga diset ke $0 secara visual!"})
   end,
})

local FarmTab = Window:CreateTab("💰 Auto Farm", 4483362458)
FarmTab:CreateToggle({
   Name = "🏁 Auto Farm Races",
   CurrentValue = false,
   Callback = function(Value) _G.AutoFarmRace = Value end,
})

local VehicleTab = Window:CreateTab("🚗 Vehicle", 4483362458)
VehicleTab:CreateSlider({
   Name = "Speed Multiplier",
   Range = {1, 50},
   Increment = 1,
   CurrentValue = 1,
   Callback = function(V) _G.VehicleSpeed = V end,
})
VehicleTab:CreateToggle({
   Name = "Infinite Nitro",
   CurrentValue = false,
   Callback = function(V) _G.InfiniteNitro = V end,
})

local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSlider({Name = "Walkspeed", Range = {16, 300}, Increment = 1, CurrentValue = 16, Callback = function(V) player.Character.Humanoid.WalkSpeed = V end})
PlayerTab:CreateToggle({Name = "No Clip", CurrentValue = false, Callback = function(V) _G.NoClip = V end})
PlayerTab:CreateToggle({Name = "Infinite Jump", CurrentValue = false, Callback = function(V) _G.InfiniteJump = V end})

-- ============================================
-- LOOPS & RUNTIME
-- ============================================

-- Speed Loop
RunService.Heartbeat:Connect(function()
    local seat = (player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.SeatPart)
    if seat and seat:IsA("VehicleSeat") then
        seat.MaxSpeed = 500 * _G.VehicleSpeed
        if _G.InfiniteNitro then
            local n = seat.Parent:FindFirstChild("Nitro") or seat.Parent:FindFirstChild("Boost")
            if n then n.Value = 100 end
        end
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if _G.NoClip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- Auto Farm (Airport)
task.spawn(function()
    while task.wait(15) do -- Delay 15 detik agar aman
        if _G.AutoFarmRace then
            local root = player.Character.HumanoidRootPart
            root.CFrame = CFrame.new(-2697, 90, -1937) -- Start
            task.wait(2)
            root.CFrame = CFrame.new(-2800, 90, -2100) -- Finish
        end
    end
end)

-- Anti-AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

Rayfield:Notify({Title = "Script Ready", Content = "Semua fitur lama & Bypass baru telah dimuat!"})
