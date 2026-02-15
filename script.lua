-- DRIVING EMPIRE - TEMPORARY FULL UNLOCK (SESSION ONLY)
-- Fitur: Unlock All, $0 Purchase, & Old Features

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Driving Empire - SESSION UNLOCKER",
   LoadingTitle = "Injecting Temporary Data...",
   LoadingSubtitle = "By Gemini AI",
   ConfigurationSaving = { Enabled = true, FolderName = "DE_Session", FileName = "Config" },
   Discord = { Enabled = false },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Variables (Old Features)
_G.AutoFarmRace = false
_G.VehicleSpeed = 1
_G.NoClip = false
_G.InfiniteNitro = false
_G.InfiniteJump = false

-- ============================================
-- THE "REAL" TEMPORARY UNLOCKER
-- ============================================

local function ActivateTemporaryUnlock()
    -- 1. Visual Money Spoof (Agar UI tidak menghalangi pembelian)
    local pGui = player:WaitForChild("PlayerGui")
    for _, v in pairs(pGui:GetDescendants()) do
        if v:IsA("TextLabel") and (v.Text:find(",") or v.Name:lower():find("money")) then
            v.Text = "$999,999,999"
        end
    end

    -- 2. Remote Hijacking (Menipu pengecekan 'Kepemilikan' & 'Harga')
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}

        -- Menipu game agar menganggap kita punya Gamepass & Mobil
        if method == "UserOwnsGamePassAsync" or method == "PlayerOwnsAsset" then
            return true
        end

        -- Jika game mengecek harga saat beli, kita kembalikan angka 0
        if tostring(self):lower():find("price") or tostring(self):lower():find("cost") then
            return 0
        end

        return oldNamecall(self, unpack(args))
    end)
    setreadonly(mt, true)

    -- 3. Injecting Car Data to Folder (Temporary)
    -- Ini yang membuat tombol 'SPAWN' muncul dan berfungsi
    local vehicleFolder = ReplicatedStorage:FindFirstChild("Vehicles")
    local ownedFolder = player:FindFirstChild("OwnedVehicles") or player:FindFirstChild("Data")
    
    if vehicleFolder and ownedFolder then
        for _, car in pairs(vehicleFolder:GetChildren()) do
            if not ownedFolder:FindFirstChild(car.Name) then
                local fakeCar = Instance.new("BoolValue")
                fakeCar.Name = car.Name
                fakeCar.Value = true
                fakeCar.Parent = ownedFolder
                -- Menandai agar saat rejoin otomatis hilang (karena ini Instance baru)
            end
        end
    end
    
    Rayfield:Notify({
        Title = "Session Unlock Active",
        Content = "Semua mobil terbuka & bisa di-spawn. Data akan reset saat kamu Rejoin!",
        Duration = 5
    })
end

-- ============================================
-- UI TABS (KEEPING OLD FEATURES)
-- ============================================

local UnlockTab = Window:CreateTab("🔓 Unlocker", 4483362458)
UnlockTab:CreateButton({
   Name = "🚀 ACTIVATE TEMPORARY UNLOCK (Own All & Buy)",
   Callback = function() ActivateTemporaryUnlock() end,
})

local FarmTab = Window:CreateTab("💰 Auto Farm", 4483362458)
FarmTab:CreateToggle({
   Name = "🏁 Auto Farm Race",
   CurrentValue = false,
   Callback = function(V) _G.AutoFarmRace = V end,
})

local VehicleTab = Window:CreateTab("🚗 Vehicle", 4483362458)
VehicleTab:CreateSlider({
   Name = "Speed Multiplier",
   Range = {1, 20},
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
PlayerTab:CreateSlider({Name = "Walkspeed", Range = {16, 200}, Increment = 1, CurrentValue = 16, Callback = function(V) player.Character.Humanoid.WalkSpeed = V end})
PlayerTab:CreateToggle({Name = "No Clip", CurrentValue = false, Callback = function(V) _G.NoClip = V end})

-- ============================================
-- LOOPS
-- ============================================

-- Speed & Nitro Loop
RunService.Heartbeat:Connect(function()
    local seat = (player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.SeatPart)
    if seat and seat:IsA("VehicleSeat") then
        seat.MaxSpeed = 500 * _G.VehicleSpeed
        if _G.InfiniteNitro then
            local nitro = seat.Parent:FindFirstChild("Nitro")
            if nitro then nitro.Value = 100 end
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

-- Anti AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

Rayfield:Notify({Title = "Loaded Successfully", Content = "Siap digunakan!"})
