-- [[ CONFIGURATION ]]
local ESP_SETTINGS = {
    Enabled = true,
    TracerColor = {
        Prisoner = Color3.fromRGB(255, 165, 0), -- ส้ม
        Police = Color3.fromRGB(0, 191, 255),    -- ฟ้า
        Criminal = Color3.fromRGB(255, 0, 0)     -- แดง
    }
}

-- [[ 1. ระบบ ESP & GPS (ทำงานทันที) ]]
-- ฟังก์ชันวาดเส้นและแสดงตำแหน่ง
local function CreateESP(player)
    if player == game.Players.LocalPlayer then return end

    local function CharacterAdded(char)
        local root = char:WaitForChild("HumanoidRootPart", 10)
        local hum = char:WaitForChild("Humanoid", 10)
        if not root or not hum then return end

        -- สร้างเส้น Tracer (แบบ Free Fire)
        local line = Drawing.new("Line")
        line.Visible = false
        line.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y) -- เริ่มจากขอบล่างจอ
        line.Thickness = 1.5
        line.Transparency = 1

        -- ระบบอัปเดตตำแหน่งแบบ Real-time
        local updater
        updater = game:GetService("RunService").RenderStepped:Connect(function()
            if char and char:Parent() and root and root.Parent and hum.Health > 0 then
                local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(root.Position)
                
                if onScreen then
                    -- เลือกสีตามทีม
                    local teamColor = Color3.new(1, 1, 1) -- สีขาวพื้นฐาน
                    if player.Team then
                        if player.Team.Name == "Prisoners" or player.Team.Name == "Prisoner" then
                            teamColor = ESP_SETTINGS.TracerColor.Prisoner
                        elseif player.Team.Name == "Police" then
                            teamColor = ESP_SETTINGS.TracerColor.Police
                        elseif player.Team.Name == "Criminals" or player.Team.Name == "Criminal" then
                            teamColor = ESP_SETTINGS.TracerColor.Criminal
                        end
                    end

                    line.To = Vector2.new(pos.X, pos.Y)
                    line.Color = teamColor
                    line.Visible = true
                else
                    line.Visible = false
                end
            else
                line.Visible = false
                if not player.Parent then
                    line:Remove()
                    updater:Disconnect()
                end
            end
        end)
    end

    if player.Character then CharacterAdded(player.Character) end
    player.CharacterAdded:Connect(CharacterAdded)
end

-- [[ 2. เริ่มทำงานทันทีสำหรับทุกคนในเซิร์ฟเวอร์ ]]
for _, v in pairs(game.Players:GetPlayers()) do
    CreateESP(v)
end
game.Players.PlayerAdded:Connect(CreateESP)

-- [[ 3. ฟังชั่นเสริม: แสดงข้อความเมื่อรันสำเร็จ ]]
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Script Active",
    Text = "ระบบ ESP และแยกสีทีมทำงานแล้ว",
    Duration = 5
})

print("สคริปต์ทำงานอัตโนมัติเรียบร้อยแล้ว!")
