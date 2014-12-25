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
        
        private var _WinFunc:Function;
        private var _LoseFunc:Function;
        
        public function BallChainController(sceneView:Sprite, aSpeedVectors:Vector.<Point>, aStartPoint:Point, aFinishPoint:Point, aWinCallback:Function, aLoseCallback:Function) 
        {
            sceneView.addChild(_view);
            
            _speedVectors = aSpeedVectors;
            _startPt = aStartPoint;
            _finishPt = aFinishPoint;
            
            _WinFunc = aWinCallback;
            _LoseFunc = aLoseCallback;
        }
		
		public function GenerateStartChain(numBalls:int):void
		{
			for (var j:int = 0; j < numBalls; j++)
			{
				GenerateBall();
			}
		}
		
		private function FindBallsIndexesForDestroy():Vector.<int>
		{
			var i:int;
			
			var startIndex:int = 0;
			var count:int = 0;
            
			var tempDesc:BallDescription;
            
            if (_view.ballViews.length != 0)
            {
                tempDesc = _view.ballViews[startIndex].desc;
            }
			
			var indexesToDelete:Vector.<int> = new Vector.<int>;
			
			for (i = 1; i < _view.ballViews.length; i++)
			{
					if (tempDesc.color == _view.ballViews[i].desc.color)
					{
							tempDesc = _view.ballViews[i].desc;
							count ++;
							
							if (i == (_view.ballViews.length - 1))
							{
								if (count >= 2)
								{
									count ++;
									
									while (count > 0)
									{
											indexesToDelete.push((i + 1)- count);
											count --;
									}
									
									return indexesToDelete;
								}
							}
							
							
					}else {
						
							tempDesc = _view.ballViews[i].desc;
							
							if (count >= 2)
							{
									count ++;
									
									while (count > 0)
									{
											indexesToDelete.push(i - count);
											count --;
									}
									
									return indexesToDelete;
							}else{
							
								count = 0;
							}
						
					}
			}
			
			return null;
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

                         privIndexes.push(privIndex);
                         break;
                    }
                }
            }
            
            if (_bonus is FastShootingBonus)
            {
                 _view.addBall(BallUtils.GetBallViewClass(_color, _bonus), position, ballDesc);   
               
            }else if (_bonus is PlusOneBonus)
            {
                 _view.addBall(BallUtils.GetBallViewClass(_color, _bonus), position, ballDesc);   
                
            }else if (_bonus is StopMovementBonus)
            {
                 _view.addBall(BallUtils.GetBallViewClass(_color, _bonus), position, ballDesc);   
                
            }else if (_bonus == null)
            {
                _view.addBall(BallUtils.GetBallViewClass(_color, _bonus), position, ballDesc);     
            }
        }
		
		public function IncludeProjectileInChain(indexOfCollisionBallInChain:int, ballView:BallView, position:Point, privIndex:int):void
		{
				if (ballView.desc.color == null)
				{
						// it is superball
						var j:int;
						
						ballView.parent.removeChild(ballView);
						
						for (j = 0; j < _view.ballViews.length; j++)
						{
								KillBall(j);
						}
						
						_view.ballViews.splice(0, _view.ballViews.length);
						return;
				}
			
				ballView.parent.removeChild(ballView);
				_view.ballViews.splice(indexOfCollisionBallInChain, 0, ballView);
				_view.ballViews[indexOfCollisionBallInChain].x = 0;
				_view.ballViews[indexOfCollisionBallInChain].y = 0;
				_view.ballViews[indexOfCollisionBallInChain].view.x = position.x;
				_view.ballViews[indexOfCollisionBallInChain].view.y = position.y;
				_view.addChild(ballView);
				
			   privIndexes.splice(indexOfCollisionBallInChain, 0, privIndex);
			   
			   var destroyIndexes:Vector.<int> = FindBallsIndexesForDestroy();
			   
			   while (destroyIndexes)
			   {
				   trace(destroyIndexes);
				   var rightIndex:int = destroyIndexes[0];
				   var leftIndex:int = destroyIndexes[0] - 1;
				   
				   var i:int;
                    
                    MoveChainByBallStepBack(destroyIndexes[0], destroyIndexes.length);
				   
					for (i = 0; i < destroyIndexes.length; i++)
					{
						KillBall(destroyIndexes[i]);
					}
						
					_view.ballViews.splice(destroyIndexes[0], destroyIndexes.length);
					
					destroyIndexes = FindBallsIndexesForDestroy();
					
					if (destroyIndexes == null)
					{
						
						if ((rightIndex != _view.ballViews.length) && (_view.ballViews[rightIndex].desc.bonus != null))
						{
								 KillBall(rightIndex);
									 
								 if ((leftIndex != -1) && (_view.ballViews[leftIndex].desc.bonus != null))
								 {
										 MoveChainByBallStepBack(leftIndex, 2);
										 KillBall(leftIndex);
										 _view.ballViews.splice(leftIndex, 2);
								 }else{
									 
									 MoveChainByBallStepBack(rightIndex, 1);
									 KillBall(rightIndex);
									 _view.ballViews.splice(rightIndex, 1);
								 }
						}else {
								 
							if ((leftIndex != -1) && (_view.ballViews[leftIndex].desc.bonus != null))
							{
										 MoveChainByBallStepBack(leftIndex, 1);
										 KillBall(leftIndex);
										 _view.ballViews.splice(leftIndex, 1);
							 }
							
						}
						
						destroyIndexes = FindBallsIndexesForDestroy();
					
					}else {
							
						destroyIndexes = FindBallsIndexesForDestroy();
					}
					
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
		
        private function CheckStatus():void
        {
                if (_view.ballViews.length == 0)
                {
                    _WinFunc();
					FreezeChain();
                }
                
				for (var i:int = 0; i < view.ballViews.length; i++)
				{
					if (privIndexes[i] == (_speedVectors.length - 1))
					{
						_LoseFunc();
						FreezeChain();
					}
				}
        }
		
		public function MoveBallsWhenLose():Boolean
		{
			var speedFactor:int = 3;
			var isDeleteAllBalls:Boolean = false;
			
			var i:int = 0;
			
			while (i < _view.ballViews.length)
            {
					for (var j:int = 0; j < speedFactor; j++)
					{
						if (privIndexes.length > 0)
						{
								if (_speedVectors.length != privIndexes[i])
								{
									if (_speedVectors[privIndexes[i]].length < 4)
									{
										_view.ballViews[i].view.x += _speedVectors[privIndexes[i]].x;
										_view.ballViews[i].view.y += _speedVectors[privIndexes[i]].y;
										privIndexes[i] ++;
										 
										if (_speedVectors.length == privIndexes[i]) return isDeleteAllBalls;
										
										_view.ballViews[i].view.x += _speedVectors[privIndexes[i]].x;
										_view.ballViews[i].view.y += _speedVectors[privIndexes[i]].y;
										privIndexes[i] ++;
									}else 
									{
										_view.ballViews[i].view.x += _speedVectors[privIndexes[i]].x;
										_view.ballViews[i].view.y += _speedVectors[privIndexes[i]].y;
										privIndexes[i] ++;
									}
								}else {
											_view.ballViews[i].parent.removeChild(_view.ballViews[i]);
											_view.ballViews.splice(i, 1);
											privIndexes.splice(i, 1);
											i --;
											
											if (i == -1)
											{
													isDeleteAllBalls = true;
													
													return isDeleteAllBalls;
											}
								}
						}
					}
					
					i ++;
				}
				
				return isDeleteAllBalls;
		}
        
		private var g:int = 0;
        
        public function MoveChain():void
        {
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
             
             CheckStatus();
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
                
                CheckStatus();
		}
        
        public function MoveChainByBallStepBack(fromIndex:int, count:int):void
		{
				var i:int;
                var tempCoords:Vector.<Point> = new Vector.<Point>;
                
                 for (i = 0; i < _view.ballViews.length; i++)
                {
                    tempCoords.push(new Point(_view.ballViews[i].view.x, _view.ballViews[i].view.y));
                }
               
                for (i = fromIndex; i < _view.ballViews.length; i++)
                {
                        if (i + count < _view.ballViews.length)
                        {
                            _view.ballViews[i + count].view.x = tempCoords[i].x;
                            _view.ballViews[i + count].view.y = tempCoords[i].y;
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