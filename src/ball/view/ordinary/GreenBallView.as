package ball.view.ordinary 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.GreenBallView;
	 
	
    public class GreenBallView extends BallView
    {
        
        public function GreenBallView() 
        {
				view = new fla_assets.GreenBallView();
				addChild(view);
		}
        
    }

}