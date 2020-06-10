function FireBombAnimation(position, radius)

	local self = {}
	local maxDuration = 800
	local duration = maxDuration

	self.update = function(dt)
		if (duration > 0) then
			duration = duration - dt * 1000
		end
	end

	self.isRemoved = function()
		return duration <= 0
	end

	self.draw = function()
		if duration > 0 then
			love.graphics.setColor(0.7, 0.1, 0.1, 1 * duration / maxDuration)
			love.graphics.circle("fill", position.getX(), position.getY(), radius)
		end
	end

	return self
end