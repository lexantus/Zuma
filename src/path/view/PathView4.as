package path.view 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import flash.display.MovieClip;
    import fla_assets.PathView4;
	
    
    public class PathView4 extends PathView
    {
        
        public function PathView4() 
        {
            view  = new fla_assets.PathView4();
            view.x = 436.7;
            view.y = 245.6;
            addChild(view);
        }
        
    }

}