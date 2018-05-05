require("ball")
require("basket")
require("player")
require("shuriken")

function love.load()

	background = love.graphics.newImage("Textures/background.png")

	initBasket()
	initPlayer()
  initBall()
  initShuriken()
  createStandardShuriken()

end

function love.update(dt)
  
  g_MouseX = love.mouse.getX()
  g_MouseY = love.mouse.getY()

  playerUpdate(dt)
  ballUpdate(dt)
  basketUpdate(dt)
  shurikenUpdate(dt)
  
end

function love.draw()

	love.graphics.draw(background,0,0)

	drawPlayer()
  drawBall()
  drawBasket()
  drawShuriken()
  drawPlayerHealth(player.health.amount)
	
end