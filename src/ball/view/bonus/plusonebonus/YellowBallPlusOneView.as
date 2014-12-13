package ball.view.bonus.plusonebonus
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.YellowBallPlusOneView;
	 
	 
    public class YellowBallPlusOneView extends BallView
    {
        
        public function YellowBallPlusOneView() 
        {
				view = new fla_assets.YellowBallPlusOneView();
				addChild(view);
        }
        
    }

}