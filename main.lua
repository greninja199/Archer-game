push = require 'push'

WINDOW_WIDTH=1280   --Width of the window 
WINDOW_HEIGHT=720   --Height of the window

VIRTUAL_WIDTH=1280  -- Width of the window to be created can be varied in devices
VIRTUAL_HEIGHT=720  -- Height of the window to be created can be varied in devices

velocity_y=0        -- Velocity in Y direction
velocity_x=0        -- Velocity in X direction
ACCEL_Y=2           -- Accelaration Due to gravity in Y direction 
count=0             -- A variable to simulate calculation of score
null_con=0          -- A variable to define if W,A,S,D input should be taken in or not. if null_con=0 then take input, if its 1 then no input should be taken

dist=0              -- Distance of the Bow stretched 
degree = 0          -- Degree at which arrow is to the ground
rad_degree = 0      -- Degree in Radians
rate=0              -- calculation for bending of arrow in midflight to look like a projectile

string_up_x=112     -- X-value of upper end of the string of Bow
string_up_y=400     -- Y-value of upper end of the string of Bow

string_down_x=112   -- X-value of lower end of the string of Bow
string_down_y=500   -- Y-value of lower end of the string of Bow

arrow_head_x = 192  -- X-value of head of the arrow
arrow_head_y = 450  -- Y-value of head of the arrow

arrow_tail_x = 112  -- X-value of tail of the arrow
arrow_tail_y = 450  -- Y-value of tail of the arrow

travel_time=0       -- Calculation of travel time of Projectile(arrow)

score=0             -- Initialising Score to 0

con=0               -- To stimulate whether to move arrow or not. If con=0 then no changes to take place, if con = 1 then take input from W,A,S,D

VELOCITY_MUL= 15    -- Value of Square root of(2* Spring constant of string / mass of the arrow)

function love.load()        -- Runs at the start of the program . Helps to set up size of the screen
    love.graphics.setDefaultFilter('nearest','nearest')     -- use nearest-neighbor filtering on upscaling and downscaling to prevent blurring of text 
    love.window.setTitle('Archery')     --Set titles for windows
    
    gamestate = 'start'       --Sets gamestate to play

    push:setupScreen(       -- Sets up the screen of window height, window width in ratio of virtual width, virtual height 
        VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
            vsync= true,        -- vertical_sync is true
            fullscreen =false,      -- full screen not allowed
            resizable=true          --Resizable
    })
end

function love.update(dt)        -- Runs after every 'dt' time
    if con == 1 then            -- Only this loops runs when we launch the arrow
        if arrow_tail_x + 80 * math.cos( rad_degree ) < 1100 then   --checks if head of arrow is passed the board
            arrow_tail_x = arrow_tail_x + velocity_x *0.2           --update the value of arrow_tail_x for after 0.2 secs
            arrow_tail_y = arrow_tail_y + velocity_y * 0.2          --update the value of arrow_tail_y for after 0.2 secs
            velocity_y = velocity_y + ACCEL_Y * (0.2)               --Updating velocity in y after every 0.2 secs
            null_con=1                                              -- setting up null_con=1 which restricts input through W, A , S, D.
            rad_degree = rad_degree + math.rad(rate)                -- Changes rad_degree for curve path
            if arrow_tail_x + 80 * math.cos( rad_degree ) >= 1100 then      --checks if arrow hits board or not if board is hit set con to 2 
                con = 2
                velocity_y = 0
                velocity_x = 0
            end
            if arrow_head_y >= 600 then                             --checks if arrow hits board or not if board is hit set con to 2
                con = 2
                velocity_x = 0
                velocity_y = 0
            end
        end
    elseif love.keyboard.isDown('a') and null_con == 0 then         --If 'A' is pressed
        if arrow_head_x > (112 + 50 * math.cos( rad_degree )) then  --If arrow_head_x 
           dist= dist+1                                             -- Increases the draw length
           arrow_tail_x = arrow_tail_x - dist * math.cos( rad_degree )  --updates the arrow_tail_x value
            
        end
    elseif love.keyboard.isDown('d') and null_con == 0 then         --If 'D' is pressed
        if arrow_tail_x < 112 then                                  --If arrow_tail_x is less than 112
            dist = dist-1                                           -- then value of dist is reduced 
            arrow_tail_x = arrow_tail_x + dist * math.cos( rad_degree )         --updates the value of arrow_tail_x
        end
    
    elseif love.keyboard.isDown('l') then                           --If 'L' is pressed then arrow is launched
            con=1                                                   --sets the value of con to 1
            velocity = VELOCITY_MUL * dist                          --sets values of velocity according to draw length
            velocity_x = VELOCITY_MUL * dist * 0.2 * math.cos(rad_degree)       --velocity in x direction
            if degree == 0 then
                velocity_y = VELOCITY_MUL * dist * 0.2 * math.sin( math.rad(10) )
                travel_time = velocity * math.sin(math.rad(10)) / ACCEL_Y  
            else
                travel_time = velocity * math.sin(rad_degree) / ACCEL_Y  
                velocity_y = VELOCITY_MUL * dist * 0.2 * math.sin( rad_degree )     --velocity in y direction
            end
    
                       --updates the travel time
            rate = math.rad(degree*35 / travel_time)                            --suitable rate for reduction of variable rad_degree

    elseif love.keyboard.isDown('w')  and null_con == 0 then        --If 'W' is pressed then angle is shifted upward by 1
        if degree >= -35 then                                       --If degree is greater than -35, then only update
            degree = degree - 1;
        end
        rad_degree = math.rad(degree)
        arrow_tail_x = arrow_tail_x - dist * math.cos( rad_degree ) 

    elseif love.keyboard.isDown('s')  and null_con == 0 then        --If 'S' is pressed then angle is shifted downwards by 1
        if degree <= 35 then
            degree = degree + 1;
        end
        rad_degree = math.rad(degree)
        arrow_tail_x = arrow_tail_x - dist * math.cos( rad_degree ) 
    end
end

function love.resize(w, h)          -- function to resize the window
    push:resize(w, h)
end

function love.keypressed(key)
    if key== 'escape' then  -- If 'escape' is pressed, then window is closed 
        love.event.quit()       --'quit' function is used to close window
    elseif key == 'enter' or key == 'return' then
       -- if gamestate == 'start' then
         --   gamestate = 'play'
       -- else
            gamestate = 'start'
            con=0
            dist=0
            velocity_y=0
            arrow_tail_x=112
            rad_degree = 0
            degree=0
            count=0
            null_con=0
       -- end
    end
    --setting up a key like w,a,s,d
end
function calc_score()                                       --Calculates the score
    if arrow_head_y >= 310 and arrow_head_y < 330 then      --Topmost box
        score = score +10
    elseif arrow_head_y >= 330 and arrow_head_y < 350 then  --2nd box
        score = score + 20
    elseif arrow_head_y >= 350 and arrow_head_y < 370 then  --3rd box
        score = score + 30
    elseif arrow_head_y >= 370 and arrow_head_y < 390 then  --4th box
        score = score + 40
    elseif arrow_head_y >= 390 and arrow_head_y < 410 then  --5th Box
        score = score + 50
    elseif arrow_head_y >= 410 and arrow_head_y < 430 then  --6th Box
        score = score + 40
    elseif arrow_head_y >= 430 and arrow_head_y < 450 then  --7th box
        score = score + 30
    elseif arrow_head_y >= 450 and arrow_head_y < 470 then  --8th box
        score = score + 20
    elseif arrow_head_y >= 470 and arrow_head_y < 490 then  --9th box
        score = score + 10
    else                                                    --Anywhere else
        score = score + 0
    end
    count = count + 1
end


function love.draw()
    push:start()
   if con==0 then               --State in which arrow is not fired
        string_up_x = 112 + 50 * math.sin( rad_degree )
        string_up_y = 450 - 50 * math.cos( rad_degree )

        string_down_x = 112 - 50 * math.sin(rad_degree)
        string_down_y = 450 + 50 * math.cos( rad_degree )
   
        arrow_tail_x = 112 - dist * math.cos( rad_degree ) 
        arrow_tail_y = 450 - dist * math.sin( rad_degree ) 
        
        arrow_tail_x1 = arrow_tail_x
        arrow_tail_y1 = arrow_tail_y
    end
    arrow_head_x = arrow_tail_x + 80 * math.cos( rad_degree )
    arrow_head_y = arrow_tail_y + 80 * math.sin( rad_degree )
    if con == 2 then
        if count == 0 then          --To run calc_score only one time 
            calc_score()            --CAlculates the score 
        end
        
    end
    love.graphics.printf('SCORE = ' .. score , 0, 20, VIRTUAL_WIDTH, 'right')           --Prints the score
    love.graphics.line(arrow_tail_x , arrow_tail_y , arrow_head_x , arrow_head_y )      --Draws the arrow

    love.graphics.line(string_up_x,string_up_y,arrow_tail_x1,arrow_tail_y1)          --bow upper string
    love.graphics.line(arrow_tail_x1,arrow_tail_y1,string_down_x,string_down_y)          --bow lower string

    love.graphics.rectangle('fill',0,600,1280,120)  --GROUND

    love.graphics.rectangle('line',1100,310,10,20)  --Topmost box
    love.graphics.rectangle('line',1100,330,10,20)  --2nd box
    love.graphics.rectangle('line',1100,350,10,20)  --3rd box
    love.graphics.rectangle('line',1100,370,10,20)  --4th box
    love.graphics.rectangle('line',1100,390,10,20)  --5th box
    love.graphics.rectangle('line',1100,410,10,20)  --6th box
    love.graphics.rectangle('line',1100,430,10,20)  --7th box
    love.graphics.rectangle('line',1100,450,10,20)  --8th box
    love.graphics.rectangle('line',1100,470,10,20)  --9th box
    love.graphics.rectangle('fill',1105,490,1,110)  --stand for the board

    love.graphics.arc( 'line', 112, 450, 50, math.pi/2 +(math.pi/180)*degree ,-math.pi/2 + (math.pi/180) * degree)  --It draws the BOW

    push:finish()
end