package ui.view 
{
    import flash.display.MovieClip;
    import fla_assets.ui.BuySuperBallView;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.text.TextField;
	/**
     * ...
     * @author Rozhin Alexey
     */
    public class BuySuperballView 
    {
        public var view:MovieClip;
        
        public static const BUY_STATE_FRAME:int = 1;
        public static const SHOOT_STATE_FRAME:int = 2;
        private var _currentState:int;
        
        public var btnBuy:SimpleButton;
        public var btnFire:SimpleButton;
        public var tfProjectilesNum:TextField;
        
        public var callbackBuyFunc:Function;
        public var callbackFireFunc:Function;
        
        private var _projectilesNum:int = 0;
        
        public function BuySuperballView(position:Point, aCallbackBuyFunc:Function, aCallbackFireFunc:Function) 
        {
            callbackBuyFunc = aCallbackBuyFunc;
            callbackFireFunc = aCallbackFireFunc;
            
            view = new fla_assets.ui.BuySuperBallView();
            view.x = position.x;
            view.y = position.y;
            
            SetState(BUY_STATE_FRAME);
        }
        
        private function OnFire(e:MouseEvent):void 
        {
            _projectilesNum --;
            callbackFireFunc();
            
            if (_projectilesNum == 0)
            {
                SetState(BUY_STATE_FRAME);
            }
        }
        
        private function OnBuy(e:MouseEvent):void 
        {
            _projectilesNum ++;
            callbackBuyFunc();
            SetState(SHOOT_STATE_FRAME);
        }
        
        public function SetState(frameNum:int):void
        {
            if (frameNum == BUY_STATE_FRAME)
            {
                view.gotoAndStop(frameNum);
                view["btn_buy"].addEventListener(MouseEvent.CLICK, OnBuy);
                _currentState = frameNum;
              
            }else if (frameNum == SHOOT_STATE_FRAME)
            {
                view.gotoAndStop(frameNum); 
                view["btn_fire"].addEventListener(MouseEvent.CLICK, OnFire);
                view["txt_num"].text = _projectilesNum.toString();
                _currentState = frameNum;
            
            }else
            {
                throw new Error("ZumaError: No such state for superball btn.");
            }
        }
        
        public function get currentState():int 
        {
            return _currentState;
        }
    }

}