package levels.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
     import flash.display.Sprite;
     import levels.controller.ZumaLevelController;
     import levels.model.ZumaLevelModel2;
     import levels.view.ZumaLevelView2;
     
     
    public class ZumaLevelController2 extends ZumaLevelController 
    {
        
        public function ZumaLevelController2(aSceneView:Sprite) 
        {
            model = new ZumaLevelModel2();
            view = new ZumaLevelView2();
            
            aSceneView.addChild(view);
        }
        
    }

}