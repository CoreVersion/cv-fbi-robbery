local Core = exports[Config.CoreName]:GetCoreObject()

local FbiEmailSent = false

local CanRob = false

local Security = false

local InFbi1 = false

local InLester = false

local InRadar = false

local InEncrypted = false

local Elevator = false

local DownElevator = false

local FbiHack = false

local CurrentCops = 0 

local StartCoolDownSeconds = 3600
local StartCoolDownRemaining = 0

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('cv-fbi-robbery:client:policeAlert')
AddEventHandler('cv-fbi-robbery:client:policeAlert', function()
    Core.Functions.Notify(Config.AlertNotify)
	local plyPos = GetEntityCoords(PlayerPedId(), true)
    local FbiBlip = AddBlipForCoord(plyPos.x, plyPos.y, plyPos.z)

	SetBlipSprite(FbiBlip, 161)
	SetBlipScale(FbiBlip , 1.5)
	SetBlipColour(HandCuffBli, 3)
	PulseBlip(FbiBlip)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    Citizen.Wait(100)
    PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
    Citizen.Wait(100)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    Citizen.Wait(100)
    PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
    Citizen.Wait((1000 * 60 * 5))   
    RemoveBlip(FbiBlip)
end)

RegisterNetEvent('cv-fbi-robbery:SellGoodsItemCheck', function()
	SellFbiGoods()
	TriggerServerEvent(Config.Core..":Server:RemoveItem", Config.encrypteddocument, 1)
    TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[Config.encrypteddocument], "remove")
end)

RegisterNetEvent('cv-fbi-robbery:TalkAnimations', function()       
	LoadDict2('amb@prop_human_parking_meter@male@idle_a')
	TaskPlayAnim(GetPlayerPed(-1), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
	Core.Functions.Progressbar("search_register", "Checking With There Is An Active Robbery", 2000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableInventory = true,
	}, {}, {}, {}, function()
		ClearPedTasks(GetPlayerPed(-1))
		TriggerEvent("cv-fbi-robbery:TalkToLester")
		ClearPedTasks(GetPlayerPed(-1))            
	end, function()
		ClearPedTasks(GetPlayerPed(-1))
	end)
end)

local LesterCoolDownSeconds = 200
local LesterCoolDownRemaining = 0

RegisterNetEvent('cv-fbi-robbery:TalkToLester', function()
	print("coreversion On Top!")
    if Config.NotHere then
		if LesterCoolDownRemaining <= 0 then
			TriggerEvent('cv-fbi-robbery:OpenMenu')
			StartLesterCoolDown()
		else
			Core.Functions.Notify("It Seems Like Lester Is Not Here...", "error")
		end
	else
		TriggerEvent('cv-fbi-robbery:OpenMenu')
		--remove
		TriggerServerEvent(Config.Core..":Server:RemoveItem", Config.encrypteddocument, 1)
		TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[Config.encrypteddocument], "remove")
		--add
		TriggerServerEvent(Config.Core..":Server:AddItem", Config.FBICardItem, 1)
		TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[Config.FBICardItem], "add")
	end
end)

function SellFbiGoods()
	print("coreversion On Top!")
	Core.Functions.Progressbar("search_register", "You Are Selling Your Goods...", 5000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = 'mp_arresting',
		anim = 'a_uncuff',
		flags = 16,
    }, {}, {}, function()
        TriggerServerEvent("cv-fbi-robbery:SellFbiGoods")
		ClearPedTasks(GetPlayerPed(-1))
	end, function()
	    ClearPedTasks(GetPlayerPed(-1))
	end)     
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function ThermitePlanting()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end

    local ped = PlayerPedId()
    SetEntityHeading(ped, 46.89)
    local pos = vector3(2128.77, 2917.77, 47.9)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(ped)))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)

    local x, y, z = table.unpack(GetEntityCoords(ped))
    local thermite = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(thermite, false, true)
    AttachEntityToEntity(thermite, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(5000)
    DetachEntity(thermite, 1, 1)
    FreezeEntityPosition(thermite, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(bagscene)
    Citizen.CreateThread(function()
        Citizen.Wait(15000)
        DeleteEntity(thermite)
    end)
end

function ThermiteEffect()
	RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
	 while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
		 Citizen.Wait(50)
	 end
	 local ped = PlayerPedId()
	 Citizen.Wait(1500)
	 TriggerServerEvent("cv-fbi-robbery:server:ThermitePtfx", ptfx)
	 Citizen.Wait(500)
	 TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
	 TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
	 local ptfx
 
	 RequestNamedPtfxAsset("scr_ornate_heist")
	 while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
		Citizen.Wait(1)
	 end
		ptfx = vector3(2128.77, 2918.79, 47.9)
	 SetPtfxAssetNextCall("scr_ornate_heist")
	 local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	 Citizen.Wait(4000)
	 StopParticleFxLooped(effect, 0)
	 ClearPedTasks(ped)
	 Core.Functions.Notify("success", "success")
end

RegisterNetEvent("cv-fbi-robbery:client:ThermitePtfx", function(coords)
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Wait(50)
    end
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_ornate_heist_thernite_burn", coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
        Wait(5000)
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent('cv-fbi-robbery:OpenMenu', function()
    exports["qb-menu"]:openMenu({
        {
            header = Config.Header,
            txt = Config.HeaderText,
			isMenuHeader = true,
        },
        {
            header = Config.SecondHeader,
			params = {
				event = "cv-fbi-robbery:SendEmail",
			}
        },    
		{
            header = Config.ThirdHeader,
			params = {
				event = "cv-fbi-robbery:SellGoodsItemCheck",
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

Citizen.CreateThread(function()
	for _, info in pairs(Config.BlipLocation) do
		if Config.UseBlips then
	   		info.blip = AddBlipForCoord(info.x, info.y, info.z)
	   		SetBlipSprite(info.blip, info.id)
	   		SetBlipDisplay(info.blip, 4)
	   		SetBlipScale(info.blip, 0.6)	
	   		SetBlipColour(info.blip, info.colour)
	   		SetBlipAsShortRange(info.blip, true)
	   		BeginTextCommandSetBlipName("STRING")
	   		AddTextComponentString(info.title)
	   		EndTextCommandSetBlipName(info.blip)
	 	end
   	end	
end)

RegisterNetEvent('cv-fbi-robbery:StartRob', function()
	StartRob()
end)

local StartCoolDownSeconds = 3600
local StartCoolDownRemaining = 0

function StartRob()
	print("coreversion On Top!")
	Core.Functions.TriggerCallback('cv-fbi-robbery:CheckForStart', function(HasItems)
 		if HasItems then
			if StartCoolDownRemaining <= 0 then
				StartCoolDown()
				ThermitePlanting()
				ThermiteEffect()
    			Core.Functions.Progressbar("search_register", "Connecting ElectronicKit...", 12000, false, true, {
					disableMovement = true,
    				disableCarMovement = true,
    				disableMouse = false,
    				disableCombat = true,
    				disableInventory = true,
    			}, {}, {}, {}, function()end, function()
    			end)  
    			TaskPlayAnim(player,animDict,animName,3.0,0.5,-1,31,1.0,0,0)
    			Citizen.Wait(7500)
    			TaskStartScenarioInPlace(player, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
    			Citizen.Wait(4500)
				if Config.StandAlonePoliceAlert == true then
					TriggerServerEvent("cv-fbi-robbery:server:policeAlert")
				elseif Config.StandAlonePoliceAlert == false then
					TriggerEvent(Config.YourAlert)
				end
				TriggerEvent("mhacking:show")
    			TriggerEvent("mhacking:start", math.random(4, 6), 15 , OnHackRobDone)
  			else
				local minutes = math.floor(StartCoolDownRemaining / 60)
				local seconds = StartCoolDownRemaining - minutes * 60
				Core.Functions.Notify("You Have To Wait " .. minutes .. " Minutes And ".. seconds .. " Seconds Before Robbing On This Location Again !", "error")
  			end
  		else 
			Core.Functions.Notify("You Dont Have The Right Items !")
  		end
 	end)
end

function StartCoolDown()
    StartCoolDownRemaining = StartCoolDownSeconds
    Citizen.CreateThread(function()
        while StartCoolDownRemaining > 0 do
            Citizen.Wait(1000)
            StartCoolDownRemaining = StartCoolDownRemaining - 1
        end
    end)
end

RegisterNetEvent('cv-fbi-robbery:Security', function()
	print("coreversion On Top!")
	Core.Functions.TriggerCallback('cv-fbi-robbery:CheckForStart', function(HasItems)
		if HasItems then
			Core.Functions.Progressbar("power_hack", "Connecting...", math.random(5500, 5600), false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = false,
			})
			SecurityAnimation()
			Wait(2000)
			exports['ps-ui']:Thermite(function(success)
				if success then
					Core.Functions.Notify("Youv'e Successfully Hacked The Security System ! Now Go Rob Before The Cops Arrive !")
					CanRob = true
					Elevator = true
					Security = false
					SpawnGuards()
					SecuritySuccessAnim()
					TriggerServerEvent(Config.Core..":Server:RemoveItem", Config.FBICardItem, 1)
					TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[Config.FBICardItem], "remove")
					TriggerServerEvent(Config.Core..":Server:RemoveItem", Config.ElectronicKitItem, 1)
					TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[Config.ElectronicKitItem], "remove")
				else
					Core.Functions.Notify("Failed !")
					SecurityFailedAnim()
					Security = true
					CanRob = false
				end, 10, 5, 3) 
		else
			Core.Functions.Notify("You Dont Have The Right Items !")
		end
	end)
end)

local hackCoord = {x = 124.5725 , y = -760.9537, z = 41.451705, h = 63.933696}

function SecurityAnimation()
    local animDict = "anim@heists@ornate_bank@hack"
    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do
        Wait(100)
    end
    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))

    SetEntityHeading(ped, hackCoord.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", hackCoord.x, hackCoord.y, hackCoord.z+1.15, hackCoord.x, hackCoord.y, hackCoord.z+1.20, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", hackCoord.x, hackCoord.y, hackCoord.z+1.15, hackCoord.x, hackCoord.y, hackCoord.z+1.20, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", hackCoord.x, hackCoord.y, hackCoord.z+1.15, hackCoord.x, hackCoord.y, hackCoord.z+1.20, 0, 2)

    netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)
    laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)

    netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)

    netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)

    SetPedComponentVariation(ped, 5, 0, 0, 0)
    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)

end

function SecuritySuccessAnim()
    NetworkStartSynchronisedScene(netScene3)
    Wait(2500)
    NetworkStopSynchronisedScene(netScene3)
    DeleteObject(laptop)
    DeleteObject(bag)
end

function SecurityFailedAnim()
    NetworkStartSynchronisedScene(netScene3)
    Wait(2500)
    NetworkStopSynchronisedScene(netScene3)
    DeleteObject(laptop)
    DeleteObject(bag)
end

function OnHackRobDone(success, timeremaining)
    if success then
        TriggerEvent('mhacking:hide')
        Security = true
        Wait(200)
		Core.Functions.Notify("Youv'e Successfully Connected The Electronic kit Next Up is Security System " , "success")
		InFbiBlip()
    else
		Core.Functions.Notify("You Failed To Hack The System Try Again " , "error")
        Core.Functions.Notify("Failed !")
        TriggerServerEvent(Config.Core..":Server:RemoveItem", Config.ElectronicKitItem, 1)
        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[Config.ElectronicKitItem], "remove")
        TriggerEvent('mhacking:hide')
    end
end

RegisterNetEvent("cv-fbi-robbery:SendEmail", function()  
	FbiEmailSent = true
	TriggerServerEvent(Config.Core..":Server:AddItem", Config.FBICardItem, 1)
    TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[Config.FBICardItem], "add")
	local securitycard = Config.FBICardItem
	local electronic = Config.ElectronicKitItem
	local phone = Config.Phone
    if Config.UsePhoneNotification then
		TriggerServerEvent("cv-fbi-robbery:SendDiscordLog")
        TriggerServerEvent(phone..':server:sendNewMail', {
            sender = Config.Header,
            subject = "The FBI Heist Information",
            message = "Here Is The Information You Need For Robbing The FBI <br /> After Robbing Dont Forgot To Come Back For Payment ! <br /> <br /> <strong> Items Needed: </strong> <br /> 1X " .. securitycard .. " 1X "  .. electronic .. " The Location Is Pinged On The Map !s",
            button = {}
		})
		RadarBlip()
    else
        Core.Function.Notify('Here Is The Information You Need: ' .. securitycard .. ' And 1X ' .. electronickit .. 'For Robbing After Robbing Dont Forgot To Come Back For Payment ! Location Is Pinged On The Map')
		RadarBlip()
		TriggerServerEvent("cv-fbi-robbery:SendDiscordLog")
    end
end)

RegisterCommand("yg", function()
	InFbiBlip()
end)

function CheckInFbiCoords()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(7)
            local ped = GetPlayerPed(-1) 
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            local Distance = GetDistanceBetweenCoords(PlayerCoords,93.461212, -742.3516, 45.75571, true) 
            if Distance < 60.0 then
                InFbi1 = true
                break
            end
        end
    end)
end


function ChecklesterCoords()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(7)
            local ped = GetPlayerPed(-1) 
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            local Distance = GetDistanceBetweenCoords(PlayerCoords, 707.01782, -963.8489, 30.408246, true) 
            if Distance < 60.0 then
                InLester = true
                break
            end
        end
    end)
end

function CheckRadarCoords()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(7)
            local ped = GetPlayerPed(-1) 
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            local Distance = GetDistanceBetweenCoords(PlayerCoords, 2130.3625, 2915.7116, 47.618892,true) 
            if Distance < 60.0 then
                InRadar = true
                break
            end
        end
    end)
end

function InFbiBlip()
    local blip = AddBlipForCoord(93.461212, -742.3516, 45.75571) 
	SetBlipColour(blip, 0)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 18)
    SetBlipSprite(blip,619)
    BeginTextCommandSetBlipName("Fbi")
    AddTextComponentString('Fbi')
    Citizen.Wait(1000)
	CheckInFbiCoords()
    Citizen.Wait(2000)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(7)
            if InFbi1 == true then
                RemoveBlip(blip)
                break
            end
        end
    end)
end

function lesterBlip()
    local blip = AddBlipForCoord(707.01782, -963.8489, 30.408246) 
    SetBlipColour(blip, 0)
    SetBlipRoute(blip, false)
    SetBlipRouteColour(blip, 18)
    SetBlipSprite(blip,77)
    BeginTextCommandSetBlipName("Lester")
    AddTextComponentString('Lester')
    Citizen.Wait(1000)
    ChecklesterCoords()
    Citizen.Wait(2000)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(7)
            if InLester == true then
                RemoveBlip(blip)
                break
            end
        end
    end)
end

function RadarBlip()
    local blip = AddBlipForCoord(2130.3625, 2915.7116, 47.618892)
    SetBlipColour(blip, 0)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 5)
    SetBlipSprite(blip,564)
    BeginTextCommandSetBlipName("Radar")
    AddTextComponentString('Radar')
    Citizen.Wait(1000)
    CheckRadarCoords()
    Citizen.Wait(2000)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(7)
            if InRadar == true then
                RemoveBlip(blip)
                break
            end
        end
    end)
end

function StartLesterCoolDown()
    LesterCoolDownRemaining = LesterCoolDownSeconds
    Citizen.CreateThread(function()
        while LesterCoolDownRemaining > 0 do
            Citizen.Wait(1000)
            LesterCoolDownRemaining = LesterCoolDownRemaining - 1
        end
    end)
end

RegisterNetEvent('cv-fbi-robbery:client:setRobState', function(stateType, state, r)
    Config.RobLocations[r][stateType] = state
end)

function Rob(r)
	if CanRob == true then
		Core.Functions.Progressbar("search_register", "Searching...", 5000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
			animDict = 'mp_arresting',
			anim = 'a_uncuff',
			flags = 16,
		}, {}, {}, function()
			TriggerServerEvent('cv-fbi-robbery:server:setRobState', "isOpened", true, r)
			TriggerServerEvent('cv-fbi-robbery:server:setRobState', "isBusy", false, r)
			TriggerServerEvent("cv-fbi-robbery:GetItems")
			ClearPedTasks(GetPlayerPed(-1))
		end, function()
			TriggerServerEvent('cv-fbi-robbery:server:setRobState', "isBusy", false, r)
			ClearPedTasks(GetPlayerPed(-1))
		end)    
		TriggerServerEvent('cv-fbi-robbery:server:setRobState', "isBusy", true, r)
	else
		Core.Functions.Notify("You Need To Start The Robbery First !", 'error')
	end
end

RegisterNetEvent('cv-fbi-robbery:Elevatorup', function()
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
    SetEntityCoords(PlayerPedId(), 136.15115, -761.7459, 242.1519, false, false, false, true)  
    SetEntityHeading(PlayerPedId(), 159.93727)

    Citizen.Wait(500)

    DoScreenFadeIn(1000) 
	FbiHack = true
end)

RegisterNetEvent('cv-fbi-robbery:FbiHack', function()
	local animDict = 'anim@heists@prison_heiststation@cop_reactions'
	local anim = 'cop_b_idle'
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Wait(10) end
	local ped = PlayerPedId()
	TaskPlayAnim(ped, animDict, anim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
	exports['ps-ui']:VarHack(function(success)
		if success then
			print("success")
			TriggerServerEvent(Config.Core..":Server:AddItem", Config.FbiServerusb, 1)
			TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[Config.FbiServerusb], "add")
			TriggerServerEvent(Config.Core..":Server:AddItem", Config.FbiServerusb2, 1)
			TriggerEvent("inventory:client:ItemBox", Core.Shared.Items[Config.FbiServerusb2], "add")
			Core.Functions.Notify("You Success The Hack", 'success')
			Core.Functions.Notify("You Got The USB's", 'success')
			FbiHack = false
			DownElevator = true
			InEncrypted = true
			StopAnimTask(ped, animDict, anim, 1.0)
		else
			print("failed")
			Core.Functions.Notify("You Failed The Hack", 'error')
			StopAnimTask(ped, animDict, anim, 1.0)
		end
	end, 4, 7)
end)


RegisterNetEvent('cv-fbi-robbery:Elevatordown', function()
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
    SetEntityCoords(PlayerPedId(), 136.18537, -761.7266, 45.752067, false, false, false, true)  
    SetEntityHeading(PlayerPedId(), 146.01408)

    Citizen.Wait(500)

    DoScreenFadeIn(1000)
	Elevator = false
end)

CreateThread(function()
	for r, v in pairs(Config.RobLocations) do
		exports[Config.Target]:AddBoxZone("RobLocation"..r, vector3(v.coords.x, v.coords.y, v.coords.z), v.poly1, v.poly2, {
			name = "RobLocation"..r,
			heading = v.heading,
			debugPoly = Config.PolyZone,
			minZ = v.minZ,
			maxZ = v.maxZ,
			}, {
				options = { 
				{
					action = function()
						Rob(r)
					end,
					icon = Config.Icon,
					label = Config.Label,
					canInteract = function()
						if v["isOpened"] or v["isBusy"] then 
							return false
						end
						return true
					end,
				}
			},
			distance = Config.Distance,
		})
	end

	exports[Config.Target]:AddBoxZone("FbiSecurity", vector3(124.15177, -760.5552, 41.75177), 1.4, 1.5, {
		name = "FbiSecurity",
		heading = 246.41476,
		debugPoly = Config.PolyZone,
		minZ = 40.75177,
		maxZ = 42.75177,
	}, {
		options = {
			{
				type = "client",
				event = "cv-fbi-robbery:Security",
				icon = Config.SecurityIcon,
				label = Config.SecurityLabel,
				canInteract = function()
					if not Security then
						return false
					else
						return true
					end
				end,
			},
		},
		distance = Config.Distance
	})

	exports[Config.Target]:AddBoxZone("FbiHack", vector3(118.08, -730.78, 242.15), 1.5, 1.5, {
		name = "FbiHack",
		heading = 340,
		debugPoly = Config.PolyZone,
		minZ = 241.15,
		maxZ = 243.15,
	}, {
		options = {
			{
				type = "client",
				event = "cv-fbi-robbery:FbiHack",
				icon = Config.HackIcon,
				label = Config.HackLabel,
				canInteract = function()
					if not FbiHack then
						return false
					else
						return true
					end
				end,
			},
		},
		distance = Config.Distance
	})

	exports[Config.Target]:AddBoxZone("FbiElevatorup", vector3(136.56, -763.48, 45.75), 0.4, 0.3, {
		name = "FbiElevatorup",
		heading = 340,
		debugPoly = Config.PolyZone,
		minZ = 44.75,
		maxZ = 46.75,
	}, {
		options = {
			{
				type = "client",
				event = "cv-fbi-robbery:Elevatorup",
				icon = Config.ElevatorupIcon,
				label = Config.ElevatorupLabel,
				canInteract = function()
					if not Elevator then
						return false
					else
						return true
					end
				end,
			},
		},
		distance = Config.Distance
	})

	exports[Config.Target]:AddBoxZone("FbiElevatordown", vector3(136.49, -763.52, 242.15), 0.5, 0.4, {
		name = "FbiElevatordown",
		heading = 340,
		debugPoly = Config.PolyZone,
		minZ = 241.15,
		maxZ = 243.15,
	}, {
		options = {
			{
				type = "client",
				event = "cv-fbi-robbery:Elevatordown",
				icon = Config.ElevatorDownIcon,
				label = Config.ElevatorDownLabel, 
				canInteract = function()
					if not  DownElevator then
						return false
					else
						return true
					end
				end,
			},
		},
		distance = Config.Distance
	})

	exports[Config.Target]:AddTargetModel(`cs_lestercrest`, {
		options = {
			{
				type = "client",
				coords = vector4(707.22576, -963.2145, 30.408254, 187.80715),
				event = "cv-fbi-robbery:TalkAnimations",
				icon = "fa fa-laptop",
				label = "Talk To Lester",
				item = Config.encrypteddocument,
			},
		},
		distance = 1.5
	})

	exports[Config.Target]:AddBoxZone("FbiStart", vector3(2128.04, 2918.43, 47.63), 3, 3, {
		name = "FbiStart",
		heading = 225,
		debugPoly = Config.PolyZone,
		minZ = 46.63,
		maxZ = 48.63
	}, {
		options = {
			{
				type = "client",
				event = "cv-fbi-robbery:StartRob",
				icon = Config.StartIcon,
				label = Config.StartLabel,
				canInteract = function()
					if not FbiEmailSent then
						return false
					else
						return true
					end
				end,
			},
		},
		distance = Config.Distance
	})
end)

CreateThread(function()
	while true do
		Wait(1000)
		for k, v in pairs{{coords = vector4(707.22576, -963.2145, 30.408254, 187.80715)}} do
			local pos = GetEntityCoords(PlayerPedId())	
			local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
			
			if dist < 40 and not pedspawned then
				TriggerEvent('cv-fbi-robbery:spawn:ped', v.coords)
				pedspawned = true
                Freeze = true
			end
			if dist >= 35 then
				pedspawned = false
				DeletePed(FbiPed)
			end
		end
	end
end)

RegisterNetEvent('cv-fbi-robbery:spawn:ped')
AddEventHandler('cv-fbi-robbery:spawn:ped',function(coords)
	local hash = `cs_lestercrest`
	RequestModel(hash)
	while not HasModelLoaded(hash) do 
		Wait(10)
	end

        pedspawned = true
        freeze = true
        invincible = true
        blockevents = true
        FbiPed = CreatePed(5, hash, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
        FreezeEntityPosition(FbiPed, true)
        SetBlockingOfNonTemporaryEvents(FbiPed, true)
        TaskStartScenarioInPlace(FbiPed, "WORLD_HUMAN_STAND_MOBILE_UPRIGHT", 0, true) 
end)

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Citizen.Wait(0) 
    end
    TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 1.0, -1.0, duration, 50, 1, false, false, false)
    RemoveAnimDict(animDict)
end

function LoadDict2(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

RegisterCommand("test", function()
	SpawnGuards()
end)

function SpawnGuards()
    local ped = PlayerPedId()
    SetPedRelationshipGroupHash(ped, GetHashKey('PLAYER'))
    AddRelationshipGroup('GuardPeds')

    for r, v in pairs(Config.Guards) do
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

AddEventHandler('onResourceStop', function (resource)
    if resource == GetCurrentResourceName() then
        ClearArea(115.96136, -743.56, 242.15222, 180.20425)
		ClearAreaOfEverything(115.96136, -743.56, 242.15222, 180.20425, true, true, true, true)
    end
end)

AddEventHandler('onResourceStart', function (resource)
    if resource == GetCurrentResourceName() then
        ClearArea(115.96136, -743.56, 242.15222, 180.20425)
		ClearAreaOfEverything(115.96136, -743.56, 242.15222, 180.20425, true, true, true, true)
    end
end) 




