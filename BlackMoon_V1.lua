local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "🌙 Black Moon | วิ่งไปหา เบนหลอด", HidePremium = false, SaveConfig = true, IntroText = "Loading Moon Hub..."})

-- [[ Tab หลัก ]]
local MainTab = Window:MakeTab({
	Name = "🏃 Auto Play",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- ฟีเจอร์วาร์ปไปหาของ (เบนหลอด / โลโก้)
MainTab:AddToggle({
	Name = "Auto Warp to Ben (วาร์ปไปหาเบนทันที)",
	Default = false,
	Callback = function(Value)
		_G.WarpBen = Value
		spawn(function()
			while _G.WarpBen do
				pcall(function()
					-- พยายามค้นหาตัว 'Ben' หรือ 'Logo' ใน Workspace
					for _, v in pairs(game.Workspace:GetDescendants()) do
						-- ตรวจสอบชื่อที่น่าจะเป็นไอเทมเป้าหมาย
						if v.Name:find("Ben") or v.Name:find("Lord") or v.Name:find("Logo") or v:IsA("TouchTransmitter") then
							local target = v:IsA("TouchTransmitter") and v.Parent or v
							if target:IsA("BasePart") then
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame
								task.wait(0.1) -- วาร์ปไวแบบกดปุ๊บถึงปั๊บ
							end
						end
					end
				end)
				task.wait(0.3)
			end
		end)
	end    
})

-- ฟีเจอร์วิ่งไว (Speed)
MainTab:AddSlider({
	Name = "Adjust Speed (ความเร็วการวิ่ง)",
	Min = 16,
	Max = 500,
	Default = 50,
	Color = Color3.fromRGB(0,0,0),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

-- [[ Settings Tab ]]
local SettingTab = Window:MakeTab({
	Name = "🌙 UI Settings",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

SettingTab:AddButton({
	Name = "Close Menu (ปิดหน้าจอ)",
	Callback = function()
        OrionLib:Destroy()
  	end    
})

OrionLib:Init()
