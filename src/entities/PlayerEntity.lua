function PlayerEntity()

	local name = "João Pedro"
	local radius = 30
	local speed = 200
	local health = HealthComponent(radius, name)
	local target = MeleeTargetComponent()
	local physics = PhysicsComponent(Vector(100, 100), radius)

	local update = function(dt)
		local position = physics.getPosition()

		health.update(dt, position.getX(), position.getY())
		target.update(position, radius)
		camera.lookAt(position.getX(), position.getY())

		if health.isDead() then return end
		physics.setSpeed(Controller.getDxy().toVec().mul(speed))
	end

	local draw = function()
		local position = physics.getPosition()
		love.graphics.setColor(0, 0, 1);
		love.graphics.circle("fill", position.getX(), position.getY() , radius)
		love.graphics.setColor(0, 1, 0);
		health.draw()
		target.draw()
	end

	return {
		getPosition = physics.getPosition,
		update = update,
		draw = draw,
		radius = radius,
		health = health,
		getTarget = function() return target end
	}
end
