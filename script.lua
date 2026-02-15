-- NYEMEK HUB - REPLICATED STORAGE INJECTOR (V4)
-- Fokus: Memaksa manipulasi UI dengan klon data dari ReplicatedStorage

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nyemek HuB", 
   LoadingTitle = "Nyemek HuB: Deep Scanning...",
   LoadingSubtitle = "Searching ReplicatedStorage Assets",
   ConfigurationSaving = { Enabled = true, FolderName = "NyemekHub_DE", FileName = "Config" },
   Discord = { Enabled = false },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Global Vars
_G.AutoFarm = false
_G.VehicleSpeed = 1
_G.NoClip = false
_G.InfiniteNitro = false

-- ============================================
-- CORE: REPLICATED STORAGE DEEP INJECTION
-- ============================================

local function NyemekDeepInject()
    -- 1. Visual Money (Loop agar tidak berubah balik)
    task.spawn(function()
        while true do
            local pGui = player:FindFirstChild("PlayerGui")
            if pGui then
                for _, v in pairs(pGui:GetDescendants()) do
                    if v:IsA("TextLabel") and (v.Text:find(",") or v.Name:lower():find("money")) then
                        v.Text = "$999,999,999"
                    end
                end
            end
            task.wait(1)
        end
    end)

    -- 2. Deep Scanning ReplicatedStorage
    -- Mencari folder yang berisi data kendaraan/item
    local ownedFolder = player:FindFirstChild("OwnedVehicles") or player:FindFirstChild("Data")
    
    if not ownedFolder then
        Rayfield:Notify({Title = "Error", Content = "Folder data player tidak ditemukan!"})
        return
    end

    local categories = {
        "Vehicles", "Helicopters", "Planes", "Boats", "Bikes", 
        "Motorcycles", "VehicleData", "CarData"
    }

    for _, catName in pairs(categories) do
        local folder = ReplicatedStorage:FindFirstChild(catName)
        if folder then
            for _, asset in pairs(folder:GetChildren()) do
                -- Injeksi: Membuat tiruan data kepemilikan di folder Player
                if not ownedFolder:FindFirstChild(asset.Name) then
                    local fakeVal = Instance.new("BoolValue")
                    fakeVal.Name = asset.Name
                    fakeVal.Value = true
                    fakeVal.Parent = ownedFolder
                end
            end
        end
    end

    -- 3. UI Refresh Bypass
    -- Memaksa UI untuk "berpikir" bahwa data baru saja di-load dari server
    local garageUI = player.PlayerGui:FindFirstChild("Garage") or player.PlayerGui:FindFirstChild("Menu")
    if garageUI then
        garageUI.Enabled = false
        task.wait(0.2)
        garageUI.Enabled = true
    end

    Rayfield:Notify({
        Title = "Nyemek HuB",
        Content = "Deep Injection Complete! Cek semua kategori di Garage.",
        Duration = 5
    })
end

-- ============================================
-- UI TABS (NYEMEK HUB)
-- ============================================

local MainTab = Window:CreateTab("🔓 Unlocker", 4483362458)
MainTab:CreateButton({
   Name = "🚀 FORCE INJECT FROM REPLICATED STORAGE",
   Callback = function() NyemekDeepInject() end,
})

local FarmTab = Window:CreateTab("💰 Auto Farm", 4483362458)
FarmTab:CreateToggle({Name = "🏁 Start Race Farm", CurrentValue = false, Callback = function(v) _G.AutoFarm = v end})

local VehicleTab = Window:CreateTab("🚗 Vehicle Mods", 4483362458)
VehicleTab:CreateSlider({Name = "Speed Multiplier", Range = {1, 20}, Increment = 1, CurrentValue = 1, Callback = function(v) _G.VehicleSpeed = v end})
VehicleTab:CreateToggle({Name = "Infinite Nitro", CurrentValue = false, Callback = function(v) _G.InfiniteNitro = v end})

local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSlider({Name = "Walkspeed", Range = {16, 200}, CurrentValue = 16, Callback = function(v) player.Character.Humanoid.WalkSpeed = v end})
PlayerTab:CreateToggle({Name = "No Clip", CurrentValue = false, Callback = function(v) _G.NoClip = v end})

-- ============================================
-- RUNTIME
-- ============================================

game:GetService("RunService").Heartbeat:Connect(function()
    local char = player.Character
    local seat = (char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart)
    if seat and seat:IsA("VehicleSeat") then
        seat.MaxSpeed = 500 * _G.VehicleSpeed
        if _G.InfiniteNitro then
            local n = seat.Parent:FindFirstChild("Nitro") or seat.Parent:FindFirstChild("Boost")
            if n then n.Value = 100 end
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if _G.NoClip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

Rayfield:Notify({Title = "Nyemek HuB", Content = "Siap untuk Deep Injection!"})
