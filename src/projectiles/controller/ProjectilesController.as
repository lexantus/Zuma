package projectiles.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import chain.controller.BallChainController;
    import flash.display.MovieClip;
    
    
    public class ProjectilesController 
    {
        private const SPEED_X:Number = 0;
        private const SPEED_Y:Number = -10;
        
        private var _projectiles:Vector.<MovieClip>;
        
        private var _ballChainController:BallChainController;
        
        public function ProjectilesController(aBallChainConroller:BallChainController) 
        {
            _projectiles = new Vector.<MovieClip>;
            _ballChainController = aBallChainConroller;
        }
        
        public function fire(projectile:MovieClip):void
        {
            _projectiles.push(projectile);
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