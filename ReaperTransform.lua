--[[
  THE BLACK HOLE METEOR (BRING ALL & EXPLODE)
  ความสามารถ: ดึงทุกคนมาหาเรา -> ล็อกตัว -> เรียกอุกกาบาตลงหัว
--]]

local player = game.Players.LocalPlayer
local Debris = game:GetService("Debris")

-- === 1. สร้างปุ่มเรียกหายนะ (GUI) ===
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.ResetOnSpawn = false
local btn = Instance.new("TextButton", screenGui)
btn.Size = UDim2.new(0, 250, 0, 70)
btn.Position = UDim2.new(0.5, -125, 0.1, 0)
btn.Text = "🌀 ดึงมาฆ่าล้างเซิร์ฟ"
btn.BackgroundColor3 = Color3.fromRGB(100, 0, 200) -- สีม่วงเข้ม
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBlack
btn.TextSize = 22
Instance.new("UICorner", btn)

-- === 2. ฟังก์ชันดึงทุกคน (Bring All) ===
local function BringAllPlayers()
	local myHrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not myHrp then return end

	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
			-- วาร์ปทุกคนมาข้างหน้าเรา 5 หน่วย
			v.Character.HumanoidRootPart.CFrame = myHrp.CFrame * CFrame.new(0, 0, -5)
		end
	end
end

-- === 3. ฟังก์ชันเรียกอุกกาบาตยักษ์ลงจุดที่ยืน ===
local function SummonTheEnd()
	local myHrp = player.Character:FindFirstChild("HumanoidRootPart")
	local targetPos = myHrp.Position
	local spawnPos = targetPos + Vector3.new(0, 400, 0)

	-- สร้างอุกกาบาต
	local meteor = Instance.new("Part", game.Workspace)
	meteor.Shape = Enum.PartType.Ball
	meteor.Size = Vector3.new(100, 100, 100)
	meteor.Position = spawnPos
	meteor.BrickColor = BrickColor.new("Really black")
	meteor.Material = Enum.Material.Neon
	meteor.CanCollide = false

	-- แรงพุ่ง
	local bv = Instance.new("BodyVelocity", meteor)
	bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bv.Velocity = Vector3.new(0, -400, 0)

	-- เมื่อถึงพื้น
	meteor.Touched:Connect(function()
		meteor:Destroy()
		
		-- ใส่เกราะให้ตัวเอง
		local ff = Instance.new("ForceField", player.Character)
		Debris:AddItem(ff, 5)

		-- ระเบิดมหาประลัย
		local exp = Instance.new("Explosion", game.Workspace)
		exp.Position = targetPos
		exp.BlastRadius = 500
		exp.BlastPressure = math.huge
		exp.DestroyJointRadiusPercent = 1
		
		print("Everyone has been eliminated.")
	end)
end

-- === 4. ระบบทำงานเมื่อกดปุ่ม ===
btn.MouseButton1Click:Connect(function()
	btn.Text = "🌀 กำลังดึงตัว..."
	BringAllPlayers() -- ดึงมากองรวมกัน
	
	task.wait(0.5) -- รอแป๊บเดียวให้คนมาถึง
	
	btn.Text = "☄️ อวสาน!"
	SummonTheEnd() -- บึ้มทิ้ง
	
	task.wait(5)
	btn.Text = "🌀 ดึงมาฆ่าล้างเซิร์ฟ"
end)
