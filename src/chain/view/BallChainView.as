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
        public var ballViews:Vector.<MovieClip>;
        
        private const BALL_DIAMETER:Number = 100;
        
        public function BallChainView() 
        {
            super();
			ballViews = new Vector.<MovieClip>;
        }
        
        public function addBall(viewClass:Class):void
        {
            ballViews.push(new viewClass());
            addChild(ballViews[ballViews.length - 1]);
        }
        
        public function SetBallsXYs():void
        {
            var i:int = 0;
                
            for (i = 0; i < ballViews.length; i++)
            {
                if (i != 0)
                {
                    ballViews[i].x = ballViews[i - 1].x + BALL_DIAMETER;
                
                }
                
                 ballViews[i].y = 120;
            }
        }
        
    }

}