/*
* Copyright (c) 2016, Tomasz Hachaj
* CCI laboratory, Poland
* tomekhachaj at o2.pl
* http://gdl.org.pl/

* Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
package gdllua;

/**
 * Skeleton data structure, unified for Microsoft Kinect SDK 1.8 and 2.0
 * @author Tomasz Hachaj
 */
public class TSkeleton {
    //bone rotation
        int version = 1;
        //Quaternion - x y z w
        public float[][] AbsoluteRotation;
        public float[][] HierarchicalRotation;
        //None = 0,
        //Right = 1,
        //Left = 2,
        //Top = 4,
        //Bottom = 8,
        public int ClippedEdges = 0;
        //x y z
        public float[] Position;
        //joint - x y z
        public float[][] JointsPositions;
        //NotTracked = 0,
        //Inferred = 1,
        //Tracked = 2,
        public int[] JointsTrackingState;

        //
        public int TrackingId;

        //NotTracked = 0,
        //PositionOnly = 1,
        //Tracked = 2,
        public int TrackingState;
        public long TimePeriod;
        public long AbsoluteTime;

        public int ElevationAngle = 0;
        public int SeatedMode = 0;

        public long SyncTime = 0;
        
        //Kinect 2
        public int HandLeftConfidence = 0;
        public int HandLeftState = 0;
        
        public int HandRightConfidence = 0;
        public int HandRightState = 0;
        
        public boolean IsRestricted = false;
        public boolean IsTracked = false;
        
        public int LeanTrackingState = 0;
        public float[]Lean = null;
}
