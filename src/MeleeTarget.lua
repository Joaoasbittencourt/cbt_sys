function MeleeTarget()

	local self = {}

	local position = Vector(0, 0)
	local radius = 30

	local function update(originVec, distance)
		local mx, my = love.mouse.getPosition()
		position = Vector(mx, my)
			.sub(originVec)
			.getUnit()
			.mul(distance + radius)
			.add(originVec)
	end

	local function draw()
		love.graphics.circle("line", position.getX(), position.getY(), radius)
	end

	self.draw = draw
	self.update = update
	return self
end