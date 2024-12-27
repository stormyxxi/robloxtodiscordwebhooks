local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local url = ""

local playerData = {}

local function roundPosition(position)
	return Vector3.new(math.floor(position.X + 0.5), math.floor(position.Y + 0.5), math.floor(position.Z + 0.5))
end


game.Players.PlayerAdded:Connect(function (player)
	player.Chatted:Connect(function(msg)
		if msg == "!ball" then
			local clone = game.ReplicatedStorage.Ball:Clone()
			local roundedPosition = roundPosition(clone.Position)
			clone.Parent = workspace
			clone.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new (5, 0, 0)
			
			local data = {
				["content"] = "";
				["embeds"] = {{
					["author"] = {
						["name"] = "Profile link";
						["url"] = "https://www.roproxy.com/users/".. player.UserId .. "/profile";
						--["icon_url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=150&height=150&format=png"
					};
					["description"] = player.Name .. " has spawned a **ball!**",
					["color"] = tonumber(0x00ff00);
					["fields"] = {
						{
							["name"] = "User ID";
							["value"] = player.UserId;
							["inline"] = true;
						};
						{
							["name"] = "Location";
							["value"] = tostring(roundedPosition);
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
		end
	end)
end)