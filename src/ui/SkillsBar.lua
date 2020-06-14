function SkillsBar()
	local self = {}

	self.update = function(dt) end

	self.draw = function(skillComponent)

		local screenHeight = love.graphics.getHeight()
		local skillSquareSize = 40
		local padding = 10
		local baseY = screenHeight - skillSquareSize - padding
		local baseX = padding + skillSquareSize
		local cooldownBarHeight = 8

		love.graphics.setColor(1, 1, 1, 0.8)
		love.graphics.rectangle("line", baseX, baseY, skillSquareSize, skillSquareSize)
		love.graphics.rectangle(
			"fill",
			baseX,
			baseY - padding - cooldownBarHeight,
			skillSquareSize * skillComponent.getGlobalCooldown().getCompletionPercentage(),
			cooldownBarHeight
		)
	end
	return self
end