package levels.model
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import chain.model.BallChainModel;
    import path.model.PathModel5;
    
    
    public class ZumaLevelModel5 extends ZumaLevelModel
    {
        
        public function ZumaLevelModel5() 
        {
            super();
            
            pathModel = new PathModel5();
        }
        
    }

}