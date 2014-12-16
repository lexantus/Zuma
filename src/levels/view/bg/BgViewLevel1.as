package levels.view.bg {
	/**
     * ...
     * @author Rozhin Alexey
     */
   import flash.display.MovieClip;
   import fla_assets.BgViewLevel1;
	
    
    public class BgViewLevel1 extends BgViewLevel
    {
        
        public function BgViewLevel1() 
        {
            view  = new fla_assets.BgViewLevel1();
            view.x = 388.6;
            view.y = 244.85;
            addChild(view);
        }
        
    }

}