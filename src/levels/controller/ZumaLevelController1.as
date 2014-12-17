package levels.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import chain.controller.BallChainController;
    import flash.display.Sprite;
    import flash.geom.Point;
    import gun.controller.GunController;
    import levels.controller.ZumaLevelController;
    import levels.model.ZumaLevelModel1;
    import levels.view.ZumaLevelView1;
    import path.model.PathModel1;
    import projectiles.controller.ProjectilesController;
    
    
    public class ZumaLevelController1 extends ZumaLevelController implements IZumaLevelController
    {
        
        public function ZumaLevelController1(aSceneView:Sprite) 
        {
            super(aSceneView);
            
            model = new ZumaLevelModel1();
            model.pathModel = new PathModel1();
            
            view = new ZumaLevelView1();
            scene.addChild(view);
        }
        
        public function Start():void
        {
            var startPoint:Point = new Point(-4, 121.2);
            var finishPoint:Point = new Point(118.85, 351.3);
            
            ballChainController  = new BallChainController(scene, model.pathModel.speedVectors, startPoint, finishPoint);
            ballChainController.GenerateStartChain(10);
            
            projectilesController = new ProjectilesController(scene, ballChainController);
            
            gunController = new GunController(scene, projectilesController);
        }
        
        public function Update():void
        {
            if (projectilesController)
            {
                projectilesController.Update();
                ballChainController.MoveChain();
            }
        }
        
    }

}