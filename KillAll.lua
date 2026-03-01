--[[
    Universal Script: Basic Kill All & Player Tools
    คำเตือน: ใช้เพื่อการศึกษาในแมพที่อนุญาตเท่านั้น
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

print("--- Script Loaded Successfully ---")

-- ฟังก์ชันสำหรับ Kill All (จะทำงานได้เฉพาะเกมที่ RemoteEvent มีช่องโหว่)
local function KillAll()
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= LocalPlayer then
            pcall(function()
                -- พยายามทำให้เลือดเหลือ 0 (ถ้า FE ไม่กัน)
                if target.Character and target.Character:FindFirstChild("Humanoid") then
                    target.Character.Humanoid.Health = 0
                end
            end)
        end
    end
end

-- ฟังก์ชันวาร์ปทุกคนมาหาเรา (Bring All)
local function BringAll()
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                target.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
            end)
        end
    end
end

-- คุณสามารถเรียกใช้ฟังก์ชันเหล่านี้ได้ใน Executor ของคุณ
-- ตัวอย่าง: KillAll() หรือ BringAll()
KillAll() 
