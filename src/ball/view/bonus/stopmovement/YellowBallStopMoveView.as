package ball.view.bonus.stopmovement
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.YellowBallStopMoveView;
	 
	 
    public class YellowBallStopMoveView extends BallView
    {
        
        public function YellowBallStopMoveView() 
        {
				view = new fla_assets.BlueBallStopMoveView();
				addChild(view);
        }
        
    }

}