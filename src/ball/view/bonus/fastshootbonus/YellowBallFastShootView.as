package ball.view.bonus.fastshootbonus 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.YellowBallFastShootView;
	 
	 
    public class YellowBallFastShootView extends BallView
    {
        
        public function YellowBallFastShootView() 
        {
				view = new fla_assets.YellowBallFastShootView();
				addChild(view);
        }
        
    }

}