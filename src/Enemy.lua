function Enemy()
	local self = {}
	local radius = 30
	local speed = 120
	local health = Health(40)
	local position = Vector(200, 200)

	local function update(dt, player)

		local playerPos = player.getPosition()

		if playerPos.distanceTo(position) > player.radius + radius then
			local dir = position.directionTo(playerPos)
			position = position.add(dir.mul(speed * dt))
		end

		health.update(dt, position.getX(), position.getY())
	end

	local function draw()
		love.graphics.circle("fill", position.getX(), position.getY(), radius)
		health.draw()
	end

	self.update = update
	self.draw = draw
	self.health = health
	self.getPosition = function() return position end
	self.getRadius = function() return radius end

	return self
end