package levels.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import flash.display.Sprite;
    import levels.controller.ZumaLevelController;
    import levels.model.ZumaLevelModel1;
    import levels.view.ZumaLevelView1;
    
    
    public class ZumaLevelController1 extends ZumaLevelController 
    {
        
        public function ZumaLevelController1(aSceneView:Sprite) 
        {
            model = new ZumaLevelModel1();
            view = new ZumaLevelView1();
            
            aSceneView.addChild(view);
        }
        
    }

}