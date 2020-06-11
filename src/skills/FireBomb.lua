function FireBomb()
	local self = {}

	local baseDamage = 40
	local range = 300
	local areaOfEffectRadius = 50

	-- this will be unecessary when getDamage will handle values from caster stats
	local varDamage = 20

	self.getDamage = function()
		return baseDamage + math.floor(varDamage * math.random())
	end

	self.getRange = function() return range end
	self.getAreaOfEffectRadius = function() return areaOfEffectRadius end

	return self
end