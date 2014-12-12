package  
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    public class ZumaModel 
    {
        // TODO assign false when deploy
        public static const DEBUG:Boolean = true;
        private var _currentLevel:int = 1;
        
        public function ZumaModel() 
        {
            
        }
        
        public function get currentLevel():int 
        {
            return _currentLevel;
        }
        
        public function set currentLevel(value:int):void 
        {
            _currentLevel = value;
        }
        
    }

}