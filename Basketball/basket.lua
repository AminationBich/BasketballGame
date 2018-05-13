function initBasket()

	basket = {}
  basket.texture = love.graphics.newImage("Textures/basket.png")
	basket.width = 128
	basket.height = 128
  basket.x = math.random(0,1200 - basket.width)
	basket.y = math.random(0,600 - basket.height)
  basket.rotation = 0
	basket.speedx = 0
	basket.speedy = 0
	basket.directionTimer = 0
	
end

function drawBasket()
  
  love.graphics.draw(basket.texture,basket.x + basket.width / 2,basket.y + basket.height / 2,-basket.rotation,1,1,basket.width / 2,basket.height / 2)

	love.graphics.draw(basket.texture,basket.x + basket.width / 2,basket.y + basket.height / 2,basket.rotation,1,1,basket.width / 2,basket.height / 2)

end

function randomBasketDirection()

	basket.speedx = love.math.random(250)
	basket.speedy = 250 - basket.speedx
	if love.math.random(2) == 1 then
		basket.speedx = - basket.speedx
	end
	
	if love.math.random(2) == 1 then
		basket.speedy = - basket.speedy
	end
	
end


function updateBasket(dt)

  basket.rotation = basket.rotation + dt
  if basket.rotation >= 2 * math.pi then basket.rotation = basket.rotation - 2 * math.pi end

	basket.directionTimer = basket.directionTimer - dt

	if basket.directionTimer < 0 then
		randomBasketDirection()
		basket.directionTimer = 1.2
	end
	basket.x = basket.x + basket.speedx * dt
	basket.y = basket.y + basket.speedy * dt
	basketCollisionDetection()

end

function basketCollisionDetection()

	if basket.x < 0 then
		basket.x = 0
		basket.speedx = - basket.speedx
	end
	
	if basket.y < 0 then
		basket.y = 0
		basket.speedy = - basket.speedy
	end

	if basket.x > 1200 - basket.width then
		basket.x = 1200 - basket.width
		basket.speedx = - basket.speedx
	end
	
	if basket.y > 600 - basket.height then
		basket.y = 600 - basket.height
		basket.speedy = - basket.speedy
	end
	
end