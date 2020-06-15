wf = require("libs/windfield")
camera = require("src/utils/Camera")

require("src.utils.Timer")
require("assets/tiles/tile_map")
require("src.ui.SkillsBar")
require("src/animations/FireBombAnimation")
require("src.skills.FireBomb")
require("src.skills.Heal")
require("src/utils/HealthBar")
require("src/utils/Controller")
require("src/utils/Loader")
require("src/utils/Vector")
require("src/utils/Fonts")
require("src/components/HealthComponent")
require("src/components/WeaponComponent")
require("src/components/ColliderComponent")
require("src/components/SkillComponent")
require("src/entities/HitSplashEntity")
require("src/entities/CircularDamageAreaEntity")
require("src/entities/EnemyEntity")
require("src/entities/PlayerEntity")
require("src/systems/AnimationSystem")
require("src/systems/UISystem")
require("src/systems/EnemySystem")
require("src/systems/DamageAreaSystem")


function love.load()
	world = wf.newWorld()
	map = Loader.loadTiledMap("assets/tiles/tile_map")
	camera.setMap(map)
	player = PlayerEntity()
	enemySystem = EnemySystem()
	animationSystem = AnimationSystem()
	uiSystem = UISystem()
	damageAreaSystem = DamageAreaSystem()
end

function love.update(dt)
	world:update(dt)
	player.update(dt)
	camera.lookAt(player.getPosition())
	enemySystem.update(dt)
	damageAreaSystem.update(dt)
	animationSystem.update(dt)
end

function love.draw()
	camera.draw(
		function()
			map:draw()
			player.draw()
			enemySystem.draw()
			animationSystem.draw()
			damageAreaSystem.draw()
		end
	)
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
		player.performSkill(2)
	end

	if key == 'h' then
		enemySystem.push(EnemyEntity())
	end
end
