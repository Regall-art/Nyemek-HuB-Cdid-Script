-- NYEMEK HUB - FINAL SESSION BYPASS
-- Target: UI Manipulation for All Categories (Car, Heli, Boat, Motor)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nyemek HuB", 
   LoadingTitle = "Nyemek HuB: Final Bypass",
   LoadingSubtitle = "Hooking Network Events...",
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
-- THE ULTIMATE UI HOOK (NYEMEK METHOD)
-- ============================================

local function NyemekFullUnlock()
    -- 1. Visual Money Manipulation
    local pGui = player:WaitForChild("PlayerGui")
    task.spawn(function()
        while task.wait(0.5) do
            for _, v in pairs(pGui:GetDescendants()) do
                if v:IsA("TextLabel") and (v.Text:find(",") or v.Name:lower():find("money")) then
                    v.Text = "$999,999,999"
                end
            end
        end
    end)

    -- 2. Hooking Metatable (Network Hijacking)
    -- Ini akan menipu UI agar menganggap kita punya SEMUA asset
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}

        -- Bypass Pengecekan Kepemilikan (Cars, Heli, Boat, Motor)
        if method == "InvokeServer" and tostring(self) == "GetPlayerData" then
            local data = oldNamecall(self, unpack(args))
            if type(data) == "table" and data.Vehicles then
                -- Injeksi paksa ke tabel data UI
                for _, folder in pairs(ReplicatedStorage.Vehicles:GetChildren()) do
                    data.Vehicles[folder.Name] = true
                end
                return data
            end
        end

        -- Bypass Remote untuk Spawn
        if method == "FireServer" and (tostring(self):find("Spawn") or tostring(self):find("Equip")) then
            return oldNamecall(self, unpack(args))
        end

        return oldNamecall(self, unpack(args))
    end)
    setreadonly(mt, true)

    -- 3. Client-Side Folder Injection (Double Protection)
    local ownedFolder = player:FindFirstChild("OwnedVehicles") or player:FindFirstChild("Data")
    if ownedFolder then
        -- Mencari di semua folder aset game
        local assetFolders = {
            ReplicatedStorage:FindFirstChild("Vehicles"),
            ReplicatedStorage:FindFirstChild("Helicopters"),
            ReplicatedStorage:FindFirstChild("Planes"),
            ReplicatedStorage:FindFirstChild("Boats"),
            ReplicatedStorage:FindFirstChild("Bikes")
        }
        
        for _, folder in pairs(assetFolders) do
            if folder then
                for _, asset in pairs(folder:GetChildren()) do
                    if not ownedFolder:FindFirstChild(asset.Name) then
                        local fake = Instance.new("BoolValue", ownedFolder)
                        fake.Name = asset.Name
                        fake.Value = true
                    end
                end
            end
        end
    end

    Rayfield:Notify({
        Title = "Nyemek HuB",
        Content = "UI Bypass Active! Re-open your Garage/Menu now.",
        Duration = 5
    })
end

-- ============================================
-- NYEMEK HUB TABS
-- ============================================

local MainTab = Window:CreateTab("🔓 Unlocker", 4483362458)
MainTab:CreateButton({
   Name = "🚀 ACTIVATE NYEMEK BYPASS (All Vehicles & UI)",
   Callback = function() NyemekFullUnlock() end,
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
-- RUNTIME LOOPS
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

-- Anti AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

Rayfield:Notify({Title = "Nyemek HuB", Content = "Script Hybrid Loaded!"})
