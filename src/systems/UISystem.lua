function UISystem()
	local self = {}
	local uiComponents = {}

	self.push = function(animation)
		table.insert(uiComponents, animation)
	end

	self.update = function(dt)
		for key, component in pairs(uiComponents) do
			component.update(dt)
			if component.isRemoved() then
				table.remove(uiComponents, key)
			end
		end
	end

	self.draw = function()
		for _, component in pairs(uiComponents) do
			component.draw()
		end
	end

	return self
end