package levels.model
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import chain.model.BallChainModel;
    import path.model.PathModel4;
    
    
    public class ZumaLevelModel4 extends ZumaLevelModel
    {
        
        public function ZumaLevelModel4() 
        {
            super();
            
            pathModel = new PathModel4();
        }
        
    }

}