StockpileBehavior = class(Behaviour)

function StockpileBehavior:Name()
	return "StockpileBehavior"
end

local CMD_STOCKPILE = 100

function StockpileBehavior:Init()
    self.finished = false
	r = math.random(0,300)
end

function StockpileBehavior:OwnerBuilt()
	self.finished = true
end

function StockpileBehavior:Update()
	if Spring.GetGameFrame() % 300 == r then
			self.unit:Internal():ExecuteCustomCommand(CMD_STOCKPILE)
			r = math.random(0,300)
	end
end

function StockpileBehavior:Activate()
		self.active = true
end

function StockpileBehavior:Deactivate()
		self.active = false
end

function StockpileBehavior:Priority()
	return 51
end