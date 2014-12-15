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
        private var _currentProjectileContainerMc:MovieClip;
        private var _nextProjectileContainerMc:MovieClip;
        
        public function GunView() 
        {
            view = new fla_assets.GunView();
            _currentProjectileContainerMc = view["currentProj"];
            _nextProjectileContainerMc = view["nextProj"];
            
            addChild(view);
        }
        
        public function get currentProjectileContainerMc():MovieClip 
        {
            _currentProjectileContainerMc = view["currentProj"];
            
            return _currentProjectileContainerMc;
        }
        
        public function get nextProjectileContainerMc():MovieClip 
        {
            _nextProjectileContainerMc = view["nextProj"];
            
            return _nextProjectileContainerMc;
        }
        
        
    }

}