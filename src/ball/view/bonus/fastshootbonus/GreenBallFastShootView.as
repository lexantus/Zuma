package ball.view.bonus.fastshootbonus 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.GreenBallFastShootView;
	 
	 
    public class GreenBallFastShootView extends BallView
    {
        
        public function GreenBallFastShootView() 
        {
				view = new fla_assets.GreenBallFastShootView();
				addChild(view);
        }
        
    }

}