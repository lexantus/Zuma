package ball.view.bonus.plusonebonus
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.GreenBallPlusOneView;
	 
	 
    public class GreenBallPlusOneView extends BallView
    {
        
        public function GreenBallPlusOneView() 
        {
				view = new fla_assets.GreenBallPlusOneView();
				addChild(view);
        }
        
    }

}