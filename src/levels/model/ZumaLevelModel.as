package levels.model 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import chain.model.interfaces.IBallChainModel;
    import levels.model.interfaces.IZumaLevelModel;
    import path.model.interfaces.IPathModel;
    
    import chain.model.BallChainModel;
    
    public class ZumaLevelModel implements IZumaLevelModel
    {
        public var pathModel:IPathModel;
		private var _isLose:Boolean;
		private var _isWin:Boolean;
		private var _isLoseAndFinishHideBallAnimations:Boolean;
        
        public function ZumaLevelModel()
        {
        }
		
		public function get isLose():Boolean 
		{
			return _isLose;
		}
		
		public function set isLose(value:Boolean):void 
		{
			_isLose = value;
		}
		
		public function get isLoseAndFinishHideBallAnimations():Boolean 
		{
			return _isLoseAndFinishHideBallAnimations;
		}
		
		public function set isLoseAndFinishHideBallAnimations(value:Boolean):void 
		{
			_isLoseAndFinishHideBallAnimations = value;
		}
		
		public function get isWin():Boolean 
		{
			return _isWin;
		}
		
		public function set isWin(value:Boolean):void 
		{
			_isWin = value;
		}
        
    }

}