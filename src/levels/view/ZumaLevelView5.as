package levels.view 
{
    /**
     * ...
     * @author Rozhin Alexey
     */
   import flash.display.MovieClip;
   import levels.view.bg.BgViewLevel5;
   import path.view.PathView5;
    
    public class ZumaLevelView5 extends ZumaLevelView
    {
        public function ZumaLevelView5() 
        {
            view  = new MovieClip;
            addChild(view);
            
            pathBgView = new BgViewLevel5;
            view.addChild(pathBgView);
            
            pathView = new PathView5;
            view.addChild(pathView);
        }
    }

}