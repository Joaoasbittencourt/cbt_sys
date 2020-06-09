function ColliderComponent(initialPosition, radius, parent)

	local collider = world:newCircleCollider(
		initialPosition.getX(),
		initialPosition.getY(),
		radius
	)

	collider.getParent = function()
		return parent
	end

	collider.getPositionVector = function ()
		local x, y = collider:getPosition()
		return Vector(x, y)
	end

	collider.addImpact = function(sourcePosition, magnitude)
		local impulse = sourcePosition
			.directionTo(collider.getPositionVector())
			.getUnit().mul(magnitude)

		collider:applyLinearImpulse(impulse.getX(), impulse.getY())
	end

	collider.setSpeed = function (vector)
		collider:setLinearVelocity(vector.getX(), vector.getY())
	end

	collider.dispose = function()
		collider:destroy()
	end

	return collider
end