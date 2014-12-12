package levels.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
     import levels.controller.interfaces.IZumaLevelController;
     import levels.controller.ZumaLevelController;
     import levels.model.ZumaLevelModel4;
     
     
    public class ZumaLevelController4 extends ZumaLevelController implements IZumaLevelController 
    {
        
        public function ZumaLevelController4() 
        {
            model = new ZumaLevelModel4();
        }
        
    }

}