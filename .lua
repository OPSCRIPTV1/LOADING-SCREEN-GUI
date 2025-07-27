-- SERVICES
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- CREATE SCREEN GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FullLoadingScreen"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- BACKGROUND FRAME
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
background.BorderSizePixel = 0
background.Parent = screenGui

-- LABEL TEXT
local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 0, 0.2, 0)
loadingText.Position = UDim2.new(0, 0, 0.3, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "WAIT FOR THE SCRIPT TO BE LOADED"
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.Font = Enum.Font.Arcade
loadingText.TextScaled = true
loadingText.Parent = background

-- LOADING BAR CONTAINER
local barContainer = Instance.new("Frame")
barContainer.Size = UDim2.new(0.5, 0, 0.05, 0)
barContainer.Position = UDim2.new(0.25, 0, 0.5, 0)
barContainer.BackgroundTransparency = 1
barContainer.Parent = background

-- CREATE 10 LOADING BLOCKS
local blocks = {}
local blockCount = 10
local spacing = 5
local blockWidth = (barContainer.AbsoluteSize.X - (spacing * (blockCount - 1))) / blockCount

for i = 1, blockCount do
	local block = Instance.new("Frame")
	block.Size = UDim2.new(1 / blockCount - 0.01, 0, 1, 0)
	block.Position = UDim2.new((i - 1) / blockCount + 0.005 * (i - 1), 0, 0, 0)
	block.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	block.BackgroundTransparency = 0.5
	block.BorderSizePixel = 0
	block.Name = "Block"..i

	-- Rounded corner
	local corner = Instance.new("UICorner", block)
	corner.CornerRadius = UDim.new(0, 8)

	block.Parent = barContainer
	table.insert(blocks, block)
end

-- Update based on screen resize (to ensure block widths are correct)
barContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	local blockWidth = (barContainer.AbsoluteSize.X - (spacing * (blockCount - 1))) / blockCount
	for i, block in ipairs(blocks) do
		block.Position = UDim2.new((i - 1) / blockCount + 0.005 * (i - 1), 0, 0, 0)
	end
end)

-- ANIMATE LOADING BLOCKS OVER 90 SECONDS
local totalTime = 90
local interval = totalTime / blockCount

task.spawn(function()
	for i = 1, blockCount do
		task.wait(interval)
		blocks[i].BackgroundTransparency = 0
		blocks[i].BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	end
end)
