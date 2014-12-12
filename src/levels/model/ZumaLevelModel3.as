package levels.model {
	/**
     * ...
     * @author Rozhin Alexey
     */
    import chain.model.BallChainModel;
    import path.model.PathModel3;
    
    
    public class ZumaLevelModel3 extends ZumaLevelModel
    {
        
        public function ZumaLevelModel3() 
        {
            super();
            
            speed = 2;
            pathModel = new PathModel3();
        }
        
    }

}