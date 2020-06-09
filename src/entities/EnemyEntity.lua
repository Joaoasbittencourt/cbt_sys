function EnemyEntity()
	local self = {}
	local radius = 15
	local speed = 120
	local health = HealthComponent(40, "Zombie")
	local collider = ColliderComponent(Vector(400, 400), radius, self)
	local attackCooldown = 1000

	local function _handleAttack(dt, playerPos, position)
		if attackCooldown > 0 then
			attackCooldown = attackCooldown - dt * 1000
		end

		if playerPos.distanceTo(position) < player.radius + radius + 5 then
			if attackCooldown <= 0 then
				player.health.insertDamage(20 + math.floor(math.random() * 20))
				attackCooldown = 1000
			end
		end
	end

	local function update(dt, player)

		local playerPos = player.getPosition()
		local position = collider.getPositionVector()

		if playerPos.distanceTo(position) > player.radius + radius then
			collider.setSpeed(position.directionTo(playerPos).mul(speed))
		end

		_handleAttack(dt, playerPos, position)

		health.update(dt, position.getX(), position.getY())
	end

	local function draw()
		local position = collider.getPositionVector()
		love.graphics.setColor(0.8, 0.8, 0.2)
		love.graphics.circle("fill", position.getX(), position.getY(), radius)
		health.draw()
	end

	local function destroy()
		collider.dispose()
	end

	self.destroy = destroy
	self.update = update
	self.draw = draw
	self.health = health
	self.getPosition = function() return collider.getPositionVector() end
	self.getRadius = function() return radius end
	self.addImpact = collider.addImpact

	return self
end