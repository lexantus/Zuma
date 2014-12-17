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
    import levels.model.ZumaLevelModel4;
    import levels.view.ZumaLevelView4;
    import path.model.PathModel4;
    import projectiles.controller.ProjectilesController;
    
    
    public class ZumaLevelController4 extends ZumaLevelController implements IZumaLevelController
    {
        
        public function ZumaLevelController4(aSceneView:Sprite) 
        {
            super(aSceneView);
            
            model = new ZumaLevelModel4();
            model.pathModel = new PathModel4();
            
            view = new ZumaLevelView4();
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