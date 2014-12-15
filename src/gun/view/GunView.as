package gun.view
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import fla_assets.GunView;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    
    
    public class GunView extends Sprite
    {
        public var view:MovieClip;
        
        public function GunView() 
        {
            view = new fla_assets.GunView();
            addChild(view);
        }
        
    }

}