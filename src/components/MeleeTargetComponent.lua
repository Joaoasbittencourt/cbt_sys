function MeleeTargetComponent()

	local self = {}

	local position = Vector(0, 0)
	local radius = 30

	local function update(originVec, distance)
		local mx, my = love.mouse.getPosition()
		position.set(
			Vector(mx, my)
			.sub(originVec)
			.getUnit()
			.mul(distance + radius)
			.add(originVec)
		)
	end

	local function draw()
		love.graphics.circle("line", position.getX(), position.getY(), radius)
	end

	self.draw = draw
	self.update = update
	self.getPosition = function () return position end
	return self
end