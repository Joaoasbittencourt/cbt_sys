function PlayerEntity()

	local self = {}

	local name = "João Pedro"
	local radius = 15
	local speed = 200
	local health = HealthComponent(radius, name)
	local target = MeleeTargetComponent()
	local collider = ColliderComponent(Vector(500, 400), radius, self)

	local update = function(dt)
		local position = collider.getPositionVector()
		health.update(dt, position.getX(), position.getY())
		target.update(position, radius)

		if health.isDead() then return end
		collider:setSpeed(Controller.getDxy().toVec().mul(speed))
	end

	local draw = function()
		local position = collider.getPositionVector()
		love.graphics.setColor(0, 0, 1);
		love.graphics.circle("fill", position.getX(), position.getY(), radius)
		love.graphics.setColor(0, 1, 0);
		health.draw()
		target.draw()
	end


		self.getPosition = collider.getPositionVector
		self.update = update
		self.draw = draw
		self.radius = radius
		self.health = health
		self.getTarget = function() return target end

	return self
end
