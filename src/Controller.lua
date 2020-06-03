Controller = {}

Controller.getDisplacement = function(dt, speed)
	local vertical = 0
	local horizontal = 0
	if love.keyboard.isDown('w') then vertical = -1 end
	if love.keyboard.isDown('s') then vertical = vertical + 1 end
	if love.keyboard.isDown('d') then horizontal = 1 end
	if love.keyboard.isDown('a') then horizontal = horizontal - 1 end

	local angle = math.atan2(horizontal, vertical)
	local dx = speed * dt * math.sin(angle)
	local dy = speed * dt * math.cos(angle)

	if vertical == 0 then dy = 0 end
	if horizontal == 0 then dx = 0 end

	return {
		dx = dx,
		dy = dy
	}
end