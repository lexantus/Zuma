package levels.view.bg {
	/**
     * ...
     * @author Rozhin Alexey
     */
   import flash.display.MovieClip;
   import fla_assets.BgViewLevel2;
	
    
    public class BgViewLevel2 extends BgViewLevel
    {
        
        public function BgViewLevel2() 
        {
            view  = new fla_assets.BgViewLevel2();
            view.x = 385.7;
            view.y = 232.6;
            addChild(view);
        }
        
    }

}