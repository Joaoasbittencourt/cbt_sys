function MeleeTargetComponent()

	local self = {}

	local position = Vector(0, 0)
	local radius = 20

	local function update(originVec, distance)
		local mx, my = love.mouse.getPosition()
		local cameraX, cameraY = camera.getViewport()
		local globalMousePos = Vector(mx + cameraX, my + cameraY)
		position.set(
			globalMousePos
			.sub(originVec)
			.getUnit()
			.mul(distance + radius)
			.add(originVec)
		)
	end

	local function draw()
		love.graphics.setColor(0.9, 0.9, 0.9)
		love.graphics.circle("line", position.getX(), position.getY(), radius)
	end

	self.draw = draw
	self.update = update
	self.getPosition = function () return position end
	return self
end