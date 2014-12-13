package ball.view.ordinary 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.BrownBallView;
	 
	 
    public class BrownBallView extends BallView
    {
        
        public function BrownBallView() 
        {
				view = new fla_assets.BrownBallView();
				addChild(view);
        }
        
    }

}