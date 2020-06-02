require("src/HealthBar")
require("src/HitSplash")
require("src/DamageArea")
require("src/Player")

function love.load()
	love.graphics.setBackgroundColor(0.8, 0.8, 0.8)
	player = Player()

	damageAreas = {}
end

function love.update(dt)
	player.update(dt)

	for k, v in pairs(damageAreas) do
		if math.sqrt((player.getX() - v.getX()) ^ 2 + (player.getY() - v.getY()) ^ 2) < player.getRadius() + v.getRadius()  then
			v.computeDamage(player)
			table.remove(damageAreas, k)
		end
	end

end

function love.draw()
	player.render()

	for k, v in pairs(damageAreas) do
		v.draw()
	end
end

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
	   love.event.quit()
	end

	if key == 'q' then
		player.insertDamage(4 + math.floor(math.random() * 5))
	end

	if key == 'h' then
		player.heal(10)
	end
end

function love.mousepressed (x, y, button, istouch)
	if button == 1 then
		table.insert(damageAreas, DamageArea(10, x, y, 100))
	end
end