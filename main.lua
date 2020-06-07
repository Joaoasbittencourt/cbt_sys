
-- Libraries
wf = require("libs/windfield")
camera = require("src/utils/Camera")


-- Utils
require("src/utils/HealthBar")
require("src/utils/Controller")
require("src/utils/Vector")


-- Components
require("src/Components/HealthComponent")
require("src/Components/MeleeTargetComponent")
require("src/Components/PhysicsComponent")


-- Entities
require("src/entities/HitSplashEntity")
require("src/entities/DamageAreaEntity")
require("src/entities/EnemyEntity")
require("src/entities/PlayerEntity")
require("src/entities/BoxEntity")


function love.load()

	camera.setBoundary(0, 0, 2000, 3000)
	world = wf.newWorld()

	love.graphics.setBackgroundColor(0.8, 0.8, 0.8)
	player = PlayerEntity()
	enemies = {}


	local box1 = BoxEntity(Vector(100, 300))
	local box2 = BoxEntity(Vector(300, 300))
end

function love.update(dt)

	player.update(dt)
	world:update(dt)

	for key, enemy in pairs(enemies) do
		enemy.update(dt, player)

		if enemy.health.isDead() then
			enemy.destroy()
			table.remove(enemies, key)
		end
	end
end

function love.draw()
	camera.draw(
		function()
			world:draw()
			player.draw()
			for key, enemy in pairs(enemies) do
				enemy.draw()
			end
		end
	)
end

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
	   love.event.quit()
	end

	if key == 'q' then
		player.health.insertDamage(4 + math.floor(math.random() * 5))
	end

	if key == 'e' then
		player.health.heal(2 +  math.floor(math.random() * 9))
	end

	if key == 'h' then
		table.insert(enemies, EnemyEntity())
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
