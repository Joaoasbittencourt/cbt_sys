require("src/HealthBar")
require("src/HitSplash")
require("src/DamageArea")
require("src/MeleeTarget")
require("src/Health")
require("src/Player")

function love.load()
	love.graphics.setBackgroundColor(0.8, 0.8, 0.8)
	player = Player()
end

function love.update(dt)
	player.update(dt)
end

function love.draw()
	player.draw()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
	   love.event.quit()
	end

	if key == 'q' then
		player.health.insertDamage(4 + math.floor(math.random() * 5))
	end

	if key == 'h' then
		player.health.heal(10)
	end
end

function love.mousepressed (x, y, button, istouch)
end