function HitSplash(value, x, y)

	local _x = x
	local _y = y
	local _duration = 800
	local _speed = 200

	local function getDuration()
		return _duration
	end

	local function update(dt)
		_speed = _speed * 0.95
		if _duration > 0 then
			_duration = _duration - dt * 1000
			_y = _y - dt * _speed
		else
			_duration = 0
		end
	end

	local function draw()
		if value < 0 then
			love.graphics.setColor(1, 0, 0)
		else
			love.graphics.setColor(0, 1, 0)
		end
		love.graphics.print(value, _x, _y)
	end

	return {
		getDuration = getDuration,
		update = update,
		draw = draw
	}
end
