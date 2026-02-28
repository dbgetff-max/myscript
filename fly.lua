-- [[ Blox Fruits Ultimate Test Suite ]] --
-- Features: Auto Farm (Level-Based), ESP (All), Fruit Tracker, Black Screen

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- 1. ระบบ ESP (มองเห็นผู้เล่น, ผล, บอส, ศัตรู)
local function createESP(part, color, name)
    if part:FindFirstChild("ESPTag") then return end
    local bgui = Instance.new("BillboardGui", part)
    bgui.Name = "ESPTag"
    bgui.AlwaysOnTop = true
    bgui.Size = UDim2.new(0, 200, 0, 50)
    bgui.ExtentsOffset = Vector3.new(0, 3, 0)
    
    local tl = Instance.new("TextLabel", bgui)
    tl.BackgroundTransparency = 1
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.Text = name
    tl.TextColor3 = color
    tl.TextSize = 14
    tl.TextStrokeTransparency = 0
end

-- ลูปเช็ค Object รอบตัวเพื่อทำ ESP
task.spawn(function()
    while task.wait(5) do
        -- ESP ผู้เล่น
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
                createESP(p.Character.Head, Color3.new(1, 0, 0), "Player: "..p.Name)
            end
        end
        -- ESP ผลปีศาจ
        for _, f in pairs(game.Workspace:GetChildren()) do
            if f:IsA("Tool") or f.Name:find("Fruit") then
                createESP(f, Color3.new(1, 1, 0), "🍎 Fruit")
            end
        end
    end
end)

-- 2. ระบบ Auto Farm Level (วาร์ปไปตามเลเวล)
local function getFarmIsland()
    local lv = player.Data.Level.Value
    if lv < 10 then return Vector3.new(100, 20, 100) -- ตัวอย่างพิกัดเกาะเริ่มต้น
    elseif lv < 50 then return Vector3.new(-1500, 30, 200) -- เกาะบากี้
    -- เพิ่มเงื่อนไขเลเวลและพิกัดตามที่คุณต้องการได้ที่นี่
    else return Vector3.new(-1000, 100, -1000) 
    end
end

task.spawn(function()
    while _G.AutoFarm do
        task.wait(1)
        local targetPos = getFarmIsland()
        hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 10, 0)) -- วาร์ปไปเหนือหัว
    end
end)

-- 3. ระบบวาร์ปเก็บผล (Fruit Sniper)
local function collectFruits()
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Tool") and v.Name:find("Fruit") then
            hrp.CFrame = v.Handle.CFrame
            task.wait(0.5)
        end
    end
end

-- 4. ระบบปิดจอดำ (Save Battery)
local function toggleBlackScreen(enable)
    if enable then
        local gui = Instance.new("ScreenGui", game.CoreGui)
        gui.Name = "BlackScreenGui"
        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
        frame.ZIndex = 999
    else
        if game.CoreGui:FindFirstChild("BlackScreenGui") then
            game.CoreGui.BlackScreenGui:Destroy()
        end
    end
end

-- สั่งเริ่มทำงาน
_G.AutoFarm = true
toggleBlackScreen(true) -- เปิดจอดำ (เปลี่ยนเป็น false ถ้าอยากปิด)
print("--- สคริปต์ฟาร์มออโต้และ ESP ทำงานแล้ว ---")
