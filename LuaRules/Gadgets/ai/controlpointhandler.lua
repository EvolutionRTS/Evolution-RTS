ControlPointHandler = class(Module)

function ControlPointHandler:Name()
	return "ControlPointHandler"
end

function ControlPointHandler:internalName()
	return "controlpointhandler"
end

local function distance(pos1,pos2)
	local xd = pos1.x-pos2.x
	local yd = pos1.z-pos2.z
	local dist = math.sqrt(xd*xd + yd*yd)
	return dist
end

function ControlPointHandler:Init()
	self.ally = self.ai.allyId
end

function ControlPointHandler:Points()
	if ShardSpringLua then
		return Script.LuaRules.ControlPoints() or {}
	end
	return {}
end

function ControlPointHandler:CaptureRadius()
	if ShardSpringLua then
		return Script.LuaRules.CaptureRadius()
	end
	return 500
end

function ControlPointHandler:ArePoints()
	local points = self:Points()
	return #points > 0
end

function ControlPointHandler:ClosestUncapturedPoint(position)
	local pos
	local bestDistance
	local points = self:Points()
	for i = 1, #points do
		local point = points[i]
		local pointAlly = point.owner
		if pointAlly ~= self.ally then
			local dist = distance(position, point)
			if not bestDistance or dist < bestDistance then
				bestDistance = dist
				pos = point
			end
		end
	end
	return pos
end