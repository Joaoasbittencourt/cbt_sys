function ColliderComponent(initialPosition, radius, parent)

	local collider = world:newCircleCollider(
		initialPosition.getX(),
		initialPosition.getY(),
		radius
	)

	function collider:getParent()
		return parent
	end

	function collider:getPositionVector()
		local x, y = collider:getPosition()
		return Vector(x, y)
	end

	function collider:setSpeed(vector)
		collider:setLinearVelocity(vector.getX(), vector.getY())
	end

	return collider
end