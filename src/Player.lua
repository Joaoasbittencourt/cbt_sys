Player = {}

function Player:new(player)
	player = player or {}
	setmetatable(player, self)
	self.__index = self

	player.radius = 30
	player.speed = 200
	player.position = Vector(100, 100)
	player.health = Health(player.radius)
	player.target = MeleeTarget()

	return player
end

function Player:update(dt)
	local x = self.position.getX()
	local y = self.position.getY()

	self.health.update(dt, x, y)
	self.target.update(self.position, self.radius)

	if self.health.isDead() then return end
	self.position = self.position.add(Controller.getDxy().toVec().mul(self.speed * dt))

end

function Player:draw()
	love.graphics.setColor(0, 0, 1);
	love.graphics.circle("fill", self.position.getX(), self.position.getY() , self.radius)
	love.graphics.setColor(0, 1, 0);
	self.health.draw()
	self.target.draw()
end
