function MeleeTarget()

	local x = 0
	local y = 0
	local radius = 30

	local function update(originX, originY, distance)
		local mx, my = love.mouse.getPosition()
		local angle = math.atan2(mx - originX, my - originY)
		local dy = math.cos(angle) * (distance + radius)
		local dx = math.sin(angle) * (distance + radius)
		x = originX + dx
		y = originY + dy
	end

	local function draw()
		love.graphics.circle("line", x, y, radius)
	end

	return {
		draw = draw,
		update = update
	}
end