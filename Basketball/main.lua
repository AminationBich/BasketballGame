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
  createShuriken(math.random(0,1200),math.random(0,500),math.random(50,300),math.random(50,300))
  createShuriken(math.random(0,1200),math.random(0,500),math.random(50,300),math.random(50,300))
  createShuriken(math.random(0,1200),math.random(0,500),math.random(50,300),math.random(50,300))
	createShuriken(math.random(0,1200),math.random(0,500),math.random(50,300),math.random(50,300))  createShuriken(math.random(0,1200),math.random(0,500),math.random(50,300),math.random(50,300))

end

function love.update(dt)

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
	
end