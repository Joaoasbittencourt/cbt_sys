function SkillControllerSystem(caster)
	local self = {}

	-- this must be a system or something global that has to do
	-- with the skill manager, a controler or something like that
	-- Will be able to read skills and count their cooldown, manage their cooldowns
	-- have a global cooldown, aswell
	-- skill can also have no effect to selected area, but after some moment can spawn damage areas and they will damage monsters

	local maxGlobalCooldown = 1000
	local globalCooldown = 0

	local selectedSkillId = 0

	self.peformSkill = function(skillId)
		selectedSkillId = skillId
	end

	local getSelectedSkill = function()
		return Skills[selectedSkillId]
	end

	local resolveSkill = function()

		if globalCooldown > 0 then
			-- skill still on cooldown
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
		globalCooldown = maxGlobalCooldown

	end

	self.update = function(dt)

		if globalCooldown > 0 then
			globalCooldown = globalCooldown - dt * 1000
		end
		if globalCooldown < 0 then
			globalCooldown = 0
		end

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

	return self
end
