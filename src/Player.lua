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

		local vertical = 0
		local horizontal = 0

		if love.keyboard.isDown('w') then vertical = -1 end
		if love.keyboard.isDown('s') then vertical = vertical + 1 end
		if love.keyboard.isDown('d') then horizontal = 1 end
		if love.keyboard.isDown('a') then horizontal = horizontal - 1 end

		_y = _y + vertical * _speed * dt
		_x = _x + horizontal * _speed * dt
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
