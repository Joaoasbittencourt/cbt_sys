
-- Libraries
wf = require("libs/windfield")

-- Modules
camera = require("src/utils/Camera")

-- Utils
require("src.utils.Timer")

-- Assets
require("assets/tiles/tile_map")

-- UI
require("src.ui.SkillsBar")

-- Animations
require("src/animations/FireBombAnimation")

-- Skills
require("src.skills.FireBomb")

-- Utils
require("src/utils/HealthBar")
require("src/utils/Controller")
require("src/utils/Loader")
require("src/utils/Vector")
require("src/utils/Fonts")

-- Components
require("src/components/HealthComponent")
require("src/components/WeaponComponent")
require("src/components/ColliderComponent")
require("src/components/SkillComponent")

-- Entities
require("src/entities/HitSplashEntity")
require("src/entities/DamageAreaEntity")
require("src/entities/EnemyEntity")
require("src/entities/PlayerEntity")

-- Systems
require("src/systems/AnimationSystem")
require("src/systems/UISystem")
require("src/systems/EnemySystem")



function love.load()
	world = wf.newWorld()
	map = Loader.loadTiledMap("assets/tiles/tile_map")
	camera.setMap(map)
	player = PlayerEntity()
	enemySystem = EnemySystem()
	animationSystem = AnimationSystem()
	uiSystem = UISystem()
end

function love.update(dt)
	world:update(dt)
	player.update(dt)
	camera.lookAt(player.getPosition())
	enemySystem.update(dt)
	animationSystem.update(dt)
end

function love.draw()
	camera.draw(function()
		map:draw()
		player.draw()
		enemySystem.draw()
		animationSystem.draw()
	end)
	uiSystem.draw(player.skillComponent)
end

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
	   love.event.quit()
	end

	if key == 'q' then
		player.performSkill(1)
	end

	if key == 'e' then
		player.health.heal(2 +  math.floor(math.random() * 9))
	end

	if key == 'h' then
		enemySystem.push(EnemyEntity())
	end

	if key == "c" then
		showCollidables = not showCollidables
	end
end
