function PlayerEntity()

	local self = {}

	local name = "João Pedro"
	local radius = 15
	local speed = 200
	local health = HealthComponent(radius, name)
	local target = WeaponComponent()
	local collider = ColliderComponent(Vector(500, 400), radius, self)
	local skillComponent = SkillComponent(self)

	local update = function(dt)
		local position = collider.getPositionVector()
		health.update(dt, position.getX(), position.getY())
		target.update(position, radius)
		skillComponent.update(dt)

		if health.isDead() then return end
		collider:setSpeed(Controller.getDxy().toVec().mul(speed))
	end

	local draw = function()
		local position = collider.getPositionVector()
		love.graphics.setColor(0, 0, 1);
		love.graphics.circle("fill", position.getX(), position.getY(), radius)
		love.graphics.setColor(0, 1, 0)
		skillComponent.draw()
		health.draw()
		target.draw()
	end

	self.skillComponent = skillComponent

	self.performSkill = skillComponent.peformSkill
	self.getPosition = collider.getPositionVector
	self.update = update
	self.draw = draw
	self.radius = radius
	self.health = health
	self.getTarget = function() return target end

	return self
end
