require("src/HealthBar")
require("src/HitSplash")
require("src/DamageArea")
require("src/Player")

function love.load()
	love.graphics.setBackgroundColor(0.8, 0.8, 0.8)
	player = Player()

	attackTarget = {
		x = 0,
		y = 0,
		radius = 30,
		update = function(self)
			local distance = player.getRadius() + attackTarget.radius
			local mx, my = love.mouse.getPosition()
			local angle = math.atan2(mx - player.getX(), my - player.getY())
			local dy = math.cos(angle) * distance
			local dx = math.sin(angle) * distance
			self.x = player.getX() + dx
			self.y = player.getY() + dy
		end,
		draw = function(self)
			love.graphics.circle("line", self.x, self.y, self.radius)
		end
	}
end

function love.update(dt)
	player.update(dt)
	attackTarget.update(attackTarget)
end

function love.draw()
	player.render()
	attackTarget.draw(attackTarget)
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
end