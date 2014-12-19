package ui.controller 
{

    import flash.display.Sprite;
    import flash.geom.Point;
    import ui.view.BuySuperballView;
	/**
     * ...
     * @author Rozhin Alexey
     */
    public class UIZumaController 
    {
        private var _scene:Sprite;
        private var _buySuperballView:BuySuperballView;
        
        public function UIZumaController(aScene:Sprite, aCallbackBuyFunc:Function, aCallbackFireFunc:Function) 
        {
            _scene = aScene;
            
            _buySuperballView = new BuySuperballView(new Point(23.2, 33.65), aCallbackBuyFunc, aCallbackFireFunc);
            _scene.addChild(_buySuperballView.view);
        }
        
        public function ForbidAddNewSuperball():void
        {
            _buySuperballView.isForbidAddNewSuperBall = true;
        }
        
        public function AllowAddNewSuperball():void
        {
            _buySuperballView.isForbidAddNewSuperBall = false;
        }
        
        public function get buySuperballView():BuySuperballView 
        {
            return _buySuperballView;
        }
        
    }

}