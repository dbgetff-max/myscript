-- [[ Android Style Moon Menu V3 - ระบบ Auto Farm เต็มรูปแบบ ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

-- สถานะระบบ Auto
local autoFarmActive = false
local autoWorkoutActive = false

-- พิกัดตัวอย่าง (คุณต้องเปลี่ยนเลข X, Y, Z ให้ตรงกับจุดในเกมของคุณ)
local posItem = Vector3.new(10, 5, 50)     -- จุดหยิบของ
local posFinish = Vector3.new(100, 5, 50)   -- จุดส่งของ (เส้นชัย)
local posWorkout = Vector3.new(-50, 5, -50) -- จุดฝึกซ้อม

-- สร้าง UI
local sg = Instance.new("ScreenGui")
sg.Name = "AndroidMoonV3"
sg.Parent = pgui
sg.ResetOnSpawn = false

-- 1. ปุ่มดวงจันทร์ (ลากวางได้)
local moonBtn = Instance.new("ImageButton")
moonBtn.Size = UDim2.new(0, 65, 0, 65)
moonBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
moonBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
moonBtn.Image = "rbxassetid://12525501" 
moonBtn.ImageColor3 = Color3.fromRGB(255, 230, 100)
moonBtn.Parent = sg
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(1, 0)
btnCorner.Parent = moonBtn

-- 2. หน้าต่างเมนู
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 260, 0, 420)
mainFrame.Position = UDim2.new(0.5, -130, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.Visible = false
mainFrame.Parent = sg
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 20)
frameCorner.Parent = mainFrame

-- หัวข้อภาษาไทย
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.Text = "AUTO STRONGMAN V3"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BackgroundTransparency = 1
title.Parent = mainFrame

-- ฟังก์ชันสร้างปุ่ม
local function createBtn(text, pos, color)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9, 0, 0, 45)
	btn.Position = pos
	btn.BackgroundColor3 = color or Color3.fromRGB(50, 50, 60)
	btn.Text = text
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 14
	btn.Parent = mainFrame
	local bCorner = Instance.new("UICorner")
	bCorner.CornerRadius = UDim.new(0, 10)
	bCorner.Parent = btn
	return btn
end

-- --- สร้างปุ่มควบคุม ---
local btnAutoFarm = createBtn("🚀 เริ่มระบบ: ออโต้ฟาร์ม (ขนของ)", UDim2.new(0.05, 0, 0.2, 0), Color3.fromRGB(0, 120, 215))
local btnAutoWork = createBtn("💪 เริ่มระบบ: ออโต้ฝึกซ้อม", UDim2.new(0.05, 0, 0.35, 0), Color3.fromRGB(150, 0, 200))
local btnNoWeight = createBtn("🏃 โหมดตัวเบา (เดินไว)", UDim2.new(0.05, 0, 0.5, 0), Color3.fromRGB(60, 140, 100))
local btnReset = createBtn("💀 รีเซ็ตตัวละคร", UDim2.new(0.05, 0, 0.85, 0), Color3.fromRGB(180, 50, 50))

-- --- ระบบการทำงาน (Logic) ---

local function teleportTo(pos)
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
	end
end

-- 1. Loop ออโต้ฟาร์ม (ขนของ)
task.spawn(function()
	while task.wait(0.5) do
		if autoFarmActive then
			-- วาร์ปไปจุดหยิบของ
			teleportTo(posItem)
			task.wait(0.5)
			-- เดินไปจุดส่ง (ในที่นี้ใช้การวาร์ปเพื่อความไวตามที่คุณขอ)
			teleportTo(posFinish)
			task.wait(0.5)
		end
	end
end)

btnAutoFarm.MouseButton1Click:Connect(function()
	autoFarmActive = not autoFarmActive
	btnAutoFarm.Text = autoFarmActive and "🛑 หยุดระบบ: ออโต้ฟาร์ม" or "🚀 เริ่มระบบ: ออโต้ฟาร์ม (ขนของ)"
	btnAutoFarm.BackgroundColor3 = autoFarmActive and Color3.fromRGB(200, 100, 0) or Color3.fromRGB(0, 120, 215)
end)

-- 2. ระบบวาร์ปไปฝึกซ้อม
btnAutoWork.MouseButton1Click:Connect(function()
	teleportTo(posWorkout)
	print("วาร์ปไปจุดฝึกซ้อมแล้ว!")
end)

-- 3. ระบบตัวเบา
btnNoWeight.MouseButton1Click:Connect(function()
	local hum = player.Character and player.Character:FindFirstChild("Humanoid")
	if hum then
		hum.WalkSpeed = (hum.WalkSpeed == 16) and 70 or 16
		btnNoWeight.Text = (hum.WalkSpeed == 70) and "🏃 ปิดโหมด: ตัวเบา" or "🏃 โหมดตัวเบา (เดินไว)"
	end
end)

-- 4. ระบบลากปุ่มดวงจันทร์ (เหมือน Android)
local dragStart, startPos, dragging
moonBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging, dragStart, startPos = true, input.Position, moonBtn.Position
	end
end)
UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		moonBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
UIS.InputEnded:Connect(function() dragging = false end)
moonBtn.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)
btnReset.MouseButton1Click:Connect(function() player.Character:BreakJoints() end)

