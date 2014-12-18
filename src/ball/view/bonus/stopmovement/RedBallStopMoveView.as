package ball.view.bonus.stopmovement
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.RedBallStopMoveView;
	 
	 
    public class RedBallStopMoveView extends BallView
    {
        
        public function RedBallStopMoveView() 
        {
				view = new fla_assets.RedBallStopMoveView();
				addChild(view);
        }
        
    }

}