local Core = exports[Config.CoreName]:GetCoreObject()

local Security = false

local Security2 = false

local Security3 = false

local InPoint = false

local InPoint2 = false

local enter = false

local thermite = false

local Document = false

local StartCoolDownRemaining = 0

local CurrentCops = 0 



local waerhouseguards = {
    'mp_m_fibsec_01'
}

local waerhouseguards2 = {
    'ig_fbisuit_01'
}

local waerhouseguards3 = {
    'cs_fbisuit_01'
}

------- Functions -------

RegisterNetEvent('qb-warehouse:client:talkto', function()
    if CurrentCops >= Config.RequiredPolice then
    if StartCoolDownRemaining <= 0 then
        StartCoolDown()
        Core.Functions.Notify("I will send you an e-mail right now..", "success")
        TriggerEvent("qb-warehouse:client:sendmail")
        wearblip()
        Security3 = true
    else
        local minutes = math.floor(StartCoolDownRemaining / 60)
        local seconds = StartCoolDownRemaining - minutes * 60
        Core.Functions.Notify("You Have To Wait " .. minutes .. " Minutes And ".. seconds .. " Seconds Before Starting Robbing Again !", "error")
    end
else
    Core.Functions.Notify("You Need At Least " .. Config.RequiredPolice .. " Police Officer To Start Robbing !", "error")
    end
end)


function wearblip()
    local blip = AddBlipForCoord(-619.1192, -1130.085, 22.198795, 264.17001)
    SetBlipColour(blip, 38)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 38)
    SetBlipSprite(blip,50)
    BeginTextCommandSetBlipName("Wear house")
    AddTextComponentString('Wear house')
    Citizen.Wait(1000)
    CheckCoords()
    Citizen.Wait(2000)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(7)
            if InPoint == true then
                RemoveBlip(blip)
                break
            end
        end
    end)
end

function pedblip()
    local blip = AddBlipForCoord(49.537307, -1452.72, 29.313117, 220.00468)
    SetBlipColour(blip, 38)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 0)
    SetBlipSprite(blip,66)
    BeginTextCommandSetBlipName("Unkown")
    AddTextComponentString('Unkown')
    Citizen.Wait(1000)
    CheckCoords2()
    Citizen.Wait(2000)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(7)
            if InPoint2 == true then
                RemoveBlip(blip)
                break
            end
        end
    end)
end


function CheckCoords2()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(7)
            local ped = GetPlayerPed(-1) 
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            local Distance = GetDistanceBetweenCoords(PlayerCoords, 49.537307, -1452.72, 29.313117, 220.00468, true) 
            if Distance < 60.0 then
                InPoint2 = true
                break
            end
        end
    end)
end

function CheckCoords()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(7)
            local ped = GetPlayerPed(-1) 
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            local Distance = GetDistanceBetweenCoords(PlayerCoords, -619.1192, -1130.085, 22.198795, 264.17001, true) 
            if Distance < 60.0 then
                InPoint = true
                break
            end
        end
    end)
end

function StartCoolDown()
    StartCoolDownRemaining = Config.NextRob
    Citizen.CreateThread(function()
        while StartCoolDownRemaining > 0 do
            Citizen.Wait(1000)
            StartCoolDownRemaining = StartCoolDownRemaining - 1
        end
    end)
end

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(amount)
    CurrentCops = amount
end)



function SpawnGuards2()
    local ped = PlayerPedId()
    SetPedRelationshipGroupHash(ped, GetHashKey('PLAYER'))
    AddRelationshipGroup('GuardPeds')

    for k, v in pairs(Config.WearhouseGuards) do
        RequestModel(GetHashKey(v.Ped))
        while not HasModelLoaded(GetHashKey(v.Ped)) do
            Wait(1)
        end
        Guards = CreatePed(0, GetHashKey(v.Ped), v.Coords, true, true)
        NetworkRegisterEntityAsNetworked(Guards)
        networkID = NetworkGetNetworkIdFromEntity(Guards)
        SetNetworkIdCanMigrate(networkID, true)
        GiveWeaponToPed(Guards, GetHashKey(v.Weapon), 255, false, false) 
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetEntityAsMissionEntity(Guards)
        SetPedDropsWeaponsWhenDead(Guards, false)
        SetPedRelationshipGroupHash(Guards, GetHashKey("GuardPeds"))
        SetEntityVisible(Guards, true)
        SetPedRandomComponentVariation(Guards, 0)
        SetPedRandomProps(Guards)
        SetPedCombatMovement(Guards, v.Aggresiveness)
        SetPedAlertness(Guards, v.Alertness)
        SetPedAccuracy(Guards, v.Accuracy)
        SetPedMaxHealth(Guards, v.Health)
    end

    SetRelationshipBetweenGroups(0, GetHashKey("GuardPeds"), GetHashKey("GuardPeds"))
	SetRelationshipBetweenGroups(5, GetHashKey("GuardPeds"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GuardPeds"))
end




RegisterNetEvent('qb-warehouse:client:sendmail', function(amount)
        TriggerServerEvent(Config.Phone..':server:sendNewMail', {
            sender = ('Unknown'),
            subject = ('warehouse Robbery'),
            message = ('I have marked the location on your GPS, all you will need is a low-yield themal charge and use it on a circuit box. You might encounter some form of armed resistance, so bring a weapon just in case!'),
            button = {}
        })
    end)

    RegisterNetEvent('qb-warehouse:client:sendmail2', function(amount)
        TriggerServerEvent(Config.Phone..':server:sendNewMail', {
            sender = ('Unknown'),
            subject = ('warehouse Robbery'),
            message = ('Its look like the stuff was take by the FBI trucks !'),
            button = {}
        })
    end)

    RegisterNetEvent('qb-warehouse:client:sendmail3', function(amount)
        TriggerServerEvent(Config.Phone..':server:sendNewMail', {
            sender = ('Unknown'),
            subject = ('warehouse Robbery'),
            message = ('I see you find a Encrypted Document come to me and i will give you a instructions !'),
            button = {},
            TriggerEvent("qb-warehouse:client:blip")
        })
    end)

    RegisterNetEvent('qb-warehouse:client:sendmail4', function(amount)
        TriggerServerEvent(Config.Phone..':server:sendNewMail', {
            sender = ('Unknown'),
            subject = ('warehouse Robbery'),
            message = ('Rolex, Goldchain, Dimaond ring.'),
            button = {},
        })
    end)


    RegisterNetEvent("qb-waerhouse:client:clear", function()
        ClearAreaOfPeds(-619.1192, -1130.085, 22.198795, 30.0, 1)
        ClearAreaOfPeds(1048.6727, -3097.425, -38.9999, 30.0, 1)
    end)


    RegisterNetEvent('qb-warehouse:client:blip', function()
            pedblip()
        end)

RegisterNetEvent('qb-warehouse:client:thermite', function()
    Core.Functions.TriggerCallback('qb-wearhouse:Checkitem2', function(HasItems)
        if HasItems then
        exports['ps-ui']:Thermite(function(success)
    function() -- success
        Core.Functions.Notify("You have successfully sabotage the elctricity", "success")
        firstDoor()
        remove()
        Security = true
    end,
    function() -- failure
        Security = false
        Core.Functions.Notify("You failed the game!", "error")
    end)
    else
        Core.Functions.Notify("You don't have thermite", "error")
    end
end, 10, 5, 3) -- Time, Gridsize (5, 6, 7, 8, 9, 10), IncorrectBlocks
end)

RegisterNetEvent("qb-warehouse:client:Document", function()
    Core.Functions.TriggerCallback('qb-wearhouse:Checkitem3', function(HasItems)
        if HasItems then
    Core.Functions.Notify("You have found a Encrypted Document", "success")
    Wait(3000)
    Core.Functions.Notify("Go to my friend laster 'L' on the map", "success")
    Wait(3000)  
    Core.Functions.Notify("And give him the Document", "success")
    Security = false
    Security2 = false
    Security3 = false
    enter = false
    lesterBlip()
    else
        Core.Functions.Notify("You don't have Encrypted Document", "error")
    end
end)
end)


RegisterNetEvent('qb-warehouse:client:enter', function()
    local ped = PlayerPedId()
    local currentPos = GetEntityCoords(ped)
    print(currentPos)
    
    SetEntityCoords(ped, 1048.6727, -3097.425, -38.9999, 266.62631, false, false, false, true)
    
    currentPos = GetEntityCoords(ped)
    print(currentPos) -- changed!
    SpawnGuards2()
    TriggerEvent("qb-warehouse:client:sendmail2")
end)

RegisterNetEvent('qb-warehouse:client:enter2', function()
    if enter == false then
    TriggerEvent("qb-warehouse:client:enter")
    enter = true
    else
        Core.Functions.Notify("You already enter the warehouse", "error")
    end
end)

RegisterNetEvent('qb-warehouse:client:exit', function()
    local ped = PlayerPedId()
    local currentPos = GetEntityCoords(ped)
    print(currentPos)
    
    SetEntityCoords(ped, -620.1753, -1130.159, 22.179019, 85.752098, false, false, false, true)
    
    currentPos = GetEntityCoords(ped)
    print(currentPos) -- changed!
    exports[Config.Target]:RemoveTargetModel(waerhouseguards, 'FBI')
    exports[Config.Target]:RemoveTargetModel(waerhouseguards2, 'FBI2')
end)

RegisterNetEvent("qb-warehouse:client:cash2", function()
    TriggerServerEvent("qb-wearhouse:server:cash")
end)


RegisterNetEvent("qb-wearhouse:client:item", function()
    TriggerServerEvent(Config.Core..":Server:AddItem", "thermite", "1")
    TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["thermite"], "add")
end)


function hacklocks(success, timeremaining)
    if success then
        TriggerEvent('mhacking:hide')
        Security2 = true
        Wait(200)
        Core.Functions.Notify("Youv'e Successfully Connected Disabled the locks !" , "success")
        TriggerServerEvent(Config.Core..":Server:RemoveItem", "wearhousecard", "1")
        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["wearhousecard"], "remove")
    else
        Core.Functions.Notify("Failed !", "error")
        TriggerEvent('mhacking:hide')
        Security2 = false
    end
end

RegisterNetEvent("qb-waerhosue:client:sellgoods", function()
    Core.Functions.TriggerCallback('qb-wearhouse:Checkitemgoods', function(HasItems)
        if HasItems then
    TriggerServerEvent("qb-wearhouse:server:sellgoods4")
    TriggerServerEvent("qb-wearhouse:server:sellgoods2")
    TriggerServerEvent("qb-waerhouse:server:notifysell")
        else
            Core.Functions.Notify("You don't have enough goods, i send you a email for the things", "error")
            TriggerEvent("qb-warehouse:client:sendmail4")
        end
    end)
end)



    RegisterNetEvent('qb-warehouse:client:hack', function()
        Core.Functions.TriggerCallback('qb-wearhouse:Checkitem', function(HasItems)
            if HasItems then
        local player = PlayerPedId()
        local playerPos = GetEntityCoords(player)        
        local animDict = "anim@heists@prison_heiststation@cop_reactions"
        local animName = "cop_b_reaction"                    
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(0)
        end
        TriggerEvent('mhacking:show')
        TriggerEvent('mhacking:start', 5, 20, hacklocks)
        TaskPlayAnim(player,animDict,animName,3.0,0.5,-1,31,1.0,0,0)
        Wait(5000)
        ClearPedTasksImmediately(player)
    else
        Core.Functions.Notify("You don't have a keycard", "error")
    end
end)
    end)

    RobGuard = function(entity)
        local ped = PlayerPedId()
            -- ANIMATION
            RequestAnimDict("pickup_object")
            while not HasAnimDictLoaded("pickup_object") do Wait(10) end
            TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
    
            -- REWARD
            local netId = NetworkGetNetworkIdFromEntity(entity)
            TriggerServerEvent('qb-wearhouse:server:LootGuards', netId)
            
            -- FINISH
            Wait(1000)
            ClearPedTasks(ped)
        end

        RobGuard2 = function(entity)
            local ped = PlayerPedId()
                -- ANIMATION
                RequestAnimDict("pickup_object")
                while not HasAnimDictLoaded("pickup_object") do Wait(10) end
                TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
        
                -- REWARD
                local netId = NetworkGetNetworkIdFromEntity(entity)
                TriggerServerEvent('qb-wearhouse:server:LootGuards2', netId)
                
                -- FINISH
                Wait(1000)
                ClearPedTasks(ped)
            end

            trashbag = function(entity)
                local ped = PlayerPedId()
                    -- ANIMATION
                    RequestAnimDict("pickup_object")
                    while not HasAnimDictLoaded("pickup_object") do Wait(10) end
                    TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
            
                    -- REWARD
                    local netId = NetworkGetNetworkIdFromEntity(entity)
                    TriggerServerEvent('qb-wearhouse:server:trashbag', netId)
                    
                    -- FINISH
                    Wait(1000)
                    ClearPedTasks(ped)
                end

function remove()
    TriggerServerEvent(Config.Core..":Server:RemoveItem", "thermite", "1")
    TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["thermite"], "remove")
end

-- Opening Doors 
function firstDoor()
    loadAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 354.29281)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(-601.1083, -1164.137, 22.319362, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"),-601.1083, -1164.137, 22.319362,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomb = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.3,  true,  true, true)

    SetEntityCollision(bomb, false, true)
    AttachEntityToEntity(bomb, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(2000)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, -1, 0, 0)
    DetachEntity(bomb, 1, 1)
    FreezeEntityPosition(bomb, true)
    TriggerServerEvent("qb-warehouse:particles", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomb)
    StopParticleFxLooped(effect, 0)
    TriggerEvent("qb-bobcdat:openFirstDoor") 
end

RegisterNetEvent("qb-warehouse:ptfxparticle")
AddEventHandler("qb-warehouse:ptfxparticle", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(-600.9428, -1163.556, 22.190507)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000) 
    StopParticleFxLooped(effect, 0)
end)




------- Commands -------


------- spawn the ped -------
CreateThread(function()
	while true do
		Wait(1000)
		for k, v in pairs(Config.PedLocations) do
			local pos2 = GetEntityCoords(PlayerPedId())	
			local dist2 = #(pos2 - vector3(v.coords.x, v.coords.y, v.coords.z))
			
			if dist2 < 40 and not pedspawned2 then
				TriggerEvent('qb-warehouse:spawn:ped', v.coords)
				pedspawned2 = true
			end
			if dist2 >= 35 then
				pedspawned2 = false
				DeletePed(Surfped2)
			end
		end
	end
end)

RegisterNetEvent('qb-warehouse:spawn:ped')
AddEventHandler('qb-warehouse:spawn:ped',function(coords)
	local naor = `s_m_m_ciasec_01`

	RequestModel(naor)
	while not HasModelLoaded(naor) do 
		Wait(10)
	end

        pedspawned = true
        Surfped2 = CreatePed(5, naor, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
        FreezeEntityPosition(Surfped2, true)
        SetBlockingOfNonTemporaryEvents(Surfped2, true)
        TaskStartScenarioInPlace(Surfped2, "WORLD_HUMAN_STAND_MOBILE_UPRIGHT", 0, true) 
end)

------- Targets -------

Config.Peds = {
    "s_m_m_ciasec_01"
}

exports[Config.Target]:AddTargetModel(Config.Peds, {
	options = {
		{
			event = "qb-wearhouse:openMenu",
			icon = "fa-solid fa-user-secret",
			label = "TALK TO.."
		},
	},
	distance = 2.5,
})

exports[Config.Target]:AddBoxZone("thermite", vector3(-601.001, -1163.786, 23.667921), 0.45, 0.35, {
	name = "thermite",
	heading = 180.0,
	debugPoly = Config.PolyZone,
	minZ = 21.667921,
	maxZ = 24.667921,
}, {
	options = {
		{
            type = "client",
            event = "qb-warehouse:client:thermite",
			icon = "fa-solid fa-bolt",
			label = "Sabotage The Elctricity",
            canInteract = function()
                if not Security3 then
                  return false
                else
                  return true
                 end
              end,
		},
	},
	distance = 2.5
})

exports[Config.Target]:AddBoxZone("enter", vector3(-618.78, -1130.63, 22.18), 5, 0.5, {
	name = "enter",
	heading = 0,
	debugPoly = Config.PolyZone,
	minZ = 21.18,
	maxZ = 23.18,
}, {
	options = {
		{
            type = "client",
            event = "qb-warehouse:client:enter2",
			icon = "fa-solid fa-right-to-bracket",
			label = "Enter The Warehouse",
            canInteract = function()
                if not Security then
                  return false
                else
                  return true
                 end
              end,
		},
	},
	distance = 2.5
})

exports[Config.Target]:AddBoxZone("exit", vector3(1047.52, -3097.07, -39.0), 1, 1, {
	name = "exit",
	heading = 0,
	debugPoly = Config.PolyZone,
	minZ = -40.0,
	maxZ = -35.0,
}, {
	options = {
		{
            type = "client",
            event = "qb-warehouse:client:exit",
			icon = "fa-solid fa-right-to-bracket",
			label = "Exit The Warehouse",
            canInteract = function()
                if not Security2 then
                  return false
                else
                  return true
                 end
              end,
		},
	},
	distance = 2.5
})

exports[Config.Target]:AddBoxZone("exit2", vector3(1048.44, -3100.65, -39.0), 0.5, 0.5, {
	name = "exit2",
	heading = 0,
	debugPoly = Config.PolyZone,
	minZ = -40.0,
	maxZ = -35.0,
}, {
	options = {
		{
            type = "client",
            event = "qb-warehouse:client:hack",
			icon = "fa-solid fa-lock",
			label = "Disabled The Locks",
		},
	},
	distance = 2.5
})

exports[Config.Target]:AddTargetModel(waerhouseguards, {
    options = {
        {
            action = function(entity)
                RobGuard(entity)
            end,
            icon = 'fas fa-hand-holding',
            label = 'Grab Gear',
            canInteract = function(entity)
                if not IsPedAPlayer(entity) then 
                    return IsEntityDead(entity)
                end
                return false
            end, 
        },
    },
    distance = 1.5,
})


exports[Config.Target]:AddTargetModel(waerhouseguards2, {
    options = {
        {
            action = function(entity)
                RobGuard2(entity)
            end,
            icon = 'fa-solid fa-file',
            label = 'Grab Documents',
            canInteract = function(entity)
                if not IsPedAPlayer(entity) then 
                    return IsEntityDead(entity)
                end
                return false
            end, 
        },
    },
    distance = 1.5,
})

exports[Config.Target]:AddTargetModel(waerhouseguards3, {
    options = {
        {
            action = function(entity)
                trashbag(entity)
            end,
            icon = 'fa-solid fa-trash-can',
            label = 'Put In Trash Bag',
            canInteract = function(entity)
                if not IsPedAPlayer(entity) then 
                    return IsEntityDead(entity)
                end
                return false
            end, 
        },
    },
    distance = 1.5,
})

------- Menu -------

RegisterNetEvent('qb-wearhouse:openMenu', function()
    Core.Functions.Progressbar("talk", "Talking To..", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
    TriggerEvent('qb-menu:client:openMenu', {
        {
            header = "Fbi Wearhouse Prep ",
            txt = "Wanna rob a warehouse?",
            isMenuHeader = true,
        },
        {
            header = "Rob a warehouse",
            params = {
                event = "qb-warehouse:client:talkto",
            }
        },    
        {
            header = "Sell Goods",
            params = {
                event = "qb-waerhosue:client:sellgoods",
            }
        },
         {
            header = "Buy a thermite",
            params = {
                event = "qb-warehouse:client:cash2",
            }
        },
        {
            header = "Show the Encrypted Document",
            params = {
                event = "qb-warehouse:client:Document",
            }
        },  
        {
            header = "Close Menu",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        },        
    })
end)
end)



------- Events -------

-- Load Anim Dict 
function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

AddEventHandler('onResourceStop', function (resource)
    if resource == GetCurrentResourceName() then
        ClearArea(-621.5, -1138.01, 22.18, 351.84)
		ClearAreaOfEverything(-621.5, -1138.01, 22.18, 351.84, true, true, true, true) 
        ClearArea(1057.47, -3101.0, -39.0, 249.01)
		ClearAreaOfEverything(1057.47, -3101.0, -39.0, 249.01, true, true, true, true) 
    end
end)

AddEventHandler('onResourceStart', function (resource)
    if resource == GetCurrentResourceName() then
        ClearArea(-621.5, -1138.01, 22.18, 351.84)
		ClearAreaOfEverything(-621.5, -1138.01, 22.18, 351.84, true, true, true, true)
        ClearArea(1057.47, -3101.0, -39.0, 249.01)
		ClearAreaOfEverything(1057.47, -3101.0, -39.0, 249.01, true, true, true, true) 
    end
end)


