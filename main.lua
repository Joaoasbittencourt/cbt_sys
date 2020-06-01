require("src/HitSplash")
require("src/Player")

function love.load()
	love.graphics.setBackgroundColor(0.8, 0.8, 0.8)
	player = Player()
end

function love.update(dt)
	player.update(dt)
end

function love.draw()
	player.render()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
	   love.event.quit()
	end

	if key == 'q' then
		player.insertDamage(4 + math.floor(math.random() * 5))
	end

	if key == 'h' then
	end
end