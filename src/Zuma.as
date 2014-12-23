package 
{
    /**
     * ...
     * @author Rozhin Alexey
     */
    
	import fla_assets.Path1;
    import fla_assets.Path2;
    import fla_assets.Path3;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;
    import levels.controller.ZumaLevelController;
    import levels.controller.*;
    import path.model.PathModelGenerator;
    
    import fla_assets.Background;
	import ball.view.ordinary.RedBallView;
    import chain.controller.BallChainController;
    import gun.controller.GunController;
    import path.model.Segment;
    import projectiles.controller.ProjectilesController;
    
    import path.view.PathView;
    import path.view.*;
    
	public class Zuma extends Sprite 
	{
        private var _path:MovieClip;
        private var _pathGenerator:PathModelGenerator;
        
        private var _bg:MovieClip;
 
        private var _levelController:IZumaLevelController;
		
		public function Zuma():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
            _bg = new Background();
            _bg.x = 293.9;
            _bg.y = 247;
            addChild(_bg);
            
            GenerateLevelCoords();
            
            _levelController = new ZumaLevelController3(this);
            _levelController.Start();
            
            this.addEventListener(Event.ENTER_FRAME, OnUpdate);
		}
        
        private function GenerateLevelCoords():void
        {
            _pathGenerator = new PathModelGenerator(new Path3);
        }
        
        private function OnUpdate(e:Event):void 
        {
            _levelController.Update();
        }
        
	}
	
}