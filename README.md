# cv-fbi-robbery

**Free open source FiveM QBCore fbi robbery**
# Preview
[CV-Fbi-Robbery](https://www.youtube.com/watch?v=ZIFlmk94rNE)

# Dependencies:
* QBCore Framework
* mhacking
* memorygame
* var hack

# Installation

1 - Add Minigames 

2 - Add items:
go to "qb-core" then shared folder > items.lua and add this : 

```lua
  --FBI Robbery--
	['fbikeycard'] 		 		 	 = {['name'] = 'FbiKeycard', 					['label'] = 'FbiKeycard', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'fbi_keycard_green.png', 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'fbi keycard'},
	['datadrive'] 		 		 	 = {['name'] = 'datadrive', 					['label'] = 'datadrive', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'datadrive.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'datadrive'},
	['fbidoc'] 			             = {['name'] = 'fbidoc', 				        ['label'] = 'fbiDocument', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'fbidco.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A FBI document'},
	['stolencomputer'] 		 		 = {['name'] = 'stolencomputer', 				['label'] = 'stolencomputer', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'stolencomputer.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'stolencomputer'},
	['fbi_laptop_1'] 		 		 = {['name'] = 'fbi_laptop_1', 					['label'] = 'fbi laptop 1', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'fbi_laptop_1.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'FBI laptop'},
	['fbi_laptop_2'] 		 		 = {['name'] = 'fbi_laptop_2', 					['label'] = 'fbi laptop 2', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'fbi_laptop_2.png', 		['unique'] = false, 	['useable'] = true,		['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'FBI laptop'},
	['fbi_laptop_3'] 		 		 = {['name'] = 'fbi_laptop_3', 					['label'] = 'fbi laptop 3', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'fbi_laptop_3.png', 		['unique'] = false, 	['useable'] = true,		['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'FBI laptop'},
	['fbi_laptop_4'] 		 		 = {['name'] = 'fbi_laptop_4', 					['label'] = 'fbi laptop 4', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'fbi_laptop_4.png', 		['unique'] = false, 	['useable'] = true,		['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'FBI laptop'},
	['fbi_laptop_5'] 		 		 = {['name'] = 'fbi_laptop_5', 					['label'] = 'fbi laptop 5', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'fbi_laptop_5.png', 		['unique'] = false, 	['useable'] = true,		['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'FBI laptop'},
	['fbiserverusb'] 		 		 = {['name'] = 'fbiserverusb', 					['label'] = 'FBI SERVER USB Data', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'fbiserverusb.png', 		['unique'] = false, 	['useable'] = true,		['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'FBI laptop'},
	['fbiserverusb_2'] 		 		 = {['name'] = 'fbiserverusb_2', 				['label'] = 'FBI SERVER USB Data', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'fbiserverusb2.png', 		['unique'] = false, 	['useable'] = true,		['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'FBI laptop'},
	['encrypted_document'] 		 	 = {['name'] = 'encrypted_document', 			['label'] = ' FBI encrypted document', 	['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'np_documents.png', 		['unique'] = false, 	['useable'] = true,		['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'FBI encrypted document'},
	['electronickit'] 				 = {['name'] = 'electronickit', 			  	['label'] = 'Electronic Kit', 			['weight'] = 100, 		['type'] = 'item', 		['image'] = 'electronickit.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = {accept = {'gatecrack'}, reward = 'trojan_usb', anim = nil}, ['description'] = 'If you\'ve always wanted to build a robot you can maybe start here. Maybe you\'ll be the new Elon Musk?'},

	---prep---
	['wearhousecard'] 					 = {['name'] = 'wearhousecard', 			 	  	  	['label'] = 'FBI Card', 		['weight'] = 100, 		['type'] = 'item', 		['image'] = 'np_exec_card.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Wear house card', ['created'] = nil, ['decay'] = 28.0},
```
}

3 - Add images to inventory
here you have images folder copy the images inside that folder and put it inside "qb-inventory"

4 - Enjoy
# CREDITS:
* [NaorShabtai](https://github.com/NaorShabtai)
* [royyalbert](https://github.com/royyalbert)
* [CoreVersion](https://discord.gg/nKzaJhMkVa0)

