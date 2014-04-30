return {
  arm_raven_rt = {
    {
	name     = "Rocket type",
	tooltip  = "Select Raven's rocket type",
	cob      = "RocketType",  -- only this is required
	type = CMDTYPE.ICON_MODE,
	params = {'1', 'S.W.A.R.M', 'HE Rockets'},
    },
  },
  
  egunship2 = {
    {
	name     = "Weapon type",
	tooltip  = "Switch between air to ground missiles and torpedos",
	cob      = "MissileType",  -- only this is required
	type = CMDTYPE.ICON_MODE,
	params = {'1', 'Missile', 'Torpedo'},
    },
  },
  
}