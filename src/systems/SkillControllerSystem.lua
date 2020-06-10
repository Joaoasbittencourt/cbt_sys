function SkillControllerSystem()
	local self = {}

	-- this must be a system or something global that has to do
	-- with the skill manager, a controler or something like that
	-- Will be able to read skills and count their cooldown, manage their cooldowns
	-- have a global cooldown, aswell
	-- skill can also have no effect to selected area, but after some moment can spawn damage areas and they will damage monsters

	-- WE MUST REMOVE THE HARD CODED SKILL FROM HERE

	local onSelection = false
	local origin = Vector(0, 0)
	local skill = {}

	-- Must pass the Skill used, and everything should be handled
	self.peformSkill = function()
		onSelection = true
		skill = {
			baseDamage = 40,
			varDamage = 30,
			radius = 50,
			range = 300
		}
	end

	local resolveSkill = function()
		onSelection = false
		local position = Controller.getGlobalMousePosition()
		local colliders = world:queryCircleArea(position.getX(), position.getY(), skill.radius)
		local damage = skill.baseDamage + math.floor(skill.varDamage * math.random())
		animationSystem.push(FireBombAnimation(position, skill.radius))

		for _, collider in pairs(colliders) do
			if collider.getParent ~= nil then
				local entity = collider:getParent()
				entity.health.insertDamage(damage)
			end
		end
	end

	self.update = function(position, dt)
		origin.set(position)
		if onSelection and Controller.isLeftClicking() then
			resolveSkill()
		end
	end

	self.draw = function ()
		if onSelection then
			love.graphics.setColor(0.25, 0.70, 255)

			-- Drawing range
			love.graphics.circle("line", origin.getX(), origin.getY(), skill.range)

			-- Drawing selection Area
			local mousePos = Controller.getGlobalMousePosition()
			love.graphics.circle("line", mousePos.getX(), mousePos.getY(), skill.radius)
		end
	end

	return self
end
