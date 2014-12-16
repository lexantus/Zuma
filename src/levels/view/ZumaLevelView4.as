package levels.view 
{
    /**
     * ...
     * @author Rozhin Alexey
     */
   import flash.display.MovieClip;
   import levels.view.bg.BgViewLevel4;
   import path.view.PathView4;
    
    public class ZumaLevelView4 extends ZumaLevelView
    {
        public function ZumaLevelView4() 
        {
            view  = new MovieClip;
            addChild(view);
            
            pathBgView = new BgViewLevel4;
            view.addChild(pathBgView);
            
            pathView = new PathView4;
            view.addChild(pathView);
        }
    }

}