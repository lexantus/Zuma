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
        public var speed:Number;
        
        public var pathModel:IPathModel;
        public var ballChainModel:IBallChainModel;
        
        public function ZumaLevelModel()
        {
                ballChainModel = new BallChainModel();
        }
        
    }

}