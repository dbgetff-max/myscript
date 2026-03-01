local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local isTransformed = false -- สถานะตัวแปรเช็คการแปลงร่าง

-- === สร้าง GUI ปุ่มกด ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ReaperGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleButton"
toggleBtn.Size = UDim2.new(0, 150, 0, 50)
toggleBtn.Position = UDim2.new(0.5, -75, 0.1, 0) -- อยู่ตรงกลางด้านบน
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Text = "Reaper: OFF"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 20
toggleBtn.Parent = screenGui

-- ใส่ความโค้งมนให้ปุ่ม
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = toggleBtn

-- === ฟังก์ชันจัดการเคียว ===
local currentScythe = nil

local function RemoveScythe()
	if currentScythe then
		currentScythe:Destroy()
		currentScythe = nil
	end
end

local function CreateScythe(char)
	local rightHand = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
	if not rightHand then return end

	local scytheModel = Instance.new("Model")
	scytheModel.Name = "ReaperScythe"
	scytheModel.Parent = char

	-- ด้ามเคียว
	local handle = Instance.new("Part")
	handle.Size = Vector3.new(0.2, 7, 0.2)
	handle.BrickColor = BrickColor.new("Really black")
	handle.Material = Enum.Material.Metal
	handle.CanCollide = false
	handle.Parent = scytheModel

	-- ใบมีด
	local blade = Instance.new("Part")
	blade.Size = Vector3.new(0.2, 3, 1)
	blade.BrickColor = BrickColor.new("Really black")
	blade.Material = Enum.Material.Neon
	blade.CanCollide = false
	blade.Parent = scytheModel

	-- เชื่อมใบมีดกับด้าม
	local bladeWeld = Instance.new("WeldConstraint")
	bladeWeld.Part0 = handle
	bladeWeld.Part1 = blade
	bladeWeld.Parent = blade
	blade.CFrame = handle.CFrame * CFrame.new(0, 3, 1.5) * CFrame.Angles(math.rad(45), 0, 0)

	-- เชื่อมเคียวกับมือ
	local handWeld = Instance.new("WeldConstraint")
	handWeld.Part0 = rightHand
	handWeld.Part1 = handle
	handWeld.Parent = handle
	handle.CFrame = rightHand.CFrame * CFrame.Angles(math.rad(-90), 0, 0)

	currentScythe = scytheModel
end

-- === ฟังก์ชันจัดการควัน ===
local function CreateSmokeEffect(char)
	local hrp = char:WaitForChild("HumanoidRootPart")
	local attachment = Instance.new("Attachment", hrp)
	
	local smoke = Instance.new("ParticleEmitter")
	smoke.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
	smoke.Size = NumberSequence.new(5, 10)
	smoke.Transparency = NumberSequence.new(0.5, 1)
	smoke.Lifetime = NumberRange.new(1.5, 2.5)
	smoke.Rate = 200
	smoke.Speed = NumberRange.new(5, 12)
	smoke.Parent = attachment
	
	-- ควันพ่นออกมา 4 วินาทีแล้วหยุด
	task.delay(4, function()
		smoke.Enabled = false
		game:GetService("Debris"):AddItem(attachment, 3)
	end)
end

-- === ทำงานเมื่อกดปุ่ม ===
toggleBtn.MouseButton1Click:Connect(function()
	local char = player.Character
	if not char then return end

	if not isTransformed then
		-- [แปลงร่าง]
		isTransformed = true
		toggleBtn.Text = "Reaper: ON"
		toggleBtn.TextColor3 = Color3.fromRGB(255, 0, 0) -- เปลี่ยนตัวหนังสือเป็นสีแดง
		
		CreateSmokeEffect(char) -- เอฟเฟกต์ควันดำ
		CreateScythe(char) -- เสกเคียวสีดำ
		
	else
		-- [คืนร่าง]
		isTransformed = false
		toggleBtn.Text = "Reaper: OFF"
		toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		
		RemoveScythe() -- ลบเคียวทิ้ง
	end
end)
