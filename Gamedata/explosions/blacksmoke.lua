

return {
  ["blacksmoke"] = {
    dirtg = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
	  water				 = true,
      properties = {
        airdrag            = 0.7,
        alwaysvisible      = true,
        colormap           = [[1 0.5 0 1.0	1 0.5 0 1.0		0.9 0.4 0 1.0	0.6 0.2 0 1.0	0.3 0.1 0 1.0	0 0 0 1.0	0 0 0 0.9	0 0 0 0.8	0 0 0 0.7	0 0 0 0.6	0 0 0 0.5	0 0 0 0.4	0 0 0 0.3	0 0 0 0.2	0 0 0 0.1]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0.3, 0]],
        numparticles       = 4,
        particlelife       = 30,
        particlelifespread = 20,
        particlesize       = 1,
        particlesizespread = 2,
        particlespeed      = 1,
        particlespeedspread = 1,
        sizegrowth         = 1,
        sizemod            = 0.9,
        texture            = [[new_dirta]],
        useairlos          = false,
		colorchange			= "stuffs",
      },
    },
  },
}

