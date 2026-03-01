-- [[ Eleven ThaiBaan Hub: Pro UI Edition ]] --
local player = game.Players.LocalPlayer
local core = game:GetService("CoreGui")

-- ลบ UI เก่าออกก่อน (ถ้ามี)
if core:FindFirstChild("ElevenHub") then core.ElevenHub:Destroy() end

local sg = Instance.new("ScreenGui", core)
sg.Name = "ElevenHub"

-- [[ ตัวเมนูหลัก ]] --
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 220, 0, 280)
Main.Position = UDim2.new(0.5, -110, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- แถบหัวเมนู (ไว้พับเก็บ)
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "ELEVEN HUB V4"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

-- ปุ่มพับเมนู (Minimize)
local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -30, 0, 5)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

-- [[ ส่วนเลื่อนปุ่ม (Scrolling Frame) ]] --
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -10, 1, -45)
Scroll.Position = UDim2.new(0, 5, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0) -- เลื่อนลงได้
Scroll.ScrollBarThickness = 4

local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 8)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- [[ ฟังก์ชันสร้างปุ่มแบบมือโปร ]] --
local function CreateBtn(name, color, func)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = color
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn)
    btn.Activated:Connect(func)
end

-- --- เพิ่มปุ่มต่าง ๆ ลงในเมนู --- --

CreateBtn("ดึงเด็กแว้นมานี่! 🌀", Color3.fromRGB(0, 150, 100), function()
    local hrp = player.Character.HumanoidRootPart
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            v.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
        end
    end
end)

CreateBtn("ส่งไปสวรรค์ ☁️", Color3.fromRGB(0, 170, 255), function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = v.Character.HumanoidRootPart
            local bv = Instance.new("BodyVelocity", hrp)
            bv.Velocity = Vector3.new(0, 1000, 0)
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            task.wait(0.5)
            bv:Destroy()
            local bf = Instance.new("BodyForce", hrp)
            bf.Force = Vector3.new(0, 5000, 0)
        end
    end
end)

CreateBtn("นรกสั่งตาย! 💀", Color3.fromRGB(200, 0, 0), function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") then
            v.Character.Humanoid.Health = 0
        end
    end
end)

CreateBtn("ตัวใหญ่ยักษ์! 👹", Color3.fromRGB(150, 100, 0), function()
    local hum = player.Character.Humanoid
    for _, s in pairs({"BodyHeightScale","BodyWidthScale","BodyDepthScale","HeadScale"}) do
        if hum:FindFirstChild(s) then hum[s].Value = 4 end
    end
end)

CreateBtn("สุ่มวาร์ปคนลงน้ำ 🌊", Color3.fromRGB(0, 80, 150), function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            v.Character.HumanoidRootPart.CFrame = CFrame.new(0, -50, 0) -- วาร์ปไปใต้แมพที่มีน้ำ
        end
    end
end)

CreateBtn("ลบรถทั้งเซิร์ฟ 🚜", Color3.fromRGB(80, 80, 80), function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("VehicleSeat") or v.Name:lower():find("car") then
            v.Parent:Destroy()
        end
    end
end)

-- [[ ระบบพับเมนู ]] --
local minimized = false
MinBtn.Activated:Connect(function()
    minimized = not minimized
    if minimized then
        Scroll.Visible = false
        Main:TweenSize(UDim2.new(0, 220, 0, 35), "Out", "Quart", 0.3, true)
        MinBtn.Text = "+"
    else
        Main:TweenSize(UDim2.new(0, 220, 0, 280), "Out", "Quart", 0.3, true)
        task.wait(0.3)
        Scroll.Visible = true
        MinBtn.Text = "-"
    end
end)
