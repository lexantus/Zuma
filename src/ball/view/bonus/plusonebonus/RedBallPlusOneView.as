package ball.view.bonus.plusonebonus
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.RedBallPlusOneView;
	 
	 
    public class RedBallPlusOneView extends BallView
    {
        
        public function RedBallPlusOneView() 
        {
				view = new fla_assets.RedBallPlusOneView();
				addChild(view);
        }
        
    }

}