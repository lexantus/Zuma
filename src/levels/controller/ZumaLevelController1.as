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
    import ui.controller.UIZumaController;
    
    
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
            startPoint = new Point(5.25, 118.85);
            finishPoint = new Point(118.85, 351.3);
            
            ballChainController  = new BallChainController(scene, model.pathModel.speedVectors, startPoint, finishPoint, WinLevel, LoseLevel);
            ballChainController.GenerateStartChain(10);
            
            uiController = new UIZumaController(scene, BuySuperball, FireSuperball);
            projectilesController = new ProjectilesController(scene, ballChainController, uiController);
            gunController = new GunController(scene, projectilesController, uiController);
        }
		
		public function Restart():void
		{
			model = new ZumaLevelModel1();
            model.pathModel = new PathModel1();
			
			gunController.RemoveGunMovieClip();
			
			Start();
		}
        
        public function BuySuperball():void
        {
        }
        
        public function FireSuperball():void
        {
            gunController.SetSuperballProjectile();
        }
        
		private var missFrameForMoveChain:int = 0;
		private const MISS_FRAME_MOVE_CHAIN:int = 4;
		
        public function Update():void
        {
            if (projectilesController)
            {
                projectilesController.Update();
				
				if (!model.isLose)
				{
					
					if (missFrameForMoveChain != MISS_FRAME_MOVE_CHAIN)
					{
						missFrameForMoveChain ++;
						
					}else{
						
						missFrameForMoveChain = 0;
						ballChainController.MoveChain();
					}
				
				}else {
						
					if (ballChainController.MoveBallsWhenLose())
					{
						model.isLoseAndFinishHideBallAnimations = true;
					}
				}
            }
        }
        
       public function WinLevel():void
        {
            trace("WIN !!!");
			model.isWin = true;
        }
        
        public function LoseLevel():void
        {
            trace("LOSE !!!");
            gunController.StopGun();
			model.isLose = true;
        }
        
    }

}