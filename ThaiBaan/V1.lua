-- [[ Eleven Heaven: Pain & Mahoraga Era V18 ]] --
local player = game.Players.LocalPlayer
local core = game:GetService("CoreGui")

if core:FindFirstChild("ElevenHeavenUI") then core.ElevenHeavenUI:Destroy() end

local sg = Instance.new("ScreenGui", core)
sg.Name = "ElevenHeavenUI"

-- [[ ปุ่มเปิด/ปิด (🔮) ]] --
local ToggleBtn = Instance.new("TextButton", sg)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 10, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.Text = "🔮"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

-- [[ หน้าต่างหลัก Style Box Food ]] --
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 350, 0, 280)
Main.Position = UDim2.new(0.5, -175, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Visible = false 
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 100, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", Sidebar)

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "PAIN\nHEAVEN"
Title.TextColor3 = Color3.fromRGB(255, 100, 0)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -110, 1, -10)
Scroll.Position = UDim2.new(0, 105, 0, 5)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 3, 0)
Scroll.ScrollBarThickness = 2
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 7)

local function CreateBtn(name, color, func)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.BackgroundColor3 = color
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    btn.Activated:Connect(func)
end

ToggleBtn.Activated:Connect(function() Main.Visible = not Main.Visible end)

-- [[ --- สกิลเพน 6 วิถี & ไสยเวท --- ]] --

-- 1. คลายเทพพิชิตฟ้า (Almighty Push) - ดีดทุกคนออกไปรอบตัว
CreateBtn("คลายเทพพิชิตฟ้า! 🌀", Color3.fromRGB(255, 100, 0), function()
    local hrp = player.Character.HumanoidRootPart
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (v.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < 50 then
                local force = (v.Character.HumanoidRootPart.Position - hrp.Position).Unit * 100
                v.Character.HumanoidRootPart.Velocity = force + Vector3.new(0, 50, 0)
            end
        end
    end
end)

-- 2. หมื่นลักษณ์เหนี่ยวรั้ง (Universal Pull) - ดึงทุกคนมาหา
CreateBtn("หมื่นลักษณ์เหนี่ยวรั้ง! 🧲", Color3.fromRGB(100, 100, 100), function()
    local hrp = player.Character.HumanoidRootPart
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character then
            v.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
        end
    end
end)

-- 3. กางอาณาเขต (ไซส์ถล่มเมือง) - ใหญ่กว่าเดิม 10 เท่า!
CreateBtn("กางอาณาเขต (ระดับเมือง) 🌑", Color3.fromRGB(0, 0, 0), function()
    local d = Instance.new("Part", workspace)
    d.Shape = "Ball"; d.Size = Vector3.new(1000, 1000, 1000) -- ใหญ่เท่าเมือง
    d.Color = Color3.new(0, 0, 0); d.Material = "Neon"; d.Transparency = 0.6; d.Anchored = true; d.Position = player.Character.HumanoidRootPart.Position
    d.CanCollide = false
    task.wait(10); d:Destroy()
end)

-- 4. มุราซากิ (Purple)
CreateBtn("มุราซากิ! 🟣", Color3.fromRGB(130, 0, 255), function()
    local hrp = player.Character.HumanoidRootPart
    local ball = Instance.new("Part", workspace)
    ball.Shape = "Ball"; ball.Size = Vector3.new(20, 20, 20); ball.Color = Color3.fromRGB(150,0,255); ball.Material = "Neon"; ball.Anchored = true; ball.CanCollide = false
    ball.CFrame = hrp.CFrame
    spawn(function()
        for i = 1, 100 do
            ball.CFrame = ball.CFrame * CFrame.new(0, 0, -5)
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character and (v.Character.HumanoidRootPart.Position - ball.Position).Magnitude < 20 then
                    v.Character.Humanoid.Health = 0
                end
            end
            task.wait(0.02)
        end
        ball:Destroy()
    end)
end)

-- 5. อัญเชิญมโหราคะ (วงแหวน)
CreateBtn("อัญเชิญมโหราคะ 🎡", Color3.fromRGB(180, 180, 180), function()
    local hrp = player.Character.HumanoidRootPart
    local wheel = Instance.new("Part", hrp)
    wheel.Size = Vector3.new(5, 0.2, 5); wheel.Color = Color3.new(1, 1, 0.5); wheel.Material = "Neon"; wheel.CanCollide = false
    local weld = Instance.new("Weld", wheel)
    weld.Part0 = wheel; weld.Part1 = hrp; weld.C0 = CFrame.new(0, -4, 0) * CFrame.Angles(math.rad(90), 0, 0)
    spawn(function() while wheel.Parent do wheel.CFrame = wheel.CFrame * CFrame.Angles(0, 0, math.rad(12)); task.wait(0.05) end end)
end)
