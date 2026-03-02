-- [[ WHITE DEMON SERVER-SIDE TEST SCRIPT ]] --
-- ชื่อไฟล์: WhiteDemon_Final_Mobile.lua

local p = game.Players.LocalPlayer
local c = p.Character or p.CharacterAdded:Wait()
local h = c:WaitForChild("Humanoid")

-- 1. ขยายร่างให้ใหญ่ยักษ์ (Force Scaling)
-- เราจะใช้การวนซ้ำเพื่อบังคับค่าให้ค้างไว้
task.spawn(function()
    while task.wait(0.5) do
        local s = 15 -- ความใหญ่ (ปรับเพิ่มได้)
        local sc = {"BodyHeightScale", "BodyWidthScale", "BodyDepthScale", "HeadScale"}
        for _, name in pairs(sc) do
            local val = h:FindFirstChild(name)
            if not val then
                val = Instance.new("NumberValue", h)
                val.Name = name
            end
            val.Value = s
        end
    end
end)

-- 2. เปลี่ยนร่างสีขาว Neon (สว่างจนคนต้องหันมอง)
for _, v in pairs(c:GetChildren()) do
    if v:IsA("BasePart") then
        v.Color = Color3.new(1, 1, 1)
        v.Material = Enum.Material.Neon
        v.CanCollide = true -- ป้องกันตัวจมดินเวลาขยายใหญ่
    elseif v:IsA("Accessory") or v:IsA("Shirt") or

