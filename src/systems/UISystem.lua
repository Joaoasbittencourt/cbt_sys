function UISystem()
	local self = {}
	local skillBar = SkillsBar()

	self.update = function(dt)
	end

	self.draw = function(skillComponent)
		skillBar.draw(skillComponent)
	end

	return self
end