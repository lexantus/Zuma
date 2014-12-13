package ball.view.ordinary 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.YellowBallView;
	 
	 
    public class YellowBallView extends BallView
    {
        
        public function YellowBallView() 
        {
				view = new fla_assets.YellowBallView();
				addChild(view);
        }
        
    }

}