package ball.view.bonus.fastshootbonus 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.BrownBallFastShootView;
	 
	 
    public class BrownBallFastShootView extends BallView
    {
        
        public function BrownBallFastShootView() 
        {
				view = new fla_assets.BrownBallFastShootView();
				addChild(view);
        }
        
    }

}