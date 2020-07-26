-- lootbox beacons

return {
    ["LootboxBeaconBronze"] = {
    groundflash_large = {
            class              = [[CSimpleGroundFlash]],
            count              = 1,
            air                = true,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                colormap           = [[0 0 0 0.01   1 1 1 0.9   1 1 1 0.6   1 1 1 0.3   0 0 0 0.01]],
                size               = 36,
                ttl                = 46,
                sizegrowth         = 0.4,
                texture            = [[circlefx0]],
                alwaysvisible      = true,
            },
        },
    },
    ["LootboxBeaconSilver"] = {
    groundflash_large = {
            class              = [[CSimpleGroundFlash]],
            count              = 1,
            air                = true,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                colormap           = [[0 0 0 0.01   1 1 1 0.9   1 1 1 0.6   1 1 1 0.3   0 0 0 0.01]],
                size               = 36,
                ttl                = 46,
                sizegrowth         = 0.4,
                texture            = [[circlefx1]],
                alwaysvisible      = true,
            },
        },
    },
    ["LootboxBeaconGold"] = {
    groundflash_large = {
            class              = [[CSimpleGroundFlash]],
            count              = 1,
            air                = true,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                colormap           = [[0 0 0 0.01   1 1 1 0.9   1 1 1 0.6   1 1 1 0.3   0 0 0 0.01]],
                size               = 36,
                ttl                = 46,
                sizegrowth         = 0.4,
                texture            = [[circlefx2]],
                alwaysvisible      = true,
            },
        },
    },
    ["LootboxBeaconPlatinum"] = {
    groundflash_large = {
            class              = [[CSimpleGroundFlash]],
            count              = 1,
            air                = true,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                colormap           = [[0 0 0 0.01   1 1 1 0.9   1 1 1 0.8   1 1 1 0.7   1 1 1 0.3   0 0 0 0.01]],
                size               = 38,
                ttl                = 54,
                sizegrowth         = 0.4,
                texture            = [[circlefx3]],
                alwaysvisible      = true,
            },
        },
    },
	["LootboxLightGold"] = {
		useAirLos = false,
		usedefaultexplosions = false,
		["heatcloud"] = {
			air = true,
			water = true,
			ground = true,
			unit = true,
			count = 3,
			properties = {
				--alwaysVisible = true,
				heat = 30,
				texture = [[glow2]],
				maxheat = 30,
				heatFalloff = 1.4,
				size = [[4.0 r0.4]],
				sizeGrowth = [[-0.02 r0.02]],
				sizemod = 0,
				sizemodmod = 0,
				speed = [[0.05 r-0.05, 0.05 r-0.05, 0.05 r-0.05]],
				pos = [[0, 0.0, 0]],
				useAirLos = false,
			},
		},
	},
}