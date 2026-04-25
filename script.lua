-- [[ CONFIGURATION ]]
local ESP_CONFIG = {
    Box = {
        Enabled = true,
        Thickness = 1.5, -- ความหนาของเส้นขอบ
        Transparency = 0.8, -- ความเข้มของสี (0-1)
    },
    TeamColors = {
        Prisoner = Color3.fromRGB(255, 165, 0), -- ส้ม (นักโทษ)
        Police = Color3.fromRGB(0, 191, 255),    -- ฟ้า (ตำรวจ)
        Criminal = Color3.fromRGB(255, 0, 0),     -- แดง (ผู้ก่อการร้าย)
        Neutral = Color3.fromRGB(255, 255, 255)  -- ขาว (ไม่มีทีม)
    }
}

-- [[ core functions ]]
local currentCamera = workspace.CurrentCamera
local runService = game:GetService("RunService")
local localPlayer = game.Players.LocalPlayer

-- ฟังก์ชันดึงสีตามทีม
local function GetPlayerTeamColor(player)
    if player.Team then
        local teamName = player.Team.Name
        -- ตรวจสอบชื่อทีม (ปรับชื่อให้ตรงกับเกมของคุณได้ที่นี่)
        if teamName:find("Prisoner") then
            return ESP_CONFIG.TeamColors.Prisoner
        elseif teamName:find("Police") then
            return ESP_CONFIG.TeamColors.Police
        elseif teamName:find("Criminal") then
            return ESP_CONFIG.TeamColors.Criminal
        end
    end
    return ESP_CONFIG.TeamColors.Neutral -- ถ้าไม่มีทีม
end

-- [[ main system ]]
local function CreateESPBox(player)
    if player == localPlayer then return end -- ไม่สร้างกล่องรอบตัวเอง

    -- สร้าง object Drawing สำหรับวาดกล่อง
    local box = Drawing.new("Square")
    box.Visible = false
    box.Thickness = ESP_CONFIG.Box.Thickness
    box.Transparency = ESP_CONFIG.Box.Transparency
    box.Filled = false -- กล่องโปร่งใส ไม่ถมสีข้างใน

    local function UpdateESP()
        local connection
        connection = runService.RenderStepped:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                
                local char = player.Character
                local rootPart = char.HumanoidRootPart
                local humanoid = char.Humanoid
                
                -- แปลงตำแหน่ง 3D เป็น 2D บนหน้าจอ
                local rootPos, onScreen = currentCamera:WorldToViewportPoint(rootPart.Position)
                
                if onScreen then
                    -- คำนวณขนาดของกล่องตามระยะห่าง
                    -- หาความสูงของตัวละคร
                    local head = char:FindFirstChild("Head")
                    if head then
                        local headPos = currentCamera:WorldToViewportPoint(head.Position)
                        local legPos = currentCamera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
                        
                        local height = math.abs(headPos.Y - legPos.Y)
                        local width = height * 0.6 -- อัตราส่วนความกว้างของกล่อง
                        
                        -- ตั้งค่าขนาดและตำแหน่งกล่อง
                        box.Size = Vector2.new(width, height)
                        box.Position = Vector2.new(rootPos.X - width / 2, rootPos.Y - height / 2)
                        
                        -- อัปเดตสีตามทีม
                        box.Color = GetPlayerTeamColor(player)
                        
                        box.Visible = true
                    else
                        box.Visible = false
                    end
                else
                    box.Visible = false -- นอกจอ ไม่แสดง
                end
            else
                box.Visible = false -- ตาย หรือไม่มีตัวละคร ไม่แสดง
                if not player.Parent then -- ถ้าผู้เล่นออกจากเกม
                    box:Remove()
                    connection:Disconnect()
                end
            end
        end)
    end

    -- เริ่มทำงาน
    if player.Character then UpdateESP() end
    player.CharacterAdded:Connect(UpdateESP)
end

-- [[ 2. RUN IMMEDIATELY FOR EVERYONE ]]
for _, p in pairs(game.Players:GetPlayers()) do
    CreateESPBox(p)
end
game.Players.PlayerAdded:Connect(CreateESPBox)

-- แสดงข้อความแจ้งเตือน (ลบออกได้ถ้าไม่ต้องการ)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ESP กล่องทำงานแล้ว",
    Text = "แยกสี: ฟ้า(ตำรวจ), ส้ม(นักโทษ), แดง(Criminal)",
    Duration = 5
})

print("สคริปต์ ESP Box (ทำงานอัตโนมัติ) ได้รับการโหลดแล้ว")
