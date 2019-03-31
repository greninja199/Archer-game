push= require 'push'

WINDOW_WIDTH=1280
WINDOW_HEIGHT=720

VIRTUAL_WIDTH=1280
VIRTUAL_HEIGHT=720

arrow_end=112
arrow_end1=112

velocity_y=0
ACCEL_Y=147
dy=0

dist=0
angled = 0

con=0

VELOCITY_MUL=225.225

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    love.window.setTitle('Archery')
    
    gamestate = 'start'

    push:setupScreen(
        VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
            vsync= true,
            fullscreen =false,
            resizable=true
    })
end

function love.update(dt)
    if con == 1 then
        if arrow_end <1020 then
            arrow_end = arrow_end+ VELOCITY_MUL*dist *0.002
            velocity_y = velocity_y + ACCEL_Y*(0.05)
            dy = dy + velocity_y*(0.002)
        end
    elseif love.keyboard.isDown('a') then
        if arrow_end > 82 then
            arrow_end = arrow_end-1
            arrow_end1=arrow_end
            dist= dist+1
        end
    elseif love.keyboard.isDown('d') then
        if arrow_end < 112 then
            arrow_end = arrow_end+1
            arrow_end1=arrow_end
            dist = dist-1
        end
    --elseif love.keyboard.isDown()
    elseif love.keyboard.isDown('l') then
        --while(arrow_end < 1020)
        --do
            --love.timer.sleep(0.001)
            con=1
        --end
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key== 'escape' then 
        --love.timer.sleep(10)    -- takes input in seconds
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gamestate == 'start' then
            gamestate = 'play'
        else
            gamestate = 'start'
            arrow_end = 112
            arrow_end1 = 112
            con=0
            dist=0
            dy=0
            velocity_y=0
        end
    end
    --setting up a key like w,a,s,d
end

function love.draw()
    push:start()
   -- love.graphics.rectangle('fill',112,400,40,10)   --bow upper
   -- love.graphics.rectangle('fill',142,400,10,100)  --bow middle
   -- love.graphics.rectangle('fill',112,490,40,10)   --bow lower
    --love.graphics.rectangle('fill',112,410,1,90)    --bow string
    love.graphics.rectangle('fill',arrow_end,450+dy,80,2)    --arrow
    love.graphics.line(112,400,arrow_end1,450)          --bow upper string
    love.graphics.line(arrow_end1,450,112,500)          --bow lower string
    love.graphics.rectangle('fill',0,600,1280,120)  --GROUND
    love.graphics.rectangle('line',1100,400,10,10)  --point 2
    love.graphics.rectangle('line',1100,410,10,10)  --4
    love.graphics.rectangle('line',1100,420,10,10)  --6
    love.graphics.rectangle('line',1100,430,10,10)  --8
    love.graphics.rectangle('line',1100,440,10,10)  --10
    love.graphics.rectangle('line',1100,450,10,10)  --8
    love.graphics.rectangle('line',1100,460,10,10)  --6
    love.graphics.rectangle('line',1100,470,10,10)  --4
    love.graphics.rectangle('line',1100,480,10,10)  --2
    love.graphics.rectangle('fill',1105,490,1,110)  --stand for the board

    love.graphics.arc( 'line', 112, 450, 50, math.pi/2 , - math.pi/2 )--aim for circular arc

    --JUST FOR FUN HUMAN
    love.graphics.rectangle('fill',52,560,40,40)    --platform
    love.graphics.rectangle('fill',72,500,15,60)    --legs
    love.graphics.rectangle('fill',64.5,450,30,50)  --chest
    love.graphics.rectangle('fill',94.5,455,68.5,10)    --hand
    love.graphics.rectangle('fill',74.5,440,10,10)  --neck
    love.graphics.circle('fill',79.5,430,10,100)    --head
    love.graphics.rectangle('fill',64.5,450,arrow_end1-64.5,5)

    --love.graphics.arc( 'line', 101, 51, 50, -math.pi/2 - (math.pi/180)*10 ,math.pi/2 - (math.pi/180)*10  )
    push:finish()
end