package ball.view.bonus.plusonebonus 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.BlueBallPlusOneView;
	 
	 
    public class BlueBallPlusOneView extends BallView
    {
        
        public function BlueBallPlusOneView() 
        {
				view = new fla_assets.BlueBallPlusOneView();
				addChild(view);
        }
        
    }

}