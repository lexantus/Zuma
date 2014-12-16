package path.view 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import flash.display.MovieClip;
    import fla_assets.PathView3;
	
    
    public class PathView3 extends PathView
    {
        
        public function PathView3() 
        {
            view  = new fla_assets.PathView3();
            view.x = 385.45;
            view.y = 163.95;
            addChild(view);
        }
        
    }

}