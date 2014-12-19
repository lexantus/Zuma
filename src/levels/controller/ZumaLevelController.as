package levels.controller 
{
    import chain.controller.BallChainController;
    import flash.display.Sprite;
    import gun.controller.GunController;
    import levels.model.ZumaLevelModel;
    import levels.view.ZumaLevelView;
    import path.model.PathModel1;
    import projectiles.controller.ProjectilesController;
    import ui.controller.UIZumaController;
	/**
     * ...
     * @author Rozhin Alexey
     */
    public class ZumaLevelController 
    {
        public var scene:Sprite;
        
        public var model:ZumaLevelModel;
        public var view:ZumaLevelView;
        
        public var ballChainController:BallChainController;
        public var gunController:GunController;
        public var projectilesController:ProjectilesController;
        
        public var uiController:UIZumaController;
        
        
        public function ZumaLevelController(aSceneView:Sprite)
        {
                scene = aSceneView;
        }
    }

}