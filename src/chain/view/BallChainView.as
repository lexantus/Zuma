package chain.view 
{
	import flash.display.Sprite;
    import flash.display.MovieClip;
	
	/**
     * ...
     * @author Rozhin Alexey
     */
    public class BallChainView extends Sprite 
    {
        public var _ballViews:Vector.<MovieClip>;
        
        private const BALL_RADIUS:Number = 40;
        
        public function BallChainView() 
        {
            super();
			_ballViews = new Vector.<MovieClip>;
        }
        
        public function addBall(viewClass:Class):void
        {
            _ballViews.push(new viewClass());
            addChild(_ballViews[_ballViews.length - 1]);
        }
        
        public function SetBallsXYs():void
        {
            var i:int = 0;
                
            for (i = 0; i < _ballViews.length; i++)
            {
                if (i != 0)
                {
                    _ballViews[i].x = _ballViews[i - 1].x + BALL_RADIUS;
                
                }
                
                 _ballViews[i].y = 100;
            }
        }
        
    }

}