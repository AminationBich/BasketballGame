function initBall()

	ball = {}
  ball.texture = love.graphics.newImage("Textures/Basketball.png")
  ball.width = 32
  ball.height = 32
  ball.velx = 0
  ball.vely = 0
  ball.throwStrength = 0
  ball.x = player.x
  ball.y = player.y
  ball.points = 5
  ball.bounces = 0
  ball.isThrown = false
  ball.throwCooldown = 0
  ball.hasScored = false
  ball.previewThrowModeActive = false
  
end


function drawBall()

	love.graphics.draw(ball.texture,ball.x,ball.y)
  
  if ball.previewThrowModeActive then
    ballThrowPreview()
  end

end 

function updateBallPosition(dt)

  if not ball.isThrown then
    if player.direction == "r" then
      ball.x = player.x + player.width - ball.width / 2
    elseif player.direction == "l" then
      ball.x = player.x - ball.width / 2 + 4
    end
    ball.y = player.y + 45
  else
    ballGravity(dt)
    ball.x = ball.x + ball.velx * dt
    ball.y = ball.y + ball.vely * dt
  end
end

function ballUpdate(dt)

  updateThrowCooldown(dt)
  if ball.throwStrength >= 1.5 then ball.throwStrength = 1.5 end
  ballCollision()
  updateBallPosition(dt)
  checkGoal()

end

function checkGoal()
  
  if (ball.x + ball.width > basket.x) and
  (ball.x < basket.x + basket.width) and
  (ball.y + ball.height > basket.y) and
  (ball.y < basket.y + basket.height) then
    if ball.hasScored == false then
      increasePoints()
      ball.hasScored = true
    end
  else
    ball.hasScored = false
  end
  
  --pls Erklärung heute Abend ^^
  
end

function increasePoints()
  love.graphics.rectangle("fill",0,800,20,20,255)
  
  -- TODO (Kann für mich zum Lernen benutzt werden)
  
end

function updateThrowCooldown(dt)
  
  ball.throwCooldown = ball.throwCooldown - dt
  
  if ball.throwCooldown <= 0 then
    ball.throwCooldown = 0
  end
  
end

function ballThrowPreview()
  
  love.graphics.setColor(1,0,0)
  love.graphics.setLineWidth(1 + ball.throwStrength * 5)
  love.graphics.line(
    player.x + player.width / 2,
    player.y + player.height / 2,
    player.x + player.width / 2 + player.velx / 10 * ball.throwStrength + .5,
    player.y + player.height / 2 + player.vely / 20 * ball.throwStrength + .5)
  love.graphics.setColor(1,1,1)
  
end

function ballThrow()
  
  ball.throwStrength = ball.throwStrength + .75
  ball.isThrown = true
  ball.hasScored = false
  ball.x = player.x + player.width / 2
  ball.y = player.y + player.height / 2
  ball.velx = player.velx * (ball.throwStrength + .5)
  ball.vely = player.vely * ball.throwStrength 
  if ball.vely < -800 * ball.throwStrength then ball.vely = -800 * ball.throwStrength end
  if ball.vely < -1600 then ball.vely = -1600 end
  ball.throwStrength = 0
  
end

function ballGravity(dt)
  
  ball.vely = ball.vely + 2000 * dt

end

function calcThrowCooldown()
  
  if ball.velx < 0 then
    ball.velx = -ball.velx
  end
  
  ball.throwCooldown = (1 / (ball.velx / 800 + .35))
  
end

function ballCollision()
  
  if ball.x < 0 then
    ball.x = 0
    ball.velx = - ball.velx
    ball.bounces = ball.bounces + 1
  end
  
  if ball.x > 1200 - ball.width then
    ball.x = 1200 - ball.width
    ball.velx = - ball.velx
    ball.bounces = ball.bounces + 1
  end
  
  if ball.y < 0 then
    ball.y= 0
    ball.vely = - ball.vely
    ball.bounces = ball.bounces + 1
  end
  
  if ball.y + ball.height > player.jumpStartHeight then
    ball.isThrown = false
    calcThrowCooldown()
  end
  
end