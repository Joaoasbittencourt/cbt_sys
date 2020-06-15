
function CircularDamageAreaEntity(position, radius, damage, delay)

	local self = {}
	self.isRemoved = false
	local damageDelayTimer = Timer(delay)
	damageDelayTimer.start()

	self.draw =  function()
		love.graphics.setColor(1, 0, 0, 0.4);
		love.graphics.circle("line", position.getX(), position.getY(), radius)
	end

	local onDamage = function()

		if self.isRemoved then return end

		animationSystem.push(FireBombAnimation(position, radius))
		local colliders = world:queryCircleArea(position.getX(), position.getY(), radius)

		for _, collider in pairs(colliders) do
			if collider.getParent ~= nil then
				local entity = collider:getParent()
				entity.health.insertDamage(damage)
			end
		end

		self.isRemoved = true
	end

	self.update = function(dt)
		damageDelayTimer.update(dt)
		if damageDelayTimer.isRunning() then
			return
		end
		onDamage()
	end


	return self
end
