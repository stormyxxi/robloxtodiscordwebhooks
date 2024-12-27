local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local url = ""

local playerData = {}

Players.PlayerAdded:Connect(function(player)
	playerData[player.UserId] = {startTime = os.time()}
end)

Players.PlayerRemoving:Connect(function(player)
	local endTime = os.time()
	local startTime = playerData[player.UserId].startTime
	local totalTime = endTime - startTime

	local hours = math.floor(totalTime / 3600)
	local minutes = math.floor((totalTime % 3600) / 60)
	local seconds = totalTime % 60

	local timeString = string.format("%02d:%02d:%02d", hours, minutes, seconds)

	local data = {
		["content"] = "";
		["embeds"] = {{
			["author"] = {
				["name"] = "Profile link";
				["url"] = "https://www.roproxy.com/users/".. player.UserId .. "/profile";
				--["icon_url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=150&height=150&format=png"
			};
			["description"] = player.Name .. " left the game";
			["color"] = tonumber(0xff0000);
			["fields"] = {
				{
					["name"] = "User ID";
					["value"] = player.UserId;
					["inline"] = true;
				};
				{
					["name"] = "Time Played";
					["value"] = timeString;
					["inline"] = true;
				};
				{
					["name"] = "Time";
					["value"] = DateTime.now():FormatUniversalTime("LLL", "en-us");
					["inline"] = true;
				};
			};
			["footer"] = {
				["icon_url"] = "";
				["text"] = "@stormyxxi on discord"
			}
		}}
	}

	local finalizedData2 = HttpService:JSONEncode(data)

	HttpService:PostAsync(url, finalizedData2)
end)
