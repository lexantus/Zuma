package ball.view.bonus.stopmovement
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.BrownBallStopMoveView;
	 
	 
    public class BrownBallStopMoveView extends BallView
    {
        
        public function BrownBallStopMoveView() 
        {
				view = new fla_assets.BrownBallStopMoveView();
				addChild(view);
        }
        
    }

}