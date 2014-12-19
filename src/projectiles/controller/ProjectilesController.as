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
            
            var tempX:Number = projectile.x;
            var tempY:Number = projectile.y;
            
            for (i = 0; i < ballsViews.length; i++)
            {
                    var x1:Number = new Number(ballsViews[i].view.x);
                    var y1:Number = new Number(ballsViews[i].view.y);
                    
                    var x2:Number = new Number(tempX);
                    var y2:Number = new Number(tempY);
                    
                    var distance:Number = Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
                    var radiusSum:Number = 2 * RADIUS;
                    
                    if (distance < radiusSum)
                    {
                            trace("collision");
                               
                            //var A:Point = new Point(x1 - projectile.x, y1 - projectile.y);
                            //A.normalize(1);
                            
                            //projectile.x -= A.x;
                            //projectile.y += A.y;
                           
                            //projectile.AnimateDie(null);
                            //_ballChainController.KillBall(i);
                            var A:Point = new Point(x2 - x1, y2 - y1);
                            var k:Number = Math.atan(A.y / A.x);
                            trace("angle1 = " + Math.atan(k) * 180/Math.PI);
      
                            
                            var intersectsPtsCircle1:Vector.<Point> = FindIntersectPtCircleWithLine1(x1, y1, RADIUS, k, 0);
                            var intersectsPtsCircle2:Vector.<Point> = FindIntersectPtCircleWithLine1(x2, y2, RADIUS, k, 0);
                            
                            var p:int;
                            
                            for (p = 0; p < intersectsPtsCircle1.length; p++)
                            {
                                if (!isNaN(intersectsPtsCircle1[p].x))
                                {
                                    var ptMc1:MovieClip = new PointUtil;
                                    ptMc1.x = intersectsPtsCircle1[p].x + 200;
                                    ptMc1.y = intersectsPtsCircle1[p].y + 200;
                                    trace(i +"___"+intersectsPtsCircle1[p]);
                                    _scene.addChild(ptMc1);
                                }
                            }
                            
                            for (p = 0; p < intersectsPtsCircle2.length; p++)
                            {
                                var ptMc2:MovieClip = new PointUtil;
                                ptMc2.x = intersectsPtsCircle2[p].x + 200;
                                ptMc2.y = intersectsPtsCircle2[p].y + 200;
                                _scene.addChild(ptMc2);
                            }
                            
                            _projectiles.splice(projectileIndex, 1);
                            React(i, projectile);
                    }
            }
        }
        
        // x0, y0 - circle center, R-radius ( (x-x0)^2 + (y - y0)^2 = R^2 ), k-tangence b (y = kx + b)
        private function FindIntersectPtCircleWithLine(x0:Number, y0:Number, R:Number, k:Number, b:Number):Vector.<Point>
        {
            var roots:Vector.<Point> = new Vector.<Point>;
            
            var interSectX1:Number =
            
                (1 / (2 * (k * k + 1))) * ((-2*b*k + 2*k*y0 + 2 * x0) + Math.sqrt(Math.pow(2*b*k - 2 * k * y0 - 2 * x0, 2) - 4 * (k * k + 1) * (b * b - 2 * b * y0 - R * R + x0 * x0 + y0 * y0)));
            ;
            
            var interSectX2:Number =
                (1 / (2 * (k * k + 1))) * ((-2*b*k + 2*k*y0 + 2 * x0) - Math.sqrt(Math.pow(2*b*k - 2 * k * y0 - 2 * x0, 2) - 4 * (k * k + 1) * (b * b - 2 * b * y0 - R * R + x0 * x0 + y0 * y0)));
            ;
            
            var interSectY1:Number = k * interSectX1 + b;
            var interSectY2:Number = k * interSectX2 + b;
            
            roots.push(new Point(interSectX1, interSectY1));
            roots.push(new Point(interSectX2, interSectY2));
            
            return roots;
        }
        
         private function FindIntersectPtCircleWithLine1(x0:Number, y0:Number, R:Number, k:Number, b:Number):Vector.<Point>
        {
            var roots:Vector.<Point> = new Vector.<Point>;
            
            var interSectX1:Number =
                    ( -2 * k * b + Math.sqrt(4 * (R * R * (1 + k * k) - b * b))) / 2 * (1 + k * k);
               ;
            
            var interSectX2:Number =
                     ( -2 * k * b - Math.sqrt(4 * (R * R * (1 + k * k) - b * b))) / 2 * (1 + k * k);
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
                    trace("ball is out");
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