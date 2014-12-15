package chain.controller
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import flash.display.Sprite;
    import fla_assets.*;
    
    import bonus.interfaces.IBallBonus;
    import bonus.*;

    import chain.model.BallChainModel;
    import chain.view.BallChainView;
     
    import ball.model.colors.interfaces.IBallColor;
    import ball.model.colors.*;
    
    import ball.model.BallDescription;
    
    
    public class BallChainController
    {
        private var _model:BallChainModel = new BallChainModel();
        private var _view:BallChainView = new BallChainView();
        
        public function BallChainController(sceneView:Sprite) 
        {
            sceneView.addChild(_view);
        }
		
		public function GenerateStartChain():void
		{
			for (var j:int = 0; j < 12; j++)
			{
				GenerateBall();
			}
            
            _view.SetBallsXYs();
		}
        
        
        public function GenerateBall():void
        {
            var ballDesc:BallDescription = _model.GenerateBallDescription();
            var _bonus:IBallBonus = ballDesc.bonus;
            var _color:IBallColor = ballDesc.color;
            
            if (_bonus is FastShootingBonus)
            {
                trace("bonus is FastShootingBonus");
               
            }else if (_bonus is PlusOneBonus)
            {
                trace("bonus is PlusOneBonus");
                
            }else if (_bonus is StopMovementBonus)
            {
                trace("bonus is StopMovementBonus");
                
            }else if (_bonus == null)
            {
                _view.addBall(BallViewOrdinaryFactory(_color));     
            }
            
        }
        
        private function BallViewOrdinaryFactory(ballColor:IBallColor):Class
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