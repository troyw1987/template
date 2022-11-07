local user,repositoryName = "troyw1987","template" -- replace lines 1-3 if needed.
local scriptFolder = "/scripts"

local defaultURL = "https://raw.githubusercontent.com/"..user.."/"..repositoryName.."/main"..scriptFolder

function synapseWebRequest(url)
    print(url)
    local response = syn.request({
        Url = url,
        Method = "GET"
    })

    if not response.Success then
       print("response unsuccessful detected")
       return
    end
    return response
end

local defaultScript = synapseWebRequest(defaultURL.."/default.lua")

local gameID = "/"..tostring(game.PlaceId)
local gameScript = synapseWebRequest(defaultURL..gameID..".lua")

if defaultScript and defaultScript.Success then
    print("loaded default script successfully")
    loadstring(defaultScript.Body)()
end

if gameScript and gameScript.Success then
    print("loaded game script successfully")
    loadstring(gameScript.Body)()
end
