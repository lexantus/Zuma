package ball.view.bonus.plusonebonus 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.PurpleBallPlusOneView;
	 
	 
    public class PurpleBallPlusOneView extends BallView
    {
        
        public function PurpleBallPlusOneView() 
        {
				view = new fla_assets.PurpleBallPlusOneView();
				addChild(view);
        }
        
    }

}