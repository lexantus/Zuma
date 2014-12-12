package ball.model 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
     import ball.model.colors.interfaces.IBallColor;
     import bonus.interfaces.IBallBonus;
     
    
    public class BallDescription 
    {
        private var _bonus:IBallBonus;
        private var _color:IBallColor;
        
        public function get bonus():IBallBonus 
        {
            return _bonus;
        }
        
        public function set bonus(value:IBallBonus):void 
        {
            _bonus = value;
        }
        
        public function get color():IBallColor 
        {
            return _color;
        }
        
        public function set color(value:IBallColor):void 
        {
            _color = value;
        }
    }

}