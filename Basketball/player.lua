function initPlayer()

	player = {}
  player.texture = love.graphics.newImage("Textures/playerRight.png")
	player.width = 80
	player.height = 80
  player.x = 0
	player.y = 800 - player.height
	player.velx = 0	
	player.vely =	0
  player.jumpStartHeight = 0
  player.direction = "r"
  player.jumpIsPressed = false
	player.canJump = true
  player.canDoubleJump = true
  player.hitCooldown = 0
  player.isHit = false
  player.health = {}
  player.health.amount = 3
  player.health.texture = love.graphics.newImage("Textures/Health.png")
  player.health.width = 40
  player.health.height = 40
  player.score = 0
  
end

function drawPlayer()

  if player.direction == "r" then
    player.texture = love.graphics.newImage("Textures/playerRight.png")
  elseif player.direction == "l" then
    player.texture = love.graphics.newImage("Textures/playerLeft.png")
  end
  
  if player.isHit then
    love.graphics.setColor(1,1 / (player.hitCooldown * 10),1 / (player.hitCooldown * 10))
    if player.hitCooldown % 0.2 <= 0.16 then
      love.graphics.draw(player.texture,player.x,player.y)
    end
  else
    love.graphics.draw(player.texture,player.x,player.y)
    love.graphics.setColor(1,1,1)
  end
  
  drawPlayerZPosition()

end

function drawPlayerHealth()
  
  for i = 1,player.health.amount,1 do
    love.graphics.draw(player.health.texture,
      (4 + player.health.width) * i - player.health.width,
      10)
  end
  
end

function addPlayerHealth(p_Amount)
  
  player.health.amount = player.health.amount + p_Amount
  
end

function updatePlayerHitCooldown(dt)
  
  if player.hitCooldown <= 0 then
    player.isHit = false
    player.hitCooldown = 0
  end
  
  player.hitCooldown = player.hitCooldown - dt
  
end

function hitPlayer()
  
  player.health.amount = player.health.amount - 1
  player.isHit = true
  player.hitCooldown = 2
  
end

function drawPlayerZPosition()
  
  love.graphics.setColor(0,0.2,0)
  love.graphics.rectangle("fill",0,player.jumpStartHeight,1200,5)
  love.graphics.setColor(1,1,1)
  
end

function playerMovement(dt)
  
  playerDrag(dt)  
  
  if not ball.isThrown then
    if (love.keyboard.isDown("j")) and
       (ball.throwCooldown <= 0)then
      ball.previewThrowModeActive = true
      ball.throwStrength = ball.throwStrength + dt
    else
      if ball.previewThrowModeActive then
        ballThrow()
        ball.previewThrowModeActive = false
      end
    end
  end
  
  if love.keyboard.isDown("a") then
    player.direction = "l"
    player.velx = player.velx - 5000 * dt
  end
  
  if love.keyboard.isDown("d") then
    player.direction = "r"
    player.velx = player.velx	+ 5000 * dt
  end	
  
  if player.canJump then
    
    if player.vely > 300 then
      player.vely = 300
    end
    
    if player.vely < -300 then
      player.vely = -300
    end
    
    if love.keyboard.isDown("w") then 
      player.vely = player.vely - 2000 * dt
    end
    
    if love.keyboard.isDown("s") then 
      player.vely = player.vely + 2000 * dt
    end
    
  else
    if love.keyboard.isDown("s") then 
      if player.jumpStartHeight < 800 then
        player.jumpStartHeight = player.jumpStartHeight + 300 * dt
        player.vely = player.vely + 2500 * dt
      end
    end
  
    if love.keyboard.isDown("w") then 
      if player.jumpStartHeight > 650 then
        player.jumpStartHeight = player.jumpStartHeight - 300 * dt
        player.vely = player.vely - 2500 * dt
      end
    end
  end
  
  if love.keyboard.isDown("space") then
      if not player.jumpIsPressed then
        playerJump()
        player.jumpIsPressed = true
      end
    else
      player.jumpIsPressed = false
    end
    
	if player.velx > 800 then
		player.velx = 800
	end
	
	if player.velx < -800 then
		player.velx = -800
	end
  
	player.x = player.x + player.velx * dt
  player.y = player.y + player.vely * dt
  
  if player.canJump then
    player.jumpStartHeight = player.y + player.height
  end
  
end

function playerUpdate(dt)

  updatePlayerHitCooldown(dt)
	playerMovement(dt)
	collisionDetection()
  if not player.canJump then
    playerGravity(dt)
  end	
  
end

function collisionDetection(dt)

  if player.canJump then
    
    if player.y < 650 - player.height then
      player.y = 650 - player.height
      player.vely = 0
    end
    
    if player.y > 800 - player.height then
      player.y = 800 - player.height
      player.vely = 0
    end
  end
  
	if player.x < 0 then
		player.x = 0
    player.velx = 0
	end
	
	if player.x > 1200 - player.width then
		player.x = 1200 - player.width
    player.velx = 0
	end
	
end

function playerGravity(dt)
  
  if player.y > player.jumpStartHeight - player.height then
    player.y = player.jumpStartHeight - player.height
    player.vely = 150
    player.canJump = true
    player.canDoubleJump = true
  end
  
  player.vely = player.vely + 6000 * dt
  
end


function playerDrag(dt)

	if player.velx > 0 then
		player.velx = player.velx - 2000 * dt
		if player.velx < 0 then
			player.velx = 0
		end
	elseif player.velx < 0 then
		player.velx = player.velx + 2000 * dt
		if player.velx > 0 then
			player.velx = 0
		end
  end
	
  if player.canJump then
    if player.vely > 0 then
      player.vely = player.vely - 1000 * dt
      if player.vely < 0 then
        player.vely = 0
      end
    elseif player.vely < 0 then
      player.vely = player.vely + 1000 * dt
      if player.vely > 0 then
        player.vely = 0
      end
    end
  end
end

function playerJump()
  
  if player.canJump then
    player.jumpStartHeight = player.y + player.height
    player.vely = - 1700
    player.canJump = false
    return
  end
  
  if player.canDoubleJump then
    player.vely = - 1700
    player.canDoubleJump = false
    return
  end
  
end
