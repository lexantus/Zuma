package levels.view 
{
    /**
     * ...
     * @author Rozhin Alexey
     */
   import flash.display.MovieClip;
   import levels.view.bg.BgViewLevel1;
   import path.view.PathView1;
    
    public class ZumaLevelView1 extends ZumaLevelView
    {
        public function ZumaLevelView1() 
        {
            view  = new MovieClip;
            addChild(view);
            
            pathBgView = new BgViewLevel1;
            view.addChild(pathBgView);
            
            pathView = new PathView1;
            view.addChild(pathView);
        }
    }

}