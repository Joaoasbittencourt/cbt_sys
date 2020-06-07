function BoxEntity(position)
	local self = {}

	self.physics = PhysicsComponent(position, 50, "box")

	return self
end