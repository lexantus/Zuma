package levels.view 
{
    /**
     * ...
     * @author Rozhin Alexey
     */
   import flash.display.MovieClip;
   import levels.view.bg.BgViewLevel3;
   import path.view.PathView3;
    
    public class ZumaLevelView3 extends ZumaLevelView
    {
        public function ZumaLevelView3() 
        {
            view  = new MovieClip;
            addChild(view);
            
            pathBgView = new BgViewLevel3;
            view.addChild(pathBgView);
            
            pathView = new PathView3;
            view.addChild(pathView);
        }
    }

}