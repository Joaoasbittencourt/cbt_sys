function PhysicsComponent(initialPosition, radius, type)
	local self = {}


	if type == "box" then
		self.collider = world:newRectangleCollider(
			initialPosition.getX(),
			initialPosition.getY(),
			100,
			100
		)
		self.collider:setType("static")

	else
		self.collider = world:newCircleCollider(
			initialPosition.getX(),
			initialPosition.getY(),
			radius
		)
	end

	self.getPosition = function ()
		local x, y = self.collider:getPosition()
		return Vector(x, y)
	end

	self.setSpeed = function (vector)
		self.collider:setLinearVelocity(vector.getX(), vector.getY())
	end

	return self
end