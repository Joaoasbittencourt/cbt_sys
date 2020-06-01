require("HitSplash")
require("Player")

function love.load()
	love.graphics.setBackgroundColor(0.8, 0.8, 0.8)
	PLAYER = Player:new()
end

function love.update(dt)
	PLAYER:update(dt)
end

function love.draw()
	PLAYER:render()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
	   love.event.quit()
	end

	if key == 'q' then

		PLAYER:insertDamage(4 + math.floor(math.random() * 5))
	end

	if key == 'h' then
	end
end