package levels.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
     import flash.display.Sprite;
     import levels.controller.ZumaLevelController;
     import levels.model.ZumaLevelModel5;
     import levels.view.ZumaLevelView5;
     
     
    public class ZumaLevelController5 extends ZumaLevelController
    { 
        public function ZumaLevelController5(aSceneView:Sprite) 
        {
            model = new ZumaLevelModel5();
            view = new ZumaLevelView5();
            
            aSceneView.addChild(view);
        }
        
    }

}