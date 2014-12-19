
package gun.controller 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import ball.model.colors.interfaces.IBallColor;
    import ball.utils.BallUtils;
    import ball.view.BallView;
    import ball.view.bonus.SuperBallView;
    import caurina.transitions.Tweener;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import gun.model.GunModel;
    import gun.view.GunView;
    import gun.controller.interfaces.IGunController;
    import projectiles.controller.ProjectilesController;
    import ui.controller.UIZumaController;
    
    
    public class GunController implements IGunController 
    {
        private var _model:GunModel;
        private var _view:GunView;
        private var _scene:Sprite;
        
        private var _projectilesController:ProjectilesController;
        private var _uiController:UIZumaController;
        
        private var _currentProjectile:BallView;
        private var _nextProjectile:BallView;
        private var _superballProjectile:BallView;
        
        
        public function GunController(sceneView:Sprite, projectilesController:ProjectilesController, anUiController:UIZumaController) 
        {
            _model = new GunModel;
            _view = new GunView;
            _view.x = 402;
            _view.y = 443.5;
            
            _projectilesController = projectilesController;
            _uiController = anUiController;
            
            _scene = sceneView;
            
            _scene.addChild(_view);
            _scene.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
            _scene.addEventListener(MouseEvent.CLICK, OnClick);
            
            _superballProjectile = new SuperBallView();
            
            SetProjectiles();
        }
        
        private function SetProjectiles():void
        {
            var projectilesColors:Vector.<IBallColor>;
            
            if (!_nextProjectile)
            {
                projectilesColors = _projectilesController.ballChainController.GetRandomBallColorFromChain(2);
                _currentProjectile = new (BallUtils.GetBallViewClass(projectilesColors[0], null));
                _nextProjectile = new (BallUtils.GetBallViewClass(projectilesColors[1], null));
                
            }else
            {
                _view.nextProjectileContainerMc.removeChild(_nextProjectile);
                
                projectilesColors= _projectilesController.ballChainController.GetRandomBallColorFromChain(1);
                _currentProjectile = _nextProjectile;
                _nextProjectile = new (BallUtils.GetBallViewClass(projectilesColors[0], null));
            }
            
            _view.currentProjectileContainerMc.addChild(_currentProjectile);
            _view.nextProjectileContainerMc.addChild(_nextProjectile);
            
            _currentProjectile.scaleX = 1/_view.currentProjectileContainerMc.scaleX;
            _currentProjectile.scaleY = 1 / _view.currentProjectileContainerMc.scaleY;
            _currentProjectile.x = _currentProjectile.width / 2;
            _currentProjectile.y = _currentProjectile.height / 2;
            
            _nextProjectile.width = _view.nextProjectileContainerMc.width;
            _nextProjectile.height = _view.nextProjectileContainerMc.height;
            _nextProjectile.scaleX = 0.6 / _view.nextProjectileContainerMc.scaleX;
            _nextProjectile.scaleY = 0.6 / _view.nextProjectileContainerMc.scaleY;
            _nextProjectile.x = _nextProjectile.width / 2;
            _nextProjectile.y = _nextProjectile.height / 2;
        }
        
        
        public function SetSuperballProjectile():void
        {
            _view.currentProjectileContainerMc.removeChild(_currentProjectile);
            
            _superballProjectile = new SuperBallView();
            _currentProjectile = _superballProjectile;
            _view.currentProjectileContainerMc.addChild(_currentProjectile);
            
            _currentProjectile.scaleX = 1/_view.currentProjectileContainerMc.scaleX;
            _currentProjectile.scaleY = 1 /_view.currentProjectileContainerMc.scaleY;
            _currentProjectile.x = _currentProjectile.width / 2 - 1.5;
            _currentProjectile.y = _currentProjectile.height / 2 - 2;
            
            _uiController.ForbidAddNewSuperball();
        }
        
        private var bForbid:Boolean = false;
        private var setProjectilesTime:Number = 0.25;
        
        private function OnClick(e:MouseEvent):void 
        {
            if (e.target is SimpleButton)
            {
                return;
            }
            
            if (bForbid) return;
            
            bForbid = true;
            
             var startProjectilePt:Point = _currentProjectile.globalToLocal(new Point(_currentProjectile.x, _currentProjectile.y + 10));
            _currentProjectile.parent.removeChild(_currentProjectile);
                
            _projectilesController.fire(_currentProjectile, startProjectilePt);
            
            Tweener.addTween(_nextProjectile, { x: _nextProjectile.x, 
                                                y: _nextProjectile.y - 10,
                                           scaleX:0.38, 
                                           scaleY:0.38, 
                                             time:setProjectilesTime,
                                       onComplete:function():void 
                                      {
                                            _nextProjectile.x = _nextProjectile.x;
                                            _nextProjectile.y = _nextProjectile.y + 10;
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