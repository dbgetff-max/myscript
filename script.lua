-- [[ METEOR STRIKE SYSTEM ]]
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local RunService = game:GetService("RunService")

-- สร้างเป้าเล็ง (Visual Circle)
local circlePart = Instance.new("Part")
circlePart.Size = Vector3.new(20, 0.2, 20)
circlePart.Shape = Enum.PartType.Cylinder
circlePart.Color = Color3.fromRGB(255, 0, 0)
circlePart.Transparency = 0.5
circlePart.CanCollide = false
circlePart.Anchored = true
circlePart.Material = Enum.Material.Neon
circlePart.Parent = workspace

-- ให้เป้าเล็งวิ่งตามนิ้ว/เมาส์
RunService.RenderStepped:Connect(function()
    if mouse.TargetFilter ~= circlePart then
        circlePart.Position = mouse.Hit.p
    end
end)

-- ฟังก์ชันสร้างอุกกาบาต
local function DropMeteor(targetPos)
    local meteor = Instance.new("Part")
    meteor.Size = Vector3.new(10, 10, 10)
    meteor.Shape = Enum.PartType.Ball
    meteor.Color = Color3.fromRGB(255, 69, 0) -- สีส้มไฟ
    meteor.Material = Enum.Material.Neon
    meteor.CanCollide = false
    meteor.Anchored = false
    meteor.Position = targetPos + Vector3.new(0, 300, 0) -- เกิดบนฟ้า
    meteor.Parent = workspace

    -- เอฟเฟกต์ไฟ
    local fire = Instance.new("Fire")
    fire.Parent = meteor
    fire.Size = 30

    -- ใส่แรงพุ่งลงมา
    local velocity = Instance.new("BodyVelocity")
    velocity.Velocity = Vector3.new(0, -500, 0)
    velocity.Parent = meteor

    -- เมื่อถึงพื้นหรือชน
    meteor.Touched:Connect(function(hit)
        local explosion = Instance.new("Explosion")
        explosion.Position = meteor.Position
        explosion.BlastRadius = 50 -- รัศมีระเบิด
        explosion.BlastPressure = 1000000 -- แรงระเบิด
        explosion.Parent = workspace
        
        -- ทำลายอุกกาบาตหลังระเบิด
        meteor:Destroy()
    end)
end

-- เมื่อกดคลิก (หรือแตะหน้าจอ) ให้ปล่อยอุกกาบาต
mouse.Button1Down:Connect(function()
    local targetLocation = mouse.Hit.p
    
    -- แจ้งเตือนก่อนตก
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Meteor Inbound!",
        Text = "เป้าหมายถูกล็อคแล้ว!",
        Duration = 2
    })
    
    DropMeteor(targetLocation)
end)

print("สคริปต์อุกกาบาตทำงานแล้ว: คลิกตรงไหน ตกตรงนั้น!")
