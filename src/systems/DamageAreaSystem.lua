function DamageAreaSystem()
	local self = {}
	local areas = {}

	self.push = function(area)
		table.insert(areas, area)
	end

	self.update = function(dt)
		for key, area in pairs(areas) do
			area.update(dt)
			if area.isRemoved then
				table.remove(areas, key)
			end
		end
	end

	self.draw = function()
		for _, area in pairs(areas) do
			area.draw()
		end
	end

	return self
end