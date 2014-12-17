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
    import levels.model.ZumaLevelModel2;
    import levels.view.ZumaLevelView2;
    import path.model.PathModel2;
    import projectiles.controller.ProjectilesController;
    
    
    public class ZumaLevelController2 extends ZumaLevelController implements IZumaLevelController
    {
        
        public function ZumaLevelController2(aSceneView:Sprite) 
        {
            super(aSceneView);
            
            model = new ZumaLevelModel2();
            model.pathModel = new PathModel2();
            
            view = new ZumaLevelView2();
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