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
        
        private var RADIUS:Number = 19;
        
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
        
        private function checkCollisions(projectileIndex:int):void
        {
            var i:int = 0;
            var ballsViews:Vector.<MovieClip> = _ballChainController.view.ballViews;
            
            var projectile:MovieClip = _projectiles[projectileIndex];
            
            var tempX:Number = projectile.x + SPEED_X;
            var tempY:Number = projectile.y + SPEED_Y;
            
            for (i = 0; i < ballsViews.length; i++)
            {
                    var x1:Number = new Number(ballsViews[i].x);
                    var y1:Number = new Number(ballsViews[i].y);
                    
                    var x2:Number = new Number(tempX);
                    var y2:Number = new Number(tempY);
                    
                    var distance:Number = Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
                    var radiusSum:Number = 2 * RADIUS;
                    
                    if (distance < radiusSum)
                    {
                            trace("collision");
                               
                            projectile.isColised = true;
                           
                            _projectiles.splice(projectileIndex, 1);
                            React(i, projectile);
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
                    checkCollisions(i);
                }
            }
            
             for (i = 0; i < _projectiles.length; i++)
            {
                _projectiles[i].x += SPEED_X;
                _projectiles[i].y += SPEED_Y;
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