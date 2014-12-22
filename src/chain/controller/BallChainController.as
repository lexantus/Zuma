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
        
        public var privIndexes:Vector.<int> = new Vector.<int>;
        private var privIndex:int = 0;
        private const RADIUS:Number = 20.25;
		private var privPosition:Point;
        
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
				privPosition = position;
                privIndexes.push(privIndex);
                
            }else {
                
                ballView = _view.ballViews[_view.ballViews.length - 1];
				trace("ball view pos = " + ballView.view.x + " " + ballView.view.y);
				trace("priv position = " + privPosition.x +" "+ privPosition.y);
               
                position = privPosition.clone();
                
                for (var i:int = privIndex; i < _speedVectors.length; i++)
                {
					position.x += _speedVectors[i].x;
					position.y += _speedVectors[i].y;
					
                    var vect:Point = new Point(position.x - privPosition.x, position.y - privPosition.y);
					
                    if ((vect.length + 0.5) < 2 * RADIUS)
                    {
                        privIndex ++;
                        
                    }else {
                        
						privIndex ++;
						
						privPosition.x = position.x;
						privPosition.y = position.y;
						
                        //trace("privIndex = " + privIndex);

                         privIndexes.push(privIndex);
                         break;
                    }
                }
            }
            
			trace("position = "  + position);
            
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
		
		public function IncludeProjectileInChain(indexOfCollisionBallInChain:int, ballView:BallView, position:Point, privIndex:int):void
		{
				ballView.parent.removeChild(ballView);
				_view.ballViews.splice(indexOfCollisionBallInChain, 0, ballView);
				_view.ballViews[indexOfCollisionBallInChain].x = 0;
				_view.ballViews[indexOfCollisionBallInChain].y = 0;
				_view.ballViews[indexOfCollisionBallInChain].view.x = position.x;
				_view.ballViews[indexOfCollisionBallInChain].view.y = position.y;
				_view.addChild(ballView);
				
			   privIndexes.splice(indexOfCollisionBallInChain, 0, privIndex);
			   
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
			//return;
			if (isFreeze) return;
			
             for (var i:int = 0; i < _view.ballViews.length; i++)
             {
                    if (_speedVectors.length != privIndexes[i])
                    {
						if (_speedVectors[privIndexes[i]].length < 4)
						{
							_view.ballViews[i].view.x += _speedVectors[privIndexes[i]].x;
							_view.ballViews[i].view.y += _speedVectors[privIndexes[i]].y;
							privIndexes[i] ++;
							 
							if (_speedVectors.length == privIndexes[i]) return;
							
							_view.ballViews[i].view.x += _speedVectors[privIndexes[i]].x;
							_view.ballViews[i].view.y += _speedVectors[privIndexes[i]].y;
							privIndexes[i] ++;
						}else 
						{
							_view.ballViews[i].view.x += _speedVectors[privIndexes[i]].x;
							_view.ballViews[i].view.y += _speedVectors[privIndexes[i]].y;
							privIndexes[i] ++;
						}
                    }
             }
        }
		
		public function MoveChainByBallStep(fromIndex:int):void
		{
				var i:int;
				var j:int;
				
				for (i = fromIndex; i < _view.ballViews.length; i++)
				{
						if (i != (_view.ballViews.length - 1))
						{
							_view.ballViews[i].view.x = _view.ballViews[i + 1].view.x;
							_view.ballViews[i].view.y = _view.ballViews[i + 1].view.y;
							privIndexes[i] = privIndexes[i + 1];
						}else 
						{	
							    var position:Point = new Point(_view.ballViews[i].view.x, _view.ballViews[i].view.y);
								var privPosition:Point = position.clone();
								var privIndex:int = privIndexes[i];
								
								for (j = privIndex; j < _speedVectors.length; j++)
								{
									  position.x += _speedVectors[j].x;
									  position.y += _speedVectors[j].y;
									  
									  var vect:Point = new Point(position.x - privPosition.x, position.y - privPosition.y);
									  
									  if ((vect.length + 0.5) < 2 * RADIUS)
									  {
											privIndexes[i] ++;
											
									  }else {
											
											privIndexes[i] ++;
											break;
										}
								 }
								 
								 _view.ballViews[i].view.x = position.x;
								 _view.ballViews[i].view.y = position.y;
					    }
						
				}
		}
		
		private var isFreeze:Boolean = false;
		
		public function FreezeChain():void
		{
				isFreeze = true;
		}
		
		public function UnfreezeChain():void
		{
				isFreeze = false;
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