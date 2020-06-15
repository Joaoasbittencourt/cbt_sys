function SkillsBar()
	local self = {}

	self.update = function(dt) end

	self.draw = function(skillComponent)

		local screenHeight = love.graphics.getHeight()
		local skillSquareSize = 40
		local padding = 10
		local bottomPadding = 20
		local baseY = screenHeight - skillSquareSize - padding - bottomPadding
		local baseX = padding + skillSquareSize

		for index, skill in ipairs(skillComponent.getSkills()) do

			local xPivot = baseX + (index - 1) * (skillSquareSize + padding)
			local cooldown = skill.getCooldown().getCompletionPercentage()
			local globalCooldown = skillComponent.getGlobalCooldown().getCompletionPercentage()

			love.graphics.setColor(1, 1, 1, 0.8)
			love.graphics.rectangle("line", xPivot, baseY, skillSquareSize, skillSquareSize)
			love.graphics.setColor(1, 1, 1, 0.2)
			love.graphics.rectangle("fill", xPivot, baseY, skillSquareSize * globalCooldown, skillSquareSize)
			love.graphics.rectangle("fill", xPivot, baseY, skillSquareSize * cooldown, skillSquareSize)
			love.graphics.setColor(0, 0, 0)
			love.graphics.setFont(Fonts.smallest)
			love.graphics.print(skill.name, xPivot, baseY)
		end
	end
	return self
end