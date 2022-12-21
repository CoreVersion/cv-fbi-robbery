Config = Config or {}

print("coreversion • development")

-------------------
--Core
-------------------
Config.CoreName = "qb-core" -- qb-core

Config.Core = "QBCore" -- QBcore 
-------------------
--General
-------------------

Config.NotHere = true -- Do You Want Cooldown For Opening The Menu?

Config.UseBlips = true -- Do You Want Blips On The Map?

Config.UsePhoneNotification = true -- Do You Want Phone Notification?

Config.Phone = 'qb-phone'  -- Your Phone Script

Config.he = false -- Change to your language 

Config.BlipLocation = {
    {title="Fbi Robbery", colour=0, id=86, x = 49.197227, y = -1452.836, z = 29.313383},
}

-------------------
--WebHook
-------------------
Config.LogsImage = "https://cdn.discordapp.com/attachments/1017143045407383592/1018140350889607260/baner.png" -- Your img

Config.LogsThumbnail = "https://cdn.discordapp.com/attachments/1017143045407383592/1018140423673352192/baner.png" -- Your img

Config.WebHook = "https://discord.com/api/webhooks/1020658491947491388/umB82UaWrxyuOCoEnpEXGvOAZIk5nKqH8Prn7rPCzPEm-krPVnido2-uj_K_xLI-aRsW" -- Your WebHook

-------------------
--Police Alert
-------------------

Config.StandAlonePoliceAlert = true -- Do You Want Stand Alone Police Alert?

Config.YourAlert = false --"None"

Config.RequiredPolice = 0 -- How Many Police Do You Want To Be Online To Trigger The Alert?

Config.PoliceJob = 'police' -- Police Job Name

Config.AlertNotify = 'FBI Robbery In Progress ! Check your GPS' -- Alert Message

-------------------
--items
-------------------

Config.FBICardItem = 'fbikeycard' -- Item Name

Config.ElectronicKitItem = 'electronickit' -- Item Name

Config.FbiServerusb = 'fbiserverusb' -- Item Name

Config.FbiServerusb2 = 'fbiserverusb_2' -- Item Name

Config.encrypteddocument = 'encrypted_document' -- Item Name

Config.GoodsPrice  = {
    { item = "fbi_laptop_1", price = 200 }, 
    { item = "fbi_laptop_2", price = 200 },
    { item = "fbi_laptop_3", price = 300 },
    { item = "fbi_laptop_4", price = 350 },
    { item = "fbi_laptop_5", price = 400 },
    { item = "datadrive", price = 1000 },
    { item = "stolencomputer", price = 1500 },
    { item = "fbidoc", price = 4000 },
    {item = "fbiserverusb", price = 5000},
    {item = "fbiserverusb_2", price = 5000},
}

Config.RandomItems = {
    'datadrive',
    'fbidoc',
    'stolencomputer',
    'fbi_laptop_1',
    'fbi_laptop_2',
    'fbi_laptop_3',
    'fbi_laptop_4',
    'fbi_laptop_5',
}

-------------------
--Target
-------------------

Config.Target = 'qb-target'

Config.PolyZone = false -- Do You Want To Use PolyZone?

Config.Distance = 1.2

Config.HeLabel = 'מה צריך כסף?'

Config.Label = 'Start Rob'

Config.Icon = 'fa-solid fa-sack-dollar'

Config.SecurityIcon = 'fab fa-usb'

Config.SecurityLabel = 'Disable Security'

Config.HackIcon = 'fa-solid fa-server'

Config.HackLabel = 'Hack To FBI Server'

Config.LesterIcon = 'fa fa-laptop'

Config.LesterLabel = 'Talk To Lester'

Config.StartLabel = 'Start Robbery'

Config.StartIcon = 'fa fa-laptop'

Config.ElevatorupIcon = 'fa-solid fa-elevator'

Config.ElevatorupLabel = 'Go Up'

Config.ElevatorDownIcon = 'fa-solid fa-elevator'

Config.ElevatorDownLabel = 'Go Down'

Config.RobLocations = {
    [1] = {
        ['coords'] = vector3(120.98, -745.55, 242.15),
        ['heading'] = 340,
        ['minZ'] = 241.15,
        ['maxZ'] = 243.15,
        ['poly1'] = 2,
        ['poly2'] = 0.5,
        ['isOpened'] = false,
        ['isBusy'] = false,
    }, 
    [2] = {
        ['coords'] = vector3(119.55, -753.32, 242.15),
        ['heading'] = 340,
        ['minZ'] = 241.15,
        ['maxZ'] = 243.15,
        ['poly1'] = 2,
        ['poly2'] = 0.5,
        ['isOpened'] = false,
        ['isBusy'] = false, 
    },
    [3] = {
        ['coords'] = vector3(110.81, -737.32, 242.15),
        ['heading'] = 340,
        ['minZ'] = 241.15,
        ['maxZ'] = 243.15,
        ['poly1'] = 4,
        ['poly2'] = 3,
        ['isOpened'] = false,
        ['isBusy'] = false, 
    },
    [4] = {
        ['coords'] = vector3(122.42, -768.58, 242.15),
        ['heading'] = 340,
        ['minZ'] = 241.15,
        ['maxZ'] = 243.15,
        ['poly1'] = 0.5,
        ['poly2'] = 1,
        ['isOpened'] = false,
        ['isBusy'] = false, 
    },
    [5] = {
        ['coords'] = vector3(123.25, -766.56, 242.15),
        ['heading'] = 340,
        ['minZ'] = 241.15,
        ['maxZ'] = 243.15,
        ['poly1'] = 0.5,
        ['poly2'] = 1.5,
        ['isOpened'] = false,
        ['isBusy'] = false,
    }, 
    [6] = {
        ['coords'] = vector3(118.45, -765.35, 242.15),
        ['heading'] = 340,
        ['minZ'] = 241.15,
        ['maxZ'] = 243.15,
        ['poly1'] = 3,
        ['poly2'] = 4,
        ['isOpened'] = false,
        ['isBusy'] = false, 
    },
    [7] = {
        ['coords'] = vector3(112.88, -760.18, 242.15),
        ['heading'] = 340,
        ['minZ'] = 241.15,
        ['maxZ'] = 243.15,
        ['poly1'] = 3,
        ['poly2'] = 3,
        ['isOpened'] = false,
        ['isBusy'] = false, 
    },
    [8] = {
        ['coords'] = vector3(143.17, -754.54, 242.15),
        ['heading'] = 340,
        ['minZ'] = 241.15,
        ['maxZ'] = 243.15,
        ['poly1'] = 2,
        ['poly2'] = 0.5,
        ['isOpened'] = false,
        ['isBusy'] = false, 
    },
    [9] = {
        ['coords'] = vector3(144.16, -751.96, 242.15),
        ['heading'] = 340,
        ['minZ'] = 241.15,
        ['maxZ'] = 243.15,
        ['poly1'] = 2,
        ['poly2'] = 0.5,
        ['isOpened'] = false,
        ['isBusy'] = false,
    }, 
    [10] = {
        ['coords'] = vector3(146.99, -744.35, 242.15),
        ['heading'] = 340,
        ['minZ'] = 241.15,
        ['maxZ'] = 243.15,
        ['poly1'] = 2,
        ['poly2'] = 0.5,
        ['isOpened'] = false,
        ['isBusy'] = false, 
    },
}

-------------------
--Guards
-------------------

Config.Guards = {
    [1] = {
        Coords = vector4(131.00994, -765.723, 242.15205, 277.68093),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'WEAPON_CARBINERIFLE',
        Health = 300,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [2] = {
        Coords = vector4(124.26593, -768.1474, 242.15213, 9.7871789),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'WEAPON_CARBINERIFLE',
        Health = 300,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [3] = {
        Coords = vector4(109.3328, -751.8563, 242.15213, 265.48962),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'WEAPON_CARBINERIFLE',
        Health = 300,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [4] = {
        Coords = vector4(117.83177, -739.4479, 242.15213, 175.59205),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'WEAPON_CARBINERIFLE',
        Health = 300,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [5] = {
        Coords = vector4(121.71005, -728.2332, 242.15197, 194.30897),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'WEAPON_CARBINERIFLE',
        Health = 300,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [6] = {
        Coords = vector4(125.8226, -729.3143, 242.15197, 52.916709),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'WEAPON_CARBINERIFLE',
        Health = 300,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [7] = {
        Coords = vector4(118.72141, -758.0222, 242.15222, 238.89242),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'WEAPON_CARBINERIFLE',
        Health = 300,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [8] = {
        Coords = vector4(124.93055, -744.9186, 242.15211, 183.78738),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'WEAPON_CARBINERIFLE',
        Health = 300,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [9] = {
        Coords = vector4(147.88691, -747.9465, 242.15202, 170.71759),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'WEAPON_CARBINERIFLE',
        Health = 300,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [10] = {
        Coords = vector4(139.86961, -768.8193, 242.15206, 348.91241),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'WEAPON_CARBINERIFLE',
        Health = 300,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
}

-------------------
--Menu
-------------------

Config.Header = "Lester"

Config.HeaderText = "Wanna Do A FBI Heist?:"

Config.SecondHeader = "FBI Heist Information"

Config.ThirdHeader = "Sell FBI Heist Goods"


-------------------
--Wearhouse Prep
-------------------

Config.PedLocations = {{coords = vector4(50.153652, -1453.582, 29.311267, 41.357028)}}

Config.Location = vector2(-619.1347, -1111.606)

Config.NextRob = 3600 -- cooldown time in seconds

Config.price = math.random(100, 1500) -- price for the mission

Config.WearhouseGuards = { -- Guards that will spawn when you enter the warehouse
    [1] = {
        Coords = vector4(1065.4816, -3098.65, -38.99997, 83.484916),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'weapon_assaultrifle',
        Health = 3000,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [2] = {
        Coords = vector4(1070.9224, -3102.998, -38.99989, 93.795783),
        Ped = 'ig_fbisuit_01',
        Weapon = 'weapon_assaultrifle',
        Health = 3000,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [3] = {
        Coords = vector4(1066.7031, -3105.46, -38.99989, 88.580047),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'weapon_assaultrifle',
        Health = 3000,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [4] = {
        Coords = vector4(1061.1594, -3105.221, -38.99991, 90.819084),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'weapon_assaultrifle',
        Health = 3000,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [5] = {
        Coords = vector4(1055.7537, -3105.133, -38.9999, 89.413131),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'weapon_assaultrifle',
        Health = 3000,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
    [6] = {
        Coords = vector4(1050.5527, -3103.569, -38.99989, 4.6315765),
        Ped = 'mp_m_fibsec_01',
        Weapon = 'weapon_assaultrifle',
        Health = 3000,
        Accuracy = 60,
        Alertness = 3,
        Aggresiveness = 3,
    },
}
