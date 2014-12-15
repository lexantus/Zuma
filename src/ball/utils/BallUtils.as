package ball.utils 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import fla_assets.*;
    
    import ball.model.colors.interfaces.IBallColor;
    import ball.model.colors.*;

    
    public class BallUtils 
    {
        public static function GetBallViewClass(ballColor:IBallColor):Class
        {
             if (ballColor is BlueBallColor)
             {
                 return BlueBallView;
                 
             }else if (ballColor is BrownBallColor)
             {
                 return BrownBallView;
                 
             }else if (ballColor is GreenBallColor)
             {
                 return GreenBallView;
                 
             }else if (ballColor is PurpleBallColor)
             {
                 return PinkBallView;
                 
             }else if (ballColor is RedBallColor)
             {
                 return RedBallView;
                 
             }else if (ballColor is YellowBallColor)
             {
                 return YellowBallView;
             }else
             {
                 throw new Error("ZumaError: There is no view class for ballColor" + ballColor);
                 return undefined;
             }
        }
        
    }

}