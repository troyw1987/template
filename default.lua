print("this will load on any game")

local undetectable = Instance.new("Folder",game:GetService("CoreGui")) -- hidden root folder -->> format: {{playerhighlight},{playerhighlight},etc.}
local players = game:GetService("Players")

function getChamColor(player)
    if player.Team then
        return player.Team.TeamColor.Color
    end
    return Color3.new(1,1,1)
end

function refreshPlayerFolder(player)
    local found = undetectable:FindFirstChild(player.Name)

    if found then
        found:Destroy()
    end

    local playerFolder = Instance.new("Folder",undetectable)
    playerFolder.Name = player.Name
    return playerFolder
end

function chamChar(player) -- my cham function
    local newPlayerFolder = refreshPlayerFolder(player)
    
    local character = player.Character
    
    character:WaitForChild("Humanoid")
    local cham = Instance.new("Highlight",newPlayerFolder)
    
    cham.Name = player.Name
    cham.Adornee = player.Character
    cham.FillColor = getChamColor(player)
    cham.FillTransparency = 0.5
    cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    cham.Enabled = true
end


function init(player)
    if player.Character then
        chamChar(player)
    end

    player.CharacterAdded:Connect(function(character)
        chamChar(player)
    end)
end

--

for _,v in pairs(players:GetPlayers()) do
    if v == players.LocalPlayer then continue end
    init(v)
end

print("chams loaded ->"..#undetectable:GetChildren().."/"..#players:GetPlayers())

players.PlayerAdded:Connect(function(player)
    print(player.Name.." joined")
    init(player)
end)

players.PlayerRemoving:Connect(function(player)
    print(player.Name.." left")
    local folder = undetectable:FindFirstChild(player.Name)

    if not folder then
        print(player.Name.." has slipped through my fingers >:(")
    else
        folder:Destroy()
    end
end)
