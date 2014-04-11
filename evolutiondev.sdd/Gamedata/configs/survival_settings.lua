local spawnerSettings	= {
	smallUnit		= "elighttank3",--"aacar"
	mediumUnit		= "emediumtank3",--"ez8"
	largeUnit		= "eheavytank3",--xamel
	referenceUnit	= "efatso2",--fedmechist
	
	testUnit		= "elighttank3",
	
	modes			= {
		[1]		= "Survival Spawner: Very Easy",
		[2]		= "Survival Spawner: Easy",
		[3]		= "Survival Spawner: Normal",
		[4]		= "Survival Spawner: Hard",
		[5]		= "Survival Spawner: Very Hard",
		[6]		= "no description",
	},
	
	-- commander modes which should trigger the disable of the survival spawner
	badModes		= {
		feature	= true,
		sandbox	= true,
	},
}
return spawnerSettings