function EnemySystem()
	local self = {}
	local enemies = {}

	self.push = function(enemy)
		table.insert(enemies, enemy)
	end

	self.update = function(dt)
		for key, enemy in pairs(enemies) do
			enemy.update(dt, player)
			if enemy.health.isDead() then
				enemy:destroy()
				table.remove(enemies, key)
			end
		end
	end

	self.draw = function()
		for _, enemy in pairs(enemies) do
			enemy.draw()
		end
	end

	return self
end