
-- Libraries
wf = require("libs/windfield")
camera = require("src/utils/Camera")

-- assets
require("assets/tiles/tile_map")

-- Utils
require("src/utils/HealthBar")
require("src/utils/Controller")
require("src/utils/Loader")
require("src/utils/Vector")

-- Components
require("src/Components/HealthComponent")
require("src/Components/MeleeTargetComponent")
require("src/Components/ColliderComponent")

-- Entities
require("src/entities/HitSplashEntity")
require("src/entities/DamageAreaEntity")
require("src/entities/EnemyEntity")
require("src/entities/PlayerEntity")

-- Systems
require("src/systems/SkillControllerSystem")


function love.load()

	showCollidables = false

	world = wf.newWorld()
	map = Loader.loadTiledMap("assets/tiles/tile_map")
	camera.setBoundary(0, 0, 1024, 1024)
	player = PlayerEntity()
	enemies = {}
	skills = SkillControllerSystem()
end

function love.update(dt)

	world:update(dt)
	player.update(dt)
	camera.lookAt(player.getPosition())
	skills.update(player.getPosition(), dt)


	-- Send this handling to the EntitySystem
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
			map:draw()
			player.draw()
			for key, enemy in pairs(enemies) do
				enemy.draw()
			end

			skills.draw()

			if showCollidables then
				world:draw()
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

	if key == "c" then
		showCollidables = not showCollidables
	end
end

function love.mousepressed(x, y, button, istouch)

	local targetPos = player.getTarget().getPosition()

	for key, enemy in pairs(enemies) do
		if targetPos.distanceTo(enemy.getPosition()) < player.radius + enemy.getRadius() then
			enemy.health.insertDamage(20 + math.floor(math.random() * 5))
			enemy.addImpact(player.getPosition(), 3000)
		end
	end
 end
