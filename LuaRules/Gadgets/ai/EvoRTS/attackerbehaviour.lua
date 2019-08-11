shard_include( "attackers" )


-- speedups
local SpGetGameFrame = Spring.GetGameFrame
local SpGetUnitPosition = Spring.GetUnitPosition
local SpGetUnitSeparation = Spring.GetUnitSeparation
local SpGetUnitVelocity = Spring.GetUnitVelocity
local SpGetUnitMaxRange = Spring.GetUnitMaxRange
local SpValidUnitID = Spring.ValidUnitID
local SpGetUnitCurrentBuildPower = Spring.GetUnitCurrentBuildPower
local SpGetUnitNearestEnemy = Spring.GetUnitNearestEnemy
local Echo = Spring.Echo
------


function IsAttacker(unit)
	for i,name in ipairs(attackerlist) do
		if name == unit:Internal():Name() then
			return true
		end
	end
	return false
end

AttackerBehaviour = class(Behaviour)

function AttackerBehaviour:Init()
	--self.ai.game:SendToConsole("attacker!")
	--self.game:AddMarker({ x = startPosx, y = startPosy, z = startPosz }, "my start position")
	CMD.MOVE_STATE = 50
	CMD.FIRE_STATE = 45
end

local function Distance(x1,z1, x2,z2)
	local vectx = x2 - x1
	local vectz = z2 - z1
	local dis = math.sqrt(vectx^2+vectz^2)
	return dis
end

function AttackerBehaviour:Update()
	if not self.active then -- do not even attempt anything if the unit is inactive...
		return
	end
	if not self.unitID then
		self.unitID = self.unit:Internal().id
	end
	if not self.AggFactor then
		self.AggFactor = self.ai.attackhandler:GetAggressiveness(self)
	end
	if not self.type then
		self.type = self.ai.attackhandler:GetRole(self)
	end
	local frame = SpGetGameFrame()
	if (frame%450 == self.unitID%450) or self.myRange == nil then --refresh "myRange" casually because it can change with experience
		local unitID = self.unit:Internal().id
		local unitDefID = Spring.GetUnitDefID(unitID)
		if UnitDefs[unitDefID].customParams.retreatrangedai then
			--Spring.Echo("ORB RANGE!")
			self.myRange = tonumber(UnitDefs[unitDefID].customParams.retreatrangedai)
		else
			--Spring.Echo("NORMAL RANGE!")
			self.myRange = SpGetUnitMaxRange(self.unitID)
		end
	end
	if (frame%90 == self.unitID%90) then -- a unit on map stays 'visible' for max 3s, this also reduces lag
		local nearestVisibleAcrossMap = SpGetUnitNearestEnemy(self.unitID, self.AggFactor*self.myRange)
		if nearestVisibleAcrossMap and (GG.AiHelpers.VisibilityCheck.IsUnitVisible(nearestVisibleAcrossMap, self.ai.id)) then
			self.nearestVisibleAcrossMap = nearestVisibleAcrossMap
		end
	end
	if (frame%45 == self.unitID%45) then -- a unit in range stays 'visible' for max 1.5s, this also reduces lag
		local nearestVisibleInRange = SpGetUnitNearestEnemy(self.unitID, 2*self.myRange)
		local closestVisible = nearestVisibleInRange and GG.AiHelpers.VisibilityCheck.IsUnitVisible(nearestVisibleInRange, self.ai.id)
		if nearestVisibleInRange and closestVisible then
			self.nearestVisibleInRange = nearestVisibleInRange
			self.enemyRange = SpGetUnitMaxRange(nearestVisibleInRange)
		end
	end
	local nearestEnemy = SpGetUnitNearestEnemy(self.unitID, 30000, false)
	local distance = (nearestEnemy and SpGetUnitSeparation(self.unitID, nearestEnemy)) or 300
	local refreshRate = math.max(math.floor(((distance*0.5 or 250)/10)),10)
	if self.unitID%refreshRate == frame%refreshRate then
		self:AttackCell(self.type, self.nearestVisibleAcrossMap, self.nearestVisibleInRange, self.enemyRange)
	end
end

function AttackerBehaviour:OwnerBuilt()
	--Echo("registered unit construction")
	self.unit:Internal():ExecuteCustomCommand(CMD.MOVE_STATE, { 2 }, {})
	self.unit:Internal():ExecuteCustomCommand(CMD.FIRE_STATE, { 2 }, {})
	self.unit:Internal():ExecuteCustomCommand(CMD.CLOAK, { 1 }, {})
	self.unit:Internal():ExecuteCustomCommand(34569, { 1 }, {})
	self.attacking = true
	self.active = true
	self.unitID = self.unit:Internal().id
	self.AggFactor = self.ai.attackhandler:GetAggressiveness(self)
	self.type = self.ai.attackhandler:GetRole(self)
	self.repairThisUnit = false
end

function AttackerBehaviour:OwnerDead()
end

function AttackerBehaviour:OwnerIdle()
	self.attacking = true
	self.active = true
end

function AttackerBehaviour:AttackCell(type, nearestVisibleAcrossMap, nearestVisibleInRange, enemyRange)
	--Echo("trying to get attack position")
	local p
	local unit = self.unit:Internal()
	local unitID = unit.id
	local teamID = ai.id
	local unitDefID = Spring.GetUnitDefID(unitID)
	--local unitCanMove = UnitDefs[unitDefID].canMove
	local mc, ms = Spring.GetTeamResources(teamID, "metal")
	local ec, es = Spring.GetTeamResources(teamID, "energy")
	local r = math.random(0,20)
	local currenthealth = unit:GetHealth()
	local maxhealth = unit:GetMaxHealth()
	if currenthealth < maxhealth*0.99 and currenthealth < 5000 then
		self.repairThisUnit = true
	elseif currenthealth >= maxhealth*0.99 then
		self.repairThisUnit = false
	end
	if r == 0 and string.find(UnitDefs[unitDefID].name, "eartytank") then
		self.unit:Internal():EZMorph()
	elseif r == 0 and string.find(UnitDefs[unitDefID].name, "riot") then
		self.unit:Internal():EZMorph()
	elseif r < 10 and string.find(UnitDefs[unitDefID].name, "eartyturret") then
		self.unit:Internal():EZMorph()
		return
	elseif string.find(UnitDefs[unitDefID].name, "ehbot") and not string.find(UnitDefs[unitDefID].name, "turret") then
		local nearestEnemy = SpGetUnitNearestEnemy(self.unitID, 30000, false)
		local EnemyDefID = Spring.GetUnitDefID(nearestEnemy)
		local nearestEnemyDistance = SpGetUnitSeparation(self.unitID,nearestEnemy)
		if nearestEnemyDistance < self.myRange*1.30 and self.repairThisUnit == false then
			if UnitDefs[EnemyDefID].customParams and UnitDefs[EnemyDefID].customParams.armortype ~= "building" then
				self.unit:Internal():EZMorph()
			end
		end
	elseif string.find(UnitDefs[unitDefID].name, "ehbot") and string.find(UnitDefs[unitDefID].name, "turret") then
		local nearestEnemy = SpGetUnitNearestEnemy(self.unitID, 30000, false)
		local EnemyDefID = Spring.GetUnitDefID(nearestEnemy)
		local nearestEnemyDistance = SpGetUnitSeparation(self.unitID,nearestEnemy)
		if nearestEnemyDistance >= self.myRange+50 or self.repairThisUnit == true or (UnitDefs[EnemyDefID].customParams and UnitDefs[EnemyDefID].customParams.armortype == "building") then
			self.unit:Internal():EZMorph()
		end
	elseif (UnitDefs[unitDefID].name == "etech1" or UnitDefs[unitDefID].name == "etech2") then
		self.unit:Internal():EZMorph()
		return
	elseif string.find(UnitDefs[unitDefID].name, "eorb") and ec > es*0.98 then
		self.unit:Internal():EZMorph()
	elseif string.find(UnitDefs[unitDefID].name, "emetalextractor") and ec > es*0.98 then
		self.unit:Internal():EZMorph()
		return
	end
	if string.find(UnitDefs[unitDefID].name, "eallterr") then
		local nearestEnemy = SpGetUnitNearestEnemy(self.unitID, 30000, false)
		local nearestEnemyDistance = SpGetUnitSeparation(self.unitID,nearestEnemy)
		if nearestEnemyDistance < 2000 then
			self.unit:Internal():ExecuteCustomCommand(CMD.CLOAK, { 1 }, {})
		else
			self.unit:Internal():ExecuteCustomCommand(CMD.CLOAK, { 0 }, {})
		end
	end
	-- Retreating so we have less data process/only what matters
	if self.repairThisUnit then
	--Echo("trying to retreat")
	local nanotcx, nanotcy, nanotcz = GG.AiHelpers.NanoTC.GetClosestNanoTC(self.unitID)
		if nanotcx and nanotcy and nanotcz then
			p = api.Position()
			p.x, p.y, p.z = nanotcx, nanotcy, nanotcz
		else
			p = self.ai.attackhandler.commpos
		end
		self.target = p
		self.attacking = false
		if self.active and self.target then
			self.unit:Internal():Move(self.target)
			return
		else 
			self.repairThisUnit = false
		end
	end
	
	local utype = self.game:GetTypeByName(unit:Name())
	local attacker = (type == "attacker")
	
	-- nil/invalid checks
	if nearestVisibleInRange and (not SpValidUnitID(nearestVisibleInRange)) then 
		nearestVisibleInRange = nil 
		self.nearestVisibleInRange = nil
	end
	if nearestVisibleAcrossMap and (not SpValidUnitID(nearestVisibleAcrossMap)) then 
		nearestVisibleAcrossMap = nil 
		self.nearestVisibleAcrossMap = nil 
	end
	
	if not self.repairThisUnit and nearestVisibleInRange and (not utype:CanFly() == true) then -- process cases where there isn't any visible nearestVisibleInRange first
		--Echo("trying to attack nearby enemy")
		local ex,ey,ez = SpGetUnitPosition(nearestVisibleInRange)
		local ux,uy,uz = SpGetUnitPosition(self.unitID)
		local pointDis = SpGetUnitSeparation(self.unitID,nearestVisibleInRange)
		local dis = 120
		local f = dis/pointDis
		local wantedRange
		if self.myRange and enemyRange and self.myRange >= enemyRange and enemyRange > 50 then -- we skirm here
			wantedRange = self.myRange
		else -- randomize wantedRange between 25-75% of myRange
			wantedRange = math.random(self.myRange*0.70, self.myRange*0.80)
		end
		-- offset upos randomly so it moves a bit while keeping distance
		local dx, _, dz, dw = SpGetUnitVelocity(self.unitID) -- attempt to not always queue awful turns
		local modifier = "ctrl"
		ux = ux + math.random (-80,80)
		uy = uy
		uz = uz + math.random (-80,80)
		if wantedRange <= pointDis then
			modifier = nil -- Do not try to move backwards if attempting to get closer to target
		end
		-- here we find the goal position
		if (pointDis+dis > wantedRange) then
			f = (wantedRange-pointDis)/pointDis
		end
		local cx = ux+(ux-ex)*f
		local cy = uy
		local cz = uz+(uz-ez)*f
		if unit:Name() == "eorb" or unit:Name() == "eorb_up1" or unit:Name() == "eorb_up2" or unit:Name() == "eorb_up3" then
			if SpGetUnitCurrentBuildPower(unit.id) == 0 then -- if currently IDLE 
				self.unit:Internal():ExecuteCustomCommand(CMD.FIGHT, {cx, cy, cz}, {modifier})
			end
		else
			--Echo("attacking nearby enemy")
			self.unit:Internal():ExecuteCustomCommand(CMD.MOVE, {cx, cy, cz}, {modifier})
		end
		return
	end
	
	-- We have processed units that had to retreat and units that had visible enemies within 2* their range
	-- what are left are units with no visible enemies within 2*maxRange (no radar/los/prevLOS buildings)
	local enemyposx, enemyposy, enemyposz
	if not self.repairThisUnit and nearestVisibleAcrossMap then
		--Echo("Attacking nearest enemy on map")
		enemyposx, enemyposy, enemyposz = SpGetUnitPosition(nearestVisibleAcrossMap) -- visible on map
	elseif not self.repairThisUnit then
		--Echo("IDFK what i'm doing with my life")
		local nearestEnemy = SpGetUnitNearestEnemy(self.unitID, 30000, false)
		if nearestEnemy then
			enemyposx, enemyposy, enemyposz = SpGetUnitPosition(nearestEnemy)
		end
		--local cms = self.ai.attackhandler.targetMexes[(self.unitID%5)+1]
		--if cms then -- there is an enemy metal spot
			--enemyposx, enemyposy, enemyposz = cms.x, cms.y, cms.z
		--else -- there is nothing to target
			--return
		--end
	end
	
	p = api.Position()
	if p == nil then 
		return
	end
	p.x = enemyposx + math.random(-math.sqrt(2)/2*self.myRange*0.90, math.sqrt(2)/2*self.myRange*0.90) or 0
	p.z = enemyposz + math.random(-math.sqrt(2)/2*self.myRange*0.90, math.sqrt(2)/2*self.myRange*0.90) or 0
	p.y = enemyposy or 0
	self.target = p
	self.attacking = true
	if unit:Name() == "eorb" or unit:Name() == "eorb_up1" or unit:Name() == "eorb_up2" or unit:Name() == "eorb_up3" then 
		if SpGetUnitCurrentBuildPower(unit.id) == 0 then -- if currently IDLE  then
			unit:MoveAndPatrol(self.target)
		end
		return
	else
		if (utype:CanFly() == true) and not (unit:Name() ~= "escoutdrone" or unit:Name() ~= "zairscout") then
			local nearestEnemy = SpGetUnitNearestEnemy(self.unitID, 30000, false)
			if nearestEnemy then
				--Echo("I'm battle aircraft and i'm attacking")
				unit:Attack(nearestEnemy)
			end
		else
			--Echo("I'm anything else and i'm attacking")
			unit:MoveAndFire(self.target)
		end
	return
	end
end


function AttackerBehaviour:Priority()
	if not self.attacking then
		return 0
	else
		return 100
	end
end

function AttackerBehaviour:Activate()
	self.active = true
	if self.target then
		self.unit:Internal():MoveAndFire(self.target)
		self.target = nil
	else
	end
end


function AttackerBehaviour:OwnerDied()
	self.attacking = nil
	self.active = nil
	self.unit = nil
end