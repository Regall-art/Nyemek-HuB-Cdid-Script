-- NYEMEK HUB - CAR DEALERSHIP TYCOON (FIXED VERSION)
-- Re-checking paths for Auto Build, Money, and Cars

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nyemek HuB", 
   LoadingTitle = "Nyemek HuB: CDT Aggressive",
   LoadingSubtitle = "Scanning Game Folders...",
   ConfigurationSaving = { Enabled = true, FolderName = "NyemekHub_CDT", FileName = "Config" },
   Discord = { Enabled = false },
   KeySystem = false,
})

-- Services & Player
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Global Variables
_G.AutoBuild = false
_G.AutoCollect = false
_G.VehicleSpeed = 1
_G.InfiniteNitro = false
_G.NoClip = false

-- ============================================
-- THE CORE FUNCTIONS (RE-CHECKED)
-- ============================================

local function FullCDTUnlock()
    -- 1. Visual Money Manipulation ($999,999,999)
    task.spawn(function()
        while true do
            pcall(function()
                local gui = player.PlayerGui:FindFirstChild("MainGui") or player.PlayerGui:FindFirstChild("HUD")
                if gui then
                    for _, v in pairs(gui:GetDescendants()) do
                        if v:IsA("TextLabel") and (v.Text:find("$") or v.Name:lower():find("cash")) then
                            v.Text = "$999,999,999"
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end)

    -- 2. Unlock Cars (Injecting into CDT Data Folder)
    -- CDT biasanya menyimpan data di folder 'OwnedCars' atau 'Data'
    local carFolder = ReplicatedStorage:FindFirstChild("Cars")
    local ownedFolder = player:FindFirstChild("OwnedCars") or player:FindFirstChild("Data") or player:FindFirstChild("leaderstats")
    
    if carFolder and ownedFolder then
        for _, car in pairs(carFolder:GetChildren()) do
            if not ownedFolder:FindFirstChild(car.Name) then
                local b = Instance.new("BoolValue")
                b.Name = car.Name
                b.Value = true
                b.Parent = ownedFolder
            end
        end
    end

    -- 3. Bypass Gamepass (Hooking)
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        if getnamecallmethod() == "UserOwnsGamePassAsync" then return true end
        return old(self, ...)
    end)
    setreadonly(mt, true)

    Rayfield:Notify({Title = "Nyemek HuB", Content = "Bypass Berhasil! Cek Uang & Mobil."})
end

-- ============================================
-- UI TABS
-- ============================================

local MainTab = Window:CreateTab("🔓 Unlocker", 4483362458)
MainTab:CreateButton({
   Name = "🚀 ACTIVATE ALL (Money, Cars, Gamepass)",
   Callback = function() FullCDTUnlock() end,
})

local FarmTab = Window:CreateTab("💰 Auto Farm", 4483362458)
FarmTab:CreateToggle({
   Name = "🏗️ Auto Build Dealership",
   CurrentValue = false,
   Callback = function(v) _G.AutoBuild = v end,
})
FarmTab:CreateToggle({
   Name = "🏪 Auto Collect Cash",
   CurrentValue = false,
   Callback = function(v) _G.AutoCollect = v end,
})

local VehicleTab = Window:CreateTab("🚗 Vehicle", 4483362458)
VehicleTab:CreateSlider({Name = "Speed", Range = {1, 20}, Increment = 1, CurrentValue = 1, Callback = function(v) _G.VehicleSpeed = v end})
VehicleTab:CreateToggle({Name = "Nitro", CurrentValue = false, Callback = function(v) _G.InfiniteNitro = v end})

local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSlider({Name = "Walkspeed", Range = {16, 200}, CurrentValue = 16, Callback = function(v) player.Character.Humanoid.WalkSpeed = v end})
PlayerTab:CreateToggle({Name = "No Clip", CurrentValue = false, Callback = function(v) _G.NoClip = v end})

-- ============================================
-- LOOPS
-- ============================================

-- Auto Build & Collect
task.spawn(function()
    while task.wait(0.3) do
        if _G.AutoBuild and player.Character then
            -- CDT Auto Build Logic
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "BuyButton" or v.Name == "UpgradeButton" then
                    local touch = v:FindFirstChildOfClass("TouchTransmitter")
                    if touch then
                        firetouchinterest(player.Character.HumanoidRootPart, v, 0)
                        firetouchinterest(player.Character.HumanoidRootPart, v, 1)
                    end
                end
            end
        end
        if _G.AutoCollect then
            local rem = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:FindFirstChild("Events")
            if rem:FindFirstChild("CollectCash") then
                rem.CollectCash:FireServer()
            end
        end
    end
end)

-- Old Features: Speed & Nitro
game:GetService("RunService").Heartbeat:Connect(function()
    local seat = (player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.SeatPart)
    if seat and seat:IsA("VehicleSeat") then
        if _G.VehicleSpeed > 1 then seat.MaxSpeed = 500 * _G.VehicleSpeed end
        if _G.InfiniteNitro then
            local n = seat.Parent:FindFirstChild("Nitro") or seat.Parent:FindFirstChild("Stats")
            if n and n:FindFirstChild("Nitro") then n.Nitro.Value = 100 end
        end
    end
end)

-- NoClip
game:GetService("RunService").Stepped:Connect(function()
    if _G.NoClip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

Rayfield:Notify({Title = "Nyemek HuB", Content = "Script Ready! Jika tombol tidak muncul, klik Activate All."})
