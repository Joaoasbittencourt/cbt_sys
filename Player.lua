Player = {
	radius = 20,
	x = 100,
	y = 100,
	health = 100,
	mana = 100,
	speed = 200,
	name = "Player 1",
	level = 1,
}

function Player:new()
	setmetatable({}, Player)

	return self
end

function Player:move(dt)
	local vertical = 0
	local horizontal = 0

	if love.keyboard.isDown('w') then
		vertical = -1
	end

	if love.keyboard.isDown('s') then
		vertical = vertical + 1
	end

	if love.keyboard.isDown('d') then
		horizontal = 1
	end

	if love.keyboard.isDown('a') then
		horizontal = horizontal - 1
	end

	self.y = self.y + vertical * self.speed * dt
	self.x = self.x + horizontal * self.speed * dt
end

function Player:render()
	love.graphics.setColor(0, 0, 1);
	love.graphics.circle("fill", self.x, self.y, self.radius)
	love.graphics.setColor(0, 1, 0);
end

