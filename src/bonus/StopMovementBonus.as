package bonus 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    import bonus.interfaces.IBallBonus;
    
    public class StopMovementBonus implements IBallBonus  
    {
       
        public function getDescription():String
        {
                return '[stopMovement]';
        }
        
    }

}