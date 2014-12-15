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
    
    
    public class ProjectilesController 
    {
        private const SPEED_X:Number = 0;
        private const SPEED_Y:Number = -30;
        
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
        
        public function Update():void
        {
            var i:int = 0;
            
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