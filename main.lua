
function love.load()
	player = {}
	player.radius = 20
	player.x = 100
	player.y = 100
	player.health = 100
	player.mana = 100
	player.speed = 200

end

function love.update(dt)

	vertical = 0
	horizontal = 0

	if love.keyboard.isDown('w') then
		vertical = -1
	end

	if love.keyboard.isDown('s') then
		vertical = vertical + 1
	end

	if love.keyboard.isDown('d') then
		horizontal = 1
	end

	if love.keyboard.isDown('a') then
		horizontal = horizontal - 1
	end

	player.y = player.y + vertical * player.speed * dt
	player.x = player.x + horizontal * player.speed * dt
end

function love.draw()
	love.graphics.setColor(0, 0, 1);
	love.graphics.circle("fill", player.x, player.y, player.radius)
end

