function FireBomb()
	local self = {}

	local varDamage = 20
	local baseDamage = 40
	local range = 300
	local areaOfEffectRadius = 50
	local cooldown = Timer(5000)

	self.name = "Fire Bomb"

	self.getRange = function() return range end
	self.getAreaOfEffectRadius = function() return areaOfEffectRadius end


	self.update = function(dt)
		cooldown.update(dt)
	end

	self.aim = function ()
		
	end

	self.cast = function(caster, afterCast)

		if cooldown.isRunning() then
			return
		end

		local position = Controller.getGlobalMousePosition()
		local damage = baseDamage + math.floor(varDamage * math.random())
		local damageArea = CircularDamageAreaEntity(position, areaOfEffectRadius, damage, 400)
		damageAreaSystem.push(damageArea)

		cooldown.start()
		afterCast()
	end

	self.getCooldown = function()
		return cooldown
	end

	return self
end