function renderHealthBar(percentage, x, y, name)

	local nameFromBar = 20
	local width = 65;
	local height = 8;
	local offset = 15;
	local healthBarFrameWidth = 2
	local frameOffset = healthBarFrameWidth / 2
	local xOffset = x - width / 2
	local yOffset = y - height - offset

	love.graphics.setColor(0, 0, 0);
	love.graphics.setLineWidth(healthBarFrameWidth)
	love.graphics.rectangle(
		"line",
		xOffset - frameOffset,
		yOffset - frameOffset,
		width + healthBarFrameWidth,
		height + healthBarFrameWidth
	)

	love.graphics.setColor(1 - percentage, percentage, 0)
	love.graphics.rectangle("fill", xOffset, yOffset, width * percentage, height)
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(Fonts.small)
	love.graphics.printf(name or "", xOffset, yOffset - nameFromBar, width, "center")
end