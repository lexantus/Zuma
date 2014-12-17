package path.model 
{
    import flash.display.MovieClip;
    import flash.geom.Point;
	/**
     * ...
     * @author Rozhin Alexey
     */
    public class PathModelGenerator 
    {
        private var pathPts:Vector.<Point>;
        
		private var SPEED:Number = 3;
        private var segmentsUniformMovement:Vector.<Point>;
        
        private var _path:MovieClip;
        
        public function PathModelGenerator(aPathMc:MovieClip) 
        {
            _path = aPathMc;
            GenerateUniformMovementVectors();
        }
        
        private function GenerateUniformMovementVectors():void
        {
            pathPts = new Vector.<Point>;
                
            var pathPtMc:MovieClip;
				
            var i:int = 1;
                
			while (_path["pt_" + i])
			{
                pathPtMc = _path["pt_" + i];
                pathPts.push(new Point(pathPtMc.x, pathPtMc.y));
                i++;
			}

            segmentsUniformMovement = SubdividePath(pathPts);
            
            for (i = 0; i < segmentsUniformMovement.length; i++)
            {
                    trace("new Point(" + segmentsUniformMovement[i].x + ", " + segmentsUniformMovement[i].y + "),");
            }
        }
        
        private function SubdividePath(path:Vector.<Point>):Vector.<Point>
        {
            var subdividedPath:Vector.<Point> = new Vector.<Point>;
            
            var i:int;
            var j:int;
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
				resultNormalizedVectors.push(resultVector.clone()); // потом нормализуем, а сейчас просто копируем
				resultVectorsLen.push(resultVector.length);
			}
            
            for (i = 0; i < resultNormalizedVectors.length; i++)
            {
                    resultNormalizedVectors[i].normalize(SPEED); 
            }
            
            var normalizedVectorLength:Number = resultNormalizedVectors[0].length;
            var numNormVectorsInSegment:int;

            var multipliedVector:Point;
            
            for (i = 0; i < resultNormalizedVectors.length; i++)
            {
                    if (i == 0)
                    {
                        numNormVectorsInSegment = resultVectorsLen[i] / normalizedVectorLength; 
                        
                        multipliedVector = new Point(0, 0);
                        
                        for (j = 0; j < numNormVectorsInSegment; j++)
                        {
                            multipliedVector = multipliedVector.add(resultNormalizedVectors[i]);
                        }
                    }
                    else
                    {
                        numNormVectorsInSegment = resultVectorsLen[i] / normalizedVectorLength;
                        
                        multipliedVector = new Point(0, 0);
                        
                        for (j = 0; j < numNormVectorsInSegment; j++)
                        {
                            multipliedVector = multipliedVector.add(resultNormalizedVectors[i]);
                        }
                    }
                    
                    for (j = 0; j < numNormVectorsInSegment; j++)
                    {
                        var segment:Point = new Point;
                           
                            segment = resultNormalizedVectors[i];
                            subdividedPath.push(segment);
                    }
            }
            
            return subdividedPath;
        }
        
    }

}