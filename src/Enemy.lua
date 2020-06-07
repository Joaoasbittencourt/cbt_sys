function Enemy()
	local self = {}
	local radius = 30
	local speed = 120
	local health = Health(40, "Zombie")
	local physics = PhysicsComponent(Vector(400, 400), radius)

	local function update(dt, player)

		local playerPos = player.getPosition()
		local position = physics.getPosition()

		if playerPos.distanceTo(position) > player.radius + radius then
			physics.setSpeed(position.directionTo(playerPos).mul(speed))
		end

		health.update(dt, position.getX(), position.getY())
	end

	local function draw()
		local position = physics.getPosition()
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

	return self
end