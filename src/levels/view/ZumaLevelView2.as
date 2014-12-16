package levels.view 
{
    /**
     * ...
     * @author Rozhin Alexey
     */
   import flash.display.MovieClip;
   import levels.view.bg.BgViewLevel2;
   import path.view.PathView2;
    
    public class ZumaLevelView2 extends ZumaLevelView
    {
        public function ZumaLevelView2() 
        {
            view  = new MovieClip;
            addChild(view);
            
            pathBgView = new BgViewLevel2;
            view.addChild(pathBgView);
            
            pathView = new PathView2;
            view.addChild(pathView);
        }
    }

}