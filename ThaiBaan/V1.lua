-- [[ Eleven Chaos V4: ไทบ้านซิตี้ Edition ]] --
local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "ElevenThaiBaan"

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 200, 0, 180)
frame.Position = UDim2.new(0.4, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 50, 0) -- สีเขียวแบบไทบ้าน
frame.Active = true
frame.Draggable = true -- ลากหลบปุ่มในเกมได้
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "ไทบ้าน Destroyer 🚜"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold

-- [ ปุ่ม 1: วาร์ปเด็กแว้นมาหา (Bring All) ] --
local btn1 = Instance.new("TextButton", frame)
btn1.Size = UDim2.new(0.9, 0, 0, 45)
btn1.Position = UDim2.new(0.05, 0, 0.25, 0)
btn1.Text = "ดึงมาเข้าด่าน! 👮"
btn1.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
btn1.TextColor3 = Color3.new(0, 0, 0)
Instance.new("UICorner", btn1)

btn1.Activated:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                -- ดึงมาอยู่ข้างหน้าเรา
                v.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
            end
        end
    end
end)

-- [ ปุ่ม 2: ระเบิดวงเหล้า (Kill All) ] --
local btn2 = Instance.new("TextButton", frame)
btn2.Size = UDim2.new(0.9, 0, 0, 45)
btn2.Position = UDim2.new(0.05, 0, 0.6, 0)
btn2.Text = "ล้างทั้งซอย 💀"
btn2.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
btn2.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", btn2)

btn2.Activated:Connect(function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") then
            v.Character.Humanoid.Health = 0
        end
    end
end)
