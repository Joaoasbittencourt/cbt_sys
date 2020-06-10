function AnimationSystem()
	local self = {}
	local animations = {}

	self.push = function(animation)
		table.insert(animations, animation)
	end

	self.update = function(dt)
		for key, anim in pairs(animations) do
			anim.update(dt)
			if anim.isRemoved() then
				table.remove(animations, key)
			end
		end
	end

	self.draw = function()
		for _, anim in pairs(animations) do
			anim.draw()
		end
	end

	return self
end