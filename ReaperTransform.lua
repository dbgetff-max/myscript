--[[
  REAPER TRANSFORMATION V3 (CLOAK, MASK, WORKING SCYTHE)
  ปรับปรุง: ชุดดำ, หน้ากาก, เคียวฟันได้, ควันสมจริง
--]]

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local isTransformed = false
local items = {} -- เก็บของที่เสกออกมาเพื่อลบทีเดียว

-- === ฟังก์ชันสร้างปุ่ม GUI ===
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.ResetOnSpawn = false
local btn = Instance.new("TextButton", screenGui)
btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.5, -75, 0.05, 0)
btn.Text = "แปลงร่างยมทูต"
btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", btn)

-- === ฟังก์ชันกวัดแกว่งเคียว (Attack Animation) ===
local isAttacking = false
local function Attack()
    if isAttacking or not isTransformed then return end
    isAttacking = true
    
    local char = player.Character
    local scythe = char:FindFirstChild("ReaperScytheModel")
    if scythe then
        -- เอฟเฟกต์หมุนเคียวแบบง่ายๆ (CFrame Animation)
        local handle = scythe:FindFirstChild("Handle")
        if handle then
            for i = 1, 10 do
                handle.CFrame = handle.CFrame * CFrame.Angles(math.rad(10), 0, 0)
                task.wait(0.01)
            end
            task.wait(0.1)
            for i = 1, 10 do
                handle.CFrame = handle.CFrame * CFrame.Angles(math.rad(-10), 0, 0)
                task.wait(0.01)
            end
        end
    end
    isAttacking = false
end

-- === ฟังก์ชันหลัก: แปลงร่าง ===
local function Transform()
    local char = player.Character
    if not char then return end
    
    -- 1. เปลี่ยนสีตัวและชุด (Black Cloak)
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") then
            table.insert(items, {part = v, oldColor = v.Color}) -- จำสีเดิมไว้
            v.Color = Color3.fromRGB(0, 0, 0) -- เปลี่ยนเป็นสีดำ
        elseif v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then
            v.Parent = game.Lighting -- ซ่อนชุดเดิม
            table.insert(items, {item = v})
        end
    end

    -- 2. ใส่หน้ากาก (Skull/Mask)
    local head = char:WaitForChild("Head")
    local mask = Instance.new("Part", char)
    mask.Size = Vector3.new(1.1, 1.1, 1.1)
    mask.BrickColor = BrickColor.new("White") -- หน้ากากสีขาวกะโหลก
    mask.Material = Enum.Material.Neon
    local mWeld = Instance.new("WeldConstraint", mask)
    mWeld.Part0 = mask
    mWeld.Part1 = head
    mask.CFrame = head.CFrame
    table.insert(items, {obj = mask})

    -- 3. เสกเคียวสีดำ (Working Scythe)
    local scytheModel = Instance.new("Model", char)
    scytheModel.Name = "ReaperScytheModel"
    
    local handle = Instance.new("Part", scytheModel)
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.2, 7, 0.2)
    handle.Color = Color3.fromRGB(10, 10, 10)
    handle.CanCollide = false
    
    local blade = Instance.new("Part", scytheModel)
    blade.Size = Vector3.new(0.2, 4, 1.5)
    blade.Color = Color3.fromRGB(0, 0, 0)
    blade.Material = Enum.Material.Neon
    blade.CanCollide = false
    
    local w1 = Instance.new("WeldConstraint", blade)
    w1.Part0 = handle
    w1.Part1 = blade
    blade.CFrame = handle.CFrame * CFrame.new(0, 3, 1) * CFrame.Angles(math.rad(45),0,0)
    
    local w2 = Instance.new("WeldConstraint", handle)
    w2.Part0 = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
    w2.Part1 = handle
    handle.CFrame = (char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")).CFrame
    
    table.insert(items, {obj = scytheModel})

    -- 4. ควันดำ (พุ่งตลอดเวลาที่แปลงร่าง)
    local attachment = Instance.new("Attachment", char.HumanoidRootPart)
    local smoke = Instance.new("ParticleEmitter", attachment)
    smoke.Color = ColorSequence.new(Color3.fromRGB(0,0,0))
    smoke.Size = NumberSequence.new(5, 8)
    smoke.Rate = 50
    smoke.Lifetime = NumberRange.new(1, 2)
    table.insert(items, {obj = attachment})
end

-- === ฟังก์ชันคืนร่าง ===
local function UnTransform()
    for _, data in pairs(items) do
        if data.obj then data.obj:Destroy() end
        if data.part and data.oldColor then data.part.Color = data.oldColor end
        if data.item then data.item.Parent = player.Character end
    end
    items = {}
end

-- === ระบบปุ่มกด และ คลิกฟัน ===
btn.MouseButton1Click:Connect(function()
    if not isTransformed then
        isTransformed = true
        btn.Text = "คืนร่างเดิม"
        Transform()
    else
        isTransformed = false
        btn.Text = "แปลงร่างยมทูต"
        UnTransform()
    end
end)

mouse.Button1Down:Connect(Attack) -- คลิกเมาส์เพื่อฟัน
