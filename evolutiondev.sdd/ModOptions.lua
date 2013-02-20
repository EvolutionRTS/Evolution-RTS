local options= {
  {
    key    = 'StartingResources',
    name   = 'Starting Resources',
    desc   = 'Sets storage and amount of resources that players will start with',
    type   = 'section',
  },
  {
    key    = 'StartMetal',
    name   = 'Starting metal',
    desc   = 'Determines amount of metal and metal storage that each player will start with',
    type   = 'number',
    section= 'StartingResources',
    def    = 100,
    min    = 0,
    max    = 1000,
    step   = 1,  -- quantization is aligned to the def value
                    -- (step <= 0) means that there is no quantization
  },
  {
    key    = 'StartEnergy',
    name   = 'Starting energy',
    desc   = 'Determines amount of energy and energy storage that each player will start with',
    type   = 'number',
    section= 'StartingResources',
    def    = 250,
    min    = 0,
    max    = 1000,
    step   = 1,  -- quantization is aligned to the def value
                    -- (step <= 0) means that there is no quantization
  },
	{
		key    = "classicrtsmode",
		name   = "Classic RTS Mode",
		desc   = "Sets buildtimes to metalcost, resulting in Classic TA Style Building",
		type   = "bool",
		def    = false,
		section= 'other',
	},	
}

return options