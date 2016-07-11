Module = class(AIBase)

function Module:Name()
	return "no name defined"
end

function Module:internalName()
	return "module"
end

function Module:SetAI(ai)
	self.ai = ai
	self.game = ai.game
	self.map = ai.map
end