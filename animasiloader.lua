local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 24}):Play()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NdraawzLoader"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundTransparency = 1

local bg = Instance.new("Frame", frame)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
bg.BackgroundTransparency = 1
TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 0.3}):Play()

local barBg = Instance.new("Frame", frame)
barBg.AnchorPoint = Vector2.new(0.5, 0.5)
barBg.Position = UDim2.new(0.5, 0, 0.65, 0)
barBg.Size = UDim2.new(0.4, 0, 0.025, 0)
barBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
barBg.BackgroundTransparency = 0
barBg.BorderSizePixel = 0
local barCorner = Instance.new("UICorner", barBg)
barCorner.CornerRadius = UDim.new(0, 20)

local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
barFill.BackgroundTransparency = 0
barFill.BorderSizePixel = 0
local fillCorner = Instance.new("UICorner", barFill)
fillCorner.CornerRadius = UDim.new(0, 20)

local fillGradient = Instance.new("UIGradient", barFill)
fillGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 170, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 100, 160))
})
fillGradient.Rotation = 0

task.spawn(function()
	while barFill.Parent do
		for i = 0, 360, 2 do
			fillGradient.Rotation = i
			task.wait(0.01)
		end
	end
end)

local percentLabel = Instance.new("TextLabel", frame)
percentLabel.AnchorPoint = Vector2.new(0.5, 1)
percentLabel.Position = UDim2.new(0.5, 0, 0.63, 0)
percentLabel.Size = UDim2.new(0, 100, 0, 30)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextColor3 = Color3.new(1, 1, 1)
percentLabel.TextTransparency = 0
percentLabel.TextSize = 18

local word = "Ndraaw!"
local letters = {}

for i = 1, #word do
	local char = word:sub(i, i)
	local label = Instance.new("TextLabel")
	label.Text = char
	label.Font = Enum.Font.GothamBlack
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextTransparency = 1
	label.TextSize = 30
	label.Size = UDim2.new(0, 60, 0, 60)
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.Position = UDim2.new(0.5, (i - (#word / 2 + 0.5)) * 65, 0.5, 0)
	label.BackgroundTransparency = 1
	label.Parent = frame

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 170, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 100, 160))
	})
	gradient.Rotation = 90
	gradient.Parent = label

	TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 0, TextSize = 60}):Play()
	table.insert(letters, label)
	wait(0.25)
end

local function updatePercentage(current)
	local percent = math.floor(current * 100)
	percentLabel.Text = percent .. "%"
end

local steps = {
	{time = 0.5, goal = 0.25},
	{time = 1.0, goal = 1.00}
}

for _, step in ipairs(steps) do
	local tween = TweenService:Create(barFill, TweenInfo.new(step.time, Enum.EasingStyle.Linear), {
		Size = UDim2.new(step.goal, 0, 1, 0)
	})
	tween:Play()

	local start = barFill.Size.X.Scale
	local duration = step.time
	local t = 0
	while t < duration do
		task.wait(0.05)
		t += 0.05
		local progress = math.clamp(start + ((step.goal - start) * (t / duration)), 0, 1)
		updatePercentage(progress)
	end
end

updatePercentage(1)
wait(0.5)

for _, label in ipairs(letters) do
	TweenService:Create(label, TweenInfo.new(0.5), {TextTransparency = 1, TextSize = 20}):Play()
end

TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(barBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(barFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(percentLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0}):Play()

wait(0.6)
screenGui:Destroy()
blur:Destroy()

StarterGui:SetCore("SendNotification", {
                Title = "Ndraaw! Hub",
                Text = "Welcome to Ndraaw! Hub ",
                Duration = 4
            })
