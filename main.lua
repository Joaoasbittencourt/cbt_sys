require("Player")

function love.load()
	p = Player:new()
end

function love.update(dt)
	p:move(dt)
end

function love.draw()
	p:render()
end

