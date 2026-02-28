-- [[ Blox Fruits God Mode: Ultra Fast + Auto Code + Auto World 2 ]] --
local player = game.Players.LocalPlayer

-- 1. ระบบกด Code x2 Exp อัตโนมัติ (ใส่เพิ่มให้ครบๆ)
local codes = {"KITT_RESET", "Sub2CaptainMaui", "DEVSCOOKING", "Sub2Fer999", "JCWN", "KITT_GAMING"}
for _, v in pairs(codes) do
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RedeemFreeCode", v)
end

-- 2. ปุ่มเปิด/ปิดจอดำ (อยู่ด้านขวาจอ - กดเพื่อประหยัดแบต)
local screenGui = Instance.new("ScreenGui", game.CoreGui)
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 100, 0, 50)
toggleBtn.Position = UDim2.new(1, -120, 0.5, -25)
toggleBtn.Text = "เปิดจอดำ"
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)

local blackFrame = Instance.new("Frame", screenGui)
blackFrame.Size = UDim2.new(1, 0, 1, 0)
blackFrame.BackgroundColor3 = Color3.new(0, 0, 0)
blackFrame.Visible = false
blackFrame.ZIndex = 998
toggleBtn.ZIndex = 999

toggleBtn.MouseButton1Click:Connect(function()
    blackFrame.Visible = not blackFrame.Visible
    toggleBtn.Text = blackFrame.Visible and "ปิดจอดำ" or "เปิดจอดำ"
end)

-- 3. ระบบฟาร์มหลัก (รัดคิว 1-200 / ปกติ 200+ / ล่าบอส / ไปโลก 2)
_G.MainFarm = true
task.spawn(function()
    while _G.MainFarm do
        task.wait(0.1)
        pcall(function()
            local lv = player.Data.Level.Value
            
            -- ช่วงเลเวล 1-200: รัดคิวไปจุดเวลไวที่สุด
            if lv < 200 then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(630, 560, -1450)
            
            -- เมื่อถึงเลเวล 700: วาร์ปไปโลก 2 เองทันที
            elseif lv >= 700 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelSecondSea")
            
            -- ช่วงเลเวลปกติ: ดึงมอนสเตอร์มารวมกัน + ล่าบอสเอาค่าหัว
            else
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") then
                        -- ดึงมอนมารวมหน้าตัวละคร (Bring Mob)
                        v.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                        v.HumanoidRootPart.CanCollide = false
                    end
                end
            end
            
            -- ระบบอัพ Stats อัตโนมัติ (เน้น Melee 2 ส่วน Defense 1 ส่วน)
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 2)
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
        end)
    end
end)

print("สคริปต์ God Mode ติดตั้งสำเร็จ! ลุยเลเวล 700 ได้เลย")
