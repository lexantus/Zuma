package levels.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
     import flash.display.Sprite;
     import levels.controller.ZumaLevelController;
     import levels.model.ZumaLevelModel4;
     import levels.view.ZumaLevelView4;
     
     
    public class ZumaLevelController4 extends ZumaLevelController
    {    
        public function ZumaLevelController4(aSceneView:Sprite) 
        {
            model = new ZumaLevelModel4();
            view = new ZumaLevelView4();
            
            aSceneView.addChild(view);
        }
        
    }

}