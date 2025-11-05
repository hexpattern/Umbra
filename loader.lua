repeat task.wait(0.10) until game:IsLoaded();
_G.Config = { ["Theme"] = "Dark" };
local NotifyLib = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hexpattern/Umbra/refs/heads/main/Main/Module/Notification.lua", true))();
local MarketplaceService = game:GetService("MarketplaceService");
local Players = game:GetService("Players");

local success, experienceInfo = pcall(function() 
    return MarketplaceService:GetProductInfo(game.PlaceId);
end);

local experienceName = success and experienceInfo.Name or "Unknown Experience";
local executorName = identifyexecutor and identifyexecutor() or "Unknown Executor";

NotifyLib:Notify("Loading!", "Executor: "..executorName.. "\nExperience: "..experienceName, "normal", 5);

local function HttpGet(url)
    local response = request({Url = url});
    return response and response.Body or nil;
end;

local function SafeRequest(url)
    local scriptContent = HttpGet(url);
    if not scriptContent then
        return false;
    end;
    
    local fn, err = loadstring(scriptContent);
    if not fn then
        return false;
    end;

    local ok, execErr = pcall(fn);
    if not ok then
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
	SafeRequest(ScriptURL);
else
	NotifyLib:Notify("Loadstring Error", "Experience not supported check discord or github for full list!", "error", 10);
end;
