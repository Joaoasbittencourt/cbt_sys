function EnemyEntity()
	local self = {}
	local radius = 30
	local speed = 120
	local health = HealthComponent(40, "Zombie")
	local physics = PhysicsComponent(Vector(400, 400), radius)
	local attackCooldown = 2000

	local function _handleAttack(dt, playerPos, position)
		if attackCooldown > 0 then
			attackCooldown = attackCooldown - dt * 1000
		end

		if playerPos.distanceTo(position) < player.radius + radius + 5 then
			if attackCooldown <= 0 then
				player.health.insertDamage(10 + math.floor(math.random() * 20))
				attackCooldown = 2000
			end
		end
	end

	local function update(dt, player)

		local playerPos = player.getPosition()
		local position = physics.getPosition()

		if playerPos.distanceTo(position) > player.radius + radius then
			physics.setSpeed(position.directionTo(playerPos).mul(speed))
		end

		_handleAttack(dt, playerPos, position)

		health.update(dt, position.getX(), position.getY())
	end

	local function draw()
		local position = physics.getPosition()
		love.graphics.setColor(0.8, 0.8, 0.2)
		love.graphics.circle("fill", position.getX(), position.getY(), radius)
		health.draw()
	end

	local function destroy()
		physics.destroy()
	end

	self.destroy = destroy
	self.update = update
	self.draw = draw
	self.health = health
	self.getPosition = function() return physics.getPosition() end
	self.getRadius = function() return radius end
	self.addImpact = physics.addImpact

	return self
end