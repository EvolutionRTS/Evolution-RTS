-- Spawntrail for Lootbox Drops

return {
  ["lootbox-trail"] = {
    usedefaultexplosions = false,
    engine = {
            air                = true,
            class              = [[CBitmapMuzzleFlame]],
            count              = 1,
            ground             = true,
            underwater         = 1,
            water              = true,
            properties = {
                alwaysVisible      = true,
                colormap           = [[1 0.75 0.1 0.01   0.9 0.55 0.08 0.01   0.8 0.35 0.05 0.01   0 0 0 0.01]],
                dir                = [[dir]],
                frontoffset        = 0,
                fronttexture       = [[none]],
                length             = [[-15 r3.5]],
                sidetexture        = [[muzzleside]],
                size               = 15.5,
                sizegrowth         = [[0.2 r0.9]],
                ttl                = 1,
            },
        },
    fireglow = {
      
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        alwaysVisible      = true,
        airdrag            = 1,
        colormap           = [[0.95 0.75 0 0.01   0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0.0, 0.0, 0.0]],
        gravity            = [[0.0, 0.1, 0.0]],
        numparticles       = 1,
        particlelife       = 2,
        particlelifespread = 1,
        particlesize       = 40,
        particlesizespread = 12,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0.0, 0, 0.0]],
        sizegrowth         = -0.5,
        sizemod            = 1,
        texture            = [[dirt]],
        useairlos          = true,
      },
    },
    exhale = {
      
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        alwaysVisible      = true,
        airdrag            = 0.87,
        colormap           = [[0.95 0.75 0 0.1   0.45 0.32 0 0.1   0.0 0.0 0.0 0.01]],
        directional        = true,
        emitrot            = 80,
        emitrotspread      = 5,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.2, 0]],
        numparticles       = 1,
        particlelife       = 40,
        particlelifespread = 15,
        particlesize       = 19,
        particlesizespread = 6,
        particlespeed      = 0.25,
        particlespeedspread = 1.2,
        pos                = [[0, 1, 0]],
        sizegrowth         = -0.2,
        sizemod            = 1.0,
        texture            = [[smoke-chickens]],
      },
    },
    exhale2 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        alwaysVisible      = true,
        airdrag            = 0.87,
        colormap           = [[0.8 0.6 0 0.15   0.55 0.40 0 0.1   0.028 0.020 0 0.15   0 0 0 0.01]],
        directional        = true,
        emitrot            = 80,
        emitrotspread      = 5,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.65, 0]],
        numparticles       = 2,
        particlelife       = 30,
        particlelifespread = 15,
        particlesize       = 7,
        particlesizespread = 6,
        particlespeed      = 0.25,
        particlespeedspread = 1.9,
        pos                = [[0, 1, 0]],
        sizegrowth         = -0.07,
        sizemod            = 1.0,
        texture            = [[smoke-chickens]],
      },
    },
    trail = {
        
        air                = true,
        class              = [[CBitmapMuzzleFlame]],
        count              = 1,
        ground             = true,
        underwater         = 1,
        water              = true,
        properties = {
            alwaysVisible      = true,
            colormap           = [[0 0 0 0.01  0.035 0.025 0.015 0.10  0.035 0.025 0.015 0.08  0.035 0.025 0.015 0.05  0.035 0.025 0.015 0.04  0.035 0.025 0.015 0.02  0 0 0 0.01]],
            dir                = [[dir]],
            frontoffset        = 0,
            fronttexture       = [[trans]],
            length             = -20,
            sidetexture        = [[smoketrail]],
            size               = 2.0,
            sizegrowth         = 0.05,
            ttl                = 40,
        },
      },
    smoke = {
          air                = true,
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          water              = true,
          properties = {
              airdrag            = 0.92,
              colormap           = [[0.006 0.006 0.006 0.05   0.05 0.04 0.033 0.66   0.04 0.038 0.034 0.56   0.04 0.036 0.032 0.44   0.025 0.025 0.025 0.28   0.014 0.014 0.014 0.13    0.006 0.006 0.006 0.05   0 0 0 0.01]],
              directional        = true,
              emitrot            = -180,
              emitrotspread      = 7,
              emitvector         = [[dir]],
              gravity            = [[0.0, -0.02, 0.0]],
              numparticles       = [[1.5 r1]],
              particlelife       = 15,
              particlelifespread = 40,
              particlesize       = 4.6,
              particlesizespread = 6.2,
              particlespeed      = 1.5,
              particlespeedspread = 2.5,
              pos                = [[-15 r30, -15 r30, -15 r30]],
              sizegrowth         = 0.32,
              sizemod            = 1,
              texture            = [[smoke]],
              useairlos          = true,
          },
      },
    dustparticles = {
          air                = true,
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          underwater         = true,
          water              = true,
          properties = {
              airdrag            = 0.77,
              colormap           = [[0.9 0.66 0.4 0.8   1 0.74 0.48 0.9    0.75 0.45 0.25 0.5   0 0 0 0.01]],
              directional        = true,
              emitrot            = 80,
              emitrotspread      = 15,
              emitvector         = [[dir]],
              gravity            = [[0, -0.011, 0]],
              numparticles       = 1,
              particlelife       = 9,
              particlelifespread = 6,
              particlesize       = 4,
              particlesizespread = 0.8,
              particlespeed      = 0.05,
              particlespeedspread = 0.6,
              pos                = [[0, 0, 0]],
              sizegrowth         = 0.03,
              sizemod            = 1.0,
              texture            = [[randomdots]],
          },
      },  
    spikes = {
      air                = true,
      class              = [[explspike]],
      count              = 2,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 0.6,
        alphadecay         = 0.08,
        color              = [[1.0, 0.5, 0.2]],
        dir                = [[-10 r20,-10 r20,-10 r20]],
        length             = 2,
        width              = 9,
      },
    },
  },

}

