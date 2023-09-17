print('Codigo iniciado')
local player = game.Players.LocalPlayer
local settings = {
    Target = true,
    Key = Enum.KeyCode.E,
    Prediction = 0.178,
    ChatMode = false,
    NotifMode = true,
    PartMode = true,
    AirshotFunccc = false,
    Partz = "Head",
    AutoPrediction = true,
    Fov = 100,
    Circle = true,
    valiansh = false,
    autosavefriends = true,
    saveCP = Vector3.new(0,0,0),
}


--Commands

game.Players.LocalPlayer.Chatted:Connect(function(message)
    local args = {}
    for arg in string.gmatch(message, "%S+") do
        table.insert(args, arg)
    end

    if #args >= 2 and args[1] == "/lockkey" then
        local newKey = Enum.KeyCode[args[2]]
        if newKey then
            settings.Key = newKey
            game.StarterGui:SetCore("SendNotification", {
                Title = "[📄] Commands",
                Text = "New key to lock: ".. newKey.Name,
            })
        else
            print("Comando /lockkey requiere un nombre de tecla válido como parámetro.")
        end
    elseif #args >= 1 and args[1] == "/activefriendsystem" then
        settings.autosavefriends = not settings.autosavefriends
        local status = settings.autosavefriends and "activated" or "deactivated"
        game.StarterGui:SetCore("SendNotification", {
            Title = "[📄] Commands",
            Text = "Friend system " .. status,
        })
    elseif #args >= 1 and args[1] == "/saveCP" then
        local playerPosition = player.Character and player.Character.HumanoidRootPart.Position
        if playerPosition then
            settings.saveCP = playerPosition
            game.StarterGui:SetCore("SendNotification", {
                Title = "[📄] Commands",
                Text = "Checkpoint saved at current position.",
            })
        else
            print("Unable to save checkpoint: Player position not found.")
        end
    end
end)

-- Save friend System


-- Show initial notification
game.StarterGui:SetCore("SendNotification", {
    Title = "⭐ The best dh lock by ExoticCrew ⭐",
    Text = "Script only for exotics uwu | v1.4",
})


--ANTI LOCK
local function AntiLockCallback(answer)
    if answer == "Sí" then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Anti-Lock",
            Text = "Activando Anti-Lock...",
            Duration = 3,
        })
        wait(3)
        LoadAntiLockScript()
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Anti-Lock",
            Text = "Anti-Lock no activado",
            Duration = 3,
        })
    end
end

local AntiLockBindable = Instance.new("BindableFunction")
AntiLockBindable.OnInvoke = AntiLockCallback

local function LoadAntiLockScript()
    local Toggled = true

    local KeyCode = 'z'
    local hip = 2.80
    local val = -35





    function AA()
      local oldVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
      game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, val, oldVelocity.Z)
      game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, oldVelocity.Y, oldVelocity.Z)
      game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, val, oldVelocity.Z)
      game.Players.LocalPlayer.Character.Humanoid.HipHeight = hip
    end

    game:GetService('UserInputService').InputBegan:Connect(function(Key)
      if Key.KeyCode == Enum.KeyCode[KeyCode:upper()] and not game:GetService('UserInputService'):GetFocusedTextBox() then
          if Toggled then
              Toggled = false
              game.Players.LocalPlayer.Character.Humanoid.HipHeight = hip

          elseif not Toggled then
              Toggled = true

              while Toggled do
                  AA()
                  task.wait()
              end
          end
      end
    end)

end

local function AntiLockCallback(answer)
    if answer == "Sí" then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Anti-Lock",
            Text = "Activando Anti-Lock...",
            Duration = 3,
        })
        wait(3)
        LoadAntiLockScript()
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Anti-Lock",
            Text = "Anti-Lock no activado",
            Duration = 3,
        })
    end
end

local AntiLockBindable = Instance.new("BindableFunction")
AntiLockBindable.OnInvoke = AntiLockCallback

-- Mostrar notificación de activación de Anti-Lock
game.StarterGui:SetCore("SendNotification", {
    Title = "Anti-Lock",
    Text = "¿Quieres activar el Anti-Lock?",
    Duration = 10,
    Button1 = "Sí",
    Button2 = "No",
    Callback = AntiLockBindable
})
-- Variables
local mouse = player:GetMouse()
local Tracer = Instance.new("Part", game.Workspace)
local circle = Drawing.new("Circle")

Tracer.Name = "LockTracer"
Tracer.Anchored = true
Tracer.CanCollide = false
Tracer.Transparency = 0.5
Tracer.Parent = game.Workspace
Tracer.Size = Vector3.new(2.5, 2.5, 2.5)  -- Smaller size
Tracer.Color = Color3.fromRGB(0, 255, 0)  -- Green color
Tracer.Shape = Enum.PartType.Ball

circle.Color = Color3.fromRGB(25, 25, 25)
circle.Thickness = 0
circle.NumSides = 732
circle.Radius = settings.Fov
circle.Transparency = 0
circle.Visible = settings.Circle
circle.Filled = false

local function getClosestPlayerToCursor()
    local closestPlayer
    local shortestDistance = circle.Radius
    local localMouse = player:GetMouse()

    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("LowerTorso") then
            local pos = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(localMouse.X, localMouse.Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end

    return closestPlayer
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == settings.Key then
        local Locking = false
        local Plr

        if settings.Target then
            Locking = not Locking

            if Locking then
                Plr = getClosestPlayerToCursor()
                if Plr then
                    if settings.ChatMode then
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Target: " .. Plr.Name, "All")
                    end

                    if settings.NotifMode then
                        game.StarterGui:SetCore("SendNotification", {
                            Title = "️[✔️] User locked",
                            Text = "Target: " .. Plr.Name,
                        })
                    end
                end
            else
                if settings.ChatMode then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Unlocked!", "All")
                end

                if settings.NotifMode then
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "[❌] User unlocked",
                        Text = "Unlocked!",
                    })
                end
            end
        end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    circle.Position = Vector2.new(mouse.X, mouse.Y + 35)
    if settings.AirshotFunccc and Plr then
        if Plr.Character.Humanoid.Jump and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
            settings.Partz = "RightFoot"
        else
            Plr.Character:WaitForChild("Humanoid").StateChanged:Connect(function(_, new)
                if new == Enum.HumanoidStateType.Freefall then
                    settings.Partz = "RightFoot"
                else
                    settings.Partz = "HumanoidRootPart"
                end
            end)
        end
    end
end)

if settings.valiansh then
    game.StarterGui:SetCore("SendNotification", {
        Title = "[⭐] Exotic Lock",
        Text = "Already loaded...",
        Duration = 5,
    })
    return
end

settings.valiansh = true

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(keygo, ok)
    if not ok and keygo.KeyCode == settings.Key then
        if settings.Target then
            Locking = not Locking

            if Locking then
                Plr = getClosestPlayerToCursor()
                if Plr then
                    if settings.ChatMode then
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Target: " .. Plr.Name, "All")
                    end

                    if settings.NotifMode then
                        game.StarterGui:SetCore("SendNotification", {
                            Title = "️[✔️] User locked",
                            Text = "Target: " .. Plr.Name,
                        })
                    end
                end
            else
                if settings.ChatMode then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Unlocked!", "All")
                end

                if settings.NotifMode then
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "[⭐] Exotic Lock",
                        Text = "Unlocked!",
                    })
                end
            end
        end
    end
end)

local function updateTracer()
    if settings.PartMode then
        if Locking and Plr and Plr.Character and Plr.Character:FindFirstChild("LowerTorso") then
            Tracer.CFrame = CFrame.new(Plr.Character.LowerTorso.Position + (Plr.Character.LowerTorso.Velocity * settings.Prediction))
        else
            Tracer.CFrame = CFrame.new(0, 9999, 0)
        end
    end
end

game:GetService("RunService").Stepped:Connect(updateTracer)

local rawmetatable = getrawmetatable(game)
local old = rawmetatable.__namecall
setreadonly(rawmetatable, false)
rawmetatable.__namecall = newcclosure(function(...)
    local args = {...}
    if Locking and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
        args[3] = Plr.Character[settings.Partz].Position + (Plr.Character[settings.Partz].Velocity * settings.Prediction)
        return old(unpack(args))
    end
    return old(...)
end)

while wait() do
    if settings.AutoPrediction then
        local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        local ping = tonumber(pingvalue:match("(%d+)"))

        if ping < 130 then
            settings.Prediction = 0.151
        elseif ping < 125 then
            settings.Prediction = 0.149
        elseif ping < 110 then
            settings.Prediction = 0.140
        elseif ping < 105 then
            settings.Prediction = 0.133
        elseif ping < 90 then
            settings.Prediction = 0.130
        elseif ping < 80 then
            settings.Prediction = 0.128
        elseif ping < 70 then
            settings.Prediction = 0.1230
        elseif ping < 60 then
            settings.Prediction = 0.1229
        elseif ping < 50 then
            settings.Prediction = 0.1225
        elseif ping < 40 then
            settings.Prediction = 0.1256
        end
    end
end
