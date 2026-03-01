--[[
  THE WORLD ENDER METEOR (ULTIMATE EDITION)
  คุณสมบัติ: ใหญ่เท่าเกาะ, ระเบิดล้างแมพ, เจ้าของไม่ตาย (God Mode เฉพาะตอนระเบิด)
--]]

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local Debris = game:GetService("Debris")

-- === 1. สร้างปุ่มเรียกอุกกาบาตยักษ์ ===
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.ResetOnSpawn = false

local btn = Instance.new("TextButton", screenGui)
btn.Size = UDim2.new(0, 250, 0, 70)
btn.Position = UDim2.new(0.5, -125, 0.1, 0)
btn.Text = "☄️ มหาอุกกาบาตล้างโลก"
btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- สีแดงเดือด
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBlack
btn.TextSize = 22
Instance.new("UICorner", btn)

-- === 2. ฟังก์ชันเรียกอุกกาบาต ===
local function SummonGiganticMeteor()
    local targetPos = mouse.Hit.p
    local spawnPos = targetPos + Vector3.new(0, 600, 0) -- ตกจากฟ้าสูงมาก

    -- สร้างลูกอุกกาบาต (ขนาดใหญ่เท่าเกาะ)
    local meteor = Instance.new("Part")
    meteor.Name = "WorldEnder"
    meteor.Shape = Enum.PartType.Ball
    meteor.Size = Vector3.new(150, 150, 150) -- ขนาดมหึมา 150 หน่วย!
    meteor.Position = spawnPos
    meteor.BrickColor = BrickColor.new("Black")
    meteor.Material = Enum.Material.Slate
    meteor.CanCollide = false
    meteor.Parent = game.Workspace

    -- เอฟเฟกต์ไฟนรก (ใหญ่พิเศษ)
    local fire = Instance.new("Fire", meteor)
    fire.Size = 200
    fire.Heat = 100
    
    -- เสียงตอนตกลงมา (สร้างความน่ากลัว)
    local sound = Instance.new("Sound", meteor)
    sound.SoundId = "rbxassetid://12222030" -- เสียงระเบิด/ลมพัดแรง
    sound.Volume = 10
    sound:Play()

    -- แรงส่งให้อุกกาบาตถล่มพื้น
    local velocity = Instance.new("BodyVelocity", meteor)
    velocity.MaxForce = Vector3.new(1, 1, 1) * math.huge
    velocity.Velocity = (targetPos - spawnPos).Unit * 300 -- พุ่งเร็วมาก

    -- เช็คเมื่อถึงพื้น
    meteor.Touched:Connect(function(hit)
        if hit.Parent ~= player.Character and not hit:IsDescendantOf(player.Character) then
            meteor:Destroy()

            -- --- ระบบป้องกันเจ้าของสคริปต์ (God Mode ชั่วคราว) ---
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = 100 -- ฮีลเลือดเต็ม
                local ff = Instance.new("ForceField", player.Character) -- ใส่เกราะกันระเบิด
                Debris:AddItem(ff, 5) -- เกราะหายไปหลังระเบิดจบ
            end

            -- --- ระเบิดมหาประลัย (ล้างแมพ) ---
            local explosion = Instance.new("Explosion")
            explosion.Position = meteor.Position
            explosion.BlastRadius = 1000 -- รัศมีกว้าง 1000 หน่วย (ทั่วทั้งเกาะ)
            explosion.BlastPressure = math.huge -- แรงดันมหาศาล (กระจุย)
            explosion.DestroyJointRadiusPercent = 1 -- ทำลายทุกข้อต่อ (ตายทันที)
            explosion.Parent = game.Workspace

            -- เอฟเฟกต์แสงสีขาววาบตอนระเบิด
            local flash = Instance.new("ColorCorrectionEffect", game.Lighting)
            flash.Brightness = 1
            game:GetService("TweenService"):Create(flash, TweenInfo.new(2), {Brightness = 0}):Play()
            Debris:AddItem(flash, 2)

            -- ควันดำปกคลุมแมพ
            local boomPart = Instance.new("Part", game.Workspace)
            boomPart.Anchored = true
            boomPart.CanCollide = false
            boomPart.Transparency = 1
            boomPart.Position = meteor.Position
            
            local smoke = Instance.new("ParticleEmitter", boomPart)
            smoke.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
            smoke.Size = NumberSequence.new(100, 200)
            smoke.Rate = 2000
            smoke.Lifetime = NumberRange.new(5, 10)
            smoke.EmitCount = 200
            
            Debris:AddItem(boomPart, 10)
        end
    end)
end

-- === 3. ระบบกดปุ่ม ===
btn.MouseButton1Click:Connect(function()
    btn.Text = "🚨 ระบบกำลังรีโหลด..."
    btn.Active = false
    SummonGiganticMeteor()
    
    task.wait(5) -- คูลดาวน์ 5 วินาที
    btn.Text = "☄️ มหาอุกกาบาตล้างโลก"
    btn.Active = true
end)

print("The World Ender Script Loaded! รันเสร็จแล้วกดปุ่มเพื่อล้างโลก!")
