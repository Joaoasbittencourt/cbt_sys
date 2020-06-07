function BoxEntity(position)
	local self = {}

	self.physics = PhysicsComponent(position, 100, "box")

	return self
end