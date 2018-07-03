require("ball")
require("basket")
require("player")
require("shuriken")
require("GUI")

function love.load()

	background = love.graphics.newImage("Textures/background.png")

	initBasket()
	initPlayer()
  initBall()
  initShuriken()
  initGUIComponents()
  createStandardShuriken()

end

function love.update(dt)
  
  updatePlayer(dt)
  updateBall(dt)
  updateBasket(dt)
  updateShuriken(dt)
  updateGUI(dt)
  
end

function love.draw()

	love.graphics.draw(background,0,0)

	drawPlayer()
  drawBall()
  drawBasket()
  drawShuriken()
  drawGUI()
	
end