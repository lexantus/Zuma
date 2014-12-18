package ball.view.bonus.stopmovement
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.PurpleBallStopMoveView;
	 
	 
    public class PurpleBallStopMoveView extends BallView
    {
        
        public function PurpleBallStopMoveView() 
        {
				view = new fla_assets.PurpleBallStopMoveView();
				addChild(view);
        }
        
    }

}