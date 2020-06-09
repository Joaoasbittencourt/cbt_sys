function SkillControllerSystem()
	local self = {}

	-- this must be a system or something global that has to do
	-- with the skill manager, a controler or something like that
	-- Will be able to read skills and count their cooldown, manage their cooldowns
	-- have a globla cooldown, aswell
	-- skill can also have no effect to selected area, but after some moment can spawn damage areas and they will damage monsters

	local onSelection = 1

	local radius = 50
	local range = 300
	local origin = Vector(0, 0)

	-- Must pass the Skill used, and everything should be handled
	-- self.startSkill()

	self.query = function(position, radius, onSelect)

		local entities = {}
		local colliders = world:queryCircleArea(position.getX(), position.getY(), radius)

		for k, collider in pairs(colliders) do
			local entity = collider.getParent()
			table.insert(entities, entity)
		end

		onSelect(entities)
	end

	self.update = function(position, dt)
		origin.set(position)
		Controller.getGlobalMousePosition()
	end

	self.draw = function ()
		if onSelection then

			love.graphics.setColor(0.25, 0.70, 255)

			-- Drawing range
			love.graphics.circle("line", origin.getX(), origin.getY(), range)

			-- Drawing selection Area
			local mousePos = Controller.getGlobalMousePosition()
			love.graphics.circle("line", mousePos.getX(), mousePos.getY(), radius)
		end
	end

	return self
end
