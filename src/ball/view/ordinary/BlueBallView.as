package ball.view.ordinary 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
	import ball.view.BallView;
	import fla_assets.BlueBallView;
	 
	
    public class BlueBallView extends BallView
    {
        
        public function BlueBallView() 
        {
				view = new fla_assets.BlueBallView();
				addChild(view);
        }
        
    }

}