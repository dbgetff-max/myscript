--[[
  METEOR STRIKE SCRIPT (ULTIMATE DESTRUCTION)
  คำเตือน: สคริปต์นี้สร้างระเบิดที่รุนแรงมาก!
--]]

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local RunService = game:GetService("RunService")

-- === 1. สร้างปุ่มเรียกอุกกาบาต (GUI) ===
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.ResetOnSpawn = false

local btn = Instance.new("TextButton", screenGui)
btn.Size = UDim2.new(0, 200, 0, 60)
btn.Position = UDim2.new(0.5, -100, 0.1, 0)
btn.Text = "☄️ CALL METEOR"
btn.BackgroundColor3 = Color3.fromRGB(200, 50, 0) -- สีส้มเพลิง
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBlack
btn.TextSize = 20
Instance.new("UICorner", btn)

-- === 2. ฟังก์ชันการทำงานของอุกกาบาต ===
local function SummonMeteor()
    local targetPos = mouse.Hit.p -- จุดที่เมาส์ชี้ หรือจุดที่อุกกาบาตจะลง
    local spawnPos = targetPos + Vector3.new(0, 300, 0) -- เกิดบนฟ้าสูง 300 เมตร

    -- สร้างลูกอุกกาบาต
    local meteor = Instance.new("Part")
    meteor.Name = "Meteor"
    meteor.Shape = Enum.PartType.Ball
    meteor.Size = Vector3.new(20, 20, 20) -- ขนาดใหญ่ยักษ์
    meteor.Position = spawnPos
    meteor.BrickColor = BrickColor.new("Cinder brown")
    meteor.Material = Enum.Material.Slate
    meteor.CanCollide = false
    meteor.Parent = game.Workspace

    -- ใส่ไฟและควันให้อุกกาบาต
    local fire = Instance.new("Fire", meteor)
    fire.Size = 50
    fire.Heat = 50
    
    local attachment = Instance.new("Attachment", meteor)
    local trail = Instance.new("ParticleEmitter", attachment)
    trail.Color = ColorSequence.new(Color3.fromRGB(255, 100, 0))
    trail.Size = NumberSequence.new(10, 0)
    trail.Lifetime = NumberRange.new(0.5, 1)
    trail.Rate = 500
    trail.Speed = NumberRange.new(20)

    -- ใส่ความเร็วให้อุกกาบาตพุ่งลงมา
    local velocity = Instance.new("BodyVelocity", meteor)
    velocity.MaxForce = Vector3.new(1, 1, 1) * math.huge
    velocity.Velocity = (targetPos - spawnPos).Unit * 250 -- ความเร็วพุ่งลง

    -- เช็คเมื่ออุกกาบาตถึงพื้น
    meteor.Touched:Connect(function(hit)
        if hit.Parent ~= player.Character then -- ไม่ระเบิดถ้าโดนตัวเอง (กันพลาด)
            meteor:Destroy()
            
            -- สร้างการระเบิดยักษ์
            local explosion = Instance.new("Explosion")
            explosion.Position = meteor.Position
            explosion.BlastRadius = 50 -- รัศมีระเบิด (กว้างมาก ตายเรียบ)
            explosion.BlastPressure = 1000000 -- แรงอัดมหาศาล
            explosion.Parent = game.Workspace
            
            -- เอฟเฟกต์ไฟหลังระเบิด
            local boomPart = Instance.new("Part", game.Workspace)
            boomPart.Anchored = true
            boomPart.CanCollide = false
            boomPart.Transparency = 1
            boomPart.Position = meteor.Position
            
            local boomSmoke = Instance.new("ParticleEmitter", boomPart)
            boomSmoke.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
            boomSmoke.Size = NumberSequence.new(20, 50)
            boomSmoke.Rate = 1000
            boomSmoke.Lifetime = NumberRange.new(2, 5)
            boomSmoke.EmitCount = 100
            
            game:GetService("Debris"):AddItem(boomPart, 5)
        end
    end)
end

-- === 3. เมื่อกดปุ่มให้เรียกใช้งาน ===
btn.MouseButton1Click:Connect(function()
    btn.Text = "⏳ RELOADING..."
    btn.Active = false
    SummonMeteor()
    
    task.wait(3) -- รอ 3 วินาทีก่อนกดใหม่ได้
    btn.Text = "☄️ CALL METEOR"
    btn.Active = true
end)

print("Meteor Script Loaded! Click the button to destroy!")
