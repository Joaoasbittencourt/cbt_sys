function SkillComponent(caster)
	local self = {}

	local skills = {
		[1] = FireBomb()
	}

	local selectedSkillId = 0

	local globalCooldown = Timer(1000)

	local getSelectedSkill = function()
		return skills[selectedSkillId]
	end

	local resolveSkill = function()

		-- Still on global cooldown
		if globalCooldown.isRunning() then
			selectedSkillId = 0
			return
		end

		local skill = getSelectedSkill()
		local skillRadius = skill.getAreaOfEffectRadius()
		local position = Controller.getGlobalMousePosition()
		local colliders = world:queryCircleArea(position.getX(), position.getY(), skillRadius)
		local damage = skill.getDamage()
		animationSystem.push(FireBombAnimation(position, skillRadius))

		for _, collider in pairs(colliders) do
			if collider.getParent ~= nil then
				local entity = collider:getParent()
				entity.health.insertDamage(damage)
			end
		end

		selectedSkillId = 0
		globalCooldown.start()

	end

	self.peformSkill = function(skillId)
		selectedSkillId = skillId
	end

	self.update = function(dt)

		globalCooldown.update(dt)

		if selectedSkillId > 0 and Controller.isLeftClicking() then
			resolveSkill()
		end
	end

	self.draw = function ()
		local casterPosition = caster.getPosition()
		local selectedSkill = getSelectedSkill()

		if selectedSkillId > 0 then
			local mousePos = Controller.getGlobalMousePosition()
			love.graphics.setColor(0.25, 0.70, 255)
			love.graphics.circle("line", casterPosition.getX(), casterPosition.getY(), selectedSkill.getRange())
			love.graphics.circle("line", mousePos.getX(), mousePos.getY(), selectedSkill.getAreaOfEffectRadius())
		end
	end

	self.getGlobalCooldown = function()
		return globalCooldown
	end

	return self
end
