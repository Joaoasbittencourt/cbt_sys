HitSplash = {
	value = 0,
}

function HitSplash:new(value, x, y)
	setmetatable({}, HitSplash)

	self.x = x
	self.y = y
	self.value = value
	self.duration = 10000

	return self
end

function HitSplash:update(dt)

	local hitsplashSpeed = 20

	if self.duration > 0 then
		self.duration = self.duration - dt * 1000
		self.y = self.y - dt * hitsplashSpeed
	else
		self.duration = 0
	end
end

function HitSplash:draw()
	love.graphics.setColor(1, 0, 0)
	love.graphics.print(self.value, self.x, self.y)
end