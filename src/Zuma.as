package 
{
    /**
     * ...
     * @author Rozhin Alexey
     */
    
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;
    import levels.controller.ZumaLevelController;
    import levels.controller.*;
    
    import fla_assets.Background;
	import ball.view.ordinary.RedBallView;
    import chain.controller.BallChainController;
    import gun.controller.GunController;
    import path.model.Segment;
    import path.utils.spline.*;
    import projectiles.controller.ProjectilesController;
    
    import path.view.PathView;
    import path.view.*;
    
    import assets.Ball;
    import assets.*;
	
	public class Zuma extends Sprite 
	{
        private var _ball:Ball;
        
        private var _spline:CubicSpline;
        
        private var _path:MovieClip;
        private var pathPts:Vector.<Point>;
        private var splinePts:Vector.<Point>;
        
        private var segmentsUniformMovement:Vector.<Segment>;
        private var delta:Number = 20;
        private var SPEED:Number = 4;
        private var missUpdate:int = 2;
        
        private var _bg:MovieClip;
 
        private var _levelController:ZumaLevelController;
        private var _ballChainController:BallChainController;
        private var _gunController:GunController;
        private var _projectilesController:ProjectilesController;
		
		public function Zuma():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
            //StartGame();
            _bg = new Background();
            _bg.x = 293.9;
            _bg.y = 247;
            addChild(_bg);
            
            _levelController = new ZumaLevelController5(this);
            
            _ballChainController = new BallChainController(this);
            _ballChainController.GenerateStartChain(10);
            
            _projectilesController = new ProjectilesController(this, _ballChainController);
            
            _gunController = new GunController(this, _projectilesController);
            
            this.addEventListener(Event.ENTER_FRAME, OnUpdate1);
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
            
            addEventListener(Event.ENTER_FRAME, OnUpdate1);
        }
        
        private function OnUpdate1(e:Event):void 
        {
            _projectilesController.Update();
        }
        
        private function DrawSplinePath():void
        {
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
                
                
                var tempX:Vector.<Number> = new Vector.<Number>;
                var tempY:Vector.<Number> = new Vector.<Number>;
                
                for (i = 0; i < pathPts.length; i++)
                {
                    tempX.push(pathPts[i].x);
                    tempY.push(pathPts[i].y);
                }
                
                _spline.BuildSpline(tempX, tempY, tempX.length);
               
                // left limit
                DrawPoint(pathPts[0]);
                
                var x_ToFindY:Number = pathPts[0].x + delta;
                            
                while (x_ToFindY < pathPts[pathPts.length - 1].x)
                {
                        smoothY = _spline.F(x_ToFindY);
                        DrawPoint(new Point(x_ToFindY, smoothY));
                        x_ToFindY += delta;
                }
                
                // right limit
                DrawPoint(pathPts[pathPts.length - 1]);
                
                
                segmentsUniformMovement = SubdividePath(splinePts);
        }
        
        private function DrawPoint(_pt:Point):void
        {
            _path.graphics.beginFill(0x00ff00, 1);
            _path.graphics.drawCircle(_pt.x, _pt.y, 3);
            _path.graphics.endFill();
            
            splinePts.push(_pt);
        }
        
        private var currentSegmentIndex:int = 0;
        private var missUpdateCount:int = 0;
        
        private function OnUpdate(e:Event):void
        {
            missUpdateCount ++;
            
            if (missUpdateCount < missUpdate)
            {
                    return;
            }else 
            {
                missUpdateCount = 0;
            }
            
            if (segmentsUniformMovement)
            {
                if (currentSegmentIndex == segmentsUniformMovement.length) 
                {
                    trace("num segments = " + currentSegmentIndex);
                    currentSegmentIndex = 0;
                    _ball.x = pathPts[0].x;
                    _ball.y = pathPts[0].y;
                }
                
                if (!segmentsUniformMovement[currentSegmentIndex].isResidual)
                {
                    _ball.x += segmentsUniformMovement[currentSegmentIndex].speedVector.x;
                    _ball.y += segmentsUniformMovement[currentSegmentIndex].speedVector.y;
                    currentSegmentIndex ++;
                
                }else {
                    
                    _ball.x += segmentsUniformMovement[currentSegmentIndex].speedVector.x;
                    _ball.y += segmentsUniformMovement[currentSegmentIndex].speedVector.y;
                    
                    if ((currentSegmentIndex + 1) == segmentsUniformMovement.length)
                    {
                       currentSegmentIndex = 0;
                       _ball.x = pathPts[0].x;
                       _ball.y = pathPts[0].y;
                       
                    }else
                    {
                        currentSegmentIndex ++;
                    }
                    
                    _ball.x += segmentsUniformMovement[currentSegmentIndex].speedVector.x;
                    _ball.y += segmentsUniformMovement[currentSegmentIndex].speedVector.y;
                    currentSegmentIndex ++;
                }
            }
        }
        
        private function SubdividePath(path:Vector.<Point>):Vector.<Segment>
        {
            var subdividedPath:Vector.<Segment> = new Vector.<Segment>;
            
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
                //resultVector.x = Math.ceil(resultVector.x);
                //resultVector.y = Math.ceil(resultVector.y);
                resultVectors.push(resultVector);
                resultNormalizedVectors.push(resultVector.clone()); // потом нормализуем, а сейчас просто копируем
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
                    resultNormalizedVectors[i].normalize(SPEED); 
            }
            
            var normalizedVectorLength:Number = resultNormalizedVectors[0].length;
            var numNormVectorsInSegment:int;
            
            var residualVector:Point;
            var residualVectorLen:Number;
            
            var multipliedVector:Point;
            
            var j:int;
            
            for (i = 0; i < path.length - 1; i++)
            {
                    trace(i + "===================================================");
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
                        //numNormVectorsInSegment = (resultVectorsLen[i] - residualVectorLen) / normalizedVectorLength;
                        numNormVectorsInSegment = resultVectorsLen[i] / normalizedVectorLength;
                        
                        multipliedVector = new Point(0, 0);
                        
                        for (j = 0; j < numNormVectorsInSegment; j++)
                        {
                            multipliedVector = multipliedVector.add(resultNormalizedVectors[i]);
                        }
                        
                        //residualVector = resultVectors[i].subtract(multipliedVector).subtract(residualVector);
                        residualVector = resultVectors[i].subtract(multipliedVector);
                    }
                    
                    residualVectorLen = residualVector.length;
                    trace("resultVector[" + i + "] = " + resultVectors[i]);
                    trace("resultNormalizedVectors[" + i + "] = " + resultNormalizedVectors[i]);
                    trace("resultVectorsLen[" + i + "] = " + resultVectorsLen[i]);
                    trace("normalizedVectorLength = " + normalizedVectorLength);
                    trace("numNormVectorsInSegment = " + numNormVectorsInSegment);
                    trace("residualVector = " + residualVector);
                    trace("residualVectorLen = " + residualVectorLen);

                    for (j = 0; j < numNormVectorsInSegment; j++)
                    {
                        var segment:Segment = new Segment;
                           
                            segment.speedVector = resultNormalizedVectors[i];
                            segment.isResidual = false;
                            subdividedPath.push(segment);
                    }
                    
                    var residualSegment:Segment = new Segment;
                        residualSegment.speedVector = residualVector;
                        residualSegment.isResidual = true;
                        subdividedPath.push(residualSegment);
                        
            }
            
            
            return subdividedPath;
        }
	}
	
}