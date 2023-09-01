local Toggled = true
local KeyCode = Enum.KeyCode.Z
local hipHeight = 2.8
local antiLockOffset = -35

local function Notify(message)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Anti-Lock",
        Text = message,
        Duration = 3,
    })
end

function AntiLock()
    local character = game.Players.LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Humanoid") then
        return
    end

    local humanoidRootPart = character.HumanoidRootPart
    local humanoid = character.Humanoid

    local originalHipHeight = humanoid.HipHeight
    local originalVelocity = humanoidRootPart.Velocity

    humanoid.HipHeight = hipHeight

    while Toggled do
        humanoidRootPart.Velocity = Vector3.new(originalVelocity.X, antiLockOffset, originalVelocity.Z)
        wait()
    end

    humanoid.HipHeight = originalHipHeight
    humanoidRootPart.Velocity = originalVelocity
end

game:GetService('UserInputService').InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == KeyCode then
        Toggled = not Toggled

        if Toggled then
            AntiLock()
            Notify("Anti-Lock Activado")
        else
            Notify("Anti-Lock Desactivado")
        end
    end
end)
