-- สร้างหน้าจอ GUI แบบสดๆ
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- ตั้งค่าหน้าจอ
ScreenGui.Parent = game.CoreGui -- ใช้ CoreGui จะได้ไม่หายเวลาตาย
ScreenGui.Name = "FastClicker"

-- ตั้งค่าปุ่มกด
MainButton.Parent = ScreenGui
MainButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- เริ่มต้นสีแดง
MainButton.Position = UDim2.new(0.5, -40, 0.5, -40) -- อยู่กลางจอ
MainButton.Size = UDim2.new(0, 80, 0, 80) -- ขนาดปุ่มวงกลม
MainButton.Font = Enum.Font.GothamBold
MainButton.Text = "OFF"
MainButton.TextColor3 = Color3.new(1, 1, 1)
MainButton.TextSize = 20
MainButton.Draggable = true -- ลากย้ายที่ได้
MainButton.Active = true

-- ทำปุ่มให้กลม
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = MainButton

local clicking = false

-- ระบบคลิกรัว
MainButton.MouseButton1Click:Connect(function()
    clicking = not clicking
    
    if clicking then
        MainButton.Text = "ON"
        MainButton.BackgroundColor3 = Color3.fromRGB(50, 255, 50) -- เปลี่ยนเป็นสีเขียว
        
        task.spawn(function()
            while clicking do
                -- สั่งให้ตัวละครกดใช้ของที่ถืออยู่ (Tool)
                local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                end
                
                -- คลิกหน้าจอแบบเสมือน (Virtual Click)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
                
                task.wait(0.01) -- ความเร็ว (0.01 คือเร็วมาก)
            end
        end)
    else
        MainButton.Text = "OFF"
        MainButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- กลับเป็นสีแดง
    end
end)

print("มือสดกดเมนู: รันแล้ว! ลากปุ่มไว้ที่ไหนก็ได้แล้วกดเปิดได้เลย")
