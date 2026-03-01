-- [[ Moonlight Hub - Multi-Platform Script ]]
-- Features: Auto Warp, Auto Farm, Black UI, Moon Toggle

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🌙 Moonlight Hub | v1.0",
   LoadingTitle = "Starting All-In-One Script...",
   LoadingSubtitle = "Support: Android, iPhone, PC",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "MoonlightData"
   },
   KeySystem = false -- ตั้งเป็น true ถ้าคุณต้องการใส่ระบบ Key
})

-- [[ Main Tab: สำหรับอัพพลัง ]]
local MainTab = Window:CreateTab("⚡ Auto Farm", 4483362458)
local FarmSection = MainTab:CreateSection("Power Up Features")

MainTab:CreateToggle({
   Name = "Auto Strength & Power (อัพพลังอัตโนมัติ)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      while _G.AutoFarm do
         -- ส่วนนี้คือการส่งคำสั่งไปที่ Server เพื่ออัพพลัง (ต้องแก้ตามชื่อแมพ)
         game:GetService("ReplicatedStorage").Events.Train:FireServer() 
         task.wait(0.1)
      end
   end,
})

MainTab:CreateToggle({
   Name = "Auto Pet Power (อัพพลังสัตว์เลี้ยง)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoPet = Value
      while _G.AutoPet do
         -- คำสั่งสำหรับอัพพลังสัตว์เลี้ยง
         task.wait(0.5)
      end
   end,
})

-- [[ Warp Tab: สำหรับวาร์ปเก็บของ/โลโก้ ]]
local WarpTab = Window:CreateTab("🌀 Warp & Items", 4483345998)

WarpTab:CreateToggle({
   Name = "Fast Warp to Rarest (วาร์ปเก็บโลโก้ทันที)",
   CurrentValue = false,
   Callback = function(Value)
      _G.WarpItem = Value
      spawn(function()
         while _G.WarpItem do
            -- ค้นหาของที่หายากที่สุดในแมพแล้ววาร์ปไปทับ
            for _, item in pairs(game.Workspace:GetDescendants()) do
               if item.Name == "RareLogo" or item:IsA("TouchTransmitter") then -- แก้ชื่อตามของในแมพ
                  local targetPos = item.Parent.CFrame
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPos
                  task.wait(0.1) -- เก็บไวมาก
               end
            end
            task.wait(0.5)
         end
      end)

