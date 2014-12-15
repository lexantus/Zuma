package path.view 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import flash.display.MovieClip;
    import fla_assets.PathView1;
	
    
    public class PathView1 extends PathView
    {
        
        public function PathView1() 
        {
            view  = new fla_assets.PathView1();
            view.x = 345.85;
            view.y = 236.2;
            addChild(view);
        }
        
    }

}