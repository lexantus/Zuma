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
        
        private var _spline:CubicSpline;
        
        private var _path:Path2;
        private var pathPts:Vector.<Point>;
        private var splinePts:Vector.<Point>;
        
		
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
            DrawSplinePath();
            AddBall();
        }
        
        private function AddBall():void
        {
            _ball = new Ball;
            _ball.x = pathPts[0].x;
            _ball.y = pathPts[0].y;
            _path.addChild(_ball);
            
            addEventListener(Event.ENTER_FRAME, OnUpdate);
        }
        
        private function DrawSplinePath():void
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
                
                var delta:Number = 3;
                
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
                        DrawPoint(new Point(x_ToFindY, smoothY));
                        x_ToFindY += delta;
                }
                
                SubdividePath(splinePts);
        }
        
        private function DrawPoint(_pt:Point):void
        {
            _path.graphics.beginFill(0x00ff00, 1);
            _path.graphics.drawCircle(_pt.x, _pt.y, 3);
            _path.graphics.endFill();
            
            splinePts.push(_pt);
        }
        
        private function OnUpdate(e:Event):void
        {
            
        }
        
        private function SubdividePath(path:Vector.<Point>):Vector.<Point>
        {
            var subdividedPath:Vector.<Point> = new Vector.<Point>;
            
            var i:int;
            var pt:Point;
            var priv_pt:Point;
            var resultVector:Point;
            var resultVectors:Vector.<Point> = new Vector.<Point>;
            var resultNormalizedVectors:Vector.<Point> = new Vector.<Point>;
            var stepVectorLength:Number;
            var resultVectorsLen:Vector.<Number> = new Vector.<Number>
            
            for (i = 1; i < path.length; i++)
            {
                priv_pt = path[i - 1];
                pt = path[i];
                resultVector =  pt.subtract(priv_pt);
                resultVectors.push(resultVector);
                resultNormalizedVectors.push(resultVector); // потом нормализуем, а сейчас просто копируем
                resultVectorsLen.push(resultVector.length);
            }
            
            stepVectorLength = resultVectorsLen[0];
            
            // find min segment length
            for (i = 0; i < resultVectorsLen.length; i++)
            {
                    if (stepVectorLength > resultVectorsLen[i])
                    {
                            stepVectorLength = resultVectorsLen[i];
                    }
            }
            
            for (i = 0; i < path.length - 1; i++)
            {
                    resultNormalizedVectors[i].normalize(stepVectorLength); 
            }
            
            var normalizedVectorLength:Number = resultNormalizedVectors[0].length;
            var numNormVectorsInSegment:int;
            
            var residualVector:Point;
            var residualVectorLen:Number;
            
            var multipliedVector:Point;
            
            var j:int;
            
            for (i = 0; i < path.length - 1; i++)
            {
                    trace(i + "++++++++++++++++++++++++++++++++++");
                    if (i == 0)
                    {
                        numNormVectorsInSegment = resultVectorsLen[i] / normalizedVectorLength; 
                        
                        multipliedVector = new Point(0, 0);
                        
                        for (j = 0; j < numNormVectorsInSegment; j++)
                        {
                            multipliedVector = multipliedVector.add(resultNormalizedVectors[i]);
                            
                        }
                        
                        residualVector = resultVectors[i].subtract(multipliedVector);
                    }
                    else
                    {
                        numNormVectorsInSegment = (resultVectorsLen[i] - residualVectorLen) / normalizedVectorLength;
                        
                        multipliedVector = new Point(0, 0);
                        
                        for (j = 0; j < numNormVectorsInSegment; j++)
                        {
                            multipliedVector = multipliedVector.add(resultNormalizedVectors[i]);
                        }
                        
                        residualVector = resultVectors[i].subtract(multipliedVector).subtract(residualVector);                      
                    }
                    
                    residualVectorLen = residualVector.length;
                    trace(resultVectorsLen[i]);
                    trace(normalizedVectorLength);
                    trace(numNormVectorsInSegment);
                    trace(residualVector);
                    trace(residualVectorLen);
            }
            
            
            return null;
        }
	}
	
}