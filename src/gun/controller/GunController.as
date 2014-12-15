
package gun.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import ball.model.colors.interfaces.IBallColor;
    import ball.utils.BallUtils;
    import caurina.transitions.Tweener;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import gun.model.GunModel;
    import gun.view.GunView;
    import gun.controller.interfaces.IGunController;
    import projectiles.controller.ProjectilesController;
    
    
    public class GunController implements IGunController 
    {
        private var _model:GunModel;
        private var _view:GunView;
        
        private var _projectilesController:ProjectilesController;
        private var _currentProjectile:MovieClip;
        private var _nextProjectile:MovieClip;
        
        public function GunController(sceneView:Sprite, projectilesController:ProjectilesController) 
        {
            _model = new GunModel;
            _view = new GunView;
            _view.x = 402;
            _view.y = 443.5;
            
            _projectilesController = projectilesController;
            
            sceneView.addChild(_view);
            sceneView.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
            sceneView.addEventListener(MouseEvent.CLICK, OnClick);
            
            SetProjectiles();
        }
        
        private function SetProjectiles():void
        {
            var projectilesColors:Vector.<IBallColor>;
            
            if (!_nextProjectile)
            {
                projectilesColors= _projectilesController.ballChainController.GetRandomBallColorFromChain(2);
                _currentProjectile = new (BallUtils.GetBallViewClass(projectilesColors[0]));
                _nextProjectile = new (BallUtils.GetBallViewClass(projectilesColors[1]));
                
            }else
            {
                _view.nextProjectileContainerMc.removeChild(_nextProjectile);
                
                projectilesColors= _projectilesController.ballChainController.GetRandomBallColorFromChain(1);
                _currentProjectile = _nextProjectile;
                _nextProjectile = new (BallUtils.GetBallViewClass(projectilesColors[0]));
            }
            
            _view.currentProjectileContainerMc.addChild(_currentProjectile);
            _view.nextProjectileContainerMc.addChild(_nextProjectile);
            
            _currentProjectile.scaleX = 1/_view.currentProjectileContainerMc.scaleX;
            _currentProjectile.scaleY = 1/_view.currentProjectileContainerMc.scaleY;
            
            _nextProjectile.width = _view.nextProjectileContainerMc.width;
            _nextProjectile.height = _view.nextProjectileContainerMc.height;
            _nextProjectile.scaleX = 0.6 / _view.nextProjectileContainerMc.scaleX;
            _nextProjectile.scaleY = 0.6 / _view.nextProjectileContainerMc.scaleY;
        }
        
        private var bForbid:Boolean = false;
        
        private function OnClick(e:MouseEvent):void 
        {
            if (bForbid) return;
            
            bForbid = true;
            
             var startProjectilePt:Point = _currentProjectile.globalToLocal(new Point(_currentProjectile.x, _currentProjectile.y + 10));
            _currentProjectile.parent.removeChild(_currentProjectile);
                
            _projectilesController.fire(_currentProjectile, startProjectilePt);
            
            Tweener.addTween(_nextProjectile, { x: _nextProjectile.x - 3, 
                                                y: _nextProjectile.y - 14,
                                           scaleX:0.38, 
                                           scaleY:0.38, 
                                             time:0.5,
                                       onComplete:function():void 
                                      {
                                            _nextProjectile.x = _nextProjectile.x + 3;
                                            _nextProjectile.y = _nextProjectile.y + 14;
                                            SetProjectiles();
                                            bForbid = false;
                        
                                      }});
        }
        
        private const LEFT_X_LIMIT:Number = 34;
        private const RIGHT_X_LIMIT:Number = 740;
        
        private function OnMouseMove(e:MouseEvent):void 
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
        
        public function get model():GunModel 
        {
            return _model;
        }
        
        public function set model(value:GunModel):void 
        {
            _model = value;
        }
        
    }

}