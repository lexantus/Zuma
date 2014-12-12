package levels.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
     import levels.controller.interfaces.IZumaLevelController;
     import levels.controller.ZumaLevelController;
     import levels.model.ZumaLevelModel2;
     
     
    public class ZumaLevelController2 extends ZumaLevelController implements IZumaLevelController 
    {
        
        public function ZumaLevelController2() 
        {
            model = new ZumaLevelModel2();
        }
        
    }

}