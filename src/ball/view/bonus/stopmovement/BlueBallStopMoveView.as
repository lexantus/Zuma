package ball.view.bonus.stopmovement
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.BlueBallStopMoveView;
	 
	 
    public class BlueBallStopMoveView extends BallView
    {
        
        public function BlueBallStopMoveView() 
        {
				view = new fla_assets.BlueBallStopMoveView();
				addChild(view);
        }
        
    }

}