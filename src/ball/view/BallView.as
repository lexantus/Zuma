package ball.view {
	import ball.model.BallDescription;
    import caurina.transitions.Tweener;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
     * ...
     * @author Rozhin Alexey
     */
    public class BallView extends Sprite
    {
		public var view:MovieClip;
		public var desc:BallDescription;
        
        public function AnimateDie(finishCallback:Function):void
        {
            if (view)
            {
                Tweener.addTween(view, { alpha:0, time:1, onComplete: function():void
                {
                      finishCallback();
                }} );
            }
        }
            
    }

}