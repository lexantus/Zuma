package projectiles.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import ball.view.BallView;
    import ball.view.bonus.SuperBallView;
    import chain.controller.BallChainController;
    import fla_assets.PointUtil;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.geom.Point;
    import projectiles.utils.Boundary;
    import ui.controller.UIZumaController;
    
    
    public class ProjectilesController 
    {
        private const SPEED_X:Number = 0;
        private const SPEED_Y:Number = -45;
        
        private var RADIUS:Number = 20.5;
        
        private var _projectiles:Vector.<BallView>;
        
        private var _scene:Sprite;
        
        private var _ballChainController:BallChainController;
        private var _uiController:UIZumaController;
        
        
        
        public function ProjectilesController(aScene:Sprite, aBallChainConroller:BallChainController, anUiController:UIZumaController) 
        {
            _projectiles = new Vector.<BallView>;
            _ballChainController = aBallChainConroller;
            _uiController = anUiController;
            _scene = aScene;
        }
        
        public function fire(projectile:BallView, startPt:Point):void
        {
            if (projectile is SuperBallView)
            {
                _uiController.AllowAddNewSuperball();
            }
             
            _projectiles.push(projectile);
            _projectiles[_projectiles.length - 1].scaleX = 1;
            _projectiles[_projectiles.length - 1].scaleY = 1;
            _projectiles[_projectiles.length - 1].x = Math.abs(startPt.x);
            _projectiles[_projectiles.length - 1].y = Math.abs(startPt.y);
            _scene.addChild(_projectiles[_projectiles.length - 1]);
        }
        
        private function checkCollisions(projectileIndex:int):void
        {
            var i:int = 0;
            var ballsViews:Vector.<BallView> = _ballChainController.view.ballViews;
            
            var projectile:BallView = _projectiles[projectileIndex];
            
            
            for (i = 0; i < ballsViews.length; i++)
            {
                    var x1:Number = new Number(ballsViews[i].view.x);
                    var y1:Number = new Number(ballsViews[i].view.y);

                    
                    var x2:Number = new Number(projectile.x);
                    var y2:Number = new Number(projectile.y);
					
                    
                    var distance:Number = Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
                    var radiusSum:Number = 2 * RADIUS;
                    
                    if (distance < radiusSum)
                    {
                             // collision detected
                            var A:Point = new Point(x2 - x1, y2 - y1);
							var B:Point = new Point(x1 - x2, y1 - y2);
                            var k:Number = Math.atan(A.y / A.x);
                            
                            var intersectsPtsCircle1:Vector.<Point> = FindIntersectPtCircleWithLine(x1, y1, RADIUS, k, 0);
                            var intersectsPtsCircle2:Vector.<Point> = FindIntersectPtCircleWithLine(x2, y2, RADIUS, k, 0);
                            
                            var p:int;
                            
                            for (p = 0; p < intersectsPtsCircle1.length; p++)
                            {
									trace(intersectsPtsCircle1[p]);
								
                                    var ptMc1:MovieClip = new PointUtil;
                                    ptMc1.x = x1 + intersectsPtsCircle1[p].x;
                                    ptMc1.y = y1 + intersectsPtsCircle1[p].y;
                                    _scene.addChild(ptMc1);
                            }
							
							  var ptMcCent1:MovieClip = new PointUtil;
                                   ptMcCent1.x = x1;
                                   ptMcCent1.y = y1;
                                   _scene.addChild(ptMcCent1);
                            
                            for (p = 0; p < intersectsPtsCircle2.length; p++)
                            {
                                var ptMc2:MovieClip = new PointUtil;
                                ptMc2.x = x2 + intersectsPtsCircle2[p].x;
                                ptMc2.y = y2 + intersectsPtsCircle2[p].y;
                                _scene.addChild(ptMc2);
                            }
							
							 var ptMcCent2:MovieClip = new PointUtil;
                                   ptMcCent2.x = x2;
                                   ptMcCent2.y = y2;
                                   _scene.addChild(ptMcCent2);
                            
                            _projectiles.splice(projectileIndex, 1);
                            React(i, projectile);
                    }
            }
        }
        
         private function FindIntersectPtCircleWithLine(x0:Number, y0:Number, R:Number, k:Number, b:Number):Vector.<Point>
        {
            var roots:Vector.<Point> = new Vector.<Point>;
            
            var interSectX1:Number =
                    ( -2 * k * b + Math.sqrt(4 * (R * R * (1 + k * k) - b * b))) / (2 * (1 + k * k));
               ;
            
            var interSectX2:Number =
                     ( -2 * k * b - Math.sqrt(4 * (R * R * (1 + k * k) - b * b))) / (2 * (1 + k * k));
            ;
            
            var interSectY1:Number = k * interSectX1 + b;
            var interSectY2:Number = k * interSectX2 + b;
            
            roots.push(new Point(interSectX1, interSectY1));
            roots.push(new Point(interSectX2, interSectY2));
            
            return roots;
        }
        
        private function React(indexOfCollisionBallInChain:int, projectile:BallView):void
        {
            
        }
        
        private var boundary:Boundary = new Boundary(-100, 874, -100, 600);
        
        private function checkBoundary(projectileIndex:int):Boolean
        {
            var projectile:BallView = _projectiles[projectileIndex];
            var tempX:Number = projectile.x + SPEED_X;
            var tempY:Number = projectile.y + SPEED_Y;
            
            if ((tempX > boundary.maxX || tempX < boundary.minX)
                                       ||
                (tempY > boundary.maxY || tempY < boundary.minY))
            {
                    projectile.parent.removeChild(projectile);
                    _projectiles.splice(projectileIndex, 1);
                    return false;
            }
            
            return true;
        }
        
        public function Update():void
        {
            var i:int = 0;
            
            for (i = 0; i < _projectiles.length; i++)
            {
                _projectiles[i].x += SPEED_X;
                _projectiles[i].y += SPEED_Y;
            }
            
            for (i = 0; i < _projectiles.length; i++)
            {
                if (checkBoundary(i))
                {
                    checkCollisions(i);
                }
            }
            
        }
        
        public function get ballChainController():BallChainController 
        {
            return _ballChainController;
        }
        
        public function set ballChainController(value:BallChainController):void 
        {
            _ballChainController = value;
        }
        
    }

}