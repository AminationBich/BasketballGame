require("ball")
require("basket")
require("player")

function love.load()

	background = love.graphics.newImage("Textures/background.png")

	initBasket()
	initPlayer()
  initBall()
	
end

function love.update(dt)

	playerUpdate(dt)
  ballUpdate(dt)
	basketUpdate(dt)

end

function love.draw()

	love.graphics.draw(background,0,0)

	drawPlayer()
  drawBall()
  drawBasket()
	
end