local url = ""
local players = game:GetService("Players")
local httpservice = game:GetService("HttpService")

local function postMessage(player, index)
	local teamValue
	pcall(function()
		if not player.Team then
			teamValue = "-"
		else
			teamValue = player.Team.Name
		end
	end)
	local data = {
		["content"] = "";
		["embeds"] = {{
			["author"] = {
				["name"] = "Profile link";
				["url"] = "https://www.roproxy.com/users/".. player.UserId .. "/profile";
				--["icon_url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=150&height=150&format=png"
			};
			["description"] = player.Name .. " said: **"..index.."**",
			["color"] = tonumber(0xffffff);
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
	local finalizedData = httpservice:JSONEncode(data)
	httpservice:PostAsync(url, finalizedData)
end

local function PlayerAdded(player)
	player.Chatted:Connect(function(message)
		postMessage(player, message)
	end)
end

for _, player in ipairs(players:GetPlayers()) do
	PlayerAdded(player)
end

players.PlayerAdded:Connect(PlayerAdded)

