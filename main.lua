--holds game functions
game = {}


function love.load()
  love.graphics.setDefaultFilter("nearest","nearest",0)

  pole = love.graphics.newImage("pole.png")
  polescale = 6
  originpolescale = polescale
  fish = love.graphics.newImage("fish.png")
  castpower = 0

  castwoosh = love.audio.newSource( "cast.wav", "static" )


end



function love.draw()

  love.graphics.setColor(0.529, 0.808, 0.922)
  love.graphics.rectangle( "fill",0,0, screensize[1],screensize[2]/2 )

  love.graphics.setColor(0.925, 0.741, 0.173)
  love.graphics.circle( "fill", screensize[1]/2, screensize[2]/2, 200 )

  love.graphics.setColor(0.165, 0.404, 0.565)
  love.graphics.rectangle( "fill",0,screensize[2]/2, screensize[1],screensize[2]/2 )

  love.graphics.setColor(1,1,1)


  love.graphics.draw(pole,polepos[1],polepos[2],0,polescale,polescale)
  love.graphics.print("Cast Power:"..castpower,0,0)
end



function love.update(dt)
  game.getscreeninfo()
  game.getmouseposition(dt)
  game.controlpole(dt)
end

--how player controls pole
function game.controlpole(dt)

  local polesize = {pole:getWidth()*polescale,pole:getHeight()*polescale}
  --remember to set this to 0
  local ppos = {mousex,screensize[2]-polesize[2]}

  --left right
  if ppos[1] + polesize[1] > screensize[1] then
    ppos[1] = screensize[1] - polesize[1]
  elseif ppos[1] < 0 then
    ppos[1] = 0
  end

  --cast power
  if mousel and castpower < 100 then
    castpower = castpower + 1
  elseif not mousel and  castpower > 0 then
    castpower = castpower - 10
    if castpower < 0 then
      castpower = 0
    end
  end

  ppos[2] = screensize[2]-polesize[2]+((castpower/100)*polesize[2]) --set to new getPosition

  polescale = originpolescale*(castpower/100+1)

  polepos = {ppos[1],ppos[2]}

end



function game.getscreeninfo()
  screensize = {love.graphics.getWidth(),love.graphics.getHeight()}
end


function game.getmouseposition(dt)
  mousex, mousey = love.mouse.getPosition()
  mousel = love.mouse.isDown(1)
end
