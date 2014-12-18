package ball.view.bonus.stopmovement
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.GreenBallStopMoveView;
	 
	 
    public class GreenBallStopMoveView extends BallView
    {
        
        public function GreenBallStopMoveView() 
        {
				view = new fla_assets.GreenBallStopMoveView();
				addChild(view);
        }
        
    }

}