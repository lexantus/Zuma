package ball.view.ordinary
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.RedBallView;
	 
	 
    public class RedBallView extends BallView
    {
        
        public function RedBallView() 
        {
				view = new fla_assets.RedBallView();
				addChild(view);
        }
        
    }

}