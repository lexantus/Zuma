package 
{
    /**
     * ...
     * @author Rozhin Alexey
     */
    
	import fla_assets.Path1;
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
        private var _ball:RedBallView;
        
        //private var _splines:Vector.<CubicSpline>;
        
        private var _path:MovieClip;
        
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
            
            _levelController = new ZumaLevelController1(this);
            
            _ballChainController = new BallChainController(this);
            _ballChainController.GenerateStartChain(2);
            
            _projectilesController = new ProjectilesController(this, _ballChainController);
            
            _gunController = new GunController(this, _projectilesController);
			
			_path = new Path1();
			_path.x = 343.8;
			_path.y = 235.5;
			
			addChild(_path);
			DrawSplinePath();
			AddBall();
            
            this.addEventListener(Event.ENTER_FRAME, OnUpdate1);
		}
        
        private function AddBall():void
        {
            _ball = new RedBallView;
            _ball.x = pathPts[0][0].x;
            _ball.y = pathPts[0][0].y;
            addChild(_ball);
            
            //addEventListener(Event.ENTER_FRAME, OnUpdate1);
        }
        
        private function OnUpdate1(e:Event):void 
        {
            _projectilesController.Update();
			OnUpdate();
        }
		
		private var pathPts:Vector.<Vector.<Point>>;
		private var splinePts:Vector.<Vector.<Point>>;
		
		private var segmentsUniformMovement:Vector.<Segment>;
		///private var delta:Number = 20;
		private var SPEED:Number = 4;
		private var missUpdate:int = 1;
        
        private function DrawSplinePath():void
        {
                var i:int = 1;
				var j:int = 1;
                
                pathPts = new Vector.<Vector.<Point>>;
                splinePts = new Vector.<Vector.<Point>>;
                
                var pathPtMc:MovieClip;
                
				while (_path["f_" + j])
				{
					pathPts.push(new Vector.<Point>);
					i = 1;
					
					while (_path["f_" + j]["pt_" + i])
					{
                        pathPtMc = _path["f_" + j ]["pt_" + i];
                        pathPts[j - 1].push(new Point(pathPtMc.x, pathPtMc.y));
                        i++;
					}
					
					j++;
				}
                
                var smoothX:Number;
                var smoothY:Number;
                
                
                var tempX:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>;
                var tempY:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>;
                
				//_splines = new Vector.<CubicSpline>;
				
				for (j = 0; j < pathPts.length; j++)
				{
					tempX.push(new Vector.<Number>);
					tempY.push(new Vector.<Number>);
					//_splines.push(new CubicSpline());
					splinePts.push(new Vector.<Point>);
					
					for (i = 0; i < pathPts[j].length; i++)
					{
						tempX[j].push(pathPts[j][i].x);
						tempY[j].push(pathPts[j][i].y);
					}
					
					//_splines[j].BuildSpline(tempY[j], tempX[j], tempX[j].length);
				}
                
				
               
                // left limit
                //DrawPoint(0, pathPts[0][0]);
                
                //var x_ToFindY:Number = pathPts[1][0].x + delta;
                            
                //while (x_ToFindY < pathPts[1][pathPts[0].length - 1].x)
                //{
                  //      smoothY = _splines[1].F(x_ToFindY);
                  //      DrawPoint(0, new Point(x_ToFindY, smoothY));
                  //      x_ToFindY += delta;
                //}
                
                // right limit
                //DrawPoint(2, pathPts[_splines.length - 1][pathPts[_splines.length - 1].length - 1]);
                
                
                segmentsUniformMovement = SubdividePath(pathPts);
        }
		
		private function SubdividePath(path:Vector.<Vector.<Point>>):Vector.<Segment>
        {
            var subdividedPath:Vector.<Segment> = new Vector.<Segment>;
            
            var i:int;
			var j:int;
            var pt:Point;
            var priv_pt:Point;
            var resultVector:Point;
            var resultVectors:Vector.<Point> = new Vector.<Point>;
            var resultNormalizedVectors:Vector.<Point> = new Vector.<Point>;
            var stepVectorLength:Number;
            var resultVectorsLen:Vector.<Number> = new Vector.<Number>
            
			for (j = 0; j < path.length; j++)
			{
				for (i = 1; i < path[j].length; i++)
				{
					priv_pt = path[j][i - 1];
					pt = path[j][i];
					resultVector =  pt.subtract(priv_pt);
					resultVectors.push(resultVector);
					resultNormalizedVectors.push(resultVector.clone()); // потом нормализуем, а сейчас просто копируем
					resultVectorsLen.push(resultVector.length);
				}
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
            
            for (i = 0; i < resultNormalizedVectors.length - 1; i++)
            {
                    resultNormalizedVectors[i].normalize(SPEED); 
            }
            
            var normalizedVectorLength:Number = resultNormalizedVectors[0].length;
            var numNormVectorsInSegment:int;
            
            var residualVector:Point;
            var residualVectorLen:Number;
            
            var multipliedVector:Point;
            
            for (i = 0; i < resultNormalizedVectors.length - 1; i++)
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
        
        private function DrawPoint(splineIndex:int, _pt:Point):void
        {
            _path.graphics.beginFill(0x00ff00, 100);
            _path.graphics.drawCircle(_pt.x, _pt.y, 3);
            _path.graphics.endFill();
            
            splinePts[splineIndex].push(_pt);
        }
        
        private var currentSegmentIndex:int = 0;
        private var missUpdateCount:int = 0;
        
        private function OnUpdate():void
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
                    _ball.x = pathPts[0][0].x;
                    _ball.y = pathPts[0][0].y;
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
                       _ball.x = pathPts[0][0].x;
                       _ball.y = pathPts[0][0].y;
                       
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
       
	}
	
}