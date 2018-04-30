function initBall()

	ball = {}
  ball.texture = love.graphics.newImage("Textures/Basketball.png")
  ball.width = 32
  ball.height = 32
  ball.x = player.x
  ball.y = player.y
  ball.isThrown = false
  
end


function drawBall()

	love.graphics.draw(ball.texture,ball.x,ball.y)


end 

function updateBallPosition()

  if player.direction == "r" then
    ball.x = player.x + player.width - ball.width / 2
  elseif player.direction == "l" then
    ball.x = player.x - ball.width / 2 + 4
  end
  ball.y = player.y + 45
  
end

function ballUpdate(dt)

  updateBallPosition()

end