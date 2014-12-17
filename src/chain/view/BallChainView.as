package chain.view 
{
	import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.geom.Point;
	
	/**
     * ...
     * @author Rozhin Alexey
     */
    public class BallChainView extends Sprite 
    {
        public var ballViews:Vector.<MovieClip>;
        
        public function BallChainView() 
        {
            super();
			ballViews = new Vector.<MovieClip>;
        }
        
        public function addBall(viewClass:Class, position:Point):void
        {
            ballViews.push(new viewClass());
            ballViews[ballViews.length - 1].x = position.x;
            ballViews[ballViews.length - 1].y = position.y;
            addChild(ballViews[ballViews.length - 1]);
        }
        
    }

}