local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local url = ""

local playerData = {}

Players.PlayerAdded:Connect(function(player)
	local data = {
		["content"] = "";
		["embeds"] = {{
			["author"] = {
				["name"] = "Profile link";
				["url"] = "https://www.roproxy.com/users/".. player.UserId .. "/profile";
				--["icon_url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=150&height=150&format=png"
			};
			["description"] = player.Name .. " joined the game",
			["color"] = tonumber(0x00ff00);
			["fields"] = {
				{
					["name"] = "User ID";
					["value"] = player.UserId;
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
