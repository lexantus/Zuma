import spline.SplineTuple;
package spline {
	/**
     * ...
     * @author Rozhin Alexey
     */
     
    public class CubicSpline 
    {
        // spline tuple
        private var splines:Vector.<SplineTuple>;
        private var n:int;
        
        
        public function CubicSpline() 
        {
            
        }
        
        // Построение сплайна
        // x - узлы сетки, должны быть упорядочены по возрастанию, кратные узлы запрещены
        // y - значения функции в узлах сетки
        // n - количество узлов сетки
        public function BuildSpline(x:Vector.<Number>, y:Vector.<Number>, _n:int):void
        {
            var i:int;
            
            n = _n;
            
            // инициализация массива сплайнов
            splines = new Vector.<SplineTuple>;
            for (i = 0; i < n; i++)
            {
                    splines[i] = new SplineTuple;
                    splines[i].x = x[i];
                    splines[i].a = y[i];
            }
            
            splines[0].c = 0;
            
            // Решение СЛАУ относительно коэффициентов сплайнов c[i] методом прогонки для трехдиагональных матриц
            // Вычисление прогоночных коэффициентов - прямой ход метода прогонки
            
            var alpha:Vector.<Number> = new Vector.<Number>(n - 1);
            var beta:Vector.<Number> = new Vector.<Number>(n - 1);
            var A:Number; 
            var B:Number;
            var C:Number;
            var F:Number;
            var h_i:Number; 
            var h_i1:Number;
            var z:Number;
            
            alpha[0] = beta[0] = 0.;
            
            for (i = 1; i < n - 1; ++i)
            {
                h_i = x[i] - x[i - 1], h_i1 = x[i + 1] - x[i];
                A = h_i;
                C = 2. * (h_i + h_i1);
                B = h_i1;
                F = 6. * ((y[i + 1] - y[i]) / h_i1 - (y[i] - y[i - 1]) / h_i);
                z = (A * alpha[i - 1] + C);
                alpha[i] = -B / z;
                beta[i] = (F - A * beta[i - 1]) / z;
            }
 
            splines[n - 1].c = (F - A * beta[n - 2]) / (C + A * alpha[n - 2]);
            
            // Нахождение решения - обратный ход метода прогонки
            for (i = n - 2; i > 0; --i)
            {
                splines[i].c = alpha[i] * splines[i + 1].c + beta[i];
            }
            
            // Освобождение памяти, занимаемой прогоночными коэффициентами
            beta = null;
            alpha = null;
            
            // По известным коэффициентам c[i] находим значения b[i] и d[i]
            for (i = n - 1; i > 0; --i)
            {
                h_i = x[i] - x[i - 1];
                splines[i].d = (splines[i].c - splines[i - 1].c) / h_i;
                splines[i].b = h_i * (2. * splines[i].c + splines[i - 1].c) / 6. + (y[i] - y[i - 1]) / h_i;
            }
        }
        
        // Вычисление значения интерполированной функции в произвольной точке
        public function F(x:Number):Number
        {
            if (!splines)
            {
                    return Number.NaN; // Если сплайны ещё не построены - возвращаем NaN
            }
            
            var s:SplineTuple;
            if (x <= splines[0].x) // Если x меньше точки сетки x[0] - пользуемся первым эл-том массива
            {
                 s = splines[0];
            }
            else if (x >= splines[n - 1].x) // Если x больше точки сетки x[n - 1] - пользуемся последним эл-том массива
            {
                       s = splines[n - 1];
            }
            else // Иначе x лежит между граничными точками сетки - производим бинарный поиск нужного эл-та массива
            {
                var i:int = 0; 
                var j:int = n - 1;
                
                while (i + 1 < j)
                {
                    var k:int = i + (j - i) / 2;
                    if (x <= splines[k].x)
                    {
                        j = k;
                    }
                    else
                    {
                        i = k;
                    }
                }
                s = splines[j];
            }
 
            var dx:Number = (x - s.x);
            return s.a + (s.b + (s.c / 2. + s.d * dx / 6.) * dx) * dx; // Вычисляем значение сплайна в заданной точке.
        }
        
        public function Dispose():void
        {
            splines = null;
        }
    }

}