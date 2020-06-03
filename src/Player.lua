function Player()

	local _x = 100
	local _y = 100
	local _radius = 30
	local _speed = 200
	local health = Health(_radius)
	local target = MeleeTarget()

	local function _move(dt)
		if health.isDead() then
			return
		end

		local displacement = Controller.getDisplacement(dt, _speed)
		_y = _y + displacement.dy
		_x = _x + displacement.dx
	end

	local function _update(dt)
		_move(dt)
		health.update(dt, _x, _y)
		target.update(_x, _y, _radius)
	end

	local function _draw()
		love.graphics.setColor(0, 0, 1);
		love.graphics.circle("fill", _x, _y, _radius)
		love.graphics.setColor(0, 1, 0);
		health.draw()
		target.draw()
	end

	return {
		health = health,
		update = _update,
		draw = _draw,
		getRadius = function() return _radius end,
		getX = function() return _x end,
		getY = function() return _y end,
	}
end
