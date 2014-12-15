package 
{
    /**
     * ...
     * @author Rozhin Alexey
     */
    import flash.events.Event;
    
    // interfaces
    import gun.controller.interfaces.IGunController;
    import levels.controller.interfaces.IZumaLevelController;
    
    // controllers
    import gun.controller.*;
    import levels.controller.*;
	
    
    public class ZumaController 
    {
        private var _model:ZumaModel;
        
        private var _gunController:IGunController;
        private var _levelController:IZumaLevelController;
        
        public function ZumaController() 
        {
            _model = new ZumaModel;
            Init();
        }
        
        public function Init():void
        {
            try 
            {
                InitLevel();
                
            }catch (e:Error) 
            {
                trace(e.message);
            }
            
            InitGun();
        }
        
        public function Start():void
        {
            addEventListener(Event.ENTER_FRAME, Update);
        }
        
        public function Update():void
        {
            
        }
        
        public function Win():void
        {
            
        }
        
        public function Lose():void
        {
            
        }
        
        private function InitLevel():void
        {
            switch(_model.currentLevel)
            {
                    case 1:
                        _levelController = new ZumaLevelController1();
                        break;
                    case 2:
                        _levelController = new ZumaLevelController2();
                        break;
                    case 3:
                        _levelController = new ZumaLevelController3();
                        break;
                    case 4:
                        _levelController = new ZumaLevelController4();
                        break;
                    default:
                        throw new Error("ZumaError: Level wrong number");
            }
        }
        
        private function InitGun():void
        {
                _gunController = new GunController();
        }
        
    }

}