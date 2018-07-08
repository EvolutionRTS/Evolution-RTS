function gadget:GetInfo()
	return {
		name      = "Linear EdgeEffectiveness",
		desc      = "Makes AOE damage fall off linearly between 0 and 1",
		author    = "Sprung",
		date      = "Does it matter?",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = false  --  loaded by default?
	}
end
--[[
function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID)
	if weaponDefID <= 0 then
		return damage -- environmental damage, no weapondef entry
	end

	local weaponDef = WeaponDefs[weaponDefID]
	local ee = weaponDef.edgeEffectiveness
	if ee == 1 then
		return damage -- already desired behaviour and would else crash due to div0
	end

	local baseDamage = weaponDef.damages[UnitDefs[unitDefID].armorType]

	local isArmored, armorMult = Spring.GetUnitArmored(unitID)
	if isArmored then
		if armorMult == 0 then
			return 0
		end
		baseDamage = baseDamage * armorMult
	end

	local fraction = damage / baseDamage
	local distance = (1 - fraction) / (1 - fraction*ee)

	return baseDamage * (1 - distance*(1 - ee))
end
]]--