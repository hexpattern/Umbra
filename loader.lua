repeat task.wait(0.10) until game:IsLoaded();

local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/hexpattern/Umbra/refs/heads/main/Main/Module/Notification.lua"))();
local MarketplaceService = game:GetService("MarketplaceService");
local Players = game:GetService("Players");

local success, experienceInfo = pcall(function() 
    return MarketplaceService:GetProductInfo(game.PlaceId);
end);

local experienceName = success and experienceInfo.Name or "Unknown Experience";
local executorName = identifyexecutor and identifyexecutor() or "Unknown Executor";

NotifyLib:Notify("Loading", "Executor: "..executorName.. "\nExperience: "..experienceName, "normal", 5);

local function safeRequest(url)
    local response = request and request({Url = url}) or {Body = game:HttpGet(url)};
    local scriptContent = response.Body;

    if not scriptContent or scriptContent = "" then
        NotifyLib:Notify("URL Error", "Failed to fetch script from URL.", "error", 10);
        return false;
    end;
    
    local fn, loadErr = loadstring(scriptContent);
    if not fn then
        NotifyLib:Notify("Loadstring Error", tostring(loadErr), "error", 10);
        return false;
    end;

    local ok, execErr = pcall(fn);
    if not ok then
        NotifyLib:Notify("Runtime Error", tostring(execErr), "error", 10);
        return false;
    end;

    return true;
end;

local Scripts = {
    [6555402658] = "https://raw.githubusercontent.com/hexpattern/Umbra/refs/heads/main/Games/Wanderlands.lua",
};

local GameID = game.GameId;
local ScriptURL = Scripts[GameID];

if ScriptURL then
	safeRequest(ScriptURL); safeRequest("c2c")
else
	NotifyLib:Notify("Failed to Load", "Experience not supported.", "warn", 10);
end;
