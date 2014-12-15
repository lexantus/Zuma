
package gun.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import gun.model.GunModel;
    import gun.view.GunView;
    import gun.controller.interfaces.IGunController;
    
    
    public class GunController implements IGunController 
    {
        private var _model:GunModel;
        private var _view:GunView;
        
        public function GunController(sceneView:Sprite) 
        {
            _model = new GunModel;
            _view = new GunView;
            _view.x = 402;
            _view.y = 443.5;
            
            sceneView.addChild(_view);
            sceneView.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        }
        
        private const LEFT_X_LIMIT:Number = 34;
        private const RIGHT_X_LIMIT:Number = 740;
        
        private function onMouseMove(e:MouseEvent):void 
        {
            if (LEFT_X_LIMIT > e.stageX)
            {
                    _view.x = LEFT_X_LIMIT;
                    return;
            }
            
            if (RIGHT_X_LIMIT < e.stageX)
            {
                    _view.x = RIGHT_X_LIMIT;
                    return;
            }
             
            _view.x = e.stageX;
        }
        
    }

}