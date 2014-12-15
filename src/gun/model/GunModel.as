package gun.model 
{
    import ball.model.colors.interfaces.IBallColor;
	/**
     * ...
     * @author Rozhin Alexey
     */
    public class GunModel 
    {
        private var _currentProjectileColor:IBallColor;
        private var _nextProjectileColor:IBallColor;
        
        public function GunModel() 
        {
            
        }
        
        public function get currentProjectileColor():IBallColor 
        {
            return _currentProjectileColor;
        }
        
        public function set currentProjectileColor(value:IBallColor):void 
        {
            _currentProjectileColor = value;
        }
        
        public function get nextProjectileColor():IBallColor 
        {
            return _nextProjectileColor;
        }
        
        public function set nextProjectileColor(value:IBallColor):void 
        {
            _nextProjectileColor = value;
        }
        
    }

}