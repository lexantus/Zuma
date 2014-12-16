package path.view 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import flash.display.MovieClip;
    import fla_assets.PathView2;
	
    
    public class PathView2 extends PathView
    {
        
        public function PathView2() 
        {
            view  = new fla_assets.PathView2();
            view.x = 344.05;
            view.y = 238.5;
            addChild(view);
        }
        
    }

}