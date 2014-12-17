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
    import levels.model.ZumaLevelModel3;
    import levels.view.ZumaLevelView3;
    import path.model.PathModel3;
    import projectiles.controller.ProjectilesController;
    
    
    public class ZumaLevelController3 extends ZumaLevelController implements IZumaLevelController
    {
        
        public function ZumaLevelController3(aSceneView:Sprite) 
        {
            super(aSceneView);
            
            model = new ZumaLevelModel3();
            model.pathModel = new PathModel3();
            
            view = new ZumaLevelView3();
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