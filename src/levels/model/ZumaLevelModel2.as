package levels.model
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import chain.model.BallChainModel;
    import path.model.PathModel2;
    
    
    public class ZumaLevelModel2 extends ZumaLevelModel 
    {
        
        public function ZumaLevelModel2() 
        {
            super();
            
            speed = 2;
            pathModel = new PathModel2();
        }
        
    }

}