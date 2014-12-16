package levels.view.bg {
	/**
     * ...
     * @author Rozhin Alexey
     */
   import flash.display.MovieClip;
   import fla_assets.BgViewLevel5;
	
    
    public class BgViewLevel5 extends BgViewLevel
    {
        
        public function BgViewLevel5() 
        {
            view  = new fla_assets.BgViewLevel5();
            view.x = 399.85;
            view.y = 248.3;
            addChild(view);
        }
        
    }

}