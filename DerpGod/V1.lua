-- [[ Eleven Derp Land: FIXED God Edition V11 ]] --
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local core = game:GetService("CoreGui")

if core:FindFirstChild("ElevenHub") then core.ElevenHub:Destroy() end

local sg = Instance.new("ScreenGui", core)
sg.Name = "ElevenHub"

-- [ UI Setup ] --
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 230, 0, 380)
Main.Position = UDim2.new(0.5, -115, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -10, 1, -50)
Scroll.Position = UDim2.new(0, 5, 0, 45)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 3.5, 0)
Scroll.ScrollBarThickness = 2
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 8)

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

-- [[ 🎡 หมวดมโหราคะ (FIXED) ]] --
CreateBtn("อัญเชิญวงแหวน (ติดหัว) 🎡", Color3.fromRGB(255, 215, 0), function()
    if hrp:FindFirstChild("Wheel") then hrp.Wheel:Destroy() end
    local wheel = Instance.new("Part", hrp)
    wheel.Name = "Wheel"
    wheel.Size = Vector3.new(4, 0.2, 4)
    wheel.Color = Color3.new(1, 1, 0.5)
    wheel.Material = "Neon"
    wheel.CanCollide = false
    
    local weld = Instance.new("Weld", wheel)
    weld.Part0 = wheel
    weld.Part1 = hrp
    weld.C0 = CFrame.new(0, -3.5, 0) * CFrame.Angles(math.rad(90), 0, 0) -- ล็อกบนหัว ไม่ใช่ตัวเราหมุน
    
    spawn(function()
        while wheel.Parent do
            wheel.CFrame = wheel.CFrame * CFrame.Angles(0, 0, math.rad(10))
            task.wait(0.05)
        end
    end)
end)

-- [[ 🩸 เจาะโลหิต (แรงสะใจ+ไกลพิเศษ) ]] --
CreateBtn("เจาะโลหิต (พุ่งตรง) 🩸", Color3.fromRGB(200, 0, 0), function()
    local beam = Instance.new("Part", workspace)
    beam.Size = Vector3.new(1, 1, 200) -- ยาว 200 หน่วย
    beam.Color = Color3.new(1, 0, 0)
    beam.Material = "Neon"
    beam.Anchored = true
    beam.CanCollide = false
    -- ยิงออกจากหน้าอกตรงๆ ไปข้างหน้า
    beam.CFrame = hrp.CFrame * CFrame.new(0, 0, -105) 
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local relPos = hrp.CFrame:PointToObjectSpace(v.Character.HumanoidRootPart.Position)
            -- เช็คว่าอยู่ข้างหน้าในระยะทางที่กำหนด
            if math.abs(relPos.X) < 5 and relPos.Z < 0 and relPos.Z > -200 then
                v.Character.Humanoid.Health = 0
            end
        end
    end
    task.wait(0.3)
    beam:Destroy()
end)

-- [[ 🟣 มุราซากิ (พุ่งไปข้างหน้า ไม่ลงดิน) ]] --
CreateBtn("มุราซากิ (พุ่งพิฆาต) 🟣", Color3.fromRGB(150, 0, 255), function()
    local ball = Instance.new("Part", workspace)
    ball.Shape = "Ball"
    ball.Size = Vector3.new(15, 15, 15)
    ball.Color = Color3.fromRGB(150, 0, 255)
    ball.Material = "Neon"
    ball.CanCollide = false
    ball.Anchored = true
    ball.CFrame = hrp.CFrame
    
    -- สั่งให้บอลพุ่งไปข้างหน้า
    spawn(function()
        for i = 1, 50 do
            ball.CFrame = ball.CFrame * CFrame.new(0, 0, -4)
            -- เช็คคนโดนบอล
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    if (v.Character.HumanoidRootPart.Position - ball.Position).Magnitude < 15 then
                        v.Character.Humanoid.Health = 0
                    end
                end
            end
            task.wait(0.02)
        end
        ball:Destroy()
    end)
end)

-- [[ 🌑 กางอาณาเขต (กางกลางแมพ/รอบตัว) ]] --
CreateBtn("กางอาณาเขต (ไร้มาตรา) 🌑", Color3.fromRGB(0, 0, 0), function()
    local dome = Instance.new("Part", workspace)
    dome.Shape = "Ball"
    dome.Size = Vector3.new(100, 100, 100)
    dome.Color = Color3.new(0, 0, 0)
    dome.Material = "Neon"
    dome.Transparency = 0.5
    dome.Anchored = true
    dome.CanCollide = false
    dome.Position = hrp.Position -- กางจุดที่เรายืน
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") then
            v.Character.Humanoid.WalkSpeed = 0
            v.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(math.random(-10,10), 0, math.random(-10,10))
        end
    end
    task.wait(7)
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("Humanoid") then v.Character.Humanoid.WalkSpeed = 16 end
    end
    dome:Destroy()
end)
