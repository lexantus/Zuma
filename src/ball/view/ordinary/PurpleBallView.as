package ball.view.ordinary 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.PinkBallView;
	 
	 
    public class PurpleBallView extends BallView
    {
        
        public function PurpleBallView() 
        {
				view = new fla_assets.PinkBallView();
				addChild(view);
        }
        
    }

}