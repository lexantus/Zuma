package levels.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
     import flash.display.Sprite;
     import levels.controller.ZumaLevelController;
     import levels.model.ZumaLevelModel3;
     import levels.view.ZumaLevelView3;
     
    public class ZumaLevelController3 extends ZumaLevelController
    {
        
        public function ZumaLevelController3(aSceneView:Sprite) 
        {
            model = new ZumaLevelModel3();
            view = new ZumaLevelView3();
            
            aSceneView.addChild(view);
        }
        
    }

}