package ball.view.bonus.plusonebonus 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.BrownBallPlusOneView;
	 
	 
    public class BrownBallPlusOneView extends BallView
    {
        
        public function BrownBallPlusOneView() 
        {
				view = new fla_assets.BrownBallPlusOneView();
				addChild(view);
        }
        
    }

}