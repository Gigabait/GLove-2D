function love.mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)
	menuClick(x,y)
end

function love.mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
	hook.Call("KeyPressed", nil, key, unicode)
	loveframes.keypressed(key, unicode)
end

function love.keyreleased(key)
	loveframes.keyreleased(key)
end

function love.textinput(text) 
	loveframes.textinput(text)
end