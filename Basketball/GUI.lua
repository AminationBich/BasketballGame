function initGUIComponents()
  
  gui = {}
  gui.fonts = {}
  gui.fonts.scoring = love.graphics.newFont("Fonts/cambria.ttc",30)
  gui.fonts.board = love.graphics.newFont("Fonts/cambria.ttc",40)
  gui.scoreBoard = {}
  gui.scoreBoard.text = love.graphics.newText(gui.fonts.board,player.score)
  gui.scoreBoard.width = gui.scoreBoard.text:getWidth()
  gui.scoreText = {}
  gui.timer = {}
  gui.timer.time = 90 -- Sekunden
  gui.timer.timeText = ""
  gui.timer.text = love.graphics.newText(gui.fonts.board,"2:00")
  gui.timer.width = gui.timer.text:getWidth()
  
end

function updateGUI(dt)
  
  updateTimer(dt)
  updateScoreText(dt)
  updatePlayerScore(dt)
  
end

function drawGUI()
  
  drawTimer()
  drawScoreText()
  drawPlayerHealth()
  drawPlayerScore()
  
end

function drawTimer()
  
  love.graphics.setColor(.6,1,.6)
  love.graphics.draw(gui.timer.text,
    1200/2 - gui.timer.width / 2,
    10)
    
end

function updateTimer(dt)
  
  gui.timer.time = gui.timer.time - dt
  local l_TimerMinutes
  local l_TimerSeconds
  l_TimerMinutes = math.modf((gui.timer.time + 1) / 60) 
  l_TimerSeconds = math.floor(math.fmod((gui.timer.time + 1),60))
  if l_TimerSeconds == 0 then l_TimerSeconds = "00" end
  gui.timer.timeText = l_TimerMinutes .. ":" .. l_TimerSeconds
  gui.timer.text = love.graphics.newText(gui.fonts.board,gui.timer.timeText)
  gui.timer.width = gui.timer.text:getWidth()
  
end

function drawPlayerHealth()
  
  for i = 1,player.health.amount,1 do
    love.graphics.draw(player.health.texture,
      (4 + player.health.width) * i - player.health.width,
      10)
  end
  
end

function updatePlayerScore()
  
  gui.scoreBoard.text = love.graphics.newText(gui.fonts.board,player.score)
  gui.scoreBoard.width = gui.scoreBoard.text:getWidth()
  
end

function drawPlayerScore()
  
  love.graphics.setColor(.1,.1,.1)
  love.graphics.draw(gui.scoreBoard.text,
    1200 - 4 - gui.scoreBoard.width,
    10)
  love.graphics.setColor(1,1,1)
  
end

function addScoreText(p_Text,p_X,p_Y)
  
  local l_GUI = {
    text = love.graphics.newText(gui.fonts.scoring,p_Text),
    x = p_X,
    y = p_Y,
    startPosition = p_Y,
    alpha = 1
  }
  
  table.insert(gui.scoreText,l_GUI)
  
end

function updateScoreText(dt)
  
  for i,v in pairs(gui.scoreText) do
    v.y = v.y - 50 * dt
    if v.y < v.startPosition - 50 then
      v.alpha = v.alpha - dt
    end
    if v.alpha <= 0 then
      gui.scoreText[i] = nil
    end
  end
  
end

function drawScoreText()
  
  for i,v in pairs(gui.scoreText) do
    love.graphics.setColor(1,0,0,v.alpha)
    love.graphics.draw(v.text,v.x,v.y)
  end
  
  love.graphics.setColor(1,1,1)
  
end
