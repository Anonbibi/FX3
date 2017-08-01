--[[Register]]--

RegisterNetEvent('stores:FinishMoneyCheckForVeh')
RegisterNetEvent('vehshop:spawnVehicle')



--[[Local/Global]]--

local vehshop = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.9,
		y = 0.08,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Motorcycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Compacts", description = ''},
				{name = "Coupes", description = ''},
				{name = "Sedans", description = ''},
				{name = "Sports", description = ''},
				{name = "Sports Classics", description = ''},
				{name = "Super", description = ''},
				{name = "Muscle", description = ''},
				{name = "Off-Road", description = ''},
				{name = "SUVs", description = ''},
				{name = "Vans", description = ''},
				{name = "Cycles", description = ''},
				{name = "DLC", description = ''},
				--{name = "Modes", description = ''},
			}
		},
		["dlc"] = {
			title = "dlc",
			name = "dlc",
			buttons = {
				--{name = "Apc", costs = 0, description = {}, model = "apc"},
				{name = "Ardent", costs = 0, description = {}, model = "ardent"},
				{name = "Caddy3", costs = 0, description = {}, model = "caddy3"},
				{name = "Cheetah 2", costs = 0, description = {}, model = "cheetah2"},
				{name = "Dune 3", costs = 0, description = {}, model = "dune3"},
				{name = "Half Track", costs = 0, description = {}, model = "halftrack"},
				--{name = "Hauler 2", costs = 0, description = {}, model = "hauler2"},
				{name = "Insurgent 3", costs = 0, description = {}, model = "insurgent3"},
				{name = "Nightshark", costs = 0, description = {}, model = "nightshark"},
				{name = "Oppressor", costs = 0, description = {}, model = "oppressor"},
				{name = "Phantom 3", costs = 0, description = {}, model = "phantom3"},
				{name = "Tampa 3", costs = 0, description = {}, model = "tampa3"},
				{name = "Technical 3", costs = 0, description = {}, model = "technical3"},
				{name = "Torero", costs = 0, description = {}, model = "torero"},
				{name = "Trailerlarge", costs = 0, description = {}, model = "trailerlarge"},
				{name = "Trailers4", costs = 0, description = {}, model = "trailers4"},
				{name = "Vagner", costs = 0, description = {}, model = "vagner"},
				{name = "XA 21", costs = 0, description = {}, model = "xa21"},
				{name = "Dune", costs = 0, description = {}, model = "rallytruck"},
				{name = "Desert Raid", costs = 0, description = {}, model = "trophytruck2"},
				{name = "Trophy Truck", costs = 0, description = {}, model = "trophytruck"},
				{name = "Contender", costs = 0, description = {}, model = "contender"},
				{name = "Rumpo Custom", costs = 0, description = {}, model = "rumpo3"},
				{name = "Brickade", costs = 0, description = {}, model = "brickade"},
				{name = "P Fister 811", costs = 0, description = {}, model = "pfister811"},
				{name = "Fmj", costs = 0, description = {}, model = "fmj"},
				{name = "Seven 70", costs = 0, description = {}, model = "seven70"},
				{name = "Nimbus", costs = 0, description = {}, model = "nimbus"},
				{name = "Virgo Classic", costs = 0, description = {}, model = "virgo3"},
				{name = "Virgo Classic Custom", costs = 0, description = {}, model = "virgo2"},
				{name = "Tornado Custom", costs = 0, description = {}, model = "tornado5"},
				{name = "Slamvan Custom", costs = 0, description = {}, model = "slamvan3"},
				{name = "Sabre Turbo Custom", costs = 0, description = {}, model = "sabregt2"},
				{name = "Minivan Custom", costs = 0, description = {}, model = "minivan2"},
				{name = "Faction Custom Donk", costs = 0, description = {}, model = "faction3"},
				{name = "Roosevelt Valor", costs = 0, description = {}, model = "btype3"},
				{name = "Baller LE LWB", costs = 0, description = {}, model = "baller4"},
				{name = "Baller LE", costs = 0, description = {}, model = "baller3"},
				{name = "Cognoscenti 55", costs = 0, description = {}, model = "cog55"},
				{name = "Schafter LWB", costs = 0, description = {}, model = "schafter4"},
				{name = "Mamba", costs = 0, description = {}, model = "mamba"},
				{name = "Franken Stange", costs = 0, description = {}, model = "btype2"},
				{name = "Zombie Harse", costs = 0, description = {}, model = "lurcher"},
				{name = "Voodoo Custom", costs = 0, description = {}, model = "voodoo"},
				{name = "Buuccaneer Custom", costs = 0, description = {}, model = "buccaneer2"},
				{name = "Chino Custom", costs = 0, description = {}, model = "chino2"},
				{name = "Faction Custom", costs = 0, description = {}, model = "faction2"},
				{name = "Moonbeam", costs = 0, description = {}, model = "moonbeam"},
				{name = "Moonbeam Custom", costs = 0, description = {}, model = "moonbeam2"},
				{name = "Sanctus", costs = 950000, description = {}, model = "sanctus"},
				{name = "Tornado 6", costs = 1400000, description = {}, model = "tornado6"},
				{name = "Faggio 3", costs = 5500, description = {}, model = "faggio3"},
				{name = "Vortex", costs = 400000, description = {}, model = "vortex"},
				{name = "Avarus", costs = 900000, description = {}, model = "avarus"},
				{name = "Youga 2", costs = 800000, description = {}, model = "youga2"},
				{name = "Hakuchou 2", costs = 450000, description = {}, model = "hakuchou2"},
				{name = "Nightblade", costs = 130000, description = {}, model = "nightblade"},
				{name = "Chimera", costs = 600000, description = {}, model = "chimera"},
				{name = "Esskey", costs = 140000, description = {}, model = "esskey"},
				{name = "Wolfsbane", costs = 120000, description = {}, model = "wolfsbane"},
				{name = "Zombie A", costs = 120000, description = {}, model = "zombiea"},
				{name = "Zombie B", costs = 120000, description = {}, model = "zombieb"},
				{name = "Defiler", costs = 260000, description = {}, model = "defiler"},
				{name = "Daemon 2", costs = 130000, description = {}, model = "daemon2"},
				{name = "Ratbike", costs = 120000, description = {}, model = "ratbike"},
				{name = "Shotaro", costs = 800000, description = {}, model = "shotaro"},
				{name = "Manchez", costs = 350000, description = {}, model = "manchez"},
				{name = "Blazer 4", costs = 200000, description = {}, model = "blazer4"},
				{name = "Kalahari", costs = 190000, description = {}, model = "kalahari"},
				--{name = "Speeder", costs = 0, description = {}, model = "speeder"},
				{name = "Btype", costs = 1600000, description = {}, model = "btype"},
				--{name = "Vestra", costs = 0, description = {}, model = "vestra"}, avion
				--{name = "Besra", costs = 0, description = {}, model = "besra"}, avion
				--{name = "Miljet", costs = 0, description = {}, model = "miljet"}, jet
				--{name = "Swift", costs = 0, description = {}, model = "swift"}, helico
				{name = "Ratloader2", costs = 1750000, description = {}, model = "ratloader2"},
				--{name = "Mule 3", costs = 0, description = {}, model = "mule3"}, camion
				--{name = "Velum 2", costs = 0, description = {}, model = "velum2"}, avion
				-- {name = "Tanker 2", costs = 0, description = {}, model = "tanker2"}, remorque essence
				{name = "Gburrito 2", costs = 700000, description = {}, model = "gburrito2"},
				--{name = "Technical", costs = 0, description = {}, model = "technical"},
				--{name = "Savage", costs = 0, description = {}, model = "savage"},
				{name = "Guardian", costs = 800000, description = {}, model = "guardian"},
				--{name = "Trash 2", costs = 0, description = {}, model = "trash2"}, camion poubelle
				--{name = "Barracks3", costs = 0, description = {}, model = "barrack3"},
				{name = "Slamvan 2", costs = 1750000, description = {}, model = "slamvan2"},
				--{name = "Swift 2", costs = 0, description = {}, model = "swift2"},helico
				--{name = "Luxor 2", costs = 0, description = {}, model = "luxor"},jet privé
				--{name = "Toro", costs = 0, description = {}, model = "toro"}, bateaux
				{name = "Dukes 2", costs = 6000000, description = {}, model = "dukes2"},
				{name = "Buffalo 3 RACE", costs = 2200000, description = {}, model = "buffalo3"},
				{name = "Dominator 2 RACE", costs = 2200000, description = {}, model = "dominator2"},
				--{name = "Dodo", costs = 0, description = {}, model = "dodo"}, avion
				{name = "Marshall RACE", costs = 4000000, description = {}, model = "marshall"},
				--{name = "Blimp 2", costs = 0, description = {}, model = "blimp2"}, mongolfier
				{name = "Gauntlet 2 RACE", costs = 2200000, description = {}, model = "gauntlet2"},
				{name = "Stalion", costs = 110000, description = {}, model = "stalion"},
				{name = "Stalion 2 RACE", costs = 2200000, description = {}, model = "stalion2"},
				{name = "Blista 2", costs = 48000, description = {}, model = "blista2"},
				{name = "Blista 3", costs = 54000, description = {}, model = "blista3"},

				{name = "Elegy", costs = 300000, description = {}, model = "elegy"},
				{name = "Slamvan", costs = 300000, description = {}, model = "slamvan"},
				{name = "Tempesta", costs = 1000000, description = {}, model = "tempesta"},
				{name = "Itali GTB", costs = 980000, description = {}, model = "italigtb"},
				{name = "Itali GTB Custom", costs = 1400000, description = {}, model = "italigtb2"},
				{name = "Nero", costs = 1200000, description = {}, model = "nero"},
				{name = "Nero Custom", costs = 1800000, description = {}, model = "nero2"},
				{name = "Specter", costs = 1200000, description = {}, model = "specter"},
				{name = "Specter Custom", costs = 1800000, description = {}, model = "specter2"},
				{name = "Diabolus", costs = 130000, description = {}, model = "diablous"},
				{name = "Diabolus Custom", costs = 500000, description = {}, model = "diablous2"},
				{name = "Blazer Aqua", costs = 1000000, description = {}, model = "blazer5"},
				{name = "Ruiner 2000", costs = 900000, description = {}, model = "ruiner2"},
				--{name = "Ruiner 3000", costs = 2000000, description = {}, model = "ruiner3"},
				{name = "Dune 4 RACE", costs = 2200000, description = {}, model = "dune4"},
				{name = "Dune 5 RACE", costs = 2200000, description = {}, model = "dune5"},
				{name = "Phantom 2 RACE", costs = 2200000, description = {}, model = "voltic2"},
				{name = "Penetrator", costs = 1400000, description = {}, model = "penetrator"},
				--{name = "Box ville 5", costs = 30000000, description = {}, model = "boxville5"},
				--{name = "Wastelander", costs = 30000000, description = {}, model = "wastelander"},
				--{name = "Technical 2", costs = 0, description = {}, model = "technical2"},
				{name = "FCR 1000", costs = 90000, description = {}, model = "fcr"},
				{name = "FCR 1000 Custom", costs = 125000, description = {}, model = "fcr2"},
				{name = "Comet Retro Custom", costs = 1700000, description = {}, model = "comet3"},
				{name = "Turismo 2", costs = 1600000, description = {}, model = "turismo2"},
				{name = "Infernus 2", costs = 1800000, description = {}, model = "infernus2"},
				{name = "GP 1", costs = 1550000, description = {}, model = "gp1"},
				{name = "Ruston", costs = 1750000, description = {}, model = "ruston"},


			}
		},
		-- ["modes"] = {
		-- 	title = "modes",
		-- 	name = "modes",
		-- 	buttons = {
		-- 		--{name = "205 T16 1", costs = 0, description = {}, model = "yPG205t16A"},
		-- 		--{name = "205 T16 2", costs = 0, description = {}, model = "yPG205t16B"},
		-- 		{name = "Cabrio", costs = 150000, description = {}, model = "2fiftygt"},
		-- 		{name = "Impreza", costs = 250000, description = {}, model = "22bbublu"},
		-- 		{name = "Mercedes 300GSL", costs = 320000, description = {}, model = "300gsl"},
		-- 		{name = "Lambo Diablo", costs = 1800000, description = {}, model = "500gtrlam"},
		-- 		{name = "Porche 911 RACE", costs = 5000000, description = {}, model = "911ublu"},
		-- 		{name = "Aston Martin V12", costs = 1400000, description = {}, model = "amv12"},
		-- 		{name = "Cadillac", costs = 420000, description = {}, model = "cadicts"},
		-- 		{name = "Porche Cayman", costs = 1400000, description = {}, model = "caymanub"},
		-- 		{name = "Toyota Celica", costs = 300000, description = {}, model = "celicassi"},
		-- 		{name = "Toyota Celica GT", costs = 800000, description = {}, model = "celicassi2"},
		-- 		{name = "Buffalo", costs = 190000, description = {}, model = "charublu"},
		-- 		{name = "Shelby Cobra", costs = 1200000, description = {}, model = "cobra"},
		-- 		{name = "Aston Martin DB 700", costs = 220000, description = {}, model = "db700"},
		-- 		{name = "Ferrari F50", costs = 2300000, description = {}, model = "f50ub"},
		-- 		{name = "Ferrari F360", costs = 1700000, description = {}, model = "f360"},
		-- 		{name = "Ford Focus", costs = 250000, description = {}, model = "focusublu"},
		-- 		{name = "Mazda RACE", costs = 2200000, description = {}, model = "furaiub"},
		-- 		{name = "Infity", costs = 550000, description = {}, model = "g37cs"},
		-- 		{name = "Lambo Gallardo", costs = 1750000, description = {}, model = "gallardo"},
		-- 		{name = "Hunday", costs = 300000, description = {}, model = "genublu"},
		-- 		{name = "Jeep Escalade", costs = 200000, description = {}, model = "gmt900escalade"},
		-- 		{name = "Ferrari GTBF", costs = 1900000, description = {}, model = "gtbf"},
		-- 		{name = "Nissan GTR", costs = 700000, description = {}, model = "gtrublu"},
		-- 		{name = "Ferrari", costs = 1800000, description = {}, model = "laferublu"},
		-- 		{name = "Lambo Aventado", costs = 2000000, description = {}, model = "lamven"},
		-- 		{name = "Lotus Esprit", costs = 1400000, description = {}, model = "lev8"},
		-- 		{name = "Lambo Diablo", costs = 1650000, description = {}, model = "lh610"},
		-- 		{name = "Maclaren", costs = 1750000, description = {}, model = "mcublu"},
		-- 		{name = "Mini cooper", costs = 350000, description = {}, model = "miniub"},
		-- 		{name = "Lambo Miura", costs = 2300000, description = {}, model = "miura"},
		-- 		{name = "Ford Mustang", costs = 400000, description = {}, model = "musty5"},
		-- 		{name = "Mazda MX5", costs = 400000, description = {}, model = "mx5"},
		-- 		{name = "Mazda MX5 2", costs = 400000, description = {}, model = "mx5a"},
		-- 		{name = "Peugeot 107", costs = 100000, description = {}, model = "p107"},
		-- 		{name = "Porche 550", costs = 2400000, description = {}, model = "p550a"},
		-- 		{name = "Porche 944", costs = 1800000, description = {}, model = "p944"},
		-- 		{name = "Porche 959", costs = 1600000, description = {}, model = "p959"},
		-- 		{name = "Porche Panamera", costs = 1400000, description = {}, model = "panamera"},
		-- 		{name = "Mégane RS", costs = 300000, description = {}, model = "renmeg"},
		-- 		{name = "Peugeot RCZ", costs = 300000, description = {}, model = "rczublu"},
		-- 		{name = "Mazda RX7 RACE", costs = 2200000, description = {}, model = "rx7tunable"},
		-- 		{name = "Mazda RX7 2 RACE", costs = 2200000, description = {}, model = "rx7tunable2"},
		-- 		{name = "Mazda RX8", costs = 300000, description = {}, model = "rx8"},
		-- 		{name = "Mercedes SLR", costs = 2400000, description = {}, model = "slrublu"},
		-- 		{name = "Mercedes SLS", costs = 2200000, description = {}, model = "slsublu"},
		-- 		{name = "Impreza STI", costs = 250000, description = {}, model = "sti05"},
		-- 		{name = "Tesla 1", costs = 500000, description = {}, model = "tesla11"},
		-- 		{name = "Pontiac", costs = 400000, description = {}, model = "vc7"},
		-- 		{name = "Viper", costs = 1500000, description = {}, model = "vip99"},
		-- 		{name = "Golf 5", costs = 300000, description = {}, model = "volksci11"},
		-- 		{name = "BMW Z4i", costs = 600000, description = {}, model = "z4i"},
		-- 		{name = "Corvette", costs = 400000, description = {}, model = "zr1c3"},
		-- 	}
		-- },
		["compacts"] = {
			title = "compacts",
			name = "compacts",
			buttons = {
				{name = "Blista", costs = 20000, description = {}, model = "blista"},
				{name = "Brioso R/A", costs = 28000, description = {}, model = "brioso"},
				{name = "Dilettante", costs = 25000, description = {}, model = "Dilettante"},
				{name = "Issi", costs = 32000, description = {}, model = "issi2"},
				{name = "Panto", costs = 18000, description = {}, model = "panto"},
				{name = "Prairie", costs = 36000, description = {}, model = "prairie"},
				{name = "Rhapsody", costs = 20000, description = {}, model = "rhapsody"},
			}
		},
		["coupes"] = {
			title = "coupes",
			name = "coupes",
			buttons = {
				{name = "Cognoscenti Cabrio", costs = 110000, description = {}, model = "cogcabrio"},
				{name = "Exemplar", costs = 108000, description = {}, model = "exemplar"},
				{name = "F620", costs = 106000, description = {}, model = "f620"},
				{name = "Felon", costs = 80000, description = {}, model = "felon"},
				{name = "Felon GT", costs = 93000, description = {}, model = "felon2"},
				{name = "Jackal", costs = 75000, description = {}, model = "jackal"},
				{name = "Oracle", costs = 87000, description = {}, model = "oracle"},
				{name = "Oracle XS", costs = 91000, description = {}, model = "oracle2"},
				{name = "Sentinel", costs = 89000, description = {}, model = "sentinel"},
				{name = "Sentinel XS", costs = 94000, description = {}, model = "sentinel2"},
				{name = "Windsor", costs = 97000, description = {}, model = "windsor"},
				{name = "Windsor Drop", costs = 110000, description = {}, model = "windsor2"},
				{name = "Zion", costs = 94000, description = {}, model = "zion"},
				{name = "Zion Cabrio", costs = 96000, description = {}, model = "zion2"},
			}
		},
		["sports"] = {
			title = "sports",
			name = "sports",
			buttons = {
				{name = "9F", costs = 650000, description = {}, model = "ninef"},
				{name = "9F Cabrio", costs = 700000, description = {}, model = "ninef2"},
				{name = "Alpha", costs = 430000, description = {}, model = "alpha"},
				{name = "Banshee", costs = 500000, description = {}, model = "banshee"},
				{name = "Bestia GTS", costs = 600000, description = {}, model = "bestiagts"},
				{name = "Blista Compact", costs = 30000, description = {}, model = "blista"},
				{name = "Buffalo", costs = 68000, description = {}, model = "buffalo"},
				{name = "Buffalo S", costs = 76000, description = {}, model = "buffalo2"},
				{name = "Carbonizzare", costs = 850000, description = {}, model = "carbonizzare"},
				{name = "Comet", costs = 640000, description = {}, model = "comet2"},
				{name = "Coquette", costs = 780000, description = {}, model = "coquette"},
				{name = "Drift Tampa RACE", costs = 2200000, description = {}, model = "tampa2"},
				{name = "Feltzer", costs = 900000, description = {}, model = "feltzer2"},
				{name = "Furore GT", costs = 750000, description = {}, model = "furoregt"},
				{name = "Fusilade", costs = 220000, description = {}, model = "fusilade"},
				{name = "Jester", costs = 850000, description = {}, model = "jester"},
				{name = "Jester(Racecar) RACE", costs = 2200000, description = {}, model = "jester2"},
				{name = "Kuruma", costs = 420000, description = {}, model = "kuruma"},
				{name = "Lynx", costs = 1000000, description = {}, model = "lynx"},
				{name = "Massacro", costs = 850000, description = {}, model = "massacro"},
				{name = "Massacro(Racecar) RACE", costs = 22000000, description = {}, model = "massacro2"},
				{name = "Omnis RACE", costs = 2200000, description = {}, model = "omnis"},
				{name = "Penumbra", costs = 77000, description = {}, model = "penumbra"},
				{name = "Rapid GT", costs = 440000, description = {}, model = "rapidgt"},
				{name = "Rapid GT Convertible", costs = 490000, description = {}, model = "rapidgt2"},
				{name = "Schafter V12", costs = 85000, description = {}, model = "schafter3"},
				{name = "Sultan", costs = 330000, description = {}, model = "sultan"},
				{name = "Surano", costs = 1100000, description = {}, model = "surano"},
				{name = "Tropos RACE", costs = 2200000, description = {}, model = "tropos"},
				{name = "Verkierer", costs = 600000, description = {}, model = "verlierer2"},
			}
		},
		["sportsclassics"] = {
			title = "sports classics",
			name = "sportsclassics",
			buttons = {
				{name = "Casco", costs = 750000, description = {}, model = "casco"},
				{name = "Coquette Classic", costs = 840000, description = {}, model = "coquette2"},
				{name = "JB 700", costs = 1400000, description = {}, model = "jb700"},
				{name = "Pigalle", costs = 60000, description = {}, model = "pigalle"},
				{name = "Stinger", costs = 1100000, description = {}, model = "stinger"},
				{name = "Stinger GT", costs = 1500000, description = {}, model = "stingergt"},
				{name = "Stirling GT", costs = 1500000, description = {}, model = "feltzer3"},
				{name = "Z-Type", costs = 2000000, description = {}, model = "ztype"},
			}
		},
		["super"] = {
			title = "super",
			name = "super",
			buttons = {
				{name = "Adder", costs = 1500000, description = {}, model = "adder"},
				{name = "Banshee 900R", costs = 1500000, description = {}, model = "banshee2"},
				{name = "Bullet", costs = 1400000, description = {}, model = "bullet"},
				{name = "Cheetah", costs = 2000000, description = {}, model = "cheetah"},
				{name = "Entity XF", costs = 2000000, description = {}, model = "entityxf"},
				{name = "ETR1 RACE", costs = 2200000, description = {}, model = "sheava"},
				{name = "FMJ", costs = 2100000, description = {}, model = "fmj"},
				{name = "Infernus", costs = 2000000, description = {}, model = "infernus"},
				{name = "Osiris", costs = 2750000, description = {}, model = "osiris"},
				{name = "RE-7B RACE", costs = 2200000, description = {}, model = "le7b"},
				{name = "Reaper", costs = 2000000, description = {}, model = "reaper"},
				{name = "Sultan RS", costs = 850000, description = {}, model = "sultanrs"},
				{name = "T20", costs = 2000000, description = {}, model = "t20"},
				{name = "Turismo R", costs = 2200000, description = {}, model = "turismor"},
				{name = "Tyrus RACE", costs = 2200000, description = {}, model = "tyrus"},
				{name = "Vacca", costs = 2000000, description = {}, model = "vacca"},
				{name = "Voltic", costs = 800000, description = {}, model = "voltic"},
				{name = "X80 Proto", costs = 5000000, description = {}, model = "prototipo"},
				{name = "Zentorno", costs = 2800000, description = {}, model = "zentorno"},
			}
		},
		["muscle"] = {
			title = "muscle",
			name = "muscle",
			buttons = {
				{name = "Blade", costs = 25000, description = {}, model = "blade"},
				{name = "Buccaneer", costs = 30000, description = {}, model = "buccaneer"},
				{name = "Chino", costs = 27000, description = {}, model = "chino"},
				{name = "Coquette BlackFin", costs = 100000, description = {}, model = "coquette3"},
				{name = "Dominator", costs = 70000, description = {}, model = "dominator"},
				{name = "Dukes", costs = 75000, description = {}, model = "dukes"},
				{name = "Gauntlet", costs = 82000, description = {}, model = "gauntlet"},
				{name = "Hotknife", costs = 650000, description = {}, model = "hotknife"},
				{name = "Faction", costs = 30500, description = {}, model = "faction"},
				{name = "Nightshade", costs = 75000, description = {}, model = "nightshade"},
				{name = "Picador", costs = 33000, description = {}, model = "picador"},
				{name = "Sabre Turbo", costs = 90000, description = {}, model = "sabregt"},
				{name = "Tampa", costs = 44000, description = {}, model = "tampa"},
				{name = "Virgo", costs = 41500, description = {}, model = "virgo"},
				{name = "Vigero", costs = 60500, description = {}, model = "vigero"},
			}
		},
		["offroad"] = {
			title = "off-road",
			name = "off-road",
			buttons = {
				{name = "Bifta", costs = 120000, description = {}, model = "bifta"},
				{name = "Blazer", costs = 12000, description = {}, model = "blazer"},
				{name = "Brawler", costs = 115000, description = {}, model = "brawler"},
				{name = "Bubsta 6x6", costs = 1200000, description = {}, model = "dubsta3"},
				{name = "Dune Buggy", costs = 15000, description = {}, model = "dune"},
				{name = "Rebel", costs = 90000, description = {}, model = "rebel2"},
				{name = "Sandking", costs = 100000, description = {}, model = "sandking"},
				{name = "The Liberator RACE", costs = 4000000, description = {}, model = "monster"},
				{name = "Trophy Truck RACE", costs = 2200000, description = {}, model = "trophytruck"},
			}
		},
		["suvs"] = {
			title = "suvs",
			name = "suvs",
			buttons = {
				{name = "Baller", costs = 65000, description = {}, model = "baller"},
				{name = "Cavalcade", costs = 70000, description = {}, model = "cavalcade"},
				{name = "Grabger", costs = 100000, description = {}, model = "granger"},
				{name = "Huntley S", costs = 110000, description = {}, model = "huntley"},
				{name = "Landstalker", costs = 58000, description = {}, model = "landstalker"},
				{name = "Radius", costs = 80000, description = {}, model = "radi"},
				{name = "Rocoto", costs = 85000, description = {}, model = "rocoto"},
				{name = "Seminole", costs = 60000, description = {}, model = "seminole"},
				{name = "XLS", costs = 105000, description = {}, model = "xls"},
			}
		},
		["vans"] = {
			title = "vans",
			name = "vans",
			buttons = {
				{name = "Bison", costs = 60000, description = {}, model = "bison"},
				{name = "Bobcat XL", costs = 44000, description = {}, model = "bobcatxl"},
				{name = "Gang Burrito", costs = 70000, description = {}, model = "gburrito"},
				{name = "Journey", costs = 20000, description = {}, model = "journey"},
				{name = "Minivan", costs = 55000, description = {}, model = "minivan"},
				{name = "Paradise", costs = 40000, description = {}, model = "paradise"},
				{name = "Rumpo", costs = 25000, description = {}, model = "rumpo"},
				{name = "Surfer", costs = 22000, description = {}, model = "surfer"},
				{name = "Youga", costs = 38000, description = {}, model = "youga"},
			}
		},
		["sedans"] = {
			title = "sedans",
			name = "sedans",
			buttons = {
				{name = "Asea", costs = 8000, description = {}, model = "asea"},
				{name = "Asterope", costs = 12000, description = {}, model = "asterope"},
				--{name = "Cognoscenti", costs = 1000000, description = {}, model = "cognoscenti"},
				--{name = "Cognoscenti(Armored)", costs = 1000000, description = {}, model = "cognoscenti2"},
				--{name = "Cognoscenti 55", costs = 1000000, description = {}, model = "cognoscenti3"},
				--{name = "Cognoscenti 55(Armored", costs = 1500000, description = {}, model = "ZENTORNO"},
				{name = "Fugitive", costs = 15000, description = {}, model = "fugitive"},
				{name = "Glendale", costs = 11000, description = {}, model = "glendale"},
				{name = "Ingot", costs = 7000, description = {}, model = "ingot"},
				{name = "Intruder", costs = 28000, description = {}, model = "intruder"},
				{name = "Premier", costs = 13500, description = {}, model = "premier"},
				{name = "Primo", costs = 14000, description = {}, model = "primo"},
				{name = "Primo Custom", costs = 19000, description = {}, model = "primo2"},
				{name = "Regina (Voiture sans permis)", costs = 3500, description = {}, model = "regina"},
				{name = "Schafter", costs = 42000, description = {}, model = "schafter2"},
				{name = "Stanier", costs = 16000, description = {}, model = "stanier"},
				{name = "Stratum", costs = 20000, description = {}, model = "stratum"},
				{name = "Stretch", costs = 3000000, description = {}, model = "stretch"},
				{name = "Super Diamond", costs = 82000, description = {}, model = "superd"},
				{name = "Surge", costs = 32000, description = {}, model = "surge"},
				{name = "Tailgater", costs = 70000, description = {}, model = "tailgater"},
				{name = "Warrener", costs = 17000, description = {}, model = "warrener"},
				{name = "Washington", costs = 25000, description = {}, model = "washington"},
			}
		},
		["motorcycles"] = {
			title = "MOTORCYCLES",
			name = "motorcycles",
			buttons = {
				{name = "Akuma", costs = 65000, description = {}, model = "AKUMA"},
				{name = "Bagger", costs = 30000, description = {}, model = "bagger"},
				{name = "Bati 801", costs = 250000, description = {}, model = "bati"},
				{name = "Bati 801RR RACE", costs = 2200000, description = {}, model = "bati2"},
				{name = "BF400", costs = 130000, description = {}, model = "bf400"},
				{name = "Carbon RS", costs = 250000, description = {}, model = "carbonrs"},
				{name = "Cliffhanger", costs = 105000, description = {}, model = "cliffhanger"},
				{name = "Daemon", costs = 30000, description = {}, model = "daemon"},
				{name = "Double T", costs = 250000, description = {}, model = "double"},
				{name = "Enduro", costs = 250000, description = {}, model = "enduro"},
				{name = "Faggio (Sans permis)", costs = 2000, description = {}, model = "faggio2"},
				{name = "Gargoyle", costs = 90000, description = {}, model = "gargoyle"},
				{name = "Hakuchou", costs = 220000, description = {}, model = "hakuchou"},
				{name = "Hexer", costs = 43000, description = {}, model = "hexer"},
				{name = "Innovation", costs = 95000, description = {}, model = "innovation"},
				{name = "Lectro", costs = 160000, description = {}, model = "lectro"},
				{name = "Nemesis", costs = 170000, description = {}, model = "nemesis"},
				{name = "PCJ-600", costs = 22000, description = {}, model = "pcj"},
				{name = "Ruffian", costs = 210880, description = {}, model = "ruffian"},
				{name = "Sanchez", costs = 350000, description = {}, model = "sanchez"},
				{name = "Sovereign", costs = 110000, description = {}, model = "sovereign"},
				{name = "Thrust", costs = 200000, description = {}, model = "thrust"},
				{name = "Vader", costs = 190000, description = {}, model = "vader"},
				{name = "Vindicator", costs = 250000, description = {}, model = "vindicator"},
			}
		},
	}
}

local fakecar = {model = '', car = nil}
local vehshop_locations = {{entering = {-33.803,-1102.322,25.422}, inside = {-46.56327,-1097.382,25.99875, 120.1953}, outside = {-31.849,-1090.648,25.998,322.345}}}
local vehshop_blips ={}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false
local vehicle_price = 0
local backlock = false
local firstspawn = 0



--[[Functions]]--

function LocalPed()
	return GetPlayerPed(-1)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

function ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Concessionnaire')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(vehshop_blips, {blip = blip, pos = loc})
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(0)
				local inrange = false
				for i,b in ipairs(vehshop_blips) do
					DrawMarker(1,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
					if vehshop.opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and  GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(LocalPed())) < 5 then
						drawTxt('Appuyer sur ~g~Entrée~s~ pour accéder au menu d\'achat',0,1,0.5,0.8,0.6,255,255,255,255)
						currentlocation = b
						inrange = true
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

function f(n)
	return n + 0.0001
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	local ped = LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])
	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

function CloseCreator(name, veh, price)
	Citizen.CreateThread(function()
		local ped = LocalPed()
		if not boughtcar then
			local pos = currentlocation.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		else
			local name = name
			local vehicle = veh
			local price = price
			local veh = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(veh)
			local colors = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))

			local mods = {}
			for i = 0,24 do
				mods[i] = GetVehicleMod(veh,i)
			end
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
			local pos = currentlocation.pos.outside

			FreezeEntityPosition(ped,false)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
			SetModelAsNoLongerNeeded(model)
			for i,mod in pairs(mods) do
				SetVehicleModKit(personalvehicle,0)
				SetVehicleMod(personalvehicle,i,mod)
			end
			SetVehicleOnGroundProperly(personalvehicle)
			local plate = GetVehicleNumberPlateText(personalvehicle)
			SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
			local id = NetworkGetNetworkIdFromEntity(personalvehicle)
			SetNetworkIdCanMigrate(id, true)
			Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
			SetVehicleColours(personalvehicle,colors[1],colors[2])
			SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
			TaskWarpPedIntoVehicle(GetPlayerPed(-1),personalvehicle,-1)
			SetEntityVisible(ped,true)
			local primarycolor = colors[1]
			local secondarycolor = colors[2]
			local pearlescentcolor = extra_colors[1]
			local wheelcolor = extra_colors[2]
			TriggerServerEvent('stores:BuyForVeh', name, vehicle, price, plate, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
	DrawText(0.365, 0.934)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end

function drawMenuTitle(txt,x,y)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function DoesPlayerHaveVehicle(model,button,y,selected)
		local t = false
		--TODO:check if player own car
		if t then
			drawMenuRight("OWNED",vehshop.menu.x,y,selected)
		else
			drawMenuRight(button.costs.."$",vehshop.menu.x,y,selected)
		end
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		elseif btn == "Motorcycles" then
			OpenMenu('motorcycles')
		end
	elseif this == "vehicles" then
		if btn == "Sports" then
			OpenMenu('sports')
		elseif btn == "Sedans" then
			OpenMenu('sedans')
		elseif btn == "Compacts" then
			OpenMenu('compacts')
		elseif btn == "Coupes" then
			OpenMenu('coupes')
		elseif btn == "Sports Classics" then
			OpenMenu("sportsclassics")
		elseif btn == "Super" then
			OpenMenu('super')
		elseif btn == "Muscle" then
			OpenMenu('muscle')
		elseif btn == "Off-Road" then
			OpenMenu('offroad')
		elseif btn == "SUVs" then
			OpenMenu('suvs')
		elseif btn == "Vans" then
			OpenMenu('vans')
		elseif btn == "Modes" then
			OpenMenu('modes')
			elseif btn == "DLC" then
			OpenMenu('dlc')
		end
	elseif this == "dlc" or this == "modes" or this == "compacts" or this == "coupes" or this == "sedans" or this == "sports" or this == "sportsclassics" or this == "super" or this == "muscle" or this == "offroad" or this == "suvs" or this == "vans" or this == "industrial" or this == "cycles" or this == "motorcycles" then
		TriggerServerEvent('stores:CheckMoneyForVeh',button.name, button.model, button.costs)
	end
end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "dlc" or vehshop.currentmenu == "modes" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

--[[Citizen]]--

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,201) and IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if vehshop.opened then
			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			drawTxt(vehshop.title,1,1,vehshop.menu.x,vehshop.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, vehshop.menu.x,vehshop.menu.y + 0.08)
			drawTxt(vehshop.selectedbutton.."/"..tablelength(menu.buttons),0,0,vehshop.menu.x + vehshop.menu.width/2 - 0.0385,vehshop.menu.y + 0.067,0.4, 255,255,255,255)
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)
					if button.costs ~= nil then
						if vehshop.currentmenu == "dlc" or vehshop.currentmenu == "modes" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
							DoesPlayerHaveVehicle(button.model,button,y,selected)
						else
						drawMenuRight(button.costs.."$",vehshop.menu.x,y,selected)
						end
					end
					y = y + 0.04
					if vehshop.currentmenu == "dlc" or vehshop.currentmenu == "modes" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)
									drawTxt("~b~Loading...",0,1,0.5,0.5,1.5,255,255,255,255)

								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								while not DoesEntityExist(veh) do
									Citizen.Wait(0)
									drawTxt("~b~Loading...",0,1,0.5,0.5,1.5,255,255,255,255)
								end
								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}
							end
						end
					end
					if selected and IsControlJustPressed(1,201) then
						ButtonSelected(button)
					end
				end
			end
		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end

	end
end)

AddEventHandler('stores:FinishMoneyCheckForVeh', function(name, vehicle, price)
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price)
end)

AddEventHandler('playerSpawned', function(spawn)
if firstspawn == 0 then
	--326 car blip 227 225
	ShowVehshopBlips(true)
	firstspawn = 1
end
end)

AddEventHandler('vehshop:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = GetPlayerPed(-1)
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
	end
end)

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		RemoveIpl('v_carshowroom')
		RemoveIpl('shutter_open')
		RemoveIpl('shutter_closed')
		RemoveIpl('shr_int')
		RemoveIpl('csr_inMission')
		RequestIpl('v_carshowroom')
		RequestIpl('shr_int')
		RequestIpl('shutter_closed')
		firstspawn = 1
	end
end)
