package chain.controller
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import ball.utils.BallUtils;
    import flash.display.MovieClip;
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
                _view.addBall(BallUtils.GetBallViewClass(_color));     
            }
        }
        
        public function GetRandomBallColorFromChain(numElementsNeedToGet:int = 2):Vector.<IBallColor>
        {
            var ballColors:Vector.<IBallColor> = new Vector.<IBallColor>;
            
            var rnd:Number = -1;
            var rndIndex:int = -1;
            var privIndex:int = -1;
            
            for (var i:int = 0; i < numElementsNeedToGet; i++)
            {
                rnd = Math.random() * (_model.chain.length - 1);
                rndIndex = Math.round(rnd);
                
                if (i > 0)
                {
                        while (rndIndex == privIndex)
                        {
                             rnd = Math.random() * (_model.chain.length - 1);
                             rndIndex = Math.round(rnd);
                        }
                }
                    
                privIndex = rndIndex;
                ballColors.push(_model.chain[rndIndex].color);
            }
            
            
            return ballColors;
        }
        
    }

}