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
    import levels.model.ZumaLevelModel2;
    import levels.view.ZumaLevelView2;
    import path.model.PathModel2;
    import projectiles.controller.ProjectilesController;
    import ui.controller.UIZumaController;
    
    
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
            var startPoint:Point = new Point(3.8, 122);
            var finishPoint:Point = new Point(296.95, 276.3);
            
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
            
        }
        
        public function LoseLevel():void
        {
            
        }
        
    }

}