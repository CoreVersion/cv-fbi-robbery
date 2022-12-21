local Core = exports[Config.CoreName]:GetCoreObject()

Core.Functions.CreateCallback('cv-fbi-robbery:CheckForStart', function(source, cb)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    local card = Player.Functions.GetItemByName(Config.FBICardItem)
    local electronic = Player.Functions.GetItemByName(Config.ElectronicKitItem)
    if electronic ~= nil and card ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

RegisterNetEvent('cv-fbi-robbery:server:policeAlert')
AddEventHandler('cv-fbi-robbery:server:policeAlert', function(coords)
    local players = Core.Functions.GetPlayers()
    local _source = source

    for i = 1, #players do
        local player = Core.Functions.GetPlayer(players[i])
        local steamname = GetPlayerName(_source)
        if player.PlayerData.job.name == Config.PoliceJob then
            TriggerClientEvent('cv-fbi-robbery:client:policeAlert', players[i], coords)
        end
    end
end)

RegisterServerEvent('cv-fbi-robbery:server:ThermitePtfx', function(coords)
    TriggerClientEvent('cv-fbi-robbery:client:ThermitePtfx', -1, coords)
end)

RegisterNetEvent("cv-fbi-robbery:SellFbiGoods", function()
	local src = source;
	local Player = Core.Functions.GetPlayer(src);
	local price = 0;
	
	for r, v in next, Player.PlayerData.items do
		for i=1, #Config.GoodsPrice  do
			local data = Config.GoodsPrice [i];
			if data.item == v.name then
				price = price + (data.price * v.amount);
				Player.Functions.RemoveItem(v.name, v.amount, r);
				TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[v.name], 'remove')
				break
			end
		end
	end
	
	Player.Functions.AddMoney("cash", price);
    Core.Functions.Notify("You Sold Some Goods And Received $ " .. price .. " .")
end)

RegisterServerEvent("cv-fbi-robbery:GetItems")
AddEventHandler("cv-fbi-robbery:GetItems", function()
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    for i = 1, math.random(1, 2), 1 do
        local randItem = Config.RandomItems[math.random(1, #Config.RandomItems)]
        Player.Functions.AddItem(randItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[randItem], 'add')
        Citizen.Wait(500)
    end
end)	

function DiscordLog(message)
    local embed = {
        {
            ["color"] = 04255, 
            ["title"] = "CoreVersion • Development FBI Robbery",
            ["description"] = message,
            ["url"] = "https://discord.gg/nKzaJhMkVa",
            ["footer"] = {
            ["text"] = "By CoreVersion • Development",
            ["icon_url"] = Config.LogsImage
        },
            ["thumbnail"] = {
                ["url"] = Config.LogsImage,
            },
    }
}
    PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({username = 'cv-fbi-robbery', embeds = embed, avatar_url = Config.LogsImage}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent("cv-fbi-robbery:SendDiscordLog", function()
    local src = source
    local steamname = GetPlayerName(src)
    DiscordLog('FBI Robbery Started By: **'..steamname..'** ID: **' ..src..'**')
end)

RegisterNetEvent('cv-fbi-robbery:server:setRobState', function(stateType, state, r)
    Config.RobLocations[r][stateType] = state
    TriggerClientEvent('cv-fbi-robbery:client:setRobState', -1, stateType, state, r)
end)

