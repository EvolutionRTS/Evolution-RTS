RegroupBehaviour = class(Behaviour)

function RegroupBehaviour:Init()
	local u = self.unit:Internal()
	self.id = u:ID()
	self.name = u:Name()
	self.finished = false
end

function RegroupBehaviour:DoTargetting()
		local cells = {}
		local celllist = {}
		local mapdimensions = game.map:MapDimensions()
		local myunits = game:GetUnits()
			if myunits and #myunits > 0 then
				for i=1,#myunits do
				local mu = myunits[i]

				if mu ~= nil then
					pos = mu:GetPosition()
					px = pos.x - math.fmod(pos.x,400)
					pz = pos.z - math.fmod(pos.z,400)
					px = px/400
					pz = pz/400
					if cells[px] == nil then
						cells[px] = {}
					end
					if cells[px][pz] == nil then
						local newcell = { count = 0, posx = 0,posz=0,}
						cells[px][pz] = newcell
						table.insert(celllist,newcell)
					end
					cell = cells[px][pz]
					cell.count = cell.count + self:ScoreUnit(mu)
					
					-- we dont want to target the center of the cell encase its a ledge with nothing
					-- on it etc so target this units position instead
					cell.posx = pos.x
					cell.posz = pos.z
				end
				end
				
				
				local bestCell = nil
			-- now find the smallest nonvacant cell to go lynch!
			for i=1,#celllist do
				local cell = celllist[i]
				if bestCell == nil then
					bestCell = cell
				else
					if cell.count < bestCell.count then
						bestCell = cell
					end
				end
			end
			
			-- if we have a cell then lets go attack it!
			if bestCell ~= nil then
					u:AttackCell(bestCell)
				
				--self.counter = self.counter + 0.2
				--self.counter = math.min(self.counter,20)
				
				-- remove all our recruits!
				--self.recruits = {}
				
			end
			end
			
			-- cleanup
		cellist = nil
		cells = nil
		mapdimensions = nil
end

function RegroupBehaviour:OwnerBuilt()
	self.finished = true
end

function RegroupBehaviour:Update()
	if self.finished then
		--
	end
end

function RegroupBehaviour:MoveBackToCell(cell)
	p = api.Position()
	p.x = cell.posx
	p.z = cell.posz
	p.y = 0
	self.target = p
	self.attacking = true
	if self.active then
		self.unit:Internal():MoveAndFire(self.target)
	else
		self.unit:ElectBehaviour()
	end
end

function RegroupBehaviour:Activate()
	self.active = true
end

function RegroupBehaviour:Deactivate()
	self.active = false
end

function RegroupBehaviour:Priority()
	if self.underfire == true then
		return 150
	else
		return 0
	end
end