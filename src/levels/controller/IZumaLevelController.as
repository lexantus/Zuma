package levels.controller 
{
    
    /**
     * ...
     * @author Rozhin Alexey
     */
    public interface IZumaLevelController 
    {
        function Start():void;
		function Restart():void;
        function Update():void;
        function WinLevel():void;
        function LoseLevel():void;
    }
    
}