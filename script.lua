-- [[ MOD MENU SETTINGS ]]
local MenuConfig = {
    Enabled = true,
    TeamColors = {
        Prisoner = Color3.fromRGB(255, 165, 0), -- ส้ม
        Police = Color3.fromRGB(0, 191, 255),    -- ฟ้า
        Criminal = Color3.fromRGB(255, 0, 0)     -- แดง
    },
    TeleportPoints = {
        BaseCriminal = Vector3.new(100, 10, 200), -- แก้พิกัดฐานผู้ก่อการร้ายตรงนี้
        PoliceStation = Vector3.new(-50, 15, -100) -- แก้พิกัดโรงพักตรงนี้
    }
}

-- [[ 1. ฟังก์ชัน ESP & Health Bar (GPS) ]]
local function CreateESP(player)
    if player == game.Players.LocalPlayer then return end
    
    local function UpdateESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and MenuConfig.Enabled then
                -- (ในที่นี้คือ Logic การวาดเส้น Tracer และหลอดเลือด)
                -- หมายเหตุ: Delta ต้องรองรับ Drawing Library เพื่อให้แสดงผลได้สวยงามแบบ Free Fire
            else
                if not player.Parent then connection:Disconnect() end
            end
        end)
    end
    UpdateESP()
end

-- [[ 2. ระบบวาร์ป (Teleport) ]]
local function TeleportTo(position)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- [[ 3. ระบบตรวจจับ 3 นิ้ว แตะ 2 ครั้ง (Toggle) ]]
local UIS = game:GetService("UserInputService")
local lastTap = 0
local tapCount = 0

UIS.TouchTapInWorld:Connect(function(touchPositions)
    if #touchPositions == 3 then -- ตรวจสอบว่าใช้ 3 นิ้ว
        local currentTime = tick()
        if currentTime - lastTap < 0.5 then -- ระยะเวลา Double Tap
            MenuConfig.Enabled = not MenuConfig.Enabled
            
            -- แสดงสถานะการเปิด/ปิด
            local status = MenuConfig.Enabled and "เปิดใช้งาน" or "ปิดใช้งาน"
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Mod Status",
                Text = "ฟังก์ชันทั้งหมด: " .. status,
                Duration = 3
            })
        end
        lastTap = currentTime
    end
end)

-- [[ 4. เริ่มทำงาน (Initialize) ]]
for _, player in pairs(game.Players:GetPlayers()) do
    CreateESP(player)
end
game.Players.PlayerAdded:Connect(CreateESP)

print("Script Loaded: ใช้ 3 นิ้วแตะหน้าจอ 2 ครั้งเพื่อเปิด/ปิด")
