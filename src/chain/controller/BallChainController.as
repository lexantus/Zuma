package chain.controller
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import chain.model.BallChainModel;
    import ball.model.colors.interfaces.IBallColor;
    import ball.model.BallDescription;
    
     
    public class BallChainController
    {
        private var _model:BallChainModel = new BallChainModel();
        
        public function BallChainController() 
        {
            
        }
		
		public function GenerateStartChain():void
		{
			for (var j:int = 0; j < 12; j++)
			{
				GenerateBall();
			}
		}
        
        public function GenerateBall():void
        {
            _model.GenerateBallDescription();
        }
        
    }

}