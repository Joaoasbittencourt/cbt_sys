HitSplashEntity = {}

function HitSplashEntity:new(value, x, y)
	local hitSplash = {}
	setmetatable(hitSplash, self)
	self.__index = self

	hitSplash.x = x or 0
	hitSplash.y = y or 0
	hitSplash.value = value or 0
	hitSplash.duration = 800
	hitSplash.speed = 200

	return hitSplash
end

function HitSplashEntity:update(dt)
	self.speed = self.speed * 0.95
	if self.duration > 0 then
		self.duration = self.duration - dt * 1000
		self.y = self.y - dt * self.speed
	else
		self.duration = 0
	end
end

function HitSplashEntity:draw()
	if self.value < 0 then
		love.graphics.setColor(1, 0, 0)
	else
		love.graphics.setColor(0, 1, 0)
	end
	love.graphics.print(self.value, self.x, self.y)
end
