-- DRIVING EMPIRE - TOTAL SESSION UNLOCKER (V3)
-- SEMUA MOBIL + MANIPULASI UI GARAGE + FITUR LAMA

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Driving Empire - GOD SESSION",
   LoadingTitle = "Manipulating Vehicle Data...",
   LoadingSubtitle = "By Gemini AI",
   ConfigurationSaving = { Enabled = true, FolderName = "DE_GodMode", FileName = "Config" },
   Discord = { Enabled = false },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Global Vars (Fitur Lama)
_G.AutoFarm = false
_G.VehicleSpeed = 1
_G.NoClip = false
_G.InfiniteNitro = false

-- ============================================
-- CORE: VEHICLE & UI MANIPULATION
-- ============================================

local function ManipulateGarageUI()
    -- 1. Visual Money Fix (999M)
    local pGui = player:WaitForChild("PlayerGui")
    for _, v in pairs(pGui:GetDescendants()) do
        if v:IsA("TextLabel") and (v.Text:find(",") or v.Name:lower():find("money")) then
            v.Text = "$999,999,999"
        end
    end

    -- 2. Bypass Ownership Logic (Client-Side)
    -- Mencoba menyuntikkan data ke setiap kendaraan agar tombol 'Spawn' muncul
    local vehicleFolder = ReplicatedStorage:FindFirstChild("Vehicles")
    local ownedFolder = player:FindFirstChild("OwnedVehicles") or player:FindFirstChild("Data")
    
    if vehicleFolder and ownedFolder then
        for _, car in pairs(vehicleFolder:GetChildren()) do
            -- Cek apakah mobil sudah ada di daftar milik player
            if not ownedFolder:FindFirstChild(car.Name) then
                local fakeData = Instance.new("BoolValue")
                fakeData.Name = car.Name
                fakeData.Value = true
                fakeData.Parent = ownedFolder
            end
        end
    end

    -- 3. Force Refresh UI Garage
    -- Menipu sistem UI agar mengupdate list mobil yang ditampilkan
    local garageUI = pGui:FindFirstChild("Garage") or pGui:FindFirstChild("Menu")
    if garageUI then
        garageUI.Enabled = false
        task.wait(0.1)
        garageUI.Enabled = true
    end

    Rayfield:Notify({
        Title = "Garage Manipulated",
        Content = "Semua data mobil telah disuntikkan ke UI Spawn. Silakan cek Garage!",
        Duration = 5
    })
end

-- ============================================
-- TABS & INTERFACE
-- ============================================

local MainTab = Window:CreateTab("🔓 Unlocker", 4483362458)

MainTab:CreateButton({
   Name = "🚀 UNLOCK ALL CARS & MONEY (Session Only)",
   Callback = function()
      ManipulateGarageUI()
   end,
})

MainTab:CreateSection("Info: Data akan reset otomatis saat kamu Rejoin game.")

local FarmTab = Window:CreateTab("💰 Auto Farm", 4483362458)
FarmTab:CreateToggle({
   Name = "🏁 Safe Auto Farm",
   CurrentValue = false,
   Callback = function(v) _G.AutoFarm = v end,
})

local VehicleTab = Window:CreateTab("🚗 Vehicle Mods", 4483362458)
VehicleTab:CreateSlider({
   Name = "Speed Multiplier",
   Range = {1, 20},
   Increment = 1,
   CurrentValue = 1,
   Callback = function(v) _G.VehicleSpeed = v end,
})
VehicleTab:CreateToggle({
   Name = "Infinite Nitro",
   CurrentValue = false,
   Callback = function(v) _G.InfiniteNitro = v end,
})

local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSlider({Name = "Walkspeed", Range = {16, 200}, CurrentValue = 16, Callback = function(v) player.Character.Humanoid.WalkSpeed = v end})
PlayerTab:CreateToggle({Name = "No Clip", CurrentValue = false, Callback = function(v) _G.NoClip = v end})

-- ============================================
-- RUNTIME LOOPS
-- ============================================

-- Speed & Nitro
game:GetService("RunService").Heartbeat:Connect(function()
    local seat = (player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.SeatPart)
    if seat and seat:IsA("VehicleSeat") then
        seat.MaxSpeed = 500 * _G.VehicleSpeed
        if _G.InfiniteNitro then
            local n = seat.Parent:FindFirstChild("Nitro")
            if n then n.Value = 100 end
        end
    end
end)

-- Noclip
game:GetService("RunService").Stepped:Connect(function()
    if _G.NoClip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- Auto Farm (Basic Teleport)
task.spawn(function()
    while task.wait(20) do
        if _G.AutoFarm then
            local hrp = player.Character.HumanoidRootPart
            hrp.CFrame = CFrame.new(-2697, 90, -1937) -- Start
            task.wait(2)
            hrp.CFrame = CFrame.new(-2800, 90, -2100) -- Finish
        end
    end
end)

Rayfield:Notify({Title = "Hack Loaded", Content = "Tekan tombol Unlock untuk memanipulasi Garage!"})
