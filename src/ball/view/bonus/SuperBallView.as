package ball.view.bonus 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.SuperBallView;
	 
	 
    public class SuperBallView extends BallView
    {
        
        public function SuperBallView() 
        {
				view = new fla_assets.SuperBallView();
				addChild(view);
        }
        
    }

}