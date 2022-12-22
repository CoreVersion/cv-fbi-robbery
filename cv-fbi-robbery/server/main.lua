local Core = exports[Config.CoreName]:GetCoreObject()

local lootTable = { -- You can always add more, make sure to also add this to the confiscateContraband table
    [1] = {item = 'rolex', amount = 1},
    [2] = {item = 'pistol_ammo', amount = 1},
    [3] = {item = 'goldchain', amount = 1},
    [4] = {item = 'diamond_ring', amount = 1},
}

local lootTable2 = { -- You can always add more, make sure to also add this to the confiscateContraband table
    [1] = {item = 'encrypted_document', amount = 1},
    [2] = {item = 'wearhousecard', amount = 1},
}

Core.Functions.CreateCallback('qb-wearhouse:Checkitem2', function(source, cb)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    local wearhouseitem = Player.Functions.GetItemByName('thermite')
    if wearhouseitem ~= nil and wearhouseitem ~= nil or wearhouseitem ~= nil and wearhouseitem ~= nil or wearhouseitem ~= nil and wearhouseitem ~= nil or wearhouseitem ~= nil and wearhouseitem ~= nil then
        cb(true)
    else
        cb(false)
	end
end)
print("sdad")

RegisterServerEvent('qb-warehouse:particles')
AddEventHandler('qb-warehouse:particles', function(method)
	TriggerClientEvent('qb-warehouse:ptfxparticle', -1, method)
end)

RegisterServerEvent('qb-wearhouse:server:cash', function()
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    if Player.PlayerData.money.cash >= 500 then
    Player.Functions.RemoveMoney('cash', 500)
    TriggerClientEvent("qb-wearhouse:client:item", src)
    else
        TriggerClientEvent(Config.Core..':Notify', src, "You don't have enough cash to buy a thermite!", "error", 3000)
    end
end)

RegisterServerEvent('qb-wearhouse:server:sellgoods2', function()
local src = source
local player = Core.Functions.GetPlayer(source)
player.Functions.AddMoney("cash", Config.price, "mission-reward")
print(Config.price)
end)

Core.Functions.CreateUseableItem("encrypted_document", function(source, item)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
        TriggerClientEvent('qb-warehouse:client:sendmail3', src)
    end)

Core.Functions.CreateCallback('qb-wearhouse:Checkitem', function(source, cb)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    local wearhouseitem = Player.Functions.GetItemByName('wearhousecard')
    if wearhouseitem ~= nil and wearhouseitem ~= nil or wearhouseitem ~= nil and wearhouseitem ~= nil or wearhouseitem ~= nil and wearhouseitem ~= nil or wearhouseitem ~= nil and wearhouseitem ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

Core.Functions.CreateCallback('qb-wearhouse:Checkitemgoods', function(source, cb)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    local sellgoods = Player.Functions.GetItemByName('rolex')
    local sellgoods2 = Player.Functions.GetItemByName('goldchain')
    local sellgoods3 = Player.Functions.GetItemByName('diamond_ring')
    if sellgoods ~= nil and sellgoods2 ~= nil and sellgoods3 ~= nil and sellgoods ~= nil and sellgoods2 ~= nil and sellgoods3 ~= nil or sellgoods ~= nil and sellgoods2 ~= nil and sellgoods3 then
        cb(true)
    else
        cb(false)
	end
end)

Core.Functions.CreateCallback('qb-wearhouse:Checkitem3', function(source, cb)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    local document = Player.Functions.GetItemByName('encrypted_document')
    if document ~= nil and document ~= nil or document ~= nil and document ~= nil or document ~= nil and document ~= nil or document ~= nil and document ~= nil then
        cb(true)
    else
        cb(false)
	end
end)


RegisterNetEvent('qb-wearhouse:server:LootGuards', function(netId)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    if not Player then return end

    local guard = NetworkGetEntityFromNetworkId(netId)
        for i=1, math.random(2, 5) do -- Minimum two items, maximum five items
            local random = math.random(#lootTable)
            Player.Functions.AddItem(lootTable[random].item, lootTable[random].amount, false)
            TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[lootTable[random].item], 'add', lootTable[random].amount)
            Wait(400)
        end
    if DoesEntityExist(guard) then
        DeleteEntity(guard)
    end
end)

RegisterNetEvent('qb-wearhouse:server:LootGuards2', function(netId)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    if not Player then return end

    local guard = NetworkGetEntityFromNetworkId(netId)
        -- for i=1, math.random(2, 2) do -- Minimum two items, maximum five items
            Player.Functions.AddItem("wearhousecard", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items["wearhousecard"], "add")
            Player.Functions.AddItem("encrypted_document", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items["encrypted_document"], "add")
            Wait(400)
    if DoesEntityExist(guard) then
        DeleteEntity(guard)
    end
end)

RegisterServerEvent("qb-wearhouse:server:sellgoods4", function(itemAmount)
    local src = source 
    local Player =  Core.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('rolex', "1")
    TriggerClientEvent("inventory:client:ItemBox", src, Core.Shared.Items['rolex'], "remove")
    Player.Functions.RemoveItem('goldchain', "1")
    TriggerClientEvent("inventory:client:ItemBox", src, Core.Shared.Items['goldchain'], "remove")
    Player.Functions.RemoveItem('diamond_ring', "1")
    TriggerClientEvent("inventory:client:ItemBox", src, Core.Shared.Items['diamond_ring'], "remove")
end)

RegisterServerEvent("qb-waerhouse:server:notifysell", function()
    local src = source
    TriggerClientEvent(Config.Core..':Notify', src, "You have sold the goods i give you " ..Config.price..  " in cash enjoy",  "success")
end)

RegisterServerEvent("qb-wearhouse:server:trashbag", function(netId)
    local src = source 
    local Player =  Core.Functions.GetPlayer(src)
    local guard = NetworkGetEntityFromNetworkId(netId)

    Player.Functions.AddItem('trashbag', "1")
    TriggerClientEvent("inventory:client:ItemBox", src, Core.Shared.Items['trashbag'], "add")
    Wait(400)
    if DoesEntityExist(guard) then
        DeleteEntity(guard)
    end
end)


