package path.view 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import flash.display.MovieClip;
    import fla_assets.PathView5;
	
    
    public class PathView5 extends PathView
    {
        
        public function PathView5() 
        {
            view  = new fla_assets.PathView5();
            view.x = 286.15;
            view.y = 446.85;
            addChild(view);
        }
        
    }

}