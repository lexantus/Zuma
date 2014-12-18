package ball.view.bonus.fastshootbonus 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.PurpleBallFastShootView;
	 
	 
    public class PurpleBallFastShootView extends BallView
    {
        
        public function PurpleBallFastShootView() 
        {
				view = new fla_assets.PurpleBallFastShootView();
				addChild(view);
        }
        
    }

}