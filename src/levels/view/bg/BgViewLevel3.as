package levels.view.bg {
	/**
     * ...
     * @author Rozhin Alexey
     */
   import flash.display.MovieClip;
   import fla_assets.BgViewLevel3;
	
    
    public class BgViewLevel3 extends BgViewLevel
    {
        
        public function BgViewLevel3() 
        {
            view  = new fla_assets.BgViewLevel3();
            view.x = 410.65;
            view.y = 227.35;
            addChild(view);
        }
        
    }

}