package levels.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import chain.controller.BallChainController;
    import flash.display.Sprite;
    import gun.controller.GunController;
    import levels.controller.ZumaLevelController;
    import levels.model.ZumaLevelModel5;
    import levels.view.ZumaLevelView5;
    import path.model.PathModel5;
    import projectiles.controller.ProjectilesController;
    
    
    public class ZumaLevelController5 extends ZumaLevelController implements IZumaLevelController
    {
        
        public function ZumaLevelController5(aSceneView:Sprite) 
        {
            super(aSceneView);
            
            model = new ZumaLevelModel5();
            model.pathModel = new PathModel5();
            
            view = new ZumaLevelView5();
            scene.addChild(view);
            
        }
        
        public function Start():void
        {
            ballChainController  = new BallChainController(scene);
            ballChainController.GenerateStartChain(12);
            
            projectilesController = new ProjectilesController(scene, ballChainController);
            
            gunController = new GunController(scene, projectilesController);
        }
        
        public function Update():void
        {
            if (projectilesController)
            {
                projectilesController.Update();
            }
        }
        
    }

}