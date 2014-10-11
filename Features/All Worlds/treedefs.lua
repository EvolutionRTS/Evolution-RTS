-- Default Spring Treedef

local DRAWTYPE = { NONE = -1, MODEL = 0, TREE = 1 }

local treeDefs = {}

local function CreateTreeDef(type)
  treeDefs["treetype1"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_1_xl.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype2"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_1_l.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype3"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_2_xl.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype4"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_2_l.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype5"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_3_xl.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype6"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_3_l.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype7"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_1_xl.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype8"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_1_l.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype9"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_2_xl.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype10"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_2_l.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype11"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_3_xl.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype12"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_3_l.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype13"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_1_xl.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype14"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_1_l.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype15"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_2_xl.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype16"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_2_l.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype17"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_3_xl.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype18"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_3_l.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype19"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_1_xl.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
  
    treeDefs["treetype20"] = {
     description = [[Tree]],
     blocking    = true,
     burnable    = true,
     reclaimable = true,
	 upright = true,
     energy = 10,

     damage      = 5,
     metal = 0,
	 object				="features/0ad/ad0_pine_2_l.s3o",

     reclaimTime = 25,
     mass        = 20,
     drawType    = DRAWTYPE.MODEL,
     footprintX  = 2,
     footprintZ  = 2,
     collisionVolumeTest = 0,

     customParams = {
       mod = true,
     },

     modelType   = type,
  }
end

for i=0,20 do
  CreateTreeDef(i)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return lowerkeys( treeDefs )

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------