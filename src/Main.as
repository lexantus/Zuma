package 
{
    import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
    import flash.geom.Point;
    import spline.CubicSpline;
    
    import assets.Ball;
    import assets.Path2;
	
	/**
	 * ...
	 * @author Rozhin Alexey
	 */
	public class Main extends Sprite 
	{
        private var _ball:Ball;
        
        private var _path:Path2;
        private var pathPts:Vector.<Point>;
        private var splinePts:Vector.<Point>;
        
        private var _spline:CubicSpline;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
            trace("entry point");
            StartGame();
		}
        
        private function StartGame(): void
        {
            _path = new Path2();
            _spline = new CubicSpline;
    
            addChild(_path);
            drawSplinePath();
            addBall();
        }
        
        private function addBall():void
        {
            _ball = new Ball;
            _ball.x = pathPts[0].x;
            _ball.y = pathPts[0].y;
            _path.addChild(_ball);
            
            addEventListener(Event.ENTER_FRAME, onUpdate);
        }
        
        private var j:int = 0;
        
        private function onUpdate(e:Event):void 
        {
            _ball.x = splinePts[j].x;
            _ball.y = splinePts[j].y;
            
            if ((j + 1) > (splinePts.length - 1))
            {
                j = -1;
            }
            
            j++;
        }
        
        private function drawSplinePath():void
        {
                trace("drawSplinePath");
                var i:Number = 1;
                
                pathPts = new Vector.<Point>;
                splinePts = new Vector.<Point>;
                
                var pathPtMc:MovieClip;
                
                while (_path["pt_" + i])
                {
                        pathPtMc = _path["pt_" + i];
                        pathPts.push(new Point(pathPtMc.x, pathPtMc.y));
                        i++;
                }
                
                var smoothX:Number;
                var smoothY:Number;
                
                var delta:Number = 1;
                
                var tempX:Vector.<Number> = new Vector.<Number>;
                var tempY:Vector.<Number> = new Vector.<Number>;
                
                for (i = 0; i < pathPts.length; i++)
                {
                    tempX.push(pathPts[i].x);
                    tempY.push(pathPts[i].y);
                }
                
                _spline.BuildSpline(tempX, tempY, tempX.length);
               
                var x_ToFindY:Number = pathPts[0].x + delta;
                var n:Number = pathPts.length;
                            
                while (x_ToFindY < pathPts[pathPts.length - 1].x)
                {
                        smoothY = _spline.F(x_ToFindY);
                        trace(x_ToFindY + " and " + smoothY);
                        drawPoint(new Point(x_ToFindY, smoothY));
                        x_ToFindY += delta;
                }
        }
        
        private function drawPoint(_pt:Point):void
        {
            _path.graphics.beginFill(0x00ff00, 1);
            _path.graphics.drawCircle(_pt.x, _pt.y, 3);
            _path.graphics.endFill();
            
            splinePts.push(_pt);
        }
	}
	
}