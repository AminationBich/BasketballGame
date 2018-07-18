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
  
  if not gameOver() then
    updatePlayer(dt)
    updateBall(dt)
    updateBasket(dt)
    updateShuriken(dt)
    updateGUI(dt)
  end
  
end

function love.draw()

	love.graphics.draw(background,0,0)

	drawPlayer()
  drawBall()
  drawBasket()
  drawShuriken()
  drawGUI()
	
end

function gameOver()
  
  if player.health.amount <=0 then return(true) end
  if gui.timer.time <=0 then 
    gui.timer.time = 0
    return(true) 
  end
  return(false)
  
end
