package ball.view.bonus.fastshootbonus 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.BlueBallFastShootView;
	 
	 
    public class BlueBallFastShootView extends BallView
    {
        
        public function BlueBallFastShootView() 
        {
				view = new fla_assets.BlueBallFastShootView();
				addChild(view);
        }
        
    }

}