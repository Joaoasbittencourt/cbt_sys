function Heal()
	local self = {}

	local baseHeal = 30
	local varHeal = 10
	local cooldown = Timer(3000)

	self.name = "Heal"


	self.update = function(dt)
		cooldown.update(dt)
	end

	self.cast = function(caster, afterCast)
		if cooldown.isRunning() then
			return
		end
		caster.health.heal(baseHeal + math.floor(varHeal * math.random()))
		cooldown.start()
		afterCast()
	end

	self.getCooldown = function()
		return cooldown
	end

	return self
end