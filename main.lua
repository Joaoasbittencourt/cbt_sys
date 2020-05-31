require("Player")

function love.load()
	love.graphics.setBackgroundColor(0.8, 0.8, 0.8)
	PLAYER = Player:new()
end

function love.update(dt)
	PLAYER:move(dt)
end

function love.draw()
	PLAYER:render()
end

