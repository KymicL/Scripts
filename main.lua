local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Ky Hub [UPD 1!] Ninja Training Simulator 💥", HidePremium = true, IntroText = "Ky Hub", SaveConfig = true, ConfigFolder = "Ky"})

local Events = game:GetService("ReplicatedStorage").Events


--Values
getgenv().autoClick = true
getgenv().autoEgg = true
getgenv().autoRebirth = true
getgenv().autoUpgrades = true
getgenv().SelectEgg = "Basic"
getgenv().EggAmount = "Single"
getgenv().CraftAll = "Craft All"
getgenv().Craft = true



--Functions
function autoClick()
    spawn(function()
      while getgenv().autoClick == true do 
        Events.Click:FireServer()
        wait(.00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001)
        end  
    end)
end
 

function AntiAfk()
    local VirtualUser = game:service'VirtualUser'
    game:service('Players').LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    end)
end



function autoRebirth(Rebirthamount)
spawn(function()
    while getgenv().autoRebirth == true do
     Events.Rebirth:FireServer(Rebirthamount)
     wait(.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001)
      end
   end)
end


function AutoEgg()
    spawn(function()
    while getgenv().autoEgg == true do
     game:GetService("ReplicatedStorage").Functions.Unbox:InvokeServer(getgenv().SelectEgg, getgenv().EggAmount)
    wait()
    end 
  end)
end



function CraftAll()
    spawn(function()
    while getgenv().Craft == true do
    game:GetService("ReplicatedStorage").Functions.Request:InvokeServer(getgenv().CraftAll, {["PetID"] = 0})
    wait()
    end
   end)
end


function getCurrentPlayerPOS()
    local play = game.Player.Local.Player
    if play.Character then
        return play.CharacterHumaniodRootPart.Position
    end
    return false
end


function autoUps(AutoUpgrade)
spawn(function()
while getgenv().autoUpgrades == true do
    game:GetService("ReplicatedStorage").Functions.Upgrade:InvokeServer(AutoUpgrade)
    wait(.00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001)
    end
  end)
end


function teleportTO(placeCFrame)
    local play = game.Players.LocalPlayer
    if play.Character then
        play.Character.HumanoidRootPart.CFrame = placeCFrame
    end
end


function teleportWorld(world)
    if game:GetService("Workspace").Teleport:FindFirstChild(world) then
        teleportTO(game:GetService("Workspace").Teleport[world].CFrame)
   end
end



--Toggles

local a = Window:MakeTab({Name = "Farms",PremiumOnly = false})

a:AddToggle({Name = "AutoClick",Default = false,Callback = function(bool)
    getgenv().autoClick = bool
        autoClick()
end})


local rebirthSelected
 

a:AddToggle({Name = "AutoRebirth",Default = false,Callback = function(bool)
    getgenv().autoRebirth = bool
    if bool and rebirthSelected then
        autoRebirth(rebirthSelected)
    end
end})



a:AddDropdown({Name = "Rebirth",Default = "1",Options = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19},Callback = function(Value)
    rebirthSelected = Value
end})


a:AddToggle({Name = "Auto hatch",Default = false,Callback = function(bool)
    getgenv().autoEgg = bool
    AutoEgg()
end})


a:AddDropdown({Name = "Select Egg",Default = "Basic",Options = {"Basic","Ocean","Volcano","Forest","Candy","Cyber","Desert"},Callback = function(Value)
    getgenv().SelectEgg = Value
end})

a:AddDropdown({Name = "Amount",Default = "Single",Options = {"Single","Triple"},Callback = function(value)
    getgenv().EggAmount = value
end})

a:AddToggle({Name = "CraftAll",Default = false,Callback = function(bool)
    getgenv().Craft = bool
    CraftAll()
 end})



local b = Window:MakeTab({Name = "Upgrades",PremiumOnly = false})


b:AddToggle({Name = "Gems",Default = false,Callback = function(Value)
    getgenv().autoUpgrades = Value
    if Value then
    autoUps("Gems")
    end
end})

b:AddToggle({Name = "Power",Default = false,Callback = function(Value)
   getgenv().autoUpgrades = Value
    if Value then
        autoUps("Power")
    end
end})

b:AddToggle({Name = "Pet Equip",Default = false,Callback = function(Value)
    getgenv().autoUpgrades = Value
    if Value then
        autoUps("Pet Equip")
    end
end})

b:AddToggle({Name = "Pet Storage",Default = false,Callback = function(Value)
    getgenv().autoUpgrades = Value
    if Value then
        autoUps("Pet Storage")
    end
end})

b:AddToggle({Name = "Luck",Default = false,Callback = function(Value)
    getgenv().autoUpgrades = Value
    if Value then
        autoUps("Luck")
   end
end})


b:AddButton({Name = "Gems",Callback = function()
    game:GetService("ReplicatedStorage").Functions.Upgrade:InvokeServer("Gems")
end})

b:AddButton({Name = "Power",Callback = function(Power)
    game:GetService("ReplicatedStorage").Functions.Upgrade:InvokeServer("Power")
end})

b:AddButton({Name = "Pet equip",Callback = function(Petequip)
    game:GetService("ReplicatedStorage").Functions.Upgrade:InvokeServer("Petequip")
end})

b:AddButton({Name = "Pet Storage",Callback = function(PetStorage)
    game:GetService("ReplicatedStorage").Functions.Upgrade:InvokeServer("Pet Storage")
end})

b:AddButton({Name = "Luck",Callback = function(Luck)
    game:GetService("ReplicatedStorage").Functions.Upgrade:InvokeServer("Luck")
end})


local d = Window:MakeTab({Name = "Teleports",PremiumOnly = false})


local selectedWorld

d:AddDropdown({Name = "Teleport Worlds",Default = "Spawn",Options = {"Spawn","Ocean","Volcano","Forest","Candy","Cyber","Desert"},Callback = function(Value)
    selectedWorld = Value
end})

d:AddButton({Name = "Teleport Selected",Callback = function()
    if selectedWorld then
        teleportWorld(selectedWorld)
    end
end})



local e = Window:MakeTab({Name = "Misc",PremiumOnly = false})


e:AddSlider({
	Name = "WalkSpeed",Min = 0,Max = 200,Default = 16,Color = Color3.fromRGB(255,255,255),Increment = 1,ValueName = "WalkSpeed",Callback = function(WalkPace)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WalkPace
    end})

    e:AddSlider({
    Name = "JumpPower",Min = 0,Max = 200,Default = 50,Color = Color3.fromRGB(255,255,255),Increment = 1,ValueName = "JumpPower",Callback = function(Jumping)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jumping
    end})

    e:AddButton({Name = "Reset Jump/walk",Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end})

    e:AddButton({Name = "Anti Afk",Callback = function()
        AntiAfk()
    end})



OrionLib:Init()
OrionLib:Destroy()