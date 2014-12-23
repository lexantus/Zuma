package ball.utils 
{
	/**
     * ...
     * @author Rozhin Alexey
     */

	import ball.model.BallDescription;
    import bonus.interfaces.IBallBonus;
    import bonus.*;
    import ball.view.bonus.plusonebonus.*;
    import ball.view.bonus.fastshootbonus.*;
    import ball.view.bonus.stopmovement.*;
    import ball.view.ordinary.*;

    
    import ball.model.colors.interfaces.IBallColor;
    import ball.model.colors.*;

    
    public class BallUtils 
    {
		
        public static function GetBallViewClass(ballColor:IBallColor, aBonus:IBallBonus):Class
        {
            if (aBonus)
            {
                if (aBonus is FastShootingBonus)
                {
                    return GetFastShootBonusViewClass(ballColor);
                    
                }else if (aBonus is PlusOneBonus)
                {
                    return GetPlusOneBonusViewClass(ballColor);
                    
                }else if (aBonus is StopMovementBonus)
                {
                    
                    return GetStopMovementBonusViewClass(ballColor);
                }else 
                {
                     throw new Error("ZumaError: There is no view class for ballColor" + ballColor + " and bonus " + aBonus);
                     return undefined;
                }
            }else {
                
                return GetOrdinaryViewClass(ballColor);
            }
            
        }
        
        public static function GetOrdinaryViewClass(ballColor:IBallColor):Class
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
                return PurpleBallView;
                
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
        
        public static function GetPlusOneBonusViewClass(ballColor:IBallColor):Class
        {
            if (ballColor is BlueBallColor)
            {
                return BlueBallPlusOneView;
                
            }else if (ballColor is BrownBallColor)
            {
                return BrownBallPlusOneView;
                
            }else if (ballColor is GreenBallColor)
            {
                return GreenBallPlusOneView;
                
            }else if (ballColor is PurpleBallColor)
            {
                return PurpleBallPlusOneView;
                
            }else if (ballColor is RedBallColor)
            {
                return RedBallPlusOneView;
                
            }else if (ballColor is YellowBallColor)
            {
                return YellowBallPlusOneView;
            }else
            {
                throw new Error("ZumaError: There is no view class for ballColor" + ballColor);
                return undefined;
            }
        }
        
        public static function GetFastShootBonusViewClass(ballColor:IBallColor):Class
        {
            if (ballColor is BlueBallColor)
            {
                return BlueBallFastShootView;
                
            }else if (ballColor is BrownBallColor)
            {
                return BrownBallFastShootView;
                
            }else if (ballColor is GreenBallColor)
            {
                return GreenBallFastShootView;
                
            }else if (ballColor is PurpleBallColor)
            {
                return PurpleBallFastShootView;
                
            }else if (ballColor is RedBallColor)
            {
                return RedBallFastShootView;
                
            }else if (ballColor is YellowBallColor)
            {
                return YellowBallFastShootView;
            }else
            {
                throw new Error("ZumaError: There is no view class for ballColor" + ballColor);
                return undefined;
            }
        }
        
        public static function GetStopMovementBonusViewClass(ballColor:IBallColor):Class
        {
            if (ballColor is BlueBallColor)
            {
                return BlueBallStopMoveView;
                
            }else if (ballColor is BrownBallColor)
            {
                return BrownBallStopMoveView;
                
            }else if (ballColor is GreenBallColor)
            {
                return GreenBallStopMoveView;
                
            }else if (ballColor is PurpleBallColor)
            {
                return PurpleBallStopMoveView;
                
            }else if (ballColor is RedBallColor)
            {
                return RedBallStopMoveView;
                
            }else if (ballColor is YellowBallColor)
            {
                return YellowBallStopMoveView;
            }else
            {
                throw new Error("ZumaError: There is no view class for ballColor" + ballColor);
                return undefined;
            }
        }
    }

}