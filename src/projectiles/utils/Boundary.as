package projectiles.utils 
{
	/**
     * ...
     * @author Rozhin Alexey
     */
    public class Boundary 
    {
        public var minX:Number;
        public var maxX:Number;
        public var minY:Number;
        public var maxY:Number;
        
        public function Boundary(aMinX:Number, aMaxX:Number, aMinY:Number, aMaxY:Number) 
        {
            minX = aMinX;
            maxX = aMaxX;
            minY = aMinY;
            maxY = aMaxY;
        }
        
    }

}