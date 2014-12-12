package levels.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
     import levels.controller.ZumaLevelController;
     import levels.controller.interfaces.IZumaLevelController;
     import levels.model.ZumaLevelModel3;
     
    public class ZumaLevelController3 extends ZumaLevelController implements IZumaLevelController 
    {
        
        public function ZumaLevelController3() 
        {
            model = new ZumaLevelModel3();
        }
        
    }

}