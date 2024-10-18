local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 150) 
frame.Position = UDim2.new(0.5, -125, 0.5, -75)  
frame.BackgroundColor3 = Color3.new(0, 0, 0)  -- 
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Parent = screenGui

local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.5, 0.5, 0.5)),  
    ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))  
}
uiGradient.Parent = frame

local uiStroke = Instance.new("UIStroke")
uiStroke.Parent = frame
uiStroke.Color = Color3.new(1, 1, 1)  
uiStroke.Thickness = 3

local rotation = 0
game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
    rotation = (rotation + deltaTime * 100) % 360
    uiStroke.Rotation = rotation
end)

-- Criar o título para o menu
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Menu"
titleLabel.TextScaled = true
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = frame

-- Criar o Frame cinza atrás da opção de Aimbot
local optionsFrame = Instance.new("Frame")
optionsFrame.Size = UDim2.new(1, -20, 0, 50)
optionsFrame.Position = UDim2.new(0, 10, 0, 40)
optionsFrame.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)  -- Cinza escuro
optionsFrame.Parent = frame

-- Criar cantos arredondados com UICorner
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)  -- Cantos arredondados
uiCorner.Parent = optionsFrame

-- Criar o Toggle do Aimbot (Checkbox)
local aimbotLabel = Instance.new("TextLabel")
aimbotLabel.Size = UDim2.new(0, 150, 0, 30)
aimbotLabel.Position = UDim2.new(0, 10, 0.5, -15)  -- Centralizado verticalmente
aimbotLabel.BackgroundTransparency = 1
aimbotLabel.Text = "Aimbot"
aimbotLabel.TextScaled = true
aimbotLabel.TextColor3 = Color3.new(1, 1, 1)
aimbotLabel.Font = Enum.Font.Gotham
aimbotLabel.TextXAlignment = Enum.TextXAlignment.Left
aimbotLabel.Parent = optionsFrame

local aimToggle = Instance.new("TextButton")
aimToggle.Size = UDim2.new(0, 30, 0, 30)
aimToggle.Position = UDim2.new(1, -40, 0.5, -15)  -- Alinhado à direita
aimToggle.BackgroundColor3 = Color3.new(1, 1, 1)
aimToggle.Text = ""
aimToggle.Parent = optionsFrame

local aimbotEnabled = false

-- Função para ativar o aim assistente
aimToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    aimToggle.BackgroundColor3 = aimbotEnabled and Color3.new(0, 1, 0) or Color3.new(1, 1, 1)
    
    if aimbotEnabled then
        print("Aimbot ativado")
        -- Lógica para o Aim Assist
        game:GetService("RunService").Stepped:Connect(function()
            if aimbotEnabled and mouse.Target and mouse.Target.Parent:FindFirstChild("Humanoid") then
                local head = mouse.Target.Parent:FindFirstChild("Head")
                if head then
                    mouse.TargetFilter = head
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, head.Position)
                end
            end
        end)
    else
        print("Aimbot desativado")
        mouse.TargetFilter = nil
    end
end)

local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0.9, -25)
toggleButton.BackgroundColor3 = Color3.new(0, 0, 0)
toggleButton.Image = "rbxassetid://YOUR_IMAGE_ID"
toggleButton.Parent = screenGui

local menuOpen = true

toggleButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    frame.Visible = menuOpen
end)
