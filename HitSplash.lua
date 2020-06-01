

function createHitSplash(value, x, y)

	local _x = x
	local _y = y
	local _value = value
	local _duration = 800

	return {

		getDuration = function()
			return _duration
		end,

		update = function(dt)
			local speed = 15
			if _duration > 0 then
				_duration = _duration - dt * 1000
				_y = _y - dt * speed
			else
				_duration = 0
			end
		end,

		draw = function()
			love.graphics.setColor(1, 0, 0)
			love.graphics.print(value, _x, _y)
		end
	}
end
