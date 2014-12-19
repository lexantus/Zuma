package ball.model 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    public class SuperballModel 
    {
        public var isCurrentSuperballIsLaunched:Boolean = false;
    
        
        private static var _instance:SuperballModel;
        
        public static function gi():SuperballModel;
		{
			if(_instance == null){
				
				_instance = new SuperballModel(new SingletonEnforcer());
			}
			
			return _instance;
		}    
    }
}

class SingletonEnforcer{}