package chain.controller
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import ball.utils.BallUtils;
    import ball.view.BallView;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import fla_assets.*;
    import flash.geom.Point;
    import path.model.interfaces.IPathModel;
    
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
        
        private var _startPt:Point;
        private var _finishPt:Point;
        private var _speedVectors:Vector.<Point>;
        
        public function BallChainController(sceneView:Sprite, aSpeedVectors:Vector.<Point>, aStartPoint:Point, aFinishPoint:Point) 
        {
            sceneView.addChild(_view);
            
            _speedVectors = aSpeedVectors;
            _startPt = aStartPoint;
            _finishPt = aFinishPoint;
        }
		
		public function GenerateStartChain(numBalls:int):void
		{
			for (var j:int = 0; j < numBalls; j++)
			{
				GenerateBall();
			}
		}
        
        private var privIndexes:Vector.<int> = new Vector.<int>;
        private var privIndex:int = 0;
        private const RADIUS:Number = 20.25;
        
        public function GenerateBall():void
        {
            var ballDesc:BallDescription = _model.GenerateBallDescription();
            var _bonus:IBallBonus = ballDesc.bonus;
            var _color:IBallColor = ballDesc.color;
            
            var position:Point;
            
            var ballView:BallView;
            
            var count:int = 0;
            
            if (_view.ballViews.length == 0)
            {
                position = _startPt;
                privIndexes.push(privIndex);
                
            }else {
                
                ballView = _view.ballViews[_view.ballViews.length - 1];
               
                position = new Point(ballView.x, ballView.y);
                
                var privIndex1:int = privIndex;
                var ballViewX:Number;
                var ballViewY:Number;
                
                for (var i:int = privIndex; i < _speedVectors.length; i++)
                {
					position.x += _speedVectors[i].x;
					position.y += _speedVectors[i].y;
					
                    var vect:Point = new Point(position.x - ballView.x, position.y - ballView.y);
					
                    if ((vect.length + 0.00001) < 2 * RADIUS)
                    {
                        privIndex ++;
                        count ++;
                        
                    }else {
                        
						privIndex ++;
                        count ++;
						
                        trace("privIndex = " + privIndex);

                         privIndexes.push(privIndex);
                         break;
                    }
                }
                
                position = _startPt;
                
                for (i = privIndex; i < privIndex + count; i++)
                {
                        if (i < _speedVectors.length)
                        {
                            position.x += _speedVectors[i].x;
                            position.y += _speedVectors[i].y;
                        }
                }
            }
            
            
            if (_bonus is FastShootingBonus)
            {
                trace("bonus is FastShootingBonus");
                 _view.addBall(BallUtils.GetBallViewClass(_color, _bonus), position);   
               
            }else if (_bonus is PlusOneBonus)
            {
                trace("bonus is PlusOneBonus");
                 _view.addBall(BallUtils.GetBallViewClass(_color, _bonus), position);   
                
            }else if (_bonus is StopMovementBonus)
            {
                trace("bonus is StopMovementBonus");
                 _view.addBall(BallUtils.GetBallViewClass(_color, _bonus), position);   
                
            }else if (_bonus == null)
            {
                _view.addBall(BallUtils.GetBallViewClass(_color, _bonus), position);     
            }
        }
        
        public function KillBall(ballIndex:int):void
        {
            _view.ballViews[ballIndex].AnimateDie(KillAnimationComplete);
        }
        
        private function KillAnimationComplete():void
        {
                // TODO
        }
		
		private var g:int = 0;
        
        public function MoveChain():void
        {
			return;
             for (var i:int = 0; i < _view.ballViews.length; i++)
             {
          
                    //if (_speedVectors.length > privIndexes[i])
                    //{
                       // _view.ballViews[i].view.x += _speedVectors[privIndexes[i]].x;
                       // _view.ballViews[i].view.y += _speedVectors[privIndexes[i]].y;
                       // privIndexes[i] ++;
                    //}
					
					//_view
                 
             }
			 
			 if (_speedVectors[g].length < 2.9)
			 {
			 
				_view.ballViews[0].view.x += _speedVectors[g].x;
				_view.ballViews[0].view.y += _speedVectors[g].y;
				g++;
				_view.ballViews[0].view.x += _speedVectors[g].x;
				_view.ballViews[0].view.y += _speedVectors[g].y;
				g++;
			
			}else {
				 
			    _view.ballViews[0].view.x += _speedVectors[g].x;
				_view.ballViews[0].view.y += _speedVectors[g].y;
				g++;
			}
        }
        
        public function GetRandomBallColorFromChain(numElementsNeedToGet:int = 2):Vector.<IBallColor>
        {
            if (_model.chain.length < numElementsNeedToGet) 
            {
                return null;
            }
            
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
        
        public function get model():BallChainModel 
        {
            return _model;
        }
        
        public function get view():BallChainView 
        {
            return _view;
        }
        
    }

}