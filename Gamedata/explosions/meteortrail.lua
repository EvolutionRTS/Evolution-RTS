-- meteortrail

return {
  ["meteortrail"] = {
    usedefaultexplosions = false,
    exhale = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.87,
        colormap           = [[0.0 0.0 0.0 0.1			0.7 0.5 0.2 0.1		 0.0 0.0 0.0 0.2 		0.0 0.0 0.0 0.01]],
        directional        = false,
        emitrot            = 80,
        emitrotspread      = 5,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 1, 0]],
        numparticles       = 4,
        particlelife       = 200,
        particlelifespread = 15,
        particlesize       = 50,
        particlesizespread = 1,
        particlespeed      = 2,
        particlespeedspread = 50,
        pos                = [[0, 1, 0]],
        sizegrowth         = -1,
        sizemod            = 1.0,
        texture            = [[smoke]],
      },
    },
  },

}

