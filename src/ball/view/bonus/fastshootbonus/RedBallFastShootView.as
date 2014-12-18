package ball.view.bonus.fastshootbonus 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.RedBallFastShootView;
	 
	 
    public class RedBallFastShootView extends BallView
    {
        
        public function RedBallFastShootView() 
        {
				view = new fla_assets.RedBallFastShootView();
				addChild(view);
        }
        
    }

}