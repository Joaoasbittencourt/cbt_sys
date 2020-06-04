function Player()

	local self = {}
	local _radius = 30
	local _speed = 200
	local position = Vector(100, 100)
	local health = Health(_radius)
	local target = MeleeTarget()

	local function _update(dt)
		local x = position.getX()
		local y = position.getY()
		health.update(dt, x, y)
		target.update(position, _radius)

		if health.isDead() then return end
		position = position.add(Controller.getDxy().toVec().mul(_speed * dt))
	end

	local function _draw()
		love.graphics.setColor(0, 0, 1);
		love.graphics.circle("fill", position.getX(), position.getY() , _radius)
		love.graphics.setColor(0, 1, 0);
		health.draw()
		target.draw()
	end


	self.health = health
	self.update = _update
	self.draw = _draw
	self.getX = position.getX
	self.getY = position.getY
	self.getRadius = function() return _radius end
	return self
end
