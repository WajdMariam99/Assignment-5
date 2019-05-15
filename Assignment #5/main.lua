--Physics library















local physics = require( "physics" )







physics.start() 















--variables















catch = 0







score = 0





























-- Scrollspeeds







scrollSpeed1 = 3







scrollSpeed2 = 3.5







scrollSpeed3 = 2.5















--The environment sprites







display.setDefault( "background", 20/255, 223/255, 255/255 )































local image = display.newImageRect( "assets/sprites/ground.png", 400, 200 )







image.x = 160







image.y = 425















local barrier = display.newImageRect( "assets/sprites/ground.png", 400, 200 )







barrier.x = 160







barrier.y = 600







barrier.id = "barrier"







physics.addBody( barrier, "static", { 







    friction = 0.5, 







    bounce = 0.3 







} )















-- The Balls and Bomb Sprites







local SoccerBall = display.newImageRect("assets/sprites/SoccerBall.png", 35, 35)

SoccerBall.x = math.random (1, 320)

SoccerBall.y = -30 

SoccerBall.id = "SoccerBall"

physics.addBody( SoccerBall, "static", { 

    friction = 0, 

    bounce = 0 

    } )















local PoolBall = display.newImageRect("assets/sprites/PoolBall.png", 35, 35)

PoolBall.x = math.random (1, 320)

PoolBall.y = -50 

PoolBall.id = "PoolBall"

physics.addBody( PoolBall, "static", { 

    friction = 0, 

    bounce = 0 

    } )















local Basketball = display.newImageRect("assets/sprites/Basketball.png", 35, 35)

Basketball.x = math.random (1, 320)

Basketball.y = -70 

Basketball.id = "Basketball"

physics.addBody( Basketball, "static", { 

    friction = 0, 

    bounce = 0 

    } )















local bomb = display.newImageRect("assets/sprites/bomb.png", 40, 50)

bomb.x = math.random (1, 320)

bomb.y = -110 

bomb.id = "bleach"

physics.addBody( bomb, "static", { 

    friction = 0, 

    bounce = 0 

    } )













local Basket = display.newImageRect( "assets/sprites/Basket.png", 100, 100 )

Basket.x = 160

Basket.y = 400

Basket.id = "Basket"

physics.addBody( Basket, "dynamic", { 

    density = 0, 

    friction = 0, 

    bounce = 0 

    } )







Basket.isFixedRotation = true















--Kill switch activator







local clock = os.clock







function sleep(n)  -- seconds

  local t0 = clock()

  while clock() - t0 <= n do end



end



--Point Counter


points = display.newText( "Points: " .. score, 165, 125, native.systemFont, 30 )



points:setFillColor( 255/255, 255/255, 255/255 )



prompt = display.newText( "Drag the Basket!", 160, 30, native.systemFont, 30 )
prompt:setFillColor( 255/255, 255/255, 255/255 )



prompt2 = display.newText( "Catch the Balls!", 160, 75, native.systemFont, 30 )
prompt2:setFillColor( 255/255, 255/255, 255/255 )



endGame = display.newText( "", 160, 220, native.systemFont, 30 )
endGame:setFillColor( 255/255, 255/255, 255/255 )



endPoints = display.newText( "", 160, 250, native.systemFont, 20 )
endPoints:setFillColor( 255/255, 255/255, 255/255 )







--Move the Basket by dragging




local function BasketTouch ( event )



local self = event.target



    if event.phase == "began" then



        -- first we set the focus on the object



        display.getCurrentStage():setFocus( self, event.id )

        self.isFocus = true



        -- then we store the original x and y position
        self.markX = self.x
        self.markY = self.y


    elseif self.isFocus then



        if event.phase == "moved" then

            -- then drag our object

            self.x = event.x - event.xStart + self.markX

            self.y = event.y - event.yStart + self.markY


        elseif event.phase == "ended" or event.phase == "cancelled" then


            -- we end the movement by removing the focus from the object

           display.getCurrentStage():setFocus( self, nil )

            self.isFocus = false

        end
    end

    -- return true so Corona knows that the touch event was handled propertly
        return true

end




--Falling sprites

local function MoveImage1(event)
    SoccerBall.y = SoccerBall.y + scrollSpeed1 





end


local function MoveImage2(event)

   PoolBall.y = PoolBall.y + scrollSpeed2 

end




local function MoveImage3(event)

   Basketball.y = Basketball.y + scrollSpeed3 



end








local function MoveImage4(event)

    bomb.y = bomb.y + scrollSpeed3







end


local function imageReset ( event )







    if bomb.y >= 600 then

        math.randomseed = (os.time())

        bomb.x = math.random ( 1,320 )

        bomb.y = -110

        print ("it worked")



    end


end



--Collision Functions 

local function BallCollision1( self, event )


math.randomseed = (os.time())


    if ( event.phase == "began" ) then

        if event.other.id == "Basket" then
            score = score + 1
            points.text = ("Points: ".. score)
            timer.performWithDelay(1, function() 
            SoccerBall.x = math.random (1,320)
            SoccerBall.y = -30

        end

        )


    elseif ( event.phase == "ended" ) then







    end




end


end



local function BallCollision2( self, event )


math.randomseed = (os.time())


    if ( event.phase == "began" ) then


        if event.other.id == "Basket" then
            score = score + 1
            points.text = ("Points: ".. score)
            timer.performWithDelay(1, function() 
            PoolBall.x = math.random (1,320)
            PoolBall.y = -50




        end
        )


    elseif ( event.phase == "ended" ) then

    end



end




end





local function BallCollision3( self, event )

math.randomseed = (os.time())

    if ( event.phase == "began" ) then


        if event.other.id == "Basket" then

            score = score + 1

            points.text = ("Points: ".. score)

            timer.performWithDelay(1, function() 

            Basketball.x = math.random (1,320)

            Basketball.y = -70

        end

        )


    elseif ( event.phase == "ended" ) then



    end



end



end


local function bombCollision( self, event )



    if ( event.phase == "began" ) then

        Runtime:removeEventListener( "collision", BallCollision3 )
        Runtime:removeEventListener( "collision", BallCollision2 )
        Runtime:removeEventListener( "collision", BallCollision1 )
        catch = 1

    elseif ( event.phase == "ended" ) then




    end




end



-- Game is over.  Everything got to the bottom of the screen

local function killSwitch ( event )


if SoccerBall.y >= 600 or PoolBall.y >= 600 or Basketball.y >= 600 or catch == 1 then

        Runtime:removeEventListener( "enterFrame", killSwitch )

         if catch == 1 then


            prompt.text = "BOOM! You caught" 

            prompt2.text = "the bomb!"

        else   


            prompt.text = "The Ball touched"

            prompt2.text = "the ground!"

        end



        SoccerBall.alpha = 100

        PoolBall.alpha = 100

        Basketball.alpha = 100

        bomb.alpha = 100

        Basket.alpha = 100



end



end



local function killSwitch2 ( event )


    if SoccerBall.y >= 700 or PoolBall.y >= 700 or Basketball.y >= 700 or catch == 2 then


        Runtime:removeEventListener( "enterFrame", killSwitch2 )

        scrollSpeed3 = 0
        scrollSpeed2 = 0
        scrollSpeed1 = 0
        prompt.text = ""
        prompt2.text = ""
        points.text = ""
        sleep(3)
        endGame.text = "Game Over"
        endPoints.text = "Score: "..score


    end

end


--Event listeners
Basket:addEventListener("touch", BasketTouch)


Runtime:addEventListener("enterFrame", MoveImage1)


Runtime:addEventListener("enterFrame", killSwitch)



Runtime:addEventListener("enterFrame", killSwitch2)



Runtime:addEventListener("enterFrame", MoveImage2)



Runtime:addEventListener("enterFrame", MoveImage3)



Runtime:addEventListener("enterFrame", MoveImage4)



Runtime:addEventListener("enterFrame", imageReset)



SoccerBall.collision = BallCollision1
SoccerBall:addEventListener( "collision" )



PoolBall.collision = BallCollision2
PoolBall:addEventListener( "collision" )



Basketball.collision = BallCollision3
Basketball:addEventListener( "collision" )



bomb.collision = bombCollision
bomb:addEventListener( "collision" )