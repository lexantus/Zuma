package levels.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import levels.controller.interfaces.IZumaLevelController;
    import levels.controller.ZumaLevelController;
    import levels.model.ZumaLevelModel1;
    
    
    public class ZumaLevelController1 extends ZumaLevelController implements IZumaLevelController 
    {
        
        public function ZumaLevelController1() 
        {
            model = new ZumaLevelModel1();
            
            model.pathModel;
            model.speed;
            model.ballChainModel;
        }
        
    }

}