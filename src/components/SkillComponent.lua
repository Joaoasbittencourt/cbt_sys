function SkillComponent(caster)

	local self = {}
	local selectedSkillId = 0
	local globalCooldown = Timer(1000)

	local skills = {
		[1] = FireBomb(),
		[2] = Heal()
	}

	local getSelectedSkill = function()
		return skills[selectedSkillId]
	end

	local resolveSkill = function()

		-- Still on global cooldown
		if globalCooldown.isRunning() then
			selectedSkillId = 0
			return
		end

		getSelectedSkill().cast(caster, globalCooldown.start)

		selectedSkillId = 0
	end

	self.peformSkill = function(skillId)
		selectedSkillId = skillId
	end

	self.update = function(dt)

		globalCooldown.update(dt)

		for key, skill in pairs(skills) do
			skill.update(dt)
		end

		if selectedSkillId > 0 and not getSelectedSkill().aim then
			resolveSkill()
		end

		if selectedSkillId > 0 and getSelectedSkill().aim and Controller.isLeftClicking() then
			resolveSkill()
		end
	end

	self.draw = function ()
		local casterPosition = caster.getPosition()
		local selectedSkill = getSelectedSkill()

		if selectedSkillId > 0 and selectedSkill.aim then
			local mousePos = Controller.getGlobalMousePosition()
			love.graphics.setColor(0.25, 0.70, 255)
			love.graphics.circle("line", casterPosition.getX(), casterPosition.getY(), selectedSkill.getRange())
			love.graphics.circle("line", mousePos.getX(), mousePos.getY(), selectedSkill.getAreaOfEffectRadius())
		end
	end

	self.getGlobalCooldown = function()
		return globalCooldown
	end

	self.getSkills = function()
		return skills
	end

	return self
end
