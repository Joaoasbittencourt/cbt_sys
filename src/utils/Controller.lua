Controller = {}

function Controller.getDxy()
	local vertical = 0
	local horizontal = 0
	if love.keyboard.isDown('w') then vertical = -1 end
	if love.keyboard.isDown('s') then vertical = vertical + 1 end
	if love.keyboard.isDown('d') then horizontal = 1 end
	if love.keyboard.isDown('a') then horizontal = horizontal - 1 end

	local angle = math.atan2(horizontal, vertical)
	local dx = math.sin(angle)
	local dy = math.cos(angle)

	if vertical == 0 then dy = 0 end
	if horizontal == 0 then dx = 0 end

	local function toVec()
		return Vector(dx, dy)
	end

	return {
		dx = dx,
		dy = dy,
		toVec = toVec,
	}
end

function Controller.getGlobalMousePosition()
	local mx, my = love.mouse.getPosition()
	local cameraX, cameraY = camera.getViewport()
	return Vector(mx + cameraX, my + cameraY)
end

function Controller.isLeftClicking()
	return love.mouse.isDown(1)
end