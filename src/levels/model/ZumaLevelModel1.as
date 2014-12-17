package levels.model 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import chain.model.BallChainModel;
    import path.model.PathModel1;

    
    public class ZumaLevelModel1 extends ZumaLevelModel
    {
        
        public function ZumaLevelModel1() 
        {
            super();
            
            pathModel = new PathModel1();
        }
        
    }

}