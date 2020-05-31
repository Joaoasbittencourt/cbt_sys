Player = {
	radius = 30,
	x = 100,
	y = 100,
	health = 100,
	maxHealth = 100,
	mana = 100,
	maxMana = 100,
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

	if love.keyboard.isDown('w') then vertical = -1 end
	if love.keyboard.isDown('s') then vertical = vertical + 1 end
	if love.keyboard.isDown('d') then horizontal = 1 end
	if love.keyboard.isDown('a') then horizontal = horizontal - 1 end

	self.y = self.y + vertical * self.speed * dt
	self.x = self.x + horizontal * self.speed * dt
end

function Player:render()
	love.graphics.setColor(0, 0, 1);
	love.graphics.circle("fill", self.x, self.y, self.radius)
	love.graphics.setColor(0, 1, 0);

	self:_renderHealthBar()
end

function Player:_renderHealthBar()

	local width = 65;
	local height = 8;
	local distanceFromPlayer = 20;
	local percentage = self.health / self.maxHealth;

	local xOffset = self.x - width / 2
	local yOffset = self.y - self.radius - distanceFromPlayer - height

	love.graphics.setColor(1, 1, 1);
	love.graphics.rectangle("line", xOffset, yOffset, width, height);
	love.graphics.setColor(1 - percentage, percentage, 0.05);
	love.graphics.rectangle("fill", xOffset, yOffset, width * percentage, height);

end
