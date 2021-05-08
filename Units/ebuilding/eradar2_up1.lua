-- UNITDEF -- eradar2_up1 --
--------------------------------------------------------------------------------

unitName = [[eradar2_up1]]	

buildCostMetal = 40

humanName = [[Radar Tower]]
objectName = [[eradar3_large.s3o]]

radarDistance = 3000
radarEmitHeight = 128

sightDistance = 1500
sonarDistance = 1500
seismicDistance = 1500

tech = [[tech2]]
armortype = [[building]]


VFS.Include("units-configs-basedefs/basedefs/buildings/eradar2_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------