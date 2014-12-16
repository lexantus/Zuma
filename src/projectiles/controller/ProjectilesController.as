package projectiles.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import chain.controller.BallChainController;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.geom.Point;
    import projectiles.utils.Boundary;
    
    
    public class ProjectilesController 
    {
        private const SPEED_X:Number = 0;
        private const SPEED_Y:Number = -30;
        
        private var RADIUS:Number = 20;
        
        private var _projectiles:Vector.<MovieClip>;
        
        private var _scene:Sprite;
        
        private var _ballChainController:BallChainController;
        
        public function ProjectilesController(aScene:Sprite, aBallChainConroller:BallChainController) 
        {
            _projectiles = new Vector.<MovieClip>;
            _ballChainController = aBallChainConroller;
            _scene = aScene;
        }
        
        public function fire(projectile:MovieClip, startPt:Point):void
        {
            trace("fire");
            _projectiles.push(projectile);
            _projectiles[_projectiles.length - 1].scaleX = 1;
            _projectiles[_projectiles.length - 1].scaleY = 1;
            _projectiles[_projectiles.length - 1].x = Math.abs(startPt.x);
            _projectiles[_projectiles.length - 1].y = Math.abs(startPt.y);
            _scene.addChild(_projectiles[_projectiles.length - 1]);
        }
        
        private function checkCollisions(projectile:MovieClip):void
        {
            var i:int = 0;
            var ballsViews:Vector.<MovieClip> = _ballChainController.view.ballViews;
            
            var tempX:Number = projectile.x + SPEED_X;
            var tempY:Number = projectile.y + SPEED_Y;
            
            for (i = 0; i < ballsViews.length; i++)
            {
                    var x1:Number = new Number(ballsViews[i].x + ballsViews[i].width / 2);
                    var y1:Number = new Number(ballsViews[i].y + ballsViews[i].height / 2);
                    
                    var x2:Number = new Number(tempX + projectile.width / 2);
                    var y2:Number = new Number(tempY + projectile.height / 2);
                    
                    var distance:Number = Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
                    var radiusSum:Number = 2 * RADIUS;
                    
                    if (distance < radiusSum)
                    {
                            trace("collision");
                            React(i, projectile);
                    }else 
                    {
                            projectile.x = tempX;
                            projectile.y = tempY;
                    }
            }
        }
        
        private function React(indexOfCollisionBallInChain:int, projectile:MovieClip):void
        {
            
        }
        
        private var boundary:Boundary = new Boundary(-100, 874, -100, 600);
        
        private function checkBoundary(projectileIndex:int):Boolean
        {
            var projectile:MovieClip = _projectiles[projectileIndex];
            var tempX:Number = projectile.x + SPEED_X;
            var tempY:Number = projectile.y + SPEED_Y;
            
            if ((tempX > boundary.maxX || tempX < boundary.minX)
                                       ||
                (tempY > boundary.maxY || tempY < boundary.minY))
            {
                    trace("ball is out");
                    projectile.x = tempX;
                    projectile.y = tempY;
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
                if (checkBoundary(i))
                {
                    checkCollisions(_projectiles[i]);
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