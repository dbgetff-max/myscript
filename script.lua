-- [[ COMBAT & WEAPON SYSTEM ]]
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local RunService = game:GetService("RunService")

-- 1. ฟังก์ชันดึงอาวุธ (พยายามดึงปืนจากแสงสว่างในแมพ)
local function GetWeapons()
    -- พยายามหาปืนจากกลุ่มของที่หล่นพื้น หรือในกระเป๋า (Backpack)
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Tool") and (v.Name:lower():find("gun") or v.Name:lower():find("pistol") or v.Name:lower():find("rifle")) then
            v.Parent = player.Backpack
        end
    end
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Weapon Search",
        Text = "กำลังค้นหาและดึงอาวุธเข้าตัว...",
        Duration = 3
    })
end

-- 2. ระบบช่วยเล็ง (Aim Assist) - ยิงเข้าเป้า
local function GetClosestPlayer()
    local target = nil
    local dist = math.huge
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
            local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if onScreen then
                local magnitude = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                if magnitude < dist then
                    target = v
                    dist = magnitude
                end
            end
        end
    end
    return target
end

-- 3. ปุ่มเมนูเล็กๆ สำหรับเรียกปืนและยิง
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 150, 0, 100)
MainFrame.Position = UDim2.new(0.1, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local GetGunBtn = Instance.new("TextButton", MainFrame)
GetGunBtn.Size = UDim2.new(1, 0, 0.5, 0)
GetGunBtn.Text = "GET WEAPON"
GetGunBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
GetGunBtn.TextColor3 = Color3.new(1,1,1)

local KillBtn = Instance.new("TextButton", MainFrame)
KillBtn.Size = UDim2.new(1, 0, 0.5, 0)
KillBtn.Position = UDim2.new(0, 0, 0.5, 0)
KillBtn.Text = "LOCK & KILL"
KillBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
KillBtn.TextColor3 = Color3.new(1,1,1)

-- ตั้งค่าการทำงานของปุ่ม
GetGunBtn.MouseButton1Click:Connect(GetWeapons)

KillBtn.MouseButton1Click:Connect(function()
    local target = GetClosestPlayer()
    if target and target.Character then
        -- วาร์ปกระสุนหรือเป้าหมาย (ขึ้นอยู่กับระบบแมพ)
        player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Target Locked",
            Text = "กำลังเข้าประชิด: " .. target.Name,
            Duration = 2
        })
    end
end)

-- ทำให้เมนูลากได้
MainFrame.Active = true
MainFrame.Draggable = true

print("สคริปต์สายบวก: มือสดกดเมนู ทำงานแล้ว!")
