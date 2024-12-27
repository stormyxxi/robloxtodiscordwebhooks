local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local url = ""

local playerData = {}

local function roundPosition(position)
    return Vector3.new(math.floor(position.X + 0.5), math.floor(position.Y + 0.5), math.floor(position.Z + 0.5))
end

game.Players.PlayerAdded:Connect(function (player)
    player.Chatted:Connect(function(msg)
        local args = string.split(msg, " ")
        if args[1] == "!getlocation" then
            local targetUsername = args[2]
            local targetPlayer = Players:FindFirstChild(targetUsername)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local roundedPosition = roundPosition(targetPlayer.Character.HumanoidRootPart.Position)
                
                local data = {
                    ["content"] = "";
                    ["embeds"] = {{
                        ["author"] = {
                            ["name"] = "Profile link";
                            ["url"] = "https://www.roproxy.com/users/".. targetPlayer.UserId .. "/profile";
                        };
                        ["description"] = player.Name .. " has ran **!getlocation**",
                        ["color"] = tonumber(0x00ff00);
						["fields"] = {
							{
								["name"] = "Target Name";
								["value"] = targetPlayer.Name;
								["inline"] = true;
							};
                            {
                                ["name"] = "User ID";
                                ["value"] = targetPlayer.UserId;
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
        end
    end)
end)
