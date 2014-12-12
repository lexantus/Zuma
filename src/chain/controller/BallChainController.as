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
        private var _model:BallChainModel;
        
        public function BallChainController() 
        {
            for (var j:int = 0; j < 12; j++)
            {
                GenerateBall();
            }
            
            trace(_model.chain);
        }
        
        public function GenerateBall():void
        {
            _model.GenerateBallDescription();
        }
        
    }

}