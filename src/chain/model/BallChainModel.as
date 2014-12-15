package chain.model
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import ball.model.colors.interfaces.IBallColor;
    import ball.model.colors.*;
    import bonus.interfaces.IBallBonus;
    import bonus.*;
	import chain.model.interfaces.IBallChainModel;
    
    import ball.model.BallDescription;
    
    public class BallChainModel implements IBallChainModel
    {
        public const COLORS:Vector.<IBallColor> = new <IBallColor>[new RedBallColor(), 
                                                                   new GreenBallColor(),
                                                                   new BlueBallColor(),
                                                                   new YellowBallColor(),
                                                                   new PurpleBallColor(),
                                                                   new BrownBallColor()];
                                                                  
                                     
        public const BONUS:Vector.<IBallBonus> = new <IBallBonus>[new PlusOneBonus(), 
                                                                  new StopMovementBonus(),
                                                                  new FastShootingBonus()];
        
        public const BONUS_PROBABILITY:Number = 0.05;
        
        public var chain:Vector.<BallDescription>;
        
        public function BallChainModel():void
        {
            chain = new Vector.<BallDescription>;
        }

        public function GenerateBallDescription():BallDescription
        {
                var rnd:Number = Math.random() * (COLORS.length - 1);
                var rndIndex:int = Math.round(rnd);
                
                if (chain.length >= 2)
                {
                    if (chain[chain.length - 2].color == chain[chain.length - 1].color)
                    {
                            while (COLORS[rndIndex] == chain[chain.length - 1].color)
                            {
                                    rnd = Math.random() * (COLORS.length - 1);
                                    rndIndex = Math.round(rnd);
                            }
                    }
                }
                
                var rndBonus:Number = Math.random();
                var rndBonusIndex:int = -1;
                
                if (rndBonus <= BONUS_PROBABILITY)
                {
                    rndBonusIndex = Math.round(Math.random() * (BONUS.length - 1));
                }    
                
                var ballDesc:BallDescription = new BallDescription();
                    ballDesc.color = COLORS[rndIndex];
                
                if (rndBonusIndex != -1)
                {
                    ballDesc.bonus = BONUS[rndBonusIndex];
                    
                }else
                {
                    ballDesc.bonus = null;
                }
				
				chain.push(ballDesc);
                
                return ballDesc;
        } 
        
    }

}