- Script LocalScript (coloque em StarterPlayer > StarterPlayerScripts)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Verifica se já existe (evita duplicar)
if playerGui:FindFirstChild("NovaVersaoGUI") then
    playerGui.NovaVersaoGUI:Destroy()
end

-- ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NovaVersaoGUI"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Fundo totalmente preto cobrindo a tela
local fundo = Instance.new("Frame")
fundo.Name = "Fundo"
fundo.Size = UDim2.new(1, 0, 1, 0)
fundo.Position = UDim2.new(0, 0, 0, 0)
fundo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
fundo.BackgroundTransparency = 0
fundo.BorderSizePixel = 0
fundo.ZIndex = 1
fundo.Parent = screenGui

-- Container central
local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.new(0, 600, 0, 250)
container.Position = UDim2.new(0.5, 0, 0.5, 0)
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.BackgroundTransparency = 1
container.ZIndex = 2
container.Parent = fundo

-- Texto "NOVA VERSÃO DISPONÍVEL EM DISCORD"
local texto = Instance.new("TextLabel")
texto.Name = "Titulo"
texto.Size = UDim2.new(1, 0, 0, 100)
texto.Position = UDim2.new(0, 0, 0, 0)
texto.BackgroundTransparency = 1
texto.Text = "NOVA VERSÃO DISPONÍVEL EM DISCORD"
texto.TextColor3 = Color3.fromRGB(255, 255, 255)
texto.TextScaled = false
texto.TextSize = 36
texto.Font = Enum.Font.GothamBlack -- fonte forte/negrito
texto.TextWrapped = true
texto.TextStrokeTransparency = 0
texto.TextStrokeColor3 = Color3.fromRGB(80, 0, 255)
texto.ZIndex = 2
texto.Parent = container

-- Botão Discord
local botao = Instance.new("TextButton")
botao.Name = "BotaoDiscord"
botao.Size = UDim2.new(0, 250, 0, 70)
botao.Position = UDim2.new(0.5, 0, 1, -20)
botao.AnchorPoint = Vector2.new(0.5, 1)
botao.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- cor do Discord
botao.BorderSizePixel = 0
botao.Text = "Discord"
botao.TextColor3 = Color3.fromRGB(255, 255, 255)
botao.TextSize = 32
botao.Font = Enum.Font.GothamBold
botao.AutoButtonColor = true
botao.ZIndex = 2
botao.Parent = container

-- Cantos arredondados no botão
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = botao

-- Sombra do botão
local shadow = Instance.new("UIStroke")
shadow.Color = Color3.fromRGB(40, 50, 130)
shadow.Thickness = 3
shadow.Parent = botao

-- Efeito hover no botão
botao.MouseEnter:Connect(function()
    botao.BackgroundColor3 = Color3.fromRGB(110, 125, 255)
end)

botao.MouseLeave:Connect(function()
    botao.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
end)

-- Função para copiar o link
local function copiarLink()
    local link = "https://discord.gg/HGnARQJZhx"
    
    -- Tenta usar setclipboard (funciona em alguns exploits/executores)
    if setclipboard then
        pcall(function()
            setclipboard(link)
        end)
    elseif toclipboard then
        pcall(function()
            toclipboard(link)
        end)
    end
    
    -- Feedback visual
    local textoOriginal = botao.Text
    botao.Text = "Copiado! ✓"
    botao.BackgroundColor3 = Color3.fromRGB(87, 242, 135) -- verde
    
    task.wait(1.5)
    
    botao.Text = textoOriginal
    botao.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    
    -- Abre o Discord automaticamente (opcional)
    pcall(function()
        game:GetService("GuiService"):OpenBrowserWindow(link)
    end)
end

botao.MouseButton1Click:Connect(copiarLink)

-- Animação suave de entrada
container.Position = UDim2.new(0.5, 0, 0.5, 50)
container.BackgroundTransparency = 1
texto.TextTransparency = 1
botao.BackgroundTransparency = 1
botao.TextTransparency = 1

task.spawn(function()
    task.wait(0.1)
    
    for i = 0, 1, 0.05 do
        container.Position = UDim2.new(0.5, 0, 0.5, 50 - (50 * i))
        texto.TextTransparency = 1 - i
        botao.BackgroundTransparency = 1 - i
        botao.TextTransparency = 1 - i
        task.wait(0.02)
    end
end)
