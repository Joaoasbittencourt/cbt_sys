function FireBomb()
	local self = {}

	local varDamage = 20
	local baseDamage = 40
	local range = 300
	local areaOfEffectRadius = 50
	local cooldown = Timer(1000)

	self.name = "Fire Bomb"

	self.getRange = function() return range end
	self.getAreaOfEffectRadius = function() return areaOfEffectRadius end


	self.update = function(dt)
		cooldown.update(dt)
	end

	self.cast = function(caster, afterCast)

		if cooldown.isRunning() then
			return
		end

		local damage = baseDamage + math.floor(varDamage * math.random())
		local position = Controller.getGlobalMousePosition()
		damageAreaSystem.push(
			CircularDamageAreaEntity(position, areaOfEffectRadius, damage, 400)
		)

		cooldown.start()
		afterCast()
	end

	return self
end