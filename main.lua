require("src/HealthBar")
require("src/HitSplash")
require("src/DamageArea")
require("src/MeleeTarget")
require("src/Health")
require("src/Controller")
require("src/Vector")
require("src/Enemy")
require("src/Player")

wf = require("libs/windfield")


function love.load()
	love.graphics.setBackgroundColor(0.8, 0.8, 0.8)
	player = Player()
	enemies = {}
end

function love.update(dt)

	player.update(dt)

	for key, enemy in pairs(enemies) do
		enemy.update(dt, player)

		if enemy.health.isDead() then
			table.remove(enemies, key)
		end
	end
end

function love.draw()
	player.draw()
	for key, enemy in pairs(enemies) do
		enemy.draw()
	end
end

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
	   love.event.quit()
	end

	if key == 'q' then
		player.health.insertDamage(4 + math.floor(math.random() * 5))
	end

	if key == 'e' then
		player.health.heal(10)
	end

	if key == 'h' then
		table.insert(enemies, Enemy())
	end
end

function love.mousepressed(x, y, button, istouch)

	local targetPos = player.getTarget().getPosition()

	for key, enemy in pairs(enemies) do
		if targetPos.distanceTo(enemy.getPosition()) < player.radius + enemy.getRadius()  then
			enemy.health.insertDamage(4 + math.floor(math.random() * 5))
		end
	end
 end
