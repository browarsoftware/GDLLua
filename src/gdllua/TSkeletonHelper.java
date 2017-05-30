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

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.ArrayList;

/**
 * This class contains helper functions for skelton data
 * @author Tomasz Hachaj
 */
public class TSkeletonHelper {
    
    /**
     * Read SKL data for Microsof Kinect SDK 2.0
     * @param fileToPlay
     * @return 
     */
    public static ArrayList ReadRecordingFromFile2(String fileToPlay)
        {
            ArrayList recording = new ArrayList();
            try
            {
            InputStream fis = new FileInputStream(fileToPlay);
            InputStreamReader isr = new InputStreamReader(fis, Charset.forName("UTF-8"));
            BufferedReader br = new BufferedReader(isr);
                
            String line;
            ArrayList arHelp = new ArrayList();
            long prevFrameNumber = -1;
            long currentFrameNumber = -1;

            long absoluteTime = 0;
            try
            {
                do
                {
                    TSkeleton tSkeleton = new TSkeleton();
                    tSkeleton.version = 2;
                    prevFrameNumber = currentFrameNumber;

                    line = br.readLine();
                    line = line.replaceAll(",", ".");
                    int index = 0;
                    String[] array = line.split(" ");

                    currentFrameNumber = Long.parseLong(array[index]);
                    index++;
                    tSkeleton.TimePeriod = Long.parseLong(array[index]);
                    index++;
                    tSkeleton.ClippedEdges = Integer.parseInt(array[index]);
                    index++;
                    tSkeleton.HandLeftConfidence = Integer.parseInt(array[index]);
                    index++;
                    tSkeleton.HandLeftState = Integer.parseInt(array[index]);
                    index++;
                    tSkeleton.HandRightConfidence = Integer.parseInt(array[index]);
                    index++;
                    tSkeleton.HandRightState = Integer.parseInt(array[index]);
                    index++;
                    tSkeleton.IsRestricted = Boolean.parseBoolean(array[index]);
                    index++;
                    tSkeleton.IsTracked = Boolean.parseBoolean(array[index]);
                    index++;
                    tSkeleton.Lean = new float[2];
                    index = ReadFromFile(tSkeleton.Lean, array, index);
                    tSkeleton.LeanTrackingState = Integer.parseInt(array[index]);
                    index++;
                    tSkeleton.AbsoluteRotation = CreateArray(25, 4);
                    index = ReadFromFile(tSkeleton.AbsoluteRotation, array, index);
                    tSkeleton.JointsPositions = CreateArray(25, 3);
                    index = ReadFromFile(tSkeleton.JointsPositions, array, index);
                    tSkeleton.JointsTrackingState = new int[25];;
                    index = ReadFromFile(tSkeleton.JointsTrackingState, array, index);


                    if (currentFrameNumber != prevFrameNumber && prevFrameNumber >= 0)
                    {
                        TSkeleton[] skeletons = new TSkeleton[arHelp.size()];
                        for (int b = 0; b < skeletons.length; b++)
                        {
                            skeletons[b] = (TSkeleton)arHelp.get(b);
                        }
                        arHelp.clear();
                        recording.add(skeletons);
                        arHelp.add(tSkeleton);
                        absoluteTime += skeletons[0].TimePeriod;
                    }
                    else
                    {
                        arHelp.add(tSkeleton);
                        absoluteTime += tSkeleton.TimePeriod;
                    }

                }
                while (line != null && br != null);
            }
            catch (Exception e){ };
            if (br != null)
            {
                br.close();
                isr.close();
                fis.close();
                br = null;
            }
            if (arHelp.size() > 0)
            {
                TSkeleton[] skeletons = new TSkeleton[arHelp.size()];
                for (int b = 0; b < skeletons.length; b++)
                    skeletons[b] = (TSkeleton)arHelp.get(b);
                arHelp.clear();
                recording.add(skeletons);
            }
            }
            catch (Exception e) {}
            return recording;
        }
    
    /**
     * Read SKL data for Microsof Kinect SDK 1.8
     * @param fileToPlay
     * @return 
     */
    public static ArrayList ReadRecordingFromFile1(String fileToPlay)
        {
            ArrayList recording = new ArrayList();
            //StreamReader sr = new StreamReader(fileToPlay);
            try
            {
            InputStream fis = new FileInputStream(fileToPlay);
            InputStreamReader isr = new InputStreamReader(fis, Charset.forName("UTF-8"));
            BufferedReader br = new BufferedReader(isr);
            
            String line;
            ArrayList arHelp = new ArrayList();
            //int skeletonCount = 0;
            long prevFrameNumber = -1;
            long currentFrameNumber = -1;

            long absoluteTime = 0;
            try
            {
                do
                {
                    TSkeleton skeleton = new TSkeleton();
                    skeleton.version = 1;
                    prevFrameNumber = currentFrameNumber;

                    line = br.readLine();
                    line = line.replaceAll(",", ".");
                    int index = 0;
                    String[] array = line.split(" ");

                    currentFrameNumber = Long.parseLong(array[index]);
                    index++;
                    skeleton.AbsoluteRotation = CreateArray(20, 4);
                    index = ReadFromFile(skeleton.AbsoluteRotation,array, index);
                    skeleton.HierarchicalRotation = CreateArray(20, 4);
                    index = ReadFromFile(skeleton.HierarchicalRotation, array, index);
                    skeleton.JointsPositions = CreateArray(20, 3);
                    index = ReadFromFile(skeleton.JointsPositions, array, index);
                    skeleton.JointsTrackingState = new int[20];
                    index = ReadFromFile(skeleton.JointsTrackingState, array, index);
                    skeleton.Position = new float[3];
                    index = ReadFromFile(skeleton.Position, array, index);
                    skeleton.ClippedEdges = Integer.parseInt(array[index]);
                    index++;
                    skeleton.TrackingState = Integer.parseInt(array[index]);
                    index++;
                    skeleton.TrackingId = Integer.parseInt(array[index]);
                    index++;
                    skeleton.TimePeriod = Integer.parseInt(array[index]);
                    index++;
                    skeleton.ElevationAngle = Integer.parseInt(array[index]);
                    index++;
                    float item1 = Float.parseFloat(array[index]);
                    index++;
                    float item2 = Float.parseFloat(array[index]);
                    index++;
                    float item3 = Float.parseFloat(array[index]);
                    index++;
                    float item4 = Float.parseFloat(array[index]);
                    index++;
                    skeleton.SeatedMode = Integer.parseInt(array[index]);
                    index++;
                    if (index < array.length)
                    {
                        if (array[index].length() > 0)
                            try
                            {
                                skeleton.SyncTime = Long.parseLong(array[index]);
                            }
                            catch (Exception e){ }
                    }
                    skeleton.AbsoluteTime = absoluteTime;

                    if (currentFrameNumber != prevFrameNumber && prevFrameNumber >= 0)
                    {
                        TSkeleton[] skeletons = new TSkeleton[arHelp.size()];
                        for (int b = 0; b < skeletons.length; b++)
                        {
                            skeletons[b] = (TSkeleton)arHelp.get(b);
                        }
                        arHelp.clear();
                        recording.add(skeletons);
                        arHelp.add(skeleton);
                        absoluteTime += skeletons[0].TimePeriod;
                    }
                    else
                    {
                        arHelp.add(skeleton);
                        absoluteTime += skeleton.TimePeriod;
                    }                    
                }
                while (line != null && br != null);
            }
            catch (Exception e){ };
            if (br != null)
            {
                br.close();
                isr.close();
                fis.close();
                br = null;
            }
            if (arHelp.size() > 0)
            {
                TSkeleton[] skeletons = new TSkeleton[arHelp.size()];
                for (int b = 0; b < skeletons.length; b++)
                    skeletons[b] = (TSkeleton)arHelp.get(b);
                arHelp.clear();
                recording.add(skeletons);
            }
            }
            catch (Exception e)
            {
                
            }
            return recording;
        }
    private static float[][] CreateArray(int dim1, int dim2)
        {
            float[][] array = new float[dim1][];
            for (int a = 0; a < array.length; a++)
                array[a] = new float[dim2];
            return array;
        }
    
    private static int ReadFromFile(float[] array, String[] fileData, int startIndex)
        {
            int index = startIndex;
            for (int a = 0; a < array.length; a++)
            {
                array[a] = Float.parseFloat(fileData[index]);
                index++;
            }
            return index;
        }

        private static int ReadFromFile(int[] array, String[] fileData, int startIndex)
        {
            int index = startIndex;
            for (int a = 0; a < array.length; a++)
            {
                array[a] = Integer.parseInt(fileData[index]);
                    index++;
            }
            return index;
        }

        private static int ReadFromFile(float[][] array, String[] fileData, int startIndex)
        {
            int index = startIndex;
            for (int a = 0; a < array.length; a++)
                for (int b = 0; b < array[a].length; b++)
                {
                    array[a][b] = Float.parseFloat(fileData[index]);
                    index++;
                }
            return index;
        }


}
