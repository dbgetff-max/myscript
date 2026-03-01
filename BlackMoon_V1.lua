local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "🌙 Black Moon Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "MoonConfig", IntroText = "Black Moon Loading..."})

-- [[ Main Tab ]]
local MainTab = Window:MakeTab({
	Name = "🏠 Auto Farm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

MainTab:AddToggle({
	Name = "Auto Power Up (อัพพลัง)",
	Default = false,
	Callback = function(Value)
		_G.AutoFarm = Value
		while _G.AutoFarm do
			-- ใส่ Event ของเกมคุณที่นี่ (ตัวอย่าง)
			game:GetService("ReplicatedStorage").Events.Train:FireServer()
			task.wait(0.1)
		end
	end    
})

-- [[ Warp Tab ]]
local WarpTab = Window:MakeTab({
	Name = "🌀 Warp Logo",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

WarpTab:AddToggle({
	Name = "Auto Warp to Logo (วาร์ปเก็บโลโก้)",
	Default = false,
	Callback = function(Value)
		_G.WarpLogo = Value
		while _G.WarpLogo do
			pcall(function()
				for _, v in pairs(game.Workspace:GetDescendants()) do
					if v.Name == "Logo" or v:IsA("TouchTransmitter") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
						task.wait(0.1)
					end
				end
			end)
			task.wait(0.5)
		end
	end    
})

OrionLib:Init()
