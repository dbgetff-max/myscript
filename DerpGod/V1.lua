-- [[ Eleven Derp Land: Mahoraga & Jujutsu V10 ]] --
local player = game.Players.LocalPlayer
local core = game:GetService("CoreGui")

if core:FindFirstChild("ElevenHub") then core.ElevenHub:Destroy() end

local sg = Instance.new("ScreenGui", core)
sg.Name = "ElevenHub"

-- [ UI Setup ] --
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 230, 0, 400) -- เพิ่มความสูงเพื่อความขลัง
Main.Position = UDim2.new(0.5, -115, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", TopBar)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "MAHORAGA SYSTEM 🎡"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -10, 1, -50)
Scroll.Position = UDim2.new(0, 5, 0, 45)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 4, 0) 
Scroll.ScrollBarThickness = 2

local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 8)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function CreateBtn(name, color, func)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0.95, 0, 0, 45)
    btn.BackgroundColor3 = color
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    btn.Activated:Connect(func)
end

-- [[ ฟังก์ชันมโหราคะ ]] --

-- 🎡 1. อัญเชิญวงแหวน (Summon Wheel) - มีวงแหวนหมุนบนหัว
CreateBtn("อัญเชิญมโหราคะ! 🎡", Color3.fromRGB(200, 200, 200), function()
    local hrp = player.Character.HumanoidRootPart
    if hrp:FindFirstChild("MahoragaWheel") then hrp.MahoragaWheel:Destroy() end
    
    local wheel = Instance.new("Part", hrp)
    wheel.Name = "MahoragaWheel"
    wheel.Size = Vector3.new(5, 0.5, 5)
    wheel.Shape = Enum.PartType.Cylinder
    wheel.Color = Color3.fromRGB(255, 255, 100)
    wheel.Material = Enum.Material.Neon
    wheel.CanCollide = false
    wheel.CFrame = hrp.CFrame * CFrame.new(0, 5, 0) * CFrame.Angles(0, 0, math.rad(90))
    
    local weld = Instance.new("WeldConstraint", wheel)
    weld.Part0 = wheel
    weld.Part1 = hrp
    
    -- สั่งให้วงแหวนหมุน (หมุนทีเดียวคือปรับตัวได้!)
    spawn(function()
        while wheel.Parent do
            wheel.CFrame = wheel.CFrame * CFrame.Angles(math.rad(10), 0, 0)
            task.wait(0.1)
        end
    end)
end)

-- ⚔️ 2. ตบด้วยดาบปราบมาร (Exorcism Sword) - ตบแรงระเบิด
CreateBtn("ดาบปราบมาร! ⚔️", Color3.fromRGB(255, 255, 255), function()
    local hrp = player.Character.HumanoidRootPart
    -- เอฟเฟกต์ฟัน
    local slash = Instance.new("Part", workspace)
    slash.Size = Vector3.new(20, 1, 1)
    slash.Color = Color3.new(1, 1, 1)
    slash.Material = Enum.Material.Neon
    slash.Anchored = true
    slash.CFrame = hrp.CFrame * CFrame.new(0, 0, -10)
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (v.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < 25 then
                v.Character.Humanoid.Health = 0
                -- กระเด็น
                v.Character.HumanoidRootPart.Velocity = Vector3.new(0, 100, 0)
            end
        end
    end
    task.wait(0.2)
    slash:Destroy()
end)

-- 🩸 3. เจาะโลหิต (Piercing Blood)
CreateBtn("เจาะโลหิต! 🩸", Color3.fromRGB(180, 0, 0), function()
    local hrp = player.Character.HumanoidRootPart
    local beam = Instance.new("Part", workspace)
    beam.Size = Vector3.new(1, 1, 100)
    beam.Color = Color3.fromRGB(255, 0, 0)
    beam.Material = Enum.Material.Neon
    beam.Anchored = true
    beam.CFrame = hrp.CFrame * CFrame.new(0, 0, -55)
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if (v.Character.HumanoidRootPart.Position - hrp.Position).Magnitude < 60 then
                v.Character.Humanoid.Health = 0
            end
        end
    end
    task.wait(0.5)
    beam:Destroy()
end)

-- 🟣 4. มุราซากิ (Purple)
CreateBtn("มุราซากิ! 🟣", Color3.fromRGB(150, 0, 255), function()
    local hrp = player.Character.HumanoidRootPart
    local p = Instance.new("Part", workspace)
    p.Size = Vector3.new(20, 20, 20); p.Shape = "Ball"; p.Color = Color3.fromRGB(150,0,255); p.Material = "Neon"; p.Position = hrp.Position; p.CanCollide = false
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character then v.Character.Humanoid.Health = 0 end
    end
    task.wait(0.5); p:Destroy()
end)

-- 🌑 5. กางอาณาเขต
CreateBtn("กางอาณาเขต! 🌑", Color3.fromRGB(0, 0, 0), function()
    local hrp = player.Character.HumanoidRootPart
    local d = Instance.new("Part", workspace); d.Size = Vector3.new(100,100,100); d.Shape = "Ball"; d.Color = Color3.new(0,0,0); d.Material = "Neon"; d.Anchored = true; d.Position = hrp.Position; d.Transparency = 0.5
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character then v.Character.Humanoid.WalkSpeed = 0 end
    end
    task.wait(5); d:Destroy()
end)
