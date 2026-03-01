-- [[ Lost Duty - V4 Silent FOV & Auto Lock ]] --
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

-- การตั้งค่า (ปรับแต่งได้ในโค้ด)
local FOV_RADIUS = 300 -- ขนาดวงกลม (ยิ่งใหญ่ยิ่งล็อคไกล)
local FOV_COLOR = Color3.fromRGB(255, 0, 0) -- สีแดง
local LOCK_PART = "Head" -- ล็อคที่หัว

-- สร้างวงกลม FOV ด้วย Drawing API (สำหรับตัวรัน Android)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = FOV_COLOR
FOVCircle.Filled = false
FOVCircle.Transparency = 1
FOVCircle.Visible = true
FOVCircle.Radius = FOV_RADIUS

-- ฟังก์ชันหาศัตรูที่อยู่ในวงกลม
local function getTargetInFOV()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(LOCK_PART) then
            -- ตรวจสอบว่าศัตรูยังมีชีวิตอยู่
            if v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local screenPos, onScreen = Camera:WorldToViewportPoint(v.Character[LOCK_PART].Position)
                
                if onScreen then
                    local mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    
                    -- ถ้าอยู่ในรัศมีวงกลม และใกล้เป้าเล็งที่สุด
                    if distance <= FOV_RADIUS and distance < shortestDistance then
                        closestPlayer = v
                        shortestDistance = distance
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- ระบบทำงานอัตโนมัติ (ไม่ต้องกดปุ่ม)
RunService.RenderStepped:Connect(function()
    -- อัปเดตตำแหน่งวงกลมให้อยู่กลางจอเสมอ
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    local target = getTargetInFOV()
    if target and target.Character then
        -- ล็อคเป้าหมาย (Auto Lock)
        local targetPos = target.Character[LOCK_PART].Position
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPos)
        
        -- ระบบยิงอัตโนมัติ (ถ้ามีฟังก์ชันยิงในตัวรันของคุณ)
        -- mouse1click() 
    end
end)
