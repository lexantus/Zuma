package chain.view 
{
	import ball.model.BallDescription;
    import ball.view.BallView;
	import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.geom.Point;
	
	/**
     * ...
     * @author Rozhin Alexey
     */
    public class BallChainView extends Sprite 
    {
        public var ballViews:Vector.<BallView>;
        
        public function BallChainView() 
        {
            super();
			ballViews = new Vector.<BallView>;
        }
        
        public function addBall(viewClass:Class, position:Point, description:BallDescription):void
        {
            ballViews.push(new viewClass());
            ballViews[ballViews.length - 1].view.x = position.x;
            ballViews[ballViews.length - 1].view.y = position.y;
			ballViews[ballViews.length - 1].desc = description;
            addChild(ballViews[ballViews.length - 1]);
        }
        
    }

}