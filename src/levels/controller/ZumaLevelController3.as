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
    import levels.model.ZumaLevelModel3;
    import levels.view.ZumaLevelView3;
    import path.model.PathModel3;
    import projectiles.controller.ProjectilesController;
    import ui.controller.UIZumaController;
    
    
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
            var startPoint:Point = new Point(387.05, -290.05);
            var finishPoint:Point = new Point(304.65, 121.9);
            
            ballChainController  = new BallChainController(scene, model.pathModel.speedVectors, startPoint, finishPoint, WinLevel, LoseLevel);
            ballChainController.GenerateStartChain(10);
            
            uiController = new UIZumaController(scene, BuySuperball, FireSuperball);
            projectilesController = new ProjectilesController(scene, ballChainController, uiController);
            gunController = new GunController(scene, projectilesController, uiController);
        }
        
        public function BuySuperball():void
        {
        }
        
        public function FireSuperball():void
        {
            gunController.SetSuperballProjectile();
        }
        
        public function Update():void
        {
            if (projectilesController)
            {
                projectilesController.Update();
                ballChainController.MoveChain();
            }
        }
        
        public function WinLevel():void
        {
            trace("WIN !!!");
        }
        
        public function LoseLevel():void
        {
            trace("LOSE !!!");
            gunController.StopGun();
        }
        
    }

}