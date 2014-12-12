package bonus
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import bonus.interfaces.IBallBonus;
    
    
    public class FastShootingBonus implements IBallBonus 
    {
        public function getDescription():String
        {
                return '[fastShooting]';
        }
    }

}