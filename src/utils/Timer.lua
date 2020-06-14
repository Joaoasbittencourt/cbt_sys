function Timer(maxDuration)
	local self = {}

	local duration = 0

	self.start = function()
		duration = maxDuration
	end

	self.getCompletionPercentage = function()
		return duration / maxDuration
	end

	self.update = function(dt)
		if duration > 0 then
			duration = duration - dt * 1000
		end
		if duration < 0 then
			duration = 0
		end
	end

	self.isRunning = function()
		return duration > 0
	end

	return self
end