if not game:IsLoaded() then
    repeat
        task.wait()
    until game:IsLoaded()
end
if not (game.PlaceId == 104715542330896 or game.PlaceId == 97556409405464) then
    return
end

pcall(
    function()
        local TransitionModule = require(RS.Modules.Game.UI.TransitionUI)

        -- Hook transition() - บังคับรอ 10 วิ
        local old_transition = TransitionModule.transition
        TransitionModule.transition = function(p_in, p_wait, p_out, noLogo)
            return result
        end
    end
)


pcall(
    function()
        local CharCreator = require(RS.Modules.Game.CharacterCreator.CharacterCreator)

        
        if CharCreator.start then
            local old_start = CharCreator.start
            CharCreator.start = function(...)
                
                while true do
                    task.wait(1)
                end
            end
        end

        
        if CharCreator.load_page then
            local old_load = CharCreator.load_page
            CharCreator.load_page = function(...)
                return old_load(...)
            end
        end

        -- Hook initiate() - เริ่มต้น character creator
        if CharCreator.initiate then
            local old_initiate = CharCreator.initiate
            CharCreator.initiate = function(...)
                return old_initiate(...)
            end
        end
    end
)


local VehiclesFolder = workspace:WaitForChild("Vehicles")


local protectedVehicles = {}

local function updateVehicleList()
    protectedVehicles = {}

    for _, model in ipairs(VehiclesFolder:GetDescendants()) do
        if model:IsA("VehicleSeat") and model.Name == "DriverSeat" then
            local vehicle = model:FindFirstAncestorOfClass("Model")
            if vehicle then
                protectedVehicles[vehicle] = true
            end
        end
    end
end

updateVehicleList()



local function isProtectedSeat(seat)
    local vehicle = seat:FindFirstAncestorOfClass("Model")
    return vehicle and protectedVehicles[vehicle] == true
end



local function removeSeatIfNotInProtectedVehicle(seat)
    if isProtectedSeat(seat) then
        return 
    end

    seat:Destroy()
end



for _, seat in ipairs(workspace:GetDescendants()) do
    if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
        if not isProtectedSeat(seat) then
            removeSeatIfNotInProtectedVehicle(seat)
        end
    end
end



VehiclesFolder.DescendantAdded:Connect(function(obj)
    if obj:IsA("VehicleSeat") and obj.Name == "DriverSeat" then
        updateVehicleList()
    end
end)



workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("Seat") or obj:IsA("VehicleSeat") then
        if not isProtectedSeat(obj) then
            removeSeatIfNotInProtectedVehicle(obj)
        end
    end
end)

game:GetService("ReplicatedStorage")


if getgenv then
    getgenv().identifyexecutor = nil
end
if getfenv then
    local env = getfenv()
    env.identifyexecutor = nil
end

local v_u_1 = {}
local v2 = game.ReplicatedStorage:WaitForChild("Remotes")
local v_u_3 = {
	["send"] = v2:WaitForChild("Send"),
	["get"] = v2:WaitForChild("Get")
}
local v_u_4 = {
	["event"] = 0,
	["func"] = 0
}
local v_u_5 = {}
local v_u_6 = false
local v_u_7 = {}

function v_u_1.on_connect(p8)
	if v_u_6 then
		p8()
	else
		v_u_7[#v_u_7 + 1] = p8
	end
end

function v_u_1.hook(p_u_9, p_u_10)
	if not p_u_10 then
		error("Function nil for hook " .. p_u_9)
	end
	if v_u_6 then
		if v_u_5[p_u_9] then
			warn("Overwriting hook \'" .. p_u_9 .. "\'.")
		else
			v_u_5[p_u_9] = p_u_10
		end
	else
		v_u_1.on_connect(function()
			v_u_1.hook(p_u_9, p_u_10)
		end)
		return
	end
end

function v_u_1.is_connected(p11)
	return p11:GetAttribute("IsConnected") and true or false
end


local function v_u_19(p12, p13, p14, p15, ...)
	
	return p12(p13, p14, p15, ...)
end

task.wait(0.1)

local v_u_20 = v_u_3.send
local v_u_21 = v_u_3.send.FireServer


function v_u_1.send(p22, ...)
	v_u_4.event = v_u_4.event + 1
	
	v_u_21(v_u_20, v_u_4.event, p22, ...)
end

local v_u_23 = v_u_3.get
local v_u_24 = v_u_3.get.InvokeServer


function v_u_1.get(p25, ...)
	v_u_4.func = v_u_4.func + 1
	
	return v_u_24(v_u_23, v_u_4.func, p25, ...)
end

task.wait(0.1)

local function v_u_29()
	v_u_3.send.OnClientEvent:connect(function(p26, ...)
		if v_u_5[p26] then
			v_u_5[p26](...)
		else
			error("Invalid hook \'" .. p26 .. "\' fired!", 0)
		end
	end)
	
	function v_u_3.get.OnClientInvoke(p27, ...)
		if v_u_5[p27] then
			return v_u_5[p27](...)
		end
		error("Invalid hook \'" .. p27 .. "\' invoked!", 0)
	end
	
	if not pcall(function()
		for v28 = 1, #v_u_7 do
			v_u_7[v28]()
		end
	end) then
		pcall(function()
			print("On connect failed for client")
			v_u_1.send("issue", "On connect failed for client")
		end)
	end
end

function v_u_1.initiate() end

function v_u_1.loaded()
	function v_u_3.get.OnClientInvoke(p30)
		if p30 == "connect" then
			v_u_6 = true
			v_u_29()
			return true
		end
	end
	
	v_u_1.hook("ping", function()
		return true
	end)
end

print("bypassed")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local Debris = game:GetService("Debris")

local Players, RunService, Camera, LocalPlayer, Mouse =
    game:GetService("Players"),
    game:GetService("RunService"),
    workspace.CurrentCamera,
    game.Players.LocalPlayer,
    game.Players.LocalPlayer:GetMouse()

local Net = require(ReplicatedStorage.Modules.Core.Net)
local RagdollModule = require(ReplicatedStorage.Modules.Game.Ragdoll)
local Vechine = require(ReplicatedStorage.Modules.Game.VehicleSystem.Vehicle)
local CharModule = require(ReplicatedStorage.Modules.Core.Char)
local SprintModule = require(ReplicatedStorage.Modules.Game.Sprint)
local CrateController = require(ReplicatedStorage.Modules.Game.CrateSystem.Crate)

local Settings = {}
function c()
    return Settings
end

local Client = Players.LocalPlayer
local Character = Client.Character or Client.CharacterAdded:Wait()
local UserId = Client.UserId
local PlayerGui = Client.PlayerGui
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Backpack = Client:WaitForChild("Backpack")

Client.CharacterAdded:Connect(
    function(newCharacter)
        Character = newCharacter
        Humanoid = Character:WaitForChild("Humanoid")
        RootPart = Character:WaitForChild("HumanoidRootPart")
        Backpack = Client:WaitForChild("Backpack")
    end
)

local Sf = {}

local Sprint = require(game:GetService("ReplicatedStorage").Modules.Game.Sprint)

local consume_stamina = Sprint.consume_stamina
local SprintBar = debug.getupvalue(consume_stamina, 2).sprint_bar

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Quality x",
    Icon = "rbxassetid://138614699274576",
    Author = "Hello, I'm Txr, I'm cool.",
    Folder = "MySuperHub",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = false,
        Name = LocalPlayer.Name,
        Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId,
        Callback = function() end,
    },
})

Window:EditOpenButton({ Enabled = false })

local ScreenGui = Instance.new("ScreenGui")
local ToggleBtn = Instance.new("ImageButton")

ScreenGui.Name = "WindUI_Toggle"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Image = "rbxassetid://138614699274576" 
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local opened = true

local function toggle()
    opened = not opened
    if Window.UI then
        Window.UI.Enabled = opened
    else
        Window:Toggle()
    end
end

ToggleBtn.MouseButton1Click:Connect(function()
    ToggleBtn:TweenSize(
        UDim2.new(0, 56, 0, 56),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.12,
        true,
        function()
            ToggleBtn:TweenSize(
                UDim2.new(0, 50, 0, 50),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quad,
                0.12,
                true
            )
        end
    )
    toggle()
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.T then
        toggle()
    end
end)


if not LocalPlayer.Character then
LocalPlayer.CharacterAdded:Wait()
end


local MainTab =
    Window:Tab(
    {
        Title = "General",
        Icon = "globe"
    }
)


local Players = game:GetService("Players")
local Client = Players.LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")

local BankBalance =
    MainTab:Button(
    {
        Title = "🏦 Bank Balance",
        Desc = "N/A"
    }
)
local HandBalance =
    MainTab:Button(
    {
        Title = "💸 Hand Balance",
        Desc = "N/A"
    }
)

local function HandMoney()
    return tonumber(PlayerGui.TopRightHud.Holder.Frame.MoneyTextLabel.Text:match("%$(%d+)"))
end

local function ATMMoney()
    for _, v in ipairs(PlayerGui:GetDescendants()) do
        if v:IsA("TextLabel") and string.find(v.Text, "Bank Balance") then
            return tonumber(v.Text:match("%$(%d+)"))
        end
    end
    return 0
end

task.spawn(
    function()
        while task.wait(0.2) do
            BankBalance:SetDesc('<b><font color="#FFFFFF">$' .. (ATMMoney() or 0) .. "</font></b>")
            HandBalance:SetDesc('<b><font color="#FFFFFF">$' .. (HandMoney() or 0) .. "</font></b>")
        end
    end
)

MainTab:Section(
    {
        Title = "Player Modifier:"
    }
)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local defaultJumpPower = 20
local maxJumpPower = 100
local highJumpPower = 60
local walkSpeedMultiplier = 0.10
local highJumpActive = false
local speedActive = false

local function setJumpPower(power)
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = math.clamp(power, 0, maxJumpPower)
    end
end

local function setupCharacter(char)
    local hum = char:WaitForChild("Humanoid")
    hum.AutoJumpEnabled = false  

    if highJumpActive then
        hum.UseJumpPower = true
        hum.JumpPower = highJumpPower
    else
        hum.JumpPower = defaultJumpPower
    end
end

player.CharacterAdded:Connect(setupCharacter)

if player.Character then
    setupCharacter(player.Character)
end


MainTab:Toggle({
    Title = "High Jump",
    Default = false,
    Callback = function(state)
        highJumpActive = state
        if state then
            setJumpPower(highJumpPower)
        else
            setJumpPower(defaultJumpPower)
        end
    end
})

-- ปรับดโดสุง
MainTab:Slider({
    Title = "High Jump Power",
    Value = {Min = 20, Max = maxJumpPower, Default = highJumpPower},
    Step = 1,
    Callback = function(value)
        highJumpPower = tonumber(value)
        if highJumpActive then
            setJumpPower(highJumpPower)
        end
    end
})

-- ปุ่มวิ่งไว
MainTab:Toggle({
    Title = "Walk Speed",
    Default = false,
    Callback = function(state)
        speedActive = state
    end
})

-- ปรับวิ่งวไ
MainTab:Slider({
    Title = "Speed Multiplier",
    Value = {Min = 1, Max = 5, Default = walkSpeedMultiplier},
    Step = 1,
    Callback = function(value)
        walkSpeedMultiplier = tonumber(value)
    end
})

local player = Players.LocalPlayer
local AntiKillEnabled = false
local isAntiKill = false
local depth = 3
local fakeChar

local function getCharData()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")
    return char, hum, root
end

local function forceDownReal(root, hum, char)
    local targetY = root.Position.Y - depth
    root.CFrame = CFrame.new(root.Position.X, targetY, root.Position.Z)
    root.Velocity = Vector3.zero
    root.AssemblyLinearVelocity = Vector3.zero
    hum.PlatformStand = true
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

local function createFakeCharacter(root)
    local dummy = Instance.new("Model")
    dummy.Name = player.Name .. "_Fake"
    local hrp = Instance.new("Part")
    hrp.Name = "HumanoidRootPart"
    hrp.Size = Vector3.new(2,2,1)
    hrp.Anchored = true
    hrp.CanCollide = true
    hrp.Position = root.Position
    hrp.Parent = dummy
    local humanoid = Instance.new("Humanoid")
    humanoid.Parent = dummy
    dummy.Parent = workspace
    return dummy
end

local function startAntiKillLoop()
    if isAntiKill then return end
    isAntiKill = true

    local char, hum, root = getCharData()
    fakeChar = createFakeCharacter(root)
    local fakeRoot = fakeChar:FindFirstChild("HumanoidRootPart")

    task.spawn(function()
        while AntiKillEnabled and hum.Health > 0 and isAntiKill and hum.Health <= 21 do
            forceDownReal(root, hum, char)

            local power = 3
            local dx = math.random(-power, power)
            local dz = math.random(-power, power)
            local spin = CFrame.Angles(0, math.rad(50), 0)
            root.CFrame = (root.CFrame * spin) * CFrame.new(dx, 0, dz)

            if fakeRoot then
                fakeRoot.CFrame = root.CFrame + Vector3.new(0, depth, 0)
            end

            RunService.Heartbeat:Wait()
        end

        if fakeChar then
            fakeChar:Destroy()
            fakeChar = nil
        end
        hum.PlatformStand = false
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        root.CFrame = root.CFrame + Vector3.new(0, depth + 2, 0)
        isAntiKill = false
    end)
end

local function connectAntiKill(char)
    local hum = char:WaitForChild("Humanoid")
    hum.HealthChanged:Connect(function(hp)
        if AntiKillEnabled then
            if hp <= 21 and not isAntiKill then
                startAntiKillLoop()
            elseif hp >= 31 and isAntiKill then
                local char, hum, root = getCharData()
                if fakeChar then
                    fakeChar:Destroy()
                    fakeChar = nil
                end
                hum.PlatformStand = false
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
                root.CFrame = root.CFrame + Vector3.new(0, depth + 2, 0)
                isAntiKill = false
            end
        end
    end)
end

if player.Character then
    connectAntiKill(player.Character)
end

player.CharacterAdded:Connect(connectAntiKill)

MainTab:Toggle({
    Title = "Enable AntiKill",
    Default = false,
    Callback = function(state)
        AntiKillEnabled = state

        if AntiKillEnabled and player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum and hum.Health <= 21 and not isAntiKill then
                startAntiKillLoop()
            end
        end
    end
})

_G.AntiLock = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local CharModule = require(ReplicatedStorage.Modules.Core.Char)


local AntiAimAnimTrack = nil
local ANIM_ID = "rbxassetid://104767795538635"

local function playDanceAntiAim()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")

    if AntiAimAnimTrack then
        AntiAimAnimTrack:Stop()
        AntiAimAnimTrack:Destroy()
        AntiAimAnimTrack = nil
    end

    local anim = Instance.new("Animation")
    anim.AnimationId = ANIM_ID

    AntiAimAnimTrack = humanoid:LoadAnimation(anim)
    AntiAimAnimTrack.Looped = true
    AntiAimAnimTrack:Play()
    AntiAimAnimTrack:AdjustSpeed(99999999999999999999999999999999999)
end

local function stopDanceAntiAim()
    if AntiAimAnimTrack then
        AntiAimAnimTrack:Stop()
        AntiAimAnimTrack:Destroy()
        AntiAimAnimTrack = nil
    end
end


local function VelocityDesync()
    local hrp = CharModule.get_hrp()
    if not hrp then return end

    local OldVec = hrp.Velocity
    local Lin = hrp.AssemblyLinearVelocity
    local Ang = hrp.AssemblyAngularVelocity

    local RandomVec = Vector3.new(
        math.random(-16000, 16000),
        math.random(-16000, 16000),
        math.random(-16000, 16000)
    )

    hrp.Velocity = RandomVec
    hrp.AssemblyLinearVelocity = RandomVec
    hrp.AssemblyAngularVelocity = RandomVec

    RunService.RenderStepped:Wait()

    hrp.Velocity = OldVec
    hrp.AssemblyLinearVelocity = Lin
    hrp.AssemblyAngularVelocity = Ang
end

local function SetPhysics()
    local hrp = CharModule.get_hrp()
    if hrp then
        hrp.CustomPhysicalProperties = PhysicalProperties.new(0.001, 0.001, 0.001)
    end
end


RunService.Heartbeat:Connect(function()
    if _G.AntiLock then
        VelocityDesync()
        SetPhysics()
    end
end)


MainTab:Toggle({
    Title = "Anti Aim",
    Flag = "antilock",
    Value = false,
    Callback = function(Value)
        _G.AntiLock = Value

        if Value then
            playDanceAntiAim()
        else
            stopDanceAntiAim()
        end
    end
})

-- อันติแรคดอล
local function AntiRagdollLoop()
    while _G.AntiRagdoll do
        task.wait(0.1)

        pcall(function()
            local isRagdolled = RagdollModule.is_ragdolling.get()
            if isRagdolled then
                RagdollModule.is_ragdolling.set(false)
                
                
                pcall(function() Net.send("end_ragdoll_early") end)
                pcall(function() Net.send("clear_ragdoll") end)
                pcall(function() Net.get("end_ragdoll_early") end)
                pcall(function() Net.get("clear_ragdoll") end)
            end
        end)
    end
end


MainTab:Toggle({
    Title = "Anti Ragdoll",
    Desc = "No ragdoll",
    Flag = "AntiRagdoll",
    Value = false,
    Callback = function(Value)
        _G.AntiRagdoll = Value

        if Value then
            task.spawn(AntiRagdollLoop)
        end
    end
})
