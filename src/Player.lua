function Player()

	local radius = 30
	local speed = 200
	local position = Vector(300, 300)
	local health = Health(radius)
	local target = MeleeTarget()

	local update = function(dt)
		local x = position.getX()
		local y = position.getY()

		health.update(dt, x, y)
		target.update(position, radius)

		if health.isDead() then return end

		position.set(
			position.add(
				Controller.getDxy().toVec().mul(speed * dt)
			)
		)
	end

	local draw = function()
		love.graphics.setColor(0, 0, 1);
		love.graphics.circle("fill", position.getX(), position.getY() , radius)
		love.graphics.setColor(0, 1, 0);
		health.draw()
		target.draw()
	end

	return {
		update = update,
		draw = draw,
		position = position,
		radius = radius,
		health = health
	}

end
