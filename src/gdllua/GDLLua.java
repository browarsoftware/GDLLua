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
import java.util.ArrayList;
import javax.script.Bindings;
import org.luaj.vm2.LuaValue;
import org.luaj.vm2.Varargs;
import org.luaj.vm2.lib.jse.JsePlatform;

/**
 * This class load SKL file, GDL-Lua file and make a pattern recognition with GDL
 * SKL files can be recoreded by GDL Studio
   LuaJ 3.0.1 can be downloaded from: https://sourceforge.net/projects/luaj/
 * @author Tomasz Hachaj
 */
public class GDLLua {
    //Lua binding
    public Bindings sb = null;
    /**
     * Microsoft Kinect SDK 1.8 joints
     */
    public enum jointsV1
    {
        HipCenter, Spine, ShoulderCenter, Head, ShoulderLeft, ElbowLeft, WristLeft, HandLeft,
	ShoulderRight, ElbowRight, WristRight, HandRight, HipLeft, KneeLeft, AnkleLeft,
	FootLeft, HipRight, KneeRight, AnkleRight, FootRight
    }
    /**
     * Microsoft Kinect SDK 2 joints
     */
    public enum jointsV2
    {
        SpineBase, SpineMid, Neck, Head, ShoulderLeft, ElbowLeft, WristLeft,
        HandLeft, ShoulderRight, ElbowRight, WristRight, HandRight, HipLeft,
        KneeLeft, AnkleLeft, FootLeft, HipRight, KneeRight, AnkleRight, FootRight,
        SpineShoulder, HandTipLeft, ThumbLeft, HandTipRight, ThumbRight 
    }
    LuaValue lfSkeletonData = null;
    LuaValue lfReturnConclusions = null;
    LuaValue _G = null;
    /**
     * Prepare SKL 1 for GDL-Lua processing
     * @param ts
     * @return 
     */
    public LuaValue PrepareSkeletonV1(TSkeleton ts)
    {
        LuaValue retvals = lfSkeletonData.call();
        int tableLength = retvals.length();

        for (int a = 0; a < jointsV1.values().length; a++)
        {
            LuaValue retvals1 = retvals.rawget((jointsV1.values()[a]).toString());
            
            retvals1.rawset("x", ts.JointsPositions[a][0]);
            retvals1.rawset("y", ts.JointsPositions[a][1]);
            retvals1.rawset("z", ts.JointsPositions[a][2]);
        }
        return retvals;
    }
    /**
     * Prepare SKL 2 for GDL-Lua processing
     * @param ts
     * @return 
     */
    public LuaValue PrepareSkeletonV2(TSkeleton ts)
    {
        LuaValue retvals = lfSkeletonData.call();
        for (int a = 0; a < jointsV2.values().length; a++)
        {
            LuaValue retvals1 = retvals.rawget((jointsV2.values()[a]).toString());
             
            retvals1.rawset("x", ts.JointsPositions[a][0]);
            retvals1.rawset("y", ts.JointsPositions[a][1]);
            retvals1.rawset("z", ts.JointsPositions[a][2]);
        }
        return retvals;
    }
    
    /**
     * GDL-Lua calculation
     * @param ts
     * @return 
     */
    public GDLResults Calculate(TSkeleton ts)
    {
        GDLResults gDLResults = new GDLResults();
        LuaValue skel = null;
        if (ts.version == 1)
            skel = PrepareSkeletonV1(ts);
        if (ts.version == 2)
            skel = PrepareSkeletonV2(ts);
        lfReturnConclusions.call(skel, LuaValue.valueOf(ts.TimePeriod / 1000.0));
        LuaValue GDLStack = (LuaValue)_G.get("GDLStack");
        LuaValue StackTokens = GDLStack.rawget("StackTokens");
        LuaValue stackTop = StackTokens.get(1);
        LuaValue Conclusions = stackTop.rawget("Conclusions");
        LuaValue Features = stackTop.rawget("Features");
        
        LuaValue k = LuaValue.NIL;
        while ( true ) {
           Varargs n = Features.next(k);
           if ( (k = n.arg1()).isnil() )
              break;
           LuaValue v = n.arg(2);
           if (v.isnumber())
           {
               String conclusionName = n.arg(1).toString();
               gDLResults.festuresNumeric.put(conclusionName, v.todouble());
           }
           else
           {
                String conclusionName = n.arg(1).toString();
                double[]df = new double[3];
                df[0] = v.rawget("x").todouble();
                df[1] = v.rawget("y").todouble();
                df[2] = v.rawget("z").todouble();
                gDLResults.festuresVectors.put(conclusionName, df);
           }
        }
        
        while ( true ) {
           Varargs n = Conclusions.next(k);
           if ( (k = n.arg1()).isnil() )
              break;
           LuaValue v = n.arg(2);
           boolean bool = v.toboolean();
           if (bool)
           {
                String conclusionName = n.arg(1).toString();
                gDLResults.conclusions.add(conclusionName);
           }
        }
        
        return gDLResults;
    }
        
    /**
     * Constructor of GDL-Lua interpreter
     * @param luaFile 
     */
    public GDLLua(String luaFile)
    {
        _G = JsePlatform.standardGlobals();
        _G.get("dofile").call( LuaValue.valueOf(luaFile));
        lfSkeletonData = _G.get("GetExampleSkeletonData");
        lfReturnConclusions = _G.get("ReturnConclusions");
    }
    
    /**
     * Main entry
     * @param args 
     */
    public static void main(String[]args)
    {
        //Calculation of data acquired by Microsoft Kinect 1 with Microsoft Kinect SDK 1.8 
        //Change tis path:
        GDLLua gdl = new GDLLua("e:\\Projects\\java 3d tutorial\\GDLLua\\src\\jj.lua");
        //Change tis path:
        String filePath = "e:\\Projects\\java 3d tutorial\\GDLLua\\src\\jj.skl";
        System.out.println("Load file SKL1 file: " + filePath);
        ArrayList recording = TSkeletonHelper.ReadRecordingFromFile1(filePath);
            for (int a = 0; a < recording.size(); a++)
            {
                TSkeleton[] ts = (TSkeleton[])recording.get(a);
                GDLResults res = gdl.Calculate(ts[0]);
                System.out.println("Frame: " + a);
                System.out.print("\tConclusions: ");
                for (int b = 0; b < res.conclusions.size(); b++)
                {
                    System.out.print(res.conclusions.get(b) + " ");
                }
                System.out.println();
                System.out.print("\tNumeric features: ");
                System.out.println();
                System.out.print("\tNumeric vectors: ");
                System.out.println();
            }
        
        //Calculation of data acquired by Microsoft Kinect 1 with Microsoft Kinect SDK 2
        //Change tis path:
        gdl = new GDLLua("e:\\Projects\\java 3d tutorial\\GDLLua\\src\\hiza_geri.lua");
        //Change tis path:
        filePath = "e:\\Projects\\java 3d tutorial\\GDLLua\\src\\hiza-geri.skl";
        System.out.println("Load file SKL1 file: " + filePath);
        recording = TSkeletonHelper.ReadRecordingFromFile2(filePath);
            for (int a = 0; a < recording.size(); a++)
            {
                TSkeleton[] ts = (TSkeleton[])recording.get(a);
                GDLResults res = gdl.Calculate(ts[0]);
                System.out.println("Frame: " + a);
                System.out.print("\tConclusions: ");
                for (int b = 0; b < res.conclusions.size(); b++)
                {
                    System.out.print(res.conclusions.get(b) + " ");
                }
                System.out.println();
                System.out.print("\tNumeric features: ");
                System.out.println();
                System.out.print("\tNumeric vectors: ");
                System.out.println();
            }
    }
    
}
